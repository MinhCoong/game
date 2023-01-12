import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDownChooseGameMode extends StatefulWidget {
  const DropDownChooseGameMode({super.key});

  @override
  State<DropDownChooseGameMode> createState() => _DropDownChooseGameModeState();
}

class _DropDownChooseGameModeState extends State<DropDownChooseGameMode> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  List<String> selectedItems = [];
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        style: const TextStyle(color: Colors.white),
        dropdownDecoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.green,
        ),
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        // isExpanded: false,
        hint: const Text(
          'Random',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            //disable default onTap to avoid closing menu when selecting an item
            enabled: false,
            child: StatefulBuilder(
              builder: (context, menuSetState) {
                final _isSelected = selectedItems.contains(item);
                return InkWell(
                  onTap: () {
                    _isSelected
                        ? selectedItems.remove(item)
                        : selectedItems.add(item);
                    //This rebuilds the StatefulWidget to update the button's text
                    setState(() {});
                    //This rebuilds the dropdownMenu Widget to update the check mark
                    menuSetState(() {});
                  },
                  child: Container(
                    height: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        _isSelected
                            ? const Icon(
                                Icons.check_box_outlined,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.check_box_outline_blank,
                                color: Colors.white,
                              ),
                        const SizedBox(width: 16),
                        Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
        //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
        value: selectedItems.isEmpty ? null : selectedItems.last,
        onChanged: (value) {},
        buttonHeight: 40,
        buttonWidth: MediaQuery.of(context).size.width / 1.3,
        itemHeight: 40,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        selectedItemBuilder: (context) {
          return items.map(
            (item) {
              return Container(
                alignment: AlignmentDirectional.center,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  selectedItems.join(', '),
                  style: const TextStyle(
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              );
            },
          ).toList();
        },
      ),
    );
  }
}
