import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Constants {
  static Color primaryColor = HexColor('0f1923');
  static Color secondPrimaryColor = HexColor('e9404f');

  static String mapPicure = 'assets/images/map.png';
  static String bundlesPicure = 'assets/images/16.png';
  static String weaponPicure = 'assets/images/weapon1.png';
  static String agentPicure = 'assets/images/13.png';
  static String searchBoxPicture = 'assets/images/SearchBox.svg';
  static String redBoxPicture = 'assets/images/red_box.svg';
  static String bigBlackPicture = 'assets/images/bigBack.svg';
  static String selectedBoxPicture = 'assets/images/selectedBox.svg';
  static String boxPicture = 'assets/images/Box.svg';
  static String blackBoxPicture = 'assets/images/blackBox.svg';
  static String animatedLoginCharacter =
      'assets/animation/animated_login_character.riv';

  static String loadingRiveAnimation = 'assets/animation/wait.riv';
  static String emailReGex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static String passWordReGex =
      r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$';
  static String nameReGex = r'([a-zA-Z0-9_\s]+)';
}
