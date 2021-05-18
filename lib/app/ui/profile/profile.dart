import 'package:flutter/material.dart';
import 'package:shared_projects/app/resources/circleAvatar.dart';
import 'package:shared_projects/app/ui/profile/myData.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xFF583D72)),
          title: Text(
            'Perfil',
            style: TextStyle(
              color: Color(0xFF583D72),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          // give the app bar rounded corners
        ),
        body: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // construct the profile details widget here
            SizedBox(
              height: 130,
              child: Center(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 25,
                    ),
                    CircularAvatar(isButton: false),
                    SizedBox(
                      width: 50,
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(height: 25),
                        Text(
                          'Vanessa Klein',
                          style: TextStyle(
                              color: Color(0xFF583D72),
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(
                          '@vanessalklein',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF000000).withOpacity(.6),
                          ),
                        ),
                        Text(
                          'Guaíba, RS',
                          style: TextStyle(
                              color: Color(0xFF583D72),
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Text(
                          'Estudante na UERGS',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF000000).withOpacity(.6),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // the tab bar with two items
            SizedBox(
              height: 50,
              child: AppBar(
                backgroundColor: Colors.white,
                bottom: TabBar(
                  labelColor: Color(0xFF583D72),
                  indicatorColor: Color(0xFF583D72),
                  unselectedLabelColor: Color(0xFF000000).withOpacity(.3),
                  tabs: [
                    Tab(
                      text: 'Meus Dados',
                    ),
                    Tab(
                      text: 'Currículo',
                    ),
                    Tab(
                      text: 'Histórico',
                    ),
                  ],
                ),
              ),
            ),

            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [
                  // first tab bar view widget
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: MyDataPage(),
                    ),
                  ),

                  // second tab bar viiew widget
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        'Curriculo',
                      ),
                    ),
                  ),

                  // third tab bar viiew widget
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        'Historico',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
