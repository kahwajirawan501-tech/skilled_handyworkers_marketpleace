import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:skilled_handyworkers_marketpleace/SearchScreen/ListOfPosting.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/ListOpenQuestion.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/AppBarSearch.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends  State<Search> {
  final TextEditingController textControllerService = TextEditingController();
  final TextEditingController textControllerLocation = TextEditingController();
  bool clickPosting = false;
  bool clickOpenQuestion = false;
  List<Map<String, dynamic>> post = [];
  List<Map<String, dynamic>> openQuestion = [];

  bool serviceAndLocation=false;
  bool service=false;
  bool location=false;
  bool serviceAndLocationPost=false;
  bool servicePost=false;
  bool locationPost=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSearch(
        textControllerLocation: textControllerLocation,
        textControllerService: textControllerService,
      ),
      body: BlocConsumer<CubitSearch, SearchStates>(
        listener: (context, state) {
          if (state is SearchPostOnlyLocationSucssessfullStateStates ||
              state is SearchPostOnlyServiceSucssessfullStateStates ||
              state is SearchPostSucssessfullStateStates) {
            setState(() {
              if (state is SearchPostOnlyLocationSucssessfullStateStates) {
                post = CubitSearch.get(context).postSearchLocation;
                openQuestion = CubitSearch.get(context).openQuestionPostSearchLocation;
              } else if (state is SearchPostOnlyServiceSucssessfullStateStates) {
                post = CubitSearch.get(context).postSearchService;
                openQuestion = CubitSearch.get(context).openQuestionPostSearchService;
              }  if (state is SearchPostSucssessfullStateStates) {
                post = CubitSearch.get(context).postSearch;
                openQuestion = CubitSearch.get(context).openQuestionPostSearch;
              }
            });
          }},
        builder: (context, state) {
          return Container(
            color: AppColor.backgroundColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppFontStyles.padding,
                      vertical: AppFontStyles.aboutMe),
                  child: Row(
                    children: [
                      Image.asset("assets/images/Filter.png"),
                      SizedBox(width: AppFontStyles.aboutMe),
                      Expanded(
                        child: Box(
                            widget: GestureDetector(
                              onTap: () {
                                if (textControllerService.text.isEmpty &&
                                    textControllerLocation.text.isEmpty) {
                                  clickOpenQuestion = false;
                                  clickPosting = false;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: AppColor.backgroundColor,
                                      content: Center(
                                          child: Text(
                                              '335'.tr,
                                              style: TextStyle(
                                                  color: AppColor.grayColorFont))),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                } else if (textControllerService.text.isNotEmpty &&
                                    textControllerLocation.text.isEmpty) {
                                  setState(() {
                                    clickPosting = !clickPosting;
                                    if (clickPosting) {
                                      clickOpenQuestion = false;
                                      post.clear();
                                      servicePost=true;
                                      CubitSearch.get(context).currentPage=1;

                                    }
                                    CubitSearch.get(context).getPostForService(textControllerService.text,CubitSearch.get(context).currentPage);


                                  });
                                } else if (textControllerService.text.isEmpty &&
                                    textControllerLocation.text.isNotEmpty) {
                                  setState(() {
                                    clickPosting = !clickPosting;
                                    if (clickPosting) {
                                      clickOpenQuestion = false;
                                      post.clear();
                                      locationPost=true;
                                      CubitSearch.get(context).currentPage=1;

                                    }
                                    CubitSearch.get(context).getPostForLocation(textControllerLocation.text,CubitSearch.get(context).currentPage);


                                  });
                                } else if (textControllerService.text.isNotEmpty &&
                                    textControllerLocation.text.isNotEmpty) {
                                  setState(() {
                                    clickPosting = !clickPosting;
                                    if (clickPosting) {
                                      clickOpenQuestion = false;
                                      post.clear();
                                      serviceAndLocationPost=true;
                                      CubitSearch.get(context).currentPage=1;

                                    }
                                    CubitSearch.get(context).getPostForLocationAndService(textControllerService.text,textControllerLocation.text,CubitSearch.get(context).currentPage);


                                  });
                                }
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: clickPosting
                                        ? AppColor.orangeColor
                                        : AppColor.comment,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "103".tr,
                                    style: TextStyle(
                                        color: clickPosting
                                            ? Colors.white
                                            : AppColor.bluColor),
                                  )),
                            ),
                            height: 40,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      SizedBox(width: AppFontStyles.aboutMe),
                      Expanded(
                        child: Box(
                            widget: GestureDetector(
                              onTap: () {
                                if (textControllerService.text.isEmpty &&
                                    textControllerLocation.text.isEmpty) {
                                  clickOpenQuestion = false;
                                  clickPosting = false;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: AppColor.backgroundColor,
                                      content: Center(
                                          child: Text(
                                              '335'.tr,
                                              style: TextStyle(
                                                  color: AppColor.grayColorFont))),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                } else if (textControllerService.text.isEmpty &&
                                    textControllerLocation.text.isNotEmpty) {
                                  setState(() {
                                    clickOpenQuestion = !clickOpenQuestion;
                                    if (clickOpenQuestion) {
                                      clickPosting = false;
                                      openQuestion.clear();
                                      location=true;
                                      CubitSearch.get(context).currentPage=1;

                                    }
                                    CubitSearch.get(context).getPostForLocation(textControllerLocation.text,  CubitSearch.get(context).currentPage);
                                  });
                                } else if (textControllerService.text.isNotEmpty &&
                                    textControllerLocation.text.isEmpty) {
                                  setState(() {
                                    clickOpenQuestion = !clickOpenQuestion;
                                    if (clickOpenQuestion) {
                                      clickPosting = false;
                                      openQuestion.clear();
                                      service=true;
                                      CubitSearch.get(context).currentPage=1;

                                    }
                                    CubitSearch.get(context).getPostForService(textControllerService.text,  CubitSearch.get(context).currentPage);

                                  });
                                } else if (textControllerService.text.isNotEmpty &&
                                    textControllerLocation.text.isNotEmpty) {
                                  setState(() {
                                    clickOpenQuestion = !clickOpenQuestion;
                                    if (clickOpenQuestion) {
                                      clickPosting = false;
                                      openQuestion.clear();
                                      CubitSearch.get(context).currentPage=1;
                                      serviceAndLocation=true;

                                    }
                                    CubitSearch.get(context).getPostForLocationAndService(textControllerService.text,textControllerLocation.text,  CubitSearch.get(context).currentPage);

                                  });
                                }
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: clickOpenQuestion
                                        ? AppColor.orangeColor
                                        : AppColor.comment,
                                  ),
                                  child: Text(
                                    "104".tr,
                                    style: TextStyle(
                                        color: clickOpenQuestion
                                            ? Colors.white
                                            : AppColor.bluColor),
                                  )),
                            ),
                            height: 40,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  ),
                ),
                if (textControllerLocation.text.isEmpty &&
                    textControllerService.text.isEmpty)
                  Expanded(child: Image.asset("assets/images/Illustrasi.png")),
                if (clickPosting)
                  Expanded(
                    child: ConditionalBuilder(
                      condition:(state is! SearchPostOnlyLocationLoadStateStates &&
                          state is! SearchPostOnlyServiceLoadStateStates &&
                          state is! SearchPostLoadStateStates),
                      builder: (context) =>  post.isEmpty?
                      Center(
                        child: Text(
                          '113'.tr,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                          :ListOfPosting(
                        post: post,
                        textControllerService: textControllerService,
                        textControllerLocation:  textControllerLocation,
                        location: locationPost,
                        service: servicePost,
                        serviceAndLocation: serviceAndLocationPost,
                      ),
                      fallback: (context) => Center(
                        child: CircularProgressIndicator(
                          color: AppColor.orangeColor,
                        ),
                      ),
                    ),
                  ),
                if (clickOpenQuestion)
                  Expanded(
                    child: ConditionalBuilder(
                      condition: state is! SearchPostOnlyLocationLoadStateStates &&
                          state is! SearchPostOnlyServiceLoadStateStates &&
                          state is! SearchPostLoadStateStates,
                      builder: (context) =>
                      openQuestion.isEmpty?
                      Center(
                        child: Text(
                          '116'.tr,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                          :ListOfOpenQuestion(
                        openQuestionPost: openQuestion,
                        textControllerService: textControllerService,
                        textControllerLocation:  textControllerLocation,
                        location: location,
                        service: service,
                        serviceAndLocation: serviceAndLocation,
                      ),
                      fallback: (context) => Center(
                        child: CircularProgressIndicator(
                          color: AppColor.orangeColor,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
