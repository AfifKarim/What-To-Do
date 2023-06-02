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
    text: "First",
    desc: "First Screen",
    bg: Colors.white,
    button: Color(0xFF4756DF),
  ),
  OnboardModel(
    img: 'assets/images/img-2.png',
    text: "Second",
    desc: "Second Screen",
    bg: Color(0xFF4756DF),
    button: Colors.white,
  ),
  OnboardModel(
    img: 'assets/images/img-3.png',
    text: "Third",
    desc: "Third Screen",
    bg: Colors.white,
    button: Color(0xFF4756DF),
  ),
];
