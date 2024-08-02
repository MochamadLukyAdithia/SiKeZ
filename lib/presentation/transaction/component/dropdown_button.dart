import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDownButtonWithSearch extends StatelessWidget {
  const DropDownButtonWithSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        // hint: Text(
        //   'Select Item',
        //   style: TextStyle(
        //     fontSize: 14,
        //     color: Theme.of(context).colorScheme.primary,
        //   ),
        // ),
        iconStyleData: const IconStyleData(iconEnabledColor: Colors.green),
        items: [
          //rw this is for initial value and also title
          DropdownMenuItem(
            value: "machine_list",
            child: Center(
                child: Text(
              "machine_list",
            )),
          ),
          DropdownMenuItem(
            value: "nama_list",
            child: Center(
                child: Text(
              "nama_list",
            )),
          ),
          //rw this is for get all the machine list from api
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

        value: "machine_list",
        onChanged: (value) {
          // print("submitted value $value");
          // if (value != "machine_list") {
          //   showDialog(
          //     context: context,
          //     builder: (context) {
          //       return ConfirmationDialog(
          //           icon: Images.iconMachine,
          //           description:
          //               "are_you_sure_to_add_this_machine"
          //                   .tr,
          //           onYesPressed: () {
          //             if (controller.allMachineList !=
          //                 null) {
          //               List<CategoryModel> allMachine =
          //                   controller.allMachineList!;
          //               List<CategoryModel> chosedItem =
          //                   allMachine
          //                       .where((machine) =>
          //                           machine.name!.contains(
          //                               value as Pattern))
          //                       .toList();
          //               controller.changeMachineValue(
          //                   chosedItem.first);
          //             }

          //             Get.back();
          //           });
          //     },
          //   );
          //   setState(() {
          //     selectedValue = value;
          //   });
          // }
        },
        buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(spreadRadius: 2, blurRadius: 2, color: Colors.black12)
              ]),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 40,
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
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            // textEditingController.clear();
          }
        },
      ),
    ));
  }
}
