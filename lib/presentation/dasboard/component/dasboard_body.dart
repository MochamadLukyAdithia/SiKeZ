import 'package:flutter/material.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Transaksi",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: 20, maxWidth: MediaQuery.of(context).size.width),
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [Color(0xffA1B57D), Color(0xff464F37)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Icon(
                          Icons.arrow_outward_outlined,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Pengeluaran",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Spacer(),
                                  Text(
                                    "19 juli 2024",
                                    style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("kas -> Beban Pokok Pendapatan",
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w400)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Rp7.000.000",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: 3),
          ),
        ],
      ),
    );
  }
}
