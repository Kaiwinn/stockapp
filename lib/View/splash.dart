import 'package:flutter/material.dart';
import 'package:stockapp/View/navBar.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              height: screenHeight,
              width: screenWidth,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset("assets/image/1.gif"),
                    Column(
                      children: [
                        Text(
                          "The Future",
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Learn more about cryptocurrency, look to",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 138, 138, 138),
                          ),
                        ),
                        Text(
                          "the future in IO Crypto",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 138, 138, 138),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.14),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NavBar()));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 247, 188, 27),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.055,
                                  vertical: screenHeight * 0.015),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Create Portfolio'.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  RotationTransition(
                                    turns: AlwaysStoppedAnimation(310 / 360),
                                    child: Icon(Icons.arrow_forward_rounded),
                                  )
                                ],
                              ),
                            )),
                      ),
                    )
                  ]),
            )));
  }
}
