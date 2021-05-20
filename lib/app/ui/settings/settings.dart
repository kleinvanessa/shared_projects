import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/layout.dart';

class SettingsPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SettingsPage> {
  bool isSwitched = false;
  Widget build(BuildContext context) {
    return Layout.render(
        tittlePage: 'Configurações',
        content: SingleChildScrollView(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Notificações',
                    style: TextStyle(color: Color(0xFF583D72), fontSize: 17),
                  ),
                  SizedBox(
                    width: 120,
                  ),
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                        print(isSwitched);
                      });
                    },
                    activeTrackColor: Color(0xFF583D72).withOpacity(0.3),
                    activeColor: Color(0xFF583D72),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
