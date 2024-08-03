import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/commintSceren.dart';
import 'package:skilled_handyworkers_marketpleace/EditPost/EditOpenQuestion.dart';
import 'package:skilled_handyworkers_marketpleace/InformationCustomerOne/information.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/OpenQuestionModel.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';

import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class ListOfOpenQuestion extends StatefulWidget {
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
  State<ListOfOpenQuestion> createState() => _ListOfOpenQuestionState();
}

class _ListOfOpenQuestionState extends State<ListOfOpenQuestion> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitSearch, SearchStates>(
      listener: (context, state) {
        if (state is SearchPostOnlyLocationSucssessfullStateStatesNext ||
            state is SearchPostOnlyServiceSucssessfullStateStatesNext ||
            state is SearchPostSucssessfullStateStatesNext) {
          if (state is SearchPostOnlyLocationSucssessfullStateStatesNext) {
            widget.openQuestionPost.addAll(CubitSearch.get(context).openQuestionPostSearchLocation);
          } else if (state is SearchPostOnlyServiceSucssessfullStateStatesNext) {
            widget.openQuestionPost.addAll(CubitSearch.get(context).openQuestionPostSearchService);
          } else if (state is SearchPostSucssessfullStateStatesNext) {
            widget.openQuestionPost.addAll(CubitSearch.get(context).openQuestionPostSearch);
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
                  if (widget.serviceAndLocation) {
                    CubitSearch.get(context).getPostForLocationAndServiceNext(
                        widget.textControllerService.text,
                        widget.textControllerLocation.text,
                        CubitSearch.get(context).currentPage);
                  } else if (widget.service) {
                    CubitSearch.get(context).getPostForServiceNext(
                        widget.textControllerService.text,
                        CubitSearch.get(context).currentPage);
                  } else if (widget.location) {
                    CubitSearch.get(context).getPostForLocationNext(
                        widget.textControllerLocation.text,
                        CubitSearch.get(context).currentPage);
                  }
                }
                return false;
              },
              child: ListView.builder(
                itemCount: widget.openQuestionPost.length + (isEndOfList ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == widget.openQuestionPost.length) {
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
                    time: widget.openQuestionPost[index]['publishedAt'],
                    numberOfCommit: "",
                    name: widget.openQuestionPost[index]['user']['fullName'],
                    imagePath: widget.openQuestionPost[index]['user']['profileImage'] ?? "assets/images/aboutmy.png",
                    openQuestion: widget.openQuestionPost[index]['text'],
                    onTapImage: () {
                      if( widget.openQuestionPost[index]['user']['_id'] != id) {
                        navigateTo(context: context,widget: Information(idCustomer: widget.openQuestionPost[index]['user']['_id']));
                      }
                    },
                    onPressedForCommit: () {
                      navigateTo(context: context, widget: CommitScreen(idPost:widget.openQuestionPost[index]['_id'], typePost: "openQuestion"));
                    },
                    onPressedForFavorit: () {
                      setState(() {
                        if(widget.openQuestionPost[index]['isSaved']){
                          CubitYourPost.get(context).unSavePost(widget.openQuestionPost[index]['_id']);
                          widget.openQuestionPost[index]['isSaved']=false;
                        }
                        if(!widget.openQuestionPost[index]['isSaved']){
                          CubitYourPost.get(context).savePost(widget.openQuestionPost[index]['_id']);
                          widget.openQuestionPost[index]['isSaved']=true;
                        }
                      });
                    },
                    colorsFavorit: Colors.red,//
                    // widget.openQuestionPost[index]['isSaved']?Colors.red:Colors.grey
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
