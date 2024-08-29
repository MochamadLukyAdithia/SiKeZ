/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/dropdown-icon.svg
  SvgGenImage get dropdownIcon =>
      const SvgGenImage('assets/icons/dropdown-icon.svg');

  /// File path: assets/icons/google.svg
  SvgGenImage get google => const SvgGenImage('assets/icons/google.svg');

  /// File path: assets/icons/home-icon-off.svg
  SvgGenImage get homeIconOff =>
      const SvgGenImage('assets/icons/home-icon-off.svg');

  /// File path: assets/icons/home-icon-on.svg
  SvgGenImage get homeIconOn =>
      const SvgGenImage('assets/icons/home-icon-on.svg');

  /// File path: assets/icons/profile-icon-off.svg
  SvgGenImage get profileIconOff =>
      const SvgGenImage('assets/icons/profile-icon-off.svg');

  /// File path: assets/icons/profile-icon-on.svg
  SvgGenImage get profileIconOn =>
      const SvgGenImage('assets/icons/profile-icon-on.svg');

  /// File path: assets/icons/report-icon-off.svg
  SvgGenImage get reportIconOff =>
      const SvgGenImage('assets/icons/report-icon-off.svg');

  /// File path: assets/icons/report-icon-on.svg
  SvgGenImage get reportIconOn =>
      const SvgGenImage('assets/icons/report-icon-on.svg');

  /// File path: assets/icons/solar_calendar-bold.svg
  SvgGenImage get solarCalendarBold =>
      const SvgGenImage('assets/icons/solar_calendar-bold.svg');

  /// File path: assets/icons/transaction-minus-svgrepo-com.svg
  SvgGenImage get transactionMinusSvgrepoCom =>
      const SvgGenImage('assets/icons/transaction-minus-svgrepo-com.svg');

  /// File path: assets/icons/transaction.svg
  SvgGenImage get transaction =>
      const SvgGenImage('assets/icons/transaction.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        dropdownIcon,
        google,
        homeIconOff,
        homeIconOn,
        profileIconOff,
        profileIconOn,
        reportIconOff,
        reportIconOn,
        solarCalendarBold,
        transactionMinusSvgrepoCom,
        transaction
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/coffee_background.png
  AssetGenImage get coffeeBackground =>
      const AssetGenImage('assets/images/coffee_background.png');

  /// File path: assets/images/hmja.png
  AssetGenImage get hmja => const AssetGenImage('assets/images/hmja.png');

  /// File path: assets/images/icon_bullish.png
  AssetGenImage get iconBullish =>
      const AssetGenImage('assets/images/icon_bullish.png');

  /// File path: assets/images/kampusmerdeka.png
  AssetGenImage get kampusmerdeka =>
      const AssetGenImage('assets/images/kampusmerdeka.png');

  /// File path: assets/images/kemendikbud.png
  AssetGenImage get kemendikbud =>
      const AssetGenImage('assets/images/kemendikbud.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/logo_ppk.png
  AssetGenImage get logoPpk =>
      const AssetGenImage('assets/images/logo_ppk.png');

  /// File path: assets/images/ojk.png
  AssetGenImage get ojk => const AssetGenImage('assets/images/ojk.png');

  /// File path: assets/images/ppkcompo.png
  AssetGenImage get ppkcompo =>
      const AssetGenImage('assets/images/ppkcompo.png');

  /// File path: assets/images/ppkormawa.png
  AssetGenImage get ppkormawa =>
      const AssetGenImage('assets/images/ppkormawa.png');

  /// File path: assets/images/simbelmawa.png
  AssetGenImage get simbelmawa =>
      const AssetGenImage('assets/images/simbelmawa.png');

  /// File path: assets/images/splash.png
  AssetGenImage get splash => const AssetGenImage('assets/images/splash.png');

  /// File path: assets/images/unej.png
  AssetGenImage get unej => const AssetGenImage('assets/images/unej.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        coffeeBackground,
        hmja,
        iconBullish,
        kampusmerdeka,
        kemendikbud,
        logo,
        logoPpk,
        ojk,
        ppkcompo,
        ppkormawa,
        simbelmawa,
        splash,
        unej
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final BytesLoader loader;
    if (_isVecFormat) {
      loader = AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
