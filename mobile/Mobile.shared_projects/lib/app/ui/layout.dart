import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Layout {
  static Widget render({
    Widget content,
    Widget drawerComponent,
    final tittlePage,
  }) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF583D72)),
        title: Text(
          tittlePage,
          style: TextStyle(
            color: Color(0xFF583D72),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      drawer: drawerComponent,
      body: SafeArea(
        // minimum: const EdgeInsets.all(0),
        child: content,
      ),
    );
  }
}
