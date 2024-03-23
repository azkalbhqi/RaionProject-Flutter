// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:CampVestor/pages/onboarding_page.dart';
import 'package:CampVestor/pages/register_page.dart';
import '../styles/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './widget/buttons.dart';

class WhoAreYouPage extends StatefulWidget {
  const WhoAreYouPage({super.key});

  @override
  State<WhoAreYouPage> createState() => _WhoAreYouPageState();
}

class _WhoAreYouPageState extends State<WhoAreYouPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          color: ColorStyles.primary,
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const OnboardingPage()));
          },
        ),
        title: Text(
          "Who are you?",
          style: GoogleFonts.poppins(
            fontSize: 16
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Buttons(
              text: "Investor", 
              onClicked: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
              }, 
              width: MediaQuery.of(context).size.width, 
              backgroundColor: ColorStyles.primary, 
              fontColor: ColorStyles.white
            ),
            const SizedBox(height: 27,),
            Text(
              "OR",
              style: GoogleFonts.poppins(
                color: ColorStyles.greyText,
                fontSize: 16
              ),
            ),
            const SizedBox(height: 27,),
            Buttons(
              text: "UMKM", 
              onClicked: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
              },      
              width: MediaQuery.of(context).size.width, 
              backgroundColor: ColorStyles.primary, 
              fontColor: ColorStyles.white
            ),
          ]
        ),
      ),
    );
  }
}