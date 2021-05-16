import 'package:flutter/material.dart';

class DetailsRow extends StatelessWidget {
  final String leftText;
  final String rightText;
  const DetailsRow({Key key, @required this.leftText, @required this.rightText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(leftText),
          Spacer(),
          Text(rightText)
        ]
      ),
    );
  }
}
