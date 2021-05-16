import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:minecraft_players/src/utils.dart';

class EnumDropdown<T> extends StatelessWidget {
  final T value;
  final List<T> values;
  final ValueChanged<T> onChanged;

  const EnumDropdown(
      {Key key,
      @required this.value,
      @required this.values,
      @required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      isExpanded: true,
      icon: const Icon(Icons.arrow_downward),
      value: value,
      items: values
          .map((e) => DropdownMenuItem(
            child: Text(Utils.translateEnum(context, e)), 
            value: e)
          )
          .toList(),
      onChanged: onChanged
    );
  }
}
