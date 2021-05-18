import 'package:flutter/material.dart';
import 'package:shared_projects/app/ui/home/homeView.dart';
import 'package:shared_projects/app/ui/projects/projectsView.dart';
import 'package:shared_projects/app/ui/chat/chatView.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  PageController _pageController = PageController();
  List<Widget> _screens = [HomeView(), ProjectsView(), ChatView()];

  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        //selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: _selectedIndex == 0
                    ? Color(0xFF583D72)
                    : Color(0xFF000000).withOpacity(.3)),
            title: Text('Home',
                style: TextStyle(
                    color: _selectedIndex == 0
                        ? Color(0xFF583D72)
                        : Color(0xFF000000).withOpacity(.3))),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article,
                color: _selectedIndex == 1
                    ? Color(0xFF583D72)
                    : Color(0xFF000000).withOpacity(.3)),
            title: Text('Projetos',
                style: TextStyle(
                    color: _selectedIndex == 1
                        ? Color(0xFF583D72)
                        : Color(0xFF000000).withOpacity(.3))),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble,
                color: _selectedIndex == 2
                    ? Color(0xFF583D72)
                    : Color(0xFF000000).withOpacity(.3)),
            title: Text('Chat',
                style: TextStyle(
                    color: _selectedIndex == 2
                        ? Color(0xFF583D72)
                        : Color(0xFF000000).withOpacity(.3))),
          ),
        ],
      ),
    );
  }
}