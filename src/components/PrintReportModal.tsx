import React, { useRef, useState, useEffect } from 'react';
import { X, Printer, Download, Loader2, CheckCircle2, ExternalLink } from 'lucide-react';
import jsPDF from 'jspdf';
import html2canvas from 'html2canvas-pro';
import { formatDate } from '../utils/formatters';
import { useApp } from '../context/AppContext';

interface PrintReportModalProps {
  title: string;
  subtitle?: string;
  isOpen: boolean;
  onClose: () => void;
  children: React.ReactNode;
}

export const PrintReportModal: React.FC<PrintReportModalProps> = ({
  title,
  subtitle = 'SiKeZ - Aplikasi Keuangan Gen Z',
  isOpen,
  onClose,
  children,
}) => {
  const { showNotification } = useApp();
  const reportRef = useRef<HTMLDivElement>(null);
  const [isGenerating, setIsGenerating] = useState(false);
  const [generatedPdfUrl, setGeneratedPdfUrl] = useState<string | null>(null);
  const [generatedPdfName, setGeneratedPdfName] = useState<string>('');

  useEffect(() => {
    // Clean up created object URL when modal unmounts or closes
    return () => {
      if (generatedPdfUrl) {
        URL.revokeObjectURL(generatedPdfUrl);
      }
    };
  }, [generatedPdfUrl]);

  if (!isOpen) return null;

  const handlePrint = () => {
    window.print();
  };

  const handleDownloadPdf = async () => {
    if (!reportRef.current || isGenerating) return;

    setIsGenerating(true);

    try {
      const sheetEl = reportRef.current;
      const scrollParent = sheetEl.parentElement;
      const originalScrollLeft = scrollParent ? scrollParent.scrollLeft : 0;
      const originalScrollTop = scrollParent ? scrollParent.scrollTop : 0;

      // Temporarily reset scroll to (0,0) to prevent html2canvas clipping/displacement on mobile Android
      if (scrollParent) {
        scrollParent.scrollLeft = 0;
        scrollParent.scrollTop = 0;
      }

      // Ensure all images inside are loaded before canvas rendering
      const images = sheetEl.querySelectorAll('img');
      await Promise.all(
        Array.from(images).map((img) => {
          if (img.complete) return Promise.resolve();
          return new Promise((resolve) => {
            img.onload = resolve;
            img.onerror = resolve;
          });
        })
      );

      // Render DOM element to canvas with safe memory limits for mobile Android
      const canvas = await html2canvas(sheetEl, {
        scale: 1.5, // 1.5 provides crisp 150+ DPI for A4 without triggering Android GPU canvas memory overflow
        useCORS: true,
        allowTaint: true,
        backgroundColor: '#ffffff',
        logging: false,
        scrollX: 0,
        scrollY: 0,
        windowWidth: 800,
      });

      // Restore user scroll
      if (scrollParent) {
        scrollParent.scrollLeft = originalScrollLeft;
        scrollParent.scrollTop = originalScrollTop;
      }

      const imgData = canvas.toDataURL('image/png');
      const pdf = new jsPDF('p', 'mm', 'a4');
      const pageWidth = pdf.internal.pageSize.getWidth();
      const pageHeight = pdf.internal.pageSize.getHeight();

      // Margins in mm
      const margin = 10;
      const printableWidth = pageWidth - margin * 2;
      const printableHeight = pageHeight - margin * 2;

      // Scale height according to printable width
      const imgHeight = (canvas.height * printableWidth) / canvas.width;

      if (imgHeight <= printableHeight) {
        // Fits entirely on a single page
        pdf.addImage(imgData, 'PNG', margin, margin, printableWidth, imgHeight, undefined, 'FAST');
      } else {
        // Multi-page document splitting
        let heightLeft = imgHeight;
        let position = margin;

        pdf.addImage(imgData, 'PNG', margin, position, printableWidth, imgHeight, undefined, 'FAST');
        heightLeft -= printableHeight;

        while (heightLeft > 0) {
          position = margin - (imgHeight - heightLeft);
          pdf.addPage();
          pdf.addImage(imgData, 'PNG', margin, position, printableWidth, imgHeight, undefined, 'FAST');
          heightLeft -= printableHeight;
        }
      }

      // Generate clean filename
      const cleanTitle = title
        .toLowerCase()
        .replace(/[^a-z0-9]+/g, '_')
        .replace(/(^_+|_+$)/g, '');
      const dateStr = new Date().toISOString().slice(0, 10);
      const filename = `sikez_${cleanTitle}_${dateStr}.pdf`;

      // Create PDF Blob
      const pdfBlob = pdf.output('blob');
      const blobUrl = URL.createObjectURL(pdfBlob);

      setGeneratedPdfUrl(blobUrl);
      setGeneratedPdfName(filename);

      // Multi-strategy Android & Mobile Delivery:
      const isMobile = /Android|iPhone|iPad|iPod/i.test(navigator.userAgent);
      let handledViaShare = false;

      // Strategy 1: Web Share API for files (Supported by Android Chrome/Samsung Internet)
      // This is the native Android share sheet allowing direct "Save to Downloads", "Drive", etc.
      if (isMobile && typeof navigator.share === 'function') {
        try {
          const pdfFile = new File([pdfBlob], filename, { type: 'application/pdf' });
          if (navigator.canShare && navigator.canShare({ files: [pdfFile] })) {
            await navigator.share({
              files: [pdfFile],
              title: filename,
              text: `Laporan ${title} - SiKeZ`,
            });
            handledViaShare = true;
            showNotification('Laporan PDF berhasil dibagikan / disimpan', 'success');
          }
        } catch (shareErr: unknown) {
          const err = shareErr as { name?: string };
          if (err?.name === 'AbortError') {
            handledViaShare = true;
          }
        }
      }

      // Strategy 2: Programmatic download anchor
      if (!handledViaShare) {
        try {
          const link = document.createElement('a');
          link.href = blobUrl;
          link.download = filename;
          link.rel = 'noopener';
          link.target = '_blank';
          document.body.appendChild(link);
          link.click();
          setTimeout(() => {
            if (document.body.contains(link)) {
              document.body.removeChild(link);
            }
          }, 3000);
          showNotification(`PDF siap diunduh!`, 'success');
        } catch {
          showNotification(`PDF siap. Silakan ketuk tombol unduh di bawah.`, 'success');
        }
      }
    } catch (error) {
      console.error('Gagal membuat PDF:', error);
      showNotification('Membuka dialog cetak sistem HP sebagai alternatif...', 'success');
      window.print();
    } finally {
      setIsGenerating(false);
    }
  };

  return (
    <div className="fixed inset-0 z-50 bg-[#061812] flex flex-col justify-between overflow-hidden animate-fadeIn select-none">
      {/* Print Styles for physical printing */}
      <style>{`
        @media print {
          body {
            background: #ffffff !important;
            color: #000000 !important;
          }
          body * {
            visibility: hidden;
          }
          #printable-report-sheet, #printable-report-sheet * {
            visibility: visible;
          }
          #printable-report-sheet {
            position: absolute !important;
            left: 0 !important;
            top: 0 !important;
            width: 100% !important;
            max-width: 100% !important;
            box-shadow: none !important;
            border: none !important;
            padding: 0 !important;
            margin: 0 !important;
          }
          .no-print {
            display: none !important;
          }
        }
      `}</style>

      {/* Top action bar - Fixed header */}
      <div className="bg-[#09231C] border-b border-emerald-900/60 text-white px-3 sm:px-4 py-2.5 sm:py-3 flex items-center justify-between shadow-lg shrink-0 no-print z-20">
        <div className="flex items-center space-x-2 min-w-0 pr-2">
          <span className="font-bold text-xs sm:text-sm text-emerald-100 truncate">
            {title}
          </span>
          <span className="hidden sm:inline-block text-[11px] bg-emerald-900/80 text-emerald-300 px-2 py-0.5 rounded font-medium">
            Ukuran A4
          </span>
        </div>

        <div className="flex items-center space-x-2 shrink-0">
          {/* Main Download PDF Button */}
          <button
            onClick={handleDownloadPdf}
            disabled={isGenerating}
            className="flex items-center space-x-1.5 bg-[#10B981] hover:bg-[#059669] disabled:bg-emerald-800/60 text-white text-xs px-3 sm:px-4 py-1.5 rounded-lg font-bold shadow-md transition-all active:scale-[0.98] cursor-pointer"
          >
            {isGenerating ? (
              <>
                <Loader2 className="w-3.5 h-3.5 animate-spin" />
                <span>Memproses...</span>
              </>
            ) : (
              <>
                <Download className="w-3.5 h-3.5" />
                <span>Download PDF</span>
              </>
            )}
          </button>

          {/* System Print / Save as PDF Button (Visible on mobile & desktop) */}
          <button
            onClick={handlePrint}
            disabled={isGenerating}
            className="flex items-center space-x-1.5 bg-white/10 hover:bg-white/20 text-white text-xs px-2.5 sm:px-3 py-1.5 rounded-lg font-medium transition-colors cursor-pointer"
            title="Cetak atau Simpan PDF lewat menu printer HP"
          >
            <Printer className="w-3.5 h-3.5" />
            <span className="hidden xs:inline sm:inline">Cetak</span>
          </button>

          {/* Close Button */}
          <button
            onClick={onClose}
            className="p-1.5 hover:bg-white/10 rounded-full transition-colors text-gray-300 hover:text-white cursor-pointer"
            aria-label="Tutup"
          >
            <X className="w-5 h-5" />
          </button>
        </div>
      </div>

      {/* Persistent Action Bar if PDF is generated */}
      {generatedPdfUrl && (
        <div className="bg-[#0A2E24] border-b border-emerald-500/30 px-4 py-2.5 text-white flex flex-wrap items-center justify-between gap-2 shadow-lg no-print z-20">
          <div className="flex items-center space-x-2 min-w-0">
            <CheckCircle2 className="w-4 h-4 text-emerald-400 shrink-0" />
            <span className="text-xs text-emerald-100 truncate">
              PDF siap:{' '}
              <span className="font-semibold text-white">{generatedPdfName}</span>
            </span>
          </div>

          <div className="flex items-center space-x-2 w-full sm:w-auto justify-end">
            <a
              href={generatedPdfUrl}
              download={generatedPdfName}
              target="_blank"
              rel="noopener noreferrer"
              className="flex-1 sm:flex-none text-center bg-emerald-500 hover:bg-emerald-600 text-white font-bold text-xs px-3.5 py-1.5 rounded-lg shadow-sm flex items-center justify-center space-x-1.5 transition-colors cursor-pointer"
            >
              <ExternalLink className="w-3.5 h-3.5" />
              <span>Buka / Unduh PDF</span>
            </a>
            <button
              onClick={handlePrint}
              className="flex-1 sm:flex-none text-center bg-white/15 hover:bg-white/25 text-white font-medium text-xs px-3 py-1.5 rounded-lg flex items-center justify-center space-x-1.5 transition-colors cursor-pointer"
            >
              <Printer className="w-3.5 h-3.5" />
              <span>Cetak HP</span>
            </button>
          </div>
        </div>
      )}

      {/* Sheet Viewport - Direct 100% size with smooth horizontal and vertical scrolling */}
      <div className="flex-1 overflow-x-auto overflow-y-auto p-4 sm:p-8 flex justify-start sm:justify-center items-start bg-[#061812] select-text">
        <div
          ref={reportRef}
          id="printable-report-sheet"
          className="bg-white text-gray-900 shadow-2xl rounded-sm p-6 sm:p-10 border border-gray-200 w-[760px] min-w-[760px] min-h-[1050px] shrink-0 my-0 mx-auto"
        >
          {/* Document Header with Logo */}
          <div className="border-b-2 border-dashed border-gray-300 pb-4 mb-6">
            <div className="flex justify-between items-start">
              <div className="flex items-center space-x-3.5">
                <div className="w-14 h-14 rounded-xl border border-gray-200 p-1 bg-white shrink-0 flex items-center justify-center">
                  <img
                    src="/assets/images/logo.png"
                    alt="SiKeZ Logo"
                    className="w-full h-full object-contain"
                  />
                </div>
                <div>
                  <h1 className="text-xl font-extrabold tracking-tight text-[#0E3B2F]">{title}</h1>
                  <p className="text-xs text-gray-700 font-bold mt-0.5">{subtitle}</p>
                  <p className="text-[11px] text-gray-500 mt-0.5">
                    PPK Ormawa HMJA Universitas Jember • Sistem Akuntansi Keuangan
                  </p>
                </div>
              </div>
              <div className="text-right shrink-0 pl-2">
                <span className="text-[10px] text-gray-400 block uppercase tracking-wider font-bold">
                  Tanggal Cetak
                </span>
                <span className="text-xs font-semibold text-gray-800">
                  {formatDate(new Date(), 'long')}
                </span>
              </div>
            </div>
          </div>

          {/* Report Body */}
          <div className="text-sm">{children}</div>

          {/* Signature / Footer */}
          <div className="mt-12 pt-6 border-t border-gray-200 flex justify-between items-end text-xs text-gray-600">
            <div>
              <p className="text-[11px] text-gray-500 font-medium">
                Dicetak secara otomatis melalui aplikasi <strong className="text-[#0E3B2F]">SiKeZ</strong> (Aplikasi Keuangan Gen Z)
              </p>
            </div>
            <div className="text-center w-40">
              <p className="text-gray-500 mb-14 text-xs font-medium">Pengelola / Pemilik Usaha</p>
              <div className="border-b border-gray-400 w-full mb-1"></div>
              <p className="font-bold text-gray-800 text-xs">( Pengurus Usaha )</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
