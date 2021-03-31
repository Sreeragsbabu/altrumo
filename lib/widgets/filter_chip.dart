import 'package:flutter/material.dart';

class FilterChips extends StatelessWidget {
  final Set<String> all, valid, selected;
  final showInvalid;
  final ValueChanged<String> onSelected, onDeselected;

  FilterChips({
    Key key,
    this.all,
    this.valid,
    this.selected,
    this.showInvalid = false,
    this.onSelected,
    this.onDeselected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> allList = all.toList()..sort();
    if (!showInvalid) allList.removeWhere((v) => !valid.contains(v));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
         // margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Wrap(
           spacing: 5.0,
            //runSpacing: 10.0,
            children: allList.map((b) {
              return FilterChip(
                //showCheckmark: false,
                labelStyle: TextStyle(color: Colors.white),
                backgroundColor: Colors.black54,
                selectedColor: Colors.blue,
                checkmarkColor: Colors.white,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                label: Text(b),
                selected: selected.contains(b),
                onSelected: !valid.contains(b)
                    ? null
                    : (bool sel) {
                        if (sel)
                          onSelected(b);
                        else
                          onDeselected(b);
                      },
              );
            }).toList(),
          ),
        ),
        Divider(color: Colors.grey,)
      ],
    );
  }
}
