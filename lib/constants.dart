import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//design

var kMyTextStyle = GoogleFonts.orbitron(fontSize: 26,color: const Color.fromRGBO(80, 159, 212,1));
var kMybodyTextStyleLarge = GoogleFonts.orbitron(fontSize: 24,color: const Color.fromRGBO(80, 159, 212,1));
var kMybodyTextStyleMedium = GoogleFonts.orbitron(fontSize: 20,color: const Color.fromRGBO(80, 159, 212,1));
var kMybodyTextStyleSmall = GoogleFonts.orbitron(fontSize: 14,color: const Color.fromRGBO(80, 159, 212,1));
var kMyElevatetButtonStyle = GoogleFonts.orbitron(fontSize: 18,color: const Color.fromRGBO(80, 159, 212,1));
var kHintTextFild= GoogleFonts.orbitron(fontSize: 14, color: Colors.grey.shade600);
var kMyLabelFormFieldStyleMedium = GoogleFonts.orbitron(fontSize: 24,color: Colors.grey.shade400);

//API Notion
//var kBaeraToken = 'secret_zHRSiQ1bHltlLkZ4zLwNEG5D9eTkrX69yY5YZccB5kc';
//var kDbHabitId = '7f332bc0-1eba-480a-9121-4ed2a3d1b541';
//var kUrlListHabit = 'https://api.notion.com/v1/databases/7f332bc0-1eba-480a-9121-4ed2a3d1b541/query';

var khttpHeader = {
  HttpHeaders.authorizationHeader: 'Bearer ${dotenv.env['BAERATOKEN']}',
  'Content-Type': 'application/json',
  'Notion-Version': '2022-06-28'
};

var kDeleteUpdateMap = {
    'properties': {
      'HideHabit': {
        'number': 1,
      }
    },
  };