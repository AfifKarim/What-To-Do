import 'package:flutter/material.dart';

class OnboardModel {
  String img;
  String text;
  String desc;
  Color bg;
  Color button;

  OnboardModel({
    required this.img,
    required this.text,
    required this.desc,
    required this.bg,
    required this.button,
  });
}

List<OnboardModel> screens = <OnboardModel>[
  OnboardModel(
    img: 'assets/images/img-1.png',
    text: "Make To Do List",
    desc: "Check Your To Do List Everyday",
    bg: Colors.white,
    button: Color(0xFF4756DF),
  ),
  OnboardModel(
    img: 'assets/images/img-2.png',
    text: "Add / Delete To Do",
    desc: "Add A To Do With Description. To Delete A To Do Slide To The Right.",
    bg: Color(0xFF4756DF),
    button: Colors.white,
  ),
  OnboardModel(
    img: 'assets/images/img-3.png',
    text: "Update To Do",
    desc: "Click A To Do To Update Information.",
    bg: Colors.white,
    button: Color(0xFF4756DF),
  ),
];
