import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDownButtonWithSearch extends StatelessWidget {
  final String title;
  const DropDownButtonWithSearch({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(
          height: 10,
        ),
        Center(
            child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            iconStyleData: const IconStyleData(iconEnabledColor: Colors.green),
            items: [
              DropdownMenuItem(
                value: "nama_list",
                child: Center(
                    child: Text(
                  "nama_list",
                )),
              ),

              // if (controller.allMachineList != null) ...[
              //   for (var i = 0;
              //       i < controller.allMachineList!.length;
              //       i++) ...[
              //     DropdownMenuItem(
              //       value:
              //           "${controller.allMachineList![i].name}",
              //       child: Row(
              //         children: [
              //           Expanded(
              //               child: Image.asset(
              //                   Images.iconMachine)),
              //           Expanded(
              //             flex: 3,
              //             child: Text(
              //               "${controller.allMachineList![i].name}",
              //               maxLines: 1,
              //               overflow: TextOverflow.ellipsis,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ]
              // ],
            ],
            value: "nama_list",
            onChanged: (value) {
              //   setState(() {
              //     selectedValue = value;
              //   });
              // }
            },
            buttonStyleData: ButtonStyleData(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Colors.white, Color.fromARGB(255, 212, 212, 212)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12, width: 2),
                // boxShadow: [
                //   BoxShadow(
                //       spreadRadius: 2, blurRadius: 2, color: Colors.black12)
                // ]
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 45,
              width: double.infinity,
            ),
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 200,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
            dropdownSearchData: DropdownSearchData(
              // searchController: textEditingController,
              searchInnerWidgetHeight: 50,
              searchInnerWidget: Container(
                height: 50,
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  // controller: textEditingController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: 'Search for an item...',
                    hintStyle: const TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                return item.value
                    .toString()
                    .toLowerCase()
                    .contains(searchValue.toLowerCase());
              },
            ),
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                // textEditingController.clear();
              }
            },
          ),
        )),
      ],
    );
  }
}
