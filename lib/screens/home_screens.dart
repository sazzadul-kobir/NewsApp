


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/models/category_news_model.dart';
import 'package:newsapp/models/headline_models.dart';
import 'package:newsapp/screens/category_screen.dart';
import 'package:newsapp/service/newsapi_service.dart';


enum Newsoutlet{
  bbcNews,
  aryNews,
  alJazeera,
  independent,
  reuters,
  cnn
}
Newsoutlet Selectedenum=Newsoutlet.bbcNews;
String? SelectedName="bbc-news";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final scHeight=MediaQuery.sizeOf(context).height*1;
    final scWidth=MediaQuery.sizeOf(context).width*1;
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<Newsoutlet>(
            initialValue:Selectedenum ,
              onSelected: (value) {
                if(Newsoutlet.bbcNews==value){
                  SelectedName="bbc-news";
                }
                if(Newsoutlet.aryNews==value){
                  SelectedName="ary-news";
                }

                if(Newsoutlet.alJazeera==value){
                  SelectedName="al-jazeera-english";
                }

                setState(() {
                  Selectedenum=value;
                });
              },
              itemBuilder:(context) => <PopupMenuEntry<Newsoutlet>>[
                PopupMenuItem(

                  value: Newsoutlet.bbcNews,
                    child:Text("BBC News")
                ),

                PopupMenuItem(

                    value: Newsoutlet.aryNews,
                    child:Text("Ary News")
                ),
                PopupMenuItem(

                    value: Newsoutlet.alJazeera,
                    child:Text("alJazeera")
                )
              ],
          )
        ],
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder:(context) {
                  return CategoryScren();
                },
            ));
          },
            icon: Image.asset("assets/images/category_icon.png",
            width: 30,
              height: 30,
            )
        ),
        title: Text("News" ,style: GoogleFonts.poppins(fontSize:24,fontWeight: FontWeight.w700),),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(

            height: scHeight*.55,
            width: double.infinity,
            child: FutureBuilder<HeadlineModel>(
              future: NewsApiService().FetchHeadlineData(selectedName:SelectedName!),

              builder: (context, snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(
                    child: SpinKitFadingFour(
                      size: 40,
                      color: Colors.blue,
                    ),
                  );
                }else if(snapshot.hasError){
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else{
                  print(snapshot.data!.articles!.length);
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 20,
                      );
                    },

                    itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder:(context, index){
                        return SizedBox(

                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                                Container(

                                  height: scHeight*.6,
                                  width: scWidth*.9,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: scWidth*.01
                                  ),

                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data!.articles![index].urlToImage!,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => SpinKitFadingCircle(
                                        color: Colors.amber,
                                        size: 50,
                                      ),
                                      errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.redAccent,),
                                    ),
                                  ),
                                ),


                              Positioned(
                                bottom: 20,
                                child: Card(

                                  color: Colors.white,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Container(

                                    padding: EdgeInsets.all(10),
                                    height: scHeight*.22,
                                    width: scWidth*.8,


                                    child: Column(

                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Text(

                                                snapshot.data!.articles![index].title!,
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,

                                              ),
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,

                                            ),
                                          ),
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data!.articles![index].source!.name!,
                                              textAlign: TextAlign.end,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15
                                              ),
                                            ),

                                            Text(

                                              DateFormat('dd/MM/yy').format(DateTime.parse(snapshot.data!.articles![index].publishedAt!)),
                                              textAlign: TextAlign.end,

                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                  );
                }
              },
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(
              vertical: 10
            ),
            width: double.infinity,
            height: scHeight*.5,
            child: FutureBuilder<CategoryNewsModel>(
              future: NewsApiService().FetchCategoryNews(category: SelectedName!),

              builder: (context, snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(
                    child: SpinKitFadingFour(
                      size: 40,
                      color: Colors.blue,
                    ),
                  );
                }else if(snapshot.hasError){
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else{
                  print(snapshot.data!.articles!.length);
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },

                    itemCount: snapshot.data!.totalResults!,
                    scrollDirection: Axis.vertical,
                    itemBuilder:(context, index){
                      print(snapshot.data!.articles!.length,);
                      return Container(
                        padding: EdgeInsets.all(10),
                        height: scHeight*.20,
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 2,
                              child:ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data!.articles![index].urlToImage!,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => SpinKitFadingCircle(
                                    color: Colors.amber,
                                    size: 50,
                                  ),
                                  errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.redAccent,),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: 3,
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot.data!.articles![index].source!.name!,
                                          textAlign: TextAlign.end,
                                          style: GoogleFonts.poppins(
                                              fontSize: 15
                                          ),
                                        ),
                                        Text(

                                          DateFormat('dd/MM/yy').format(DateTime.parse(snapshot.data!.articles![index].publishedAt!)),
                                          textAlign: TextAlign.end,

                                        )
                                      ],
                                    ),

                                    Expanded(
                                      child: Center(
                                        child: Text(

                                          snapshot.data!.articles![index].title!,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,

                                          ),
                                          maxLines: 2,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,

                                        ),
                                      ),
                                    ),

                                  ],
                                )
                            )
                          ],
                        ),



                      );
                    },
                  );
                }
              },
            ),
          ),


        ],
      ),
    );
  }
}
