import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/OpenQuestionModel.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/cubit/states.dart';

import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class ListOfOpenQuestion extends StatelessWidget {
  final List<Map<String, dynamic>> openQuestionPost;
  final bool serviceAndLocation;
  final bool service;
  final bool location;

  final TextEditingController textControllerService;
  final TextEditingController textControllerLocation;

  const ListOfOpenQuestion({
    Key? key,
    required this.openQuestionPost,
    required this.serviceAndLocation,
    required this.service,
    required this.location,
    required this.textControllerService,
    required this.textControllerLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitSearch, SearchStates>(
      listener: (context, state) {
        if (state is SearchPostOnlyLocationSucssessfullStateStatesNext ||
            state is SearchPostOnlyServiceSucssessfullStateStatesNext ||
            state is SearchPostSucssessfullStateStatesNext) {
          if (state is SearchPostOnlyLocationSucssessfullStateStatesNext) {
            openQuestionPost.addAll(CubitSearch.get(context).openQuestionPostSearchLocation);
          } else if (state is SearchPostOnlyServiceSucssessfullStateStatesNext) {
            openQuestionPost.addAll(CubitSearch.get(context).openQuestionPostSearchService);
          } else if (state is SearchPostSucssessfullStateStatesNext) {
            openQuestionPost.addAll(CubitSearch.get(context).openQuestionPostSearch);
          }
        }
      },
      builder: (context, state) {
        bool isEndOfList = false;
        if (state is SearchPostSucssessfullStateStates ||
            state is SearchPostOnlyLocationSucssessfullStateStates ||
            state is SearchPostOnlyServiceSucssessfullStateStates) {
          isEndOfList = CubitSearch.get(context).hasMoreData;
        }
        if (state is SearchPostSucssessfullStateStatesNext ||
            state is SearchPostOnlyLocationSucssessfullStateStatesNext ||
            state is SearchPostOnlyServiceSucssessfullStateStatesNext) {
          isEndOfList = CubitSearch.get(context).hasMoreData;
        }

        return Container(
          color: AppColor.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(AppFontStyles.aboutMe),
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (isEndOfList &&
                    scrollInfo is ScrollEndNotification &&
                    scrollInfo.metrics.extentAfter == 0) {
                  if (serviceAndLocation) {
                    CubitSearch.get(context).getPostForLocationAndServiceNext(
                        textControllerService.text,
                        textControllerLocation.text,
                        CubitSearch.get(context).currentPage);
                  } else if (service) {
                    CubitSearch.get(context).getPostForServiceNext(
                        textControllerService.text,
                        CubitSearch.get(context).currentPage);
                  } else if (location) {
                    CubitSearch.get(context).getPostForLocationNext(
                        textControllerLocation.text,
                        CubitSearch.get(context).currentPage);
                  }
                }
                return false;
              },
              child: ListView.builder(
                itemCount: openQuestionPost.length + (isEndOfList ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == openQuestionPost.length) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          color: AppColor.orangeColor,
                        ),
                      ),
                    );
                  }
                  return OpenQuestionModel(
                    time: openQuestionPost[index]['publishedAt'],
                    numberOfCommit: "78",
                    name: openQuestionPost[index]['user']['fullName'],
                    imagePath: openQuestionPost[index]['user']['profileImage'] ?? "assets/images/aboutmy.png",
                    openQuestion: openQuestionPost[index]['text'],
                    onTapImage: () {},
                    onPressedForCommit: () {
                      // navigateTo(context: context, widget: CommitScreen(idPost: openQuestionPost[index]['postId'], typePost: "openQuestion"));
                    },
                    onPressedForFavorit: () {},
                    deleteAndEdit: false, // Decide whether to show delete and edit buttons
                    onPressed: () {},
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
