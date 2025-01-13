import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/constants.dart';

class FilterModal extends StatelessWidget {
  final Function(String?) onFilterSelected;

  const FilterModal({super.key, required this.onFilterSelected});

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              onFilterSelected(null);
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
              child: Text(
                "Clear All",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      ...AppConstants.categories.map((v) => ListTile(
            title: Text(v),
            onTap: () {
              onFilterSelected(v);
              Navigator.pop(context);
            },
          ))
    ]);
  }
}
