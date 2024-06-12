
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/models/category_news_model.dart';

import '../service/newsapi_service.dart';

class CategoryScren extends StatefulWidget {
  const CategoryScren({super.key});

  @override
  State<CategoryScren> createState() => _CategoryScrenState();
}

class _CategoryScrenState extends State<CategoryScren> {


  String category="General";

  List<String> CategorysList=[
    "General",
    "Cricket",
    "Politics",
    "Bangladesh",
    "India",
    "Pakistan"
  ];

  @override
  Widget build(BuildContext context) {
    final scHeight=MediaQuery.sizeOf(context).height*1;
    final scWidth=MediaQuery.sizeOf(context).width*1;
    return Scaffold(
      appBar: AppBar(
        title: Text("News" ,style: GoogleFonts.poppins(fontSize:24,fontWeight: FontWeight.w700),),
        centerTitle: true,
      ),

      body: Column(
        children: [
          SizedBox(
            height: 50,

            child: ListView.separated(
              scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return TextButton(
                      onPressed: (){
                        setState(() {
                          category=CategorysList[index];
                        });
                      },
                      child: Text(CategorysList[index]),
                    style: TextButton.styleFrom(
                      backgroundColor:category== CategorysList[index] ? Colors.blueAccent:Colors.grey,
                    foregroundColor:Colors.white
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 10,
                  );
                },
                itemCount: CategorysList.length
            ),
          ),

          Expanded(child: FutureBuilder<CategoryNewsModel>(
            future: NewsApiService().FetchCategoryNews(category: category),

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
                      padding: EdgeInsets.all(20),
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
          ))
        ],
      ),
    );
  }
}
