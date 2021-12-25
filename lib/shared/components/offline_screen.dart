import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget emptyPage() => 
Center(
  child: SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

       SvgPicture.asset('assets/images/No-con.svg' ,
       width: 250,
       height: 250,),
        const SizedBox(height: 50,),

        const Text(
          'Check Internet Connection',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'normal'
          ),
        ),
        
      ],
    ),
  ),
);

Widget emptyPage2({ required String image ,required String text ,required double width , required double hight}) => 
Center(
  child: SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(image ,
       width: width,
       height: hight,),
       const SizedBox(height: 50,),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontFamily: 'normal',
            color: Colors.grey
          ),
        ),
        
      ],
    ),
  ),
);