import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Color color;
  final String text;
  final Color textcolor;
  final ontapped;
  const Button({super.key, required this.color, required this.text, required this.textcolor, this.ontapped });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(child: Text(text,style: TextStyle(color: textcolor,fontSize: 20),)),
            
          ),
        ),
      ),
    );
  }
}