import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constant.dart';
import '../screens/home.dart';
import 'onboard_model.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoradState createState() => _OnBoradState();
}

class _OnBoradState extends State<OnBoard> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnBoardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: currentIndex % 2 == 0 ? kwhite : kblue,
        appBar: AppBar(
          backgroundColor: currentIndex % 2 == 0 ? kwhite : kblue,
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () async {
                await _storeOnBoardInfo();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: Text(
                "Skip",
                style: TextStyle(
                  color: currentIndex % 2 == 0 ? kblack : kwhite,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: PageView.builder(
              itemCount: screens.length,
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(screens[index].img),
                    Container(
                      height: 10.0,
                      child: ListView.builder(
                          itemCount: screens.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    margin:
                                    EdgeInsets.symmetric(horizontal: 3.0),
                                    width: currentIndex == index ? 25.0 : 8.0,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: currentIndex == index
                                          ? kblack
                                          : kbrown300,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ))
                              ],
                            );
                          }),
                    ),
                    Text(
                      screens[index].text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold,
                        color: index % 2 == 0 ? kblack : kwhite,
                      ),
                    ),
                    Text(screens[index].desc,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: index % 2 == 0 ? kblack : kwhite,
                        )),
                    InkWell(
                      onTap: () async {
                        if (index == screens.length - 1) {
                          await _storeOnBoardInfo();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        }

                        _pageController.nextPage(
                          duration: Duration(microseconds: 300),
                          curve: Curves.bounceIn,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: index % 2 == 0 ? kblue : kwhite,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Text("Next",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: index % 2 == 0 ? kwhite : kblue)),
                          SizedBox(width: 15.0),
                          Icon(
                            Icons.arrow_forward_sharp,
                            color: index % 2 == 0 ? kwhite : kblue,
                          ),
                        ]),
                      ),
                    ),
                  ],
                );
              }),
        ));
  }
}
