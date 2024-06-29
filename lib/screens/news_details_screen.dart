import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsDetails extends StatefulWidget {
 final String newImage,newsTitle, newsDate, description,url, source;



  NewsDetails(
      {
       required this.newImage,
        required this.newsTitle,
        required this.newsDate,
        required this.description,
        required this.url,
        required this.source
      });

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {


  @override
  Widget build(BuildContext context) {

    final scHeight=MediaQuery.sizeOf(context).height*1;
    final scWidth=MediaQuery.sizeOf(context).width*1;
    return  Scaffold(
      appBar: AppBar(

      ),
      body: ListView(
        children: [
          SizedBox(
            height: scHeight*0.45,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)
              ),
              child: CachedNetworkImage(
                imageUrl: widget.newImage,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
              ),
            ),
          ),
          Padding(

            padding: const EdgeInsets.all(10),
            child: Text(widget.newsTitle,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700
            ),
            ),
          ),

          Padding(

            padding: const EdgeInsets.only(
                left: 10,
                right: 10
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.source,
                  style: GoogleFonts.poppins(
                      fontSize: 13,

                  ),
                ),
                Text(widget.newsDate,
                  style: GoogleFonts.poppins(
                    fontSize: 13,

                  ),
                ),
              ],
            ),
          ),

          Padding(

            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 15
            ),
            child: Text(widget.description,
              style: GoogleFonts.poppins(
                  fontSize: 16,

              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              top: 60,
              left: 10,
              right: 10,
              bottom: 10
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,

              ),
                onPressed: () async{
                  final Uri url = Uri.parse(widget.url);
                  bool res=await launchUrl(
                    url,
                    mode: LaunchMode.inAppWebView,
                  );

                  if (!res) {
                    throw 'Could not launch $url';
                  }
                },
                child: Text(
                  "Read Full Articale"
                )
            ),
          )

        ],
      ),
    );
  }
}
