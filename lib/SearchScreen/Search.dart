import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/commintSceren.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/ListOfPosting.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/ListOpenQuestion.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/AppBarSearch.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
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
  List<Map<String, dynamic>> post=[];
  List<Map<String, dynamic>> openQuestion=[];
  Future<void> _handleRefresh() async {
    CubitSearch.get(context).changePagePost(textControllerService.text, textControllerLocation.text);
  }
  Future<void> _handleRefreshLocation() async {
    CubitSearch.get(context).changePagePostLocation( textControllerLocation.text);
  }
  Future<void> _handleRefreshService() async {
    CubitSearch.get(context).changePagePostService(textControllerService.text);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSearch(textControllerLocation: textControllerLocation,textControllerService: textControllerService,),
      body: BlocConsumer<CubitSearch,SearchStates>(
        listener: (context, state) {

        if(state is SearchPostSucssessfullStateStates){
          post=CubitSearch.get(context).postSearch;
          openQuestion=CubitSearch.get(context).openQuestionPostSearch;
          print("the length of post ");
          print(post.length);
          print("the length of openQuestion ");
          print(openQuestion.length);
        }
        else if(state is SearchPostErrorStateStates){
          showToast(text:"error in search \n", state: ToastStates.EROOR);

        }
        if(state is SearchPostOnlyServiceSucssessfullStateStates){
          post=CubitSearch.get(context).postSearchService;
          openQuestion=CubitSearch.get(context).openQuestionPostSearchService;
          print("the length of postSearchService ");
          print(post.length);
          print("the length of openQuestionPostSearchService ");
          print(openQuestion.length);
        }
        else if(state is SearchPostOnlyServiceErrorStateStates){
          showToast(text:"error in search \n", state: ToastStates.EROOR);

        }
        if(state is SearchPostOnlyLocationSucssessfullStateStates){
          post=CubitSearch.get(context).postSearchLocation;
          openQuestion=CubitSearch.get(context).openQuestionPostSearchLocation;
          print("the length of postSearchLocation ");
          print(post.length);
          print("the length of openQuestionPostSearchLocation ");
          print(openQuestion.length);
        }
        else if(state is SearchPostOnlyLocationErrorStateStates){
          showToast(text:"error in search \n", state: ToastStates.EROOR);

        }
        },
        builder: (context, state) {
          return  Container(

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

                                  content: Center(child: Text('Please select service or location first',style: TextStyle(color: AppColor.grayColorFont))),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                            else if(textControllerService.text.isNotEmpty&&textControllerLocation.text.isNotEmpty){
                              setState(() {
                                clickPosting=!clickPosting;
                                if(clickPosting){
                                  clickOpenQuestion=false;

                                }
                                CubitSearch.get(context).changePagePost(textControllerService.text, textControllerLocation.text);
                              });
                            }
                            else if(textControllerService.text.isNotEmpty&&textControllerLocation.text.isEmpty){
                              setState(() {
                                clickPosting=!clickPosting;
                                if(clickPosting){
                                  clickOpenQuestion=false;

                                }
                                CubitSearch.get(context).changePagePostService(textControllerService.text);
                              });
                            }
                            else if(textControllerService.text.isEmpty&&textControllerLocation.text.isNotEmpty){
                              setState(() {
                                clickPosting=!clickPosting;
                                if(clickPosting){
                                  clickOpenQuestion=false;

                                }
                                CubitSearch.get(context).changePagePostLocation(textControllerLocation.text);
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
                            else if(textControllerService.text.isNotEmpty&&textControllerLocation.text.isNotEmpty){
                              setState(() {
                                clickOpenQuestion=!clickOpenQuestion;
                                if(clickOpenQuestion){
                                  clickPosting=false;

                                }
                                CubitSearch.get(context).changePagePost(textControllerService.text, textControllerLocation.text);
                              });
                            }
                            else if(textControllerService.text.isNotEmpty&&textControllerLocation.text.isEmpty){
                              setState(() {
                                clickOpenQuestion=!clickOpenQuestion;
                                if(clickOpenQuestion){
                                  clickPosting=false;

                                }
                                CubitSearch.get(context).changePagePostService(textControllerService.text);
                              });
                            }
                            else if(textControllerService.text.isEmpty&&textControllerLocation.text.isNotEmpty){
                              setState(() {
                                clickOpenQuestion=!clickOpenQuestion;
                                if(clickOpenQuestion){
                                  clickPosting=false;

                                }
                                CubitSearch.get(context).changePagePostLocation(textControllerLocation.text);
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
                    condition: clickPosting && (state is !SearchPostLoadStateStates ||state is !SearchPostOnlyServiceLoadStateStates||state is !SearchPostOnlyLocationLoadStateStates),
                    builder: (context) =>CubitSearch.get(context).post.isEmpty?
                    const Center(
                     child: Text(
                     'No post yet.',
                     style:
                     TextStyle(color: Colors.grey, fontSize: 16),
                     )):RefreshIndicator(
                    color: AppColor.orangeColor,
                      onRefresh:(textControllerLocation.text.isEmpty&&textControllerService.text.isEmpty)?_handleRefresh:
                      (textControllerLocation.text.isEmpty&&textControllerService.text.isNotEmpty)?_handleRefreshService:_handleRefreshLocation,
                        child: ListOfPosting(post:post,))  ,
                    fallback: (context) =>  Center(child: CircularProgressIndicator(color:AppColor.orangeColor,),),
                  ),),


                if(clickOpenQuestion)
                  Expanded(child: ConditionalBuilder(
                    condition: clickOpenQuestion && (state is !SearchPostLoadStateStates ||state is !SearchPostOnlyServiceLoadStateStates||state is !SearchPostOnlyLocationLoadStateStates),
                    builder: (context) =>CubitSearch.get(context).openQuestionPost.isEmpty?const Center(
                     child: Text(
                    'No post yet.',
                     style:
                     TextStyle(color: Colors.grey, fontSize: 16),
          )):RefreshIndicator(
                      color: AppColor.orangeColor,
                        onRefresh:(textControllerLocation.text.isEmpty&&textControllerService.text.isEmpty)?_handleRefresh:
                        (textControllerLocation.text.isEmpty&&textControllerService.text.isNotEmpty)?_handleRefreshService:_handleRefreshLocation,
                        child: ListOfOpenQuestion(openQuestionPost:openQuestion ,))  ,
                    fallback: (context) =>  Center(child: CircularProgressIndicator(color:AppColor.orangeColor,),),
                  ),),
              ],
            ),
          );
        },
      ),
    );
  }
}
