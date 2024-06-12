
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryScren extends StatefulWidget {
  const CategoryScren({super.key});

  @override
  State<CategoryScren> createState() => _CategoryScrenState();
}

class _CategoryScrenState extends State<CategoryScren> {


  String category="general";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News" ,style: GoogleFonts.poppins(fontSize:24,fontWeight: FontWeight.w700),),
        centerTitle: true,
      ),
    );
  }
}
