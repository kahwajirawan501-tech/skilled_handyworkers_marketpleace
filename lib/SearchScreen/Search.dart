import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/ListOfPosting.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/ListOpenQuestion.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/AppBarSearch.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController textControllerService=TextEditingController() ;
  final TextEditingController textControllerLocation=TextEditingController()  ;
   bool clickPosting=false;
   bool clickOpenQuestion=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSearch(textControllerLocation: textControllerLocation,textControllerService: textControllerService,),
      body: Container(

        color:  AppColor.backgroundColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding,vertical: AppFontStyles.aboutMe),
              child: Row(

                children: [
                  Image.asset("assets/images/Filter.png"),
                  SizedBox(width: AppFontStyles.aboutMe,),
                  Expanded(

                    child: Box(widget:GestureDetector(
                      onTap: () {
                        if(textControllerService.text.isEmpty&&textControllerLocation.text.isEmpty){
                          clickOpenQuestion=false;
                          clickPosting=false;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColor.backgroundColor,

                              content: Center(child: Text('Please select service and location first',style: TextStyle(color: AppColor.grayColorFont))),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      else{

                          setState(() {
                            clickPosting=!clickPosting;
                            if(clickPosting){
                              clickOpenQuestion=false;

                            }
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                          color: clickPosting?AppColor.orangeColor:AppColor.comment,
                        ),
                          alignment: Alignment.center,
                          child: Text("posting",style: TextStyle(color:clickPosting?Colors.white:AppColor.bluColor ),)
                      ),
                    ), height: 40, borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(width: AppFontStyles.aboutMe,),
                  Expanded(
                    child: Box(widget:GestureDetector(
                      onTap: () {
                      if(textControllerService.text.isEmpty&&textControllerLocation.text.isEmpty) {
                        clickOpenQuestion=false;
                        clickPosting=false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                      backgroundColor: AppColor.backgroundColor,

                      content: Center(child: Text('Please select service and location first',style: TextStyle(color: AppColor.grayColorFont))),
                      duration: Duration(seconds: 2),
                  ),
                       );
                      }
                    else{

                      setState(() {
                      clickOpenQuestion=!clickOpenQuestion;
                       if(clickOpenQuestion){
                          clickPosting=false;

                      }
                              });
                          }

                      },
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                            color:clickOpenQuestion?AppColor.orangeColor:AppColor.comment,
                          ),
                          child: Text("open question",style: TextStyle(color:clickOpenQuestion?Colors.white:AppColor.bluColor ))
                      ),
                    ), height: 40, borderRadius: BorderRadius.circular(10)),
                  ),

                ],
              ),
            ),
            if(textControllerLocation.text.isEmpty&&textControllerService.text.isEmpty)
              Expanded(child: Image.asset("assets/images/Illustrasi.png")),
             if(clickPosting)
               Expanded(child: ConditionalBuilder(
                   condition: clickPosting,
                   builder: (context) =>ListOfPosting() ,
                   fallback: (context) =>  Center(child: CircularProgressIndicator(color:AppColor.orangeColor,),),
               ),),
              if(clickOpenQuestion)
                Expanded(child: ConditionalBuilder(
                  condition: clickOpenQuestion,
                  builder: (context) =>ListOfOpenQuestion() ,
                  fallback: (context) =>  Center(child: CircularProgressIndicator(color:AppColor.orangeColor,),),
                ),),
          ],
        ),
      ),
    );
  }
}
