import 'package:flutter/material.dart';

class TextFormComponent extends StatelessWidget {
  // @override
  final String textFormContent;
  final String labelText;
  final Color colorTextContent;
  final double fontSizeComponent;
  final Color enableBorderColorComponent;
  final Color focusedBorderColorComponent;
  final bool obscureText;
  final TextEditingController controller;
  final validator;
  final TextInputType keyboradType;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final FocusNode nextFocus;
  const TextFormComponent({
    @required this.textFormContent,
    @required this.labelText,
    @required this.colorTextContent,
    @required this.fontSizeComponent,
    @required this.enableBorderColorComponent,
    @required this.focusedBorderColorComponent,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.keyboradType,
    this.textInputAction,
    this.focusNode,
    this.nextFocus,
  });

  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: enableBorderColorComponent,
      onFieldSubmitted: (String text) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      focusNode: focusNode,
      textInputAction: textInputAction,
      keyboardType: keyboradType,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: '$labelText',
        labelStyle: TextStyle(
          color: colorTextContent,
        ),
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
          borderSide: BorderSide(
            color: focusedBorderColorComponent,
          ),
        ),
      ),
    );
  }
}
