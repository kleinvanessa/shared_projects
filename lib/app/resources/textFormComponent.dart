import 'dart:ffi';

import 'package:flutter/material.dart';

class TextFormComponent extends StatelessWidget {
  // @override
  final String textFormContent;
  final Color colorTextContent;
  final double fontSizeComponent;
  final Color enableBorderColorComponent;
  final Color focusedBorderColorComponent;
  const TextFormComponent({
    @required this.textFormContent,
    @required this.colorTextContent,
    @required this.fontSizeComponent,
    @required this.enableBorderColorComponent,
    @required this.focusedBorderColorComponent,
  });

  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: '$textFormContent',
        hintStyle: TextStyle(
          fontSize: fontSizeComponent,
          color: colorTextContent,
          fontStyle: FontStyle.italic,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: enableBorderColorComponent,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: focusedBorderColorComponent),
        ),
      ),
    );
  }
}
