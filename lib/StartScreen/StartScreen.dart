import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/commintSceren.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/ListOfPosting.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/ListOpenQuestion.dart';
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
  final TextEditingController textControllerService = TextEditingController();
  final TextEditingController textControllerLocation = TextEditingController();
  bool clickPosting = false;
  bool clickOpenQuestion = false;
  List<Map<String, dynamic>> post = [];
  List<Map<String, dynamic>> openQuestion = [];
  final ScrollController scrollController = ScrollController();
  int currentPagePost = 1;
  bool hasMoreData = true;
  bool isLoadingMore = false;
  double scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!isLoadingMore && scrollController.position.pixels == scrollController.position.maxScrollExtent && hasMoreData) {
      setState(() {
        isLoadingMore = true;
        scrollOffset = scrollController.position.pixels;

      });
      _loadMoreData();

    }
  }
  void _loadMoreData(){
    if (clickPosting) {

      if (textControllerService.text.isNotEmpty && textControllerLocation.text.isNotEmpty) {
        CubitSearch.get(context).getPostForLocationAndService(
          textControllerService.text,
          textControllerLocation.text,
          currentPagePost,
        );
      } else if (textControllerService.text.isNotEmpty) {
        CubitSearch.get(context).getPostForService(
          textControllerService.text,
          currentPagePost,
        );
      } else if (textControllerLocation.text.isNotEmpty) {
        CubitSearch.get(context).getPostForLocation(
          textControllerLocation.text,
          currentPagePost,
        );
      }
    } else if (clickOpenQuestion) {

      if (textControllerService.text.isNotEmpty && textControllerLocation.text.isNotEmpty) {
        CubitSearch.get(context).getPostForLocationAndService(
          textControllerService.text,
          textControllerLocation.text,
          currentPagePost,
        );
      } else if (textControllerService.text.isNotEmpty) {
        CubitSearch.get(context).getPostForService(
          textControllerService.text,
          currentPagePost,
        );
      } else if (textControllerLocation.text.isNotEmpty) {
        CubitSearch.get(context).getPostForLocation(
          textControllerLocation.text,
          currentPagePost,
        );
      }
    }
  }

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
              List<Map<String, dynamic>> newPosts = [];
              List<Map<String, dynamic>> newOpenQuestions = [];

              if (state is SearchPostOnlyLocationSucssessfullStateStates) {
                newPosts = CubitSearch.get(context).postSearchLocation;
                newOpenQuestions = CubitSearch.get(context).openQuestionPostSearchLocation;
              } else if (state is SearchPostOnlyServiceSucssessfullStateStates) {
                newPosts = CubitSearch.get(context).postSearchService;
                newOpenQuestions = CubitSearch.get(context).openQuestionPostSearchService;
              } else if (state is SearchPostSucssessfullStateStates) {
                newPosts = CubitSearch.get(context).postSearch;
                newOpenQuestions = CubitSearch.get(context).openQuestionPostSearch;
              }

              if (newPosts.isEmpty && newOpenQuestions.isEmpty) {
                hasMoreData = false;
              } else {
                post.addAll(newPosts);
                openQuestion.addAll(newOpenQuestions);
                currentPagePost++;
              }

              isLoadingMore = false;
              if(scrollController.hasClients){
                scrollController.jumpTo(scrollOffset);

              }

            });
          }
        },
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
                                              'Please select service or location first',
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
                                      currentPagePost = 1;
                                      hasMoreData = true;
                                    }

                                    CubitSearch.get(context).getPostForService(
                                      textControllerService.text,
                                      currentPagePost,
                                    );
                                  });
                                } else if (textControllerService.text.isEmpty &&
                                    textControllerLocation.text.isNotEmpty) {
                                  setState(() {
                                    clickPosting = !clickPosting;
                                    if (clickPosting) {
                                      clickOpenQuestion = false;
                                      post.clear();
                                      currentPagePost = 1;
                                      hasMoreData = true;
                                    }

                                    CubitSearch.get(context).getPostForLocation(
                                      textControllerLocation.text,
                                      currentPagePost,
                                    );
                                  });
                                } else if (textControllerService.text.isNotEmpty &&
                                    textControllerLocation.text.isNotEmpty) {
                                  setState(() {
                                    clickPosting = !clickPosting;
                                    if (clickPosting) {
                                      clickOpenQuestion = false;
                                      post.clear();
                                      currentPagePost = 1;
                                      hasMoreData = true;
                                    }

                                    CubitSearch.get(context).getPostForLocationAndService(
                                      textControllerService.text,
                                      textControllerLocation.text,
                                      currentPagePost,
                                    );
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
                                    "posting",
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
                                              'Please select service and location first',
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
                                      currentPagePost = 1;
                                      hasMoreData = true;
                                    }
                                    CubitSearch.get(context).getPostForLocation(
                                      textControllerLocation.text,
                                      currentPagePost,
                                    );
                                  });
                                } else if (textControllerService.text.isNotEmpty &&
                                    textControllerLocation.text.isEmpty) {
                                  setState(() {
                                    clickOpenQuestion = !clickOpenQuestion;
                                    if (clickOpenQuestion) {
                                      clickPosting = false;
                                      openQuestion.clear();
                                      currentPagePost = 1;
                                      hasMoreData = true;
                                    }
                                    CubitSearch.get(context).getPostForService(
                                      textControllerService.text,
                                      currentPagePost,
                                    );
                                  });
                                } else if (textControllerService.text.isNotEmpty &&
                                    textControllerLocation.text.isNotEmpty) {
                                  setState(() {
                                    clickOpenQuestion = !clickOpenQuestion;
                                    if (clickOpenQuestion) {
                                      clickPosting = false;
                                      openQuestion.clear();
                                      currentPagePost = 1;
                                      hasMoreData = true;
                                    }
                                    CubitSearch.get(context).getPostForLocationAndService(
                                      textControllerService.text,
                                      textControllerLocation.text,
                                      currentPagePost,
                                    );
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
                                    "open question",
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
                      builder: (context) => ListOfPosting(
                        post: post,
                        scrollController: scrollController,
                        hasMoreData: hasMoreData,
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
                      builder: (context) =>isLoadingMore? Center(
                        child: CircularProgressIndicator(
                          color: AppColor.orangeColor,
                        ),
                      ): ListOfOpenQuestion(
                        openQuestionPost: openQuestion,
                        scrollController: scrollController,
                        hasMoreData: hasMoreData,
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
