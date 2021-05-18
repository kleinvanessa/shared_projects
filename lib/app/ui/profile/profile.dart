import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/layout.dart';
import 'package:shared_projects/app/resources/circleAvatar.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          children: <Widget>[
            // construct the profile details widget here
            SizedBox(
              height: 180,
              child: Center(
                child: Text(
                  'Profile Details Goes here',
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
                      text: 'Primeira aba',
                    ),
                    Tab(
                      text: 'segunda aba',
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
                      child: Text(
                        'primeira',
                      ),
                    ),
                  ),

                  // second tab bar viiew widget
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        'segunda',
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
