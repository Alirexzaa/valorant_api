import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.size,
    required this.nameController,
    required this.name,
    required this.regex,
    required this.error,
    required this.backColor,
  });

  final Size size;
  final String name;
  final String regex;
  final String error;
  final TextEditingController nameController;
  final String backColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: HexColor(backColor).withOpacity(0.5),
        border: Border.all(
          color: HexColor(backColor),
        ),
      ),
      width: size.width,
      height: 100,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: nameController,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          errorStyle: const TextStyle(color: Colors.black, fontSize: 18),
          label: Text(name),
          labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 23,
          ),
          border: InputBorder.none,
          counterStyle: const TextStyle(color: Colors.white),
        ),
        validator: (value) {
          if (!RegExp(regex).hasMatch(value.toString())) {
            return error;
          }
          return null;
        },
      ),
    );
  }
}

class CustomLogInWidget extends StatelessWidget {
  const CustomLogInWidget({
    super.key,
    required this.size,
    required this.nameController,
    required this.name,
    required this.regex,
    required this.error,
    required this.onChanged,
    required this.onTap,
    required this.keyboardType,
    required this.obscure,
  });

  final Size size;
  final String name;
  final String regex;
  final String error;
  final TextEditingController nameController;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextInputType keyboardType;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: 80,
          child: SvgPicture.asset('assets/images/loginbox1.svg'),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          width: size.width,
          height: 110,
          child: TextFormField(
            obscureText: obscure,
            keyboardType: keyboardType,
            controller: nameController,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              errorStyle: TextStyle(color: HexColor('ff4655'), fontSize: 18),
              label: Text(name),
              labelStyle: const TextStyle(
                color: Colors.white,
                fontSize: 23,
              ),
              border: InputBorder.none,
              counterStyle: const TextStyle(color: Colors.white),
            ),
            onChanged: onChanged,
            onTap: onTap,
            validator: (value) {
              if (!RegExp(regex).hasMatch(value.toString())) {
                return error;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
