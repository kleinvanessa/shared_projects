import 'package:flutter/material.dart';
import 'package:shared_projects/app/models/curriculum.dart';
import 'package:shared_projects/app/models/user.dart';
import 'package:shared_projects/app/resources/circleAvatar.dart';
import 'package:shared_projects/app/ui/profile/myData.dart';
import 'package:shared_projects/app/ui/profile/curriculum.dart';
import 'package:shared_projects/app/ui/profile/payment.dart';
import 'package:shared_projects/app/ui/profile/changePicture.dart';
import 'package:shared_projects/app/utils/nav.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<User> future = User.get();
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
        body: SafeArea(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              //_sizedBoxInfos(context),
              FutureBuilder<User>(
                  future: future,
                  builder: (context, snapshot) {
                    User user = snapshot.data;
                    return user != null
                        ? _sizedBoxInfos(context, user)
                        : Container();
                  }),
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
                        text: 'Pagamento',
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
                        child: CurriculumPage(),
                      ),
                    ),

                    // third tab bar viiew widget
                    Container(
                      color: Colors.white,
                      child: Center(
                        child: PaymentPage(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _sizedBoxInfos(context, user) {
    // construct the profile details widget here
    Future<Curriculum> futureC = Curriculum.get();
    return Row(
      children: <Widget>[
        SizedBox(
          width: 25,
        ),
        Stack(
          children: <Widget>[
            CircularAvatar(isButton: false, image: 'assets/img/profile.jpg'),
            IconButton(
                iconSize: 20,
                alignment: Alignment.lerp(
                    Alignment.bottomCenter, Alignment.bottomLeft, 3.5),
                color: Color(0xFF583D72),
                //padding: EdgeInsets.all(60),
                icon: Icon(Icons.add_circle),
                onPressed: () {
                  push(context, ChangePicture());
                }),
          ],
        ),
        SizedBox(
          width: 30,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 10),
              Text(
                "${user.name + " " + user.lastName}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color(0xFF583D72),
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              /*   Text(
                "${user.lastName}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color(0xFF583D72),
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),*/
              Text(
                "${user.email}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF000000).withOpacity(.6),
                ),
              ),
              //_textInst(),
              //_textCourse(),
              FutureBuilder<Curriculum>(
                  future: futureC,
                  builder: (context, snapshot) {
                    Curriculum curriculum = snapshot.data;
                    return curriculum != null
                        ? _textInst(curriculum.institution)
                        : Text("");
                  }),
              FutureBuilder<Curriculum>(
                  future: futureC,
                  builder: (context, snapshot) {
                    Curriculum curriculum = snapshot.data;
                    return curriculum != null
                        ? _textCourse(curriculum.course)
                        : Text("");
                  }),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ],
    );
  }

  _textInst(inst) {
    print("aquiiiiiiiiiiiiii   $inst");
    return Text(
      "${inst}",
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 15,
        color: Color(0xFF583D72),
      ),
    );
  }

  _textCourse(course) {
    return Text(
      "$course",
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 12,
        color: Color(0xFF000000).withOpacity(.6),
      ),
    );
  }
}
