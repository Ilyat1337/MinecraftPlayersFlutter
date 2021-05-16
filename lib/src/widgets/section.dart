import 'dart:ffi';

import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final String sectionTitle;
  final List<Widget> children;
  final Widget rightWidget;

  const Section({Key key, @required this.sectionTitle, @required this.children,
    this.rightWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(sectionTitle),
                    Spacer(),
                    rightWidget == null ?
                      SizedBox.shrink():
                      rightWidget
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(children: this.children)
                )
              ],
            )
        )
    );
  }
}
