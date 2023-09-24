import 'package:flutter/material.dart';
import 'package:stockapp/View/home.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  List<Widget> pages = [
    Home(),
    Home(),
    Home(),
    Home(),
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/1.1.png",
                height: screenHeight * 0.03,
                color: Color.fromARGB(255, 126, 126, 126),
              ),
              label: "",
              activeIcon: Image.asset(
                "assets/icons/1.2.png",
                height: screenHeight * 0.03,
                color: Color.fromARGB(255, 247, 188, 27),
              )),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/2.1.png",
                height: screenHeight * 0.03,
                color: Color.fromARGB(255, 126, 126, 126),
              ),
              label: "",
              activeIcon: Image.asset(
                "assets/icons/2.2.png",
                height: screenHeight * 0.03,
                color: Color.fromARGB(255, 247, 188, 27),
              )),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/3.1.png",
                height: screenHeight * 0.03,
                color: Color.fromARGB(255, 126, 126, 126),
              ),
              label: "",
              activeIcon: Image.asset(
                "assets/icons/3.2.png",
                height: screenHeight * 0.03,
                color: Color.fromARGB(255, 247, 188, 27),
              )),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/4.1.png",
                height: screenHeight * 0.03,
                color: Color.fromARGB(255, 126, 126, 126),
              ),
              label: "",
              activeIcon: Image.asset(
                "assets/icons/4.2.png",
                height: screenHeight * 0.03,
                color: Color.fromARGB(255, 247, 188, 27),
              )),
        ],
      ),
    ));
  }
}
