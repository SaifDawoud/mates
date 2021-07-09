import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../screens/login_screen.dart';

class IntroScreen extends StatefulWidget {
  static const String routeName = 'intro_screen';

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController myController = PageController();
  int pageIndex = 0;

  @override
  void dispose() {
    super.dispose();
    myController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
                      },
                      child: Text("Skip"))
                ],
              ),
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: const AssetImage('assets/images/intro.png'))),
                padding: EdgeInsets.all(4),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 150,
                child: PageView(
                  controller: myController,
                  children: List.generate(3, (index) {
                    switch (index) {
                      case 0:
                        return Center(child: Text('simply work together'));
                        break;
                      case 1:
                        return Center(
                            child: Text(
                                'Meet with your Team Mates through video rooms'));
                        break;
                      case 2:
                        return Center(
                            child: Text('one place to put your files'));
                        break;
                      default:
                        return null;
                    }
                  }),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 8,
                      child: SmoothPageIndicator(
                        controller: myController,
                        count: 3,
                        effect: ExpandingDotsEffect(
                            dotHeight: 8,
                            dotWidth: 8,
                            dotColor: Colors.blue,
                            activeDotColor: Colors.blue,
                            expansionFactor: 3),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (myController.page.toInt() != 2) {
                          myController.nextPage(
                              duration: Duration(milliseconds: 400),
                              curve: Curves.easeIn);
                        } else {
                          Navigator.of(context)
                              .pushReplacementNamed(LoginScreen.routeName);
                        }
                      },
                      child: Text("Next"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void pageViewText(String text) {}
}
