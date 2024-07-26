import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/Commint/commintSceren.dart';
import 'package:skilled_handyworkers_marketpleace/EditPost/EditPost.dart';
import 'package:skilled_handyworkers_marketpleace/EditPost/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/InformationCustomerOne/information.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/postModel.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class ListOfPosting extends StatelessWidget {
  final List<Map<String, dynamic>> post;

  final bool serviceAndLocation;
  final bool service;
  final bool location;

  final TextEditingController textControllerService;
  final TextEditingController textControllerLocation;
  const ListOfPosting({
    Key? key,
    required this.post, required this.serviceAndLocation, required this.service, required this.location, required this.textControllerService, required this.textControllerLocation,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return BlocConsumer<CubitSearch, SearchStates>(
      listener:(context, state) {
        if (state is SearchPostOnlyLocationSucssessfullStateStatesNext ||
            state is SearchPostOnlyServiceSucssessfullStateStatesNext ||
            state is SearchPostSucssessfullStateStatesNext) {
          if (state is SearchPostOnlyLocationSucssessfullStateStatesNext) {
            post.addAll(CubitSearch.get(context).postSearchLocation);
          } else if (state is SearchPostOnlyServiceSucssessfullStateStatesNext) {
            post.addAll(CubitSearch.get(context).postSearchService);
          } else if (state is SearchPostSucssessfullStateStatesNext) {
            post.addAll(CubitSearch.get(context).postSearch);
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
                itemCount: post.length+ (isEndOfList ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == post.length) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          color: AppColor.orangeColor,
                        ),
                      ),
                    );
                  }

                  return  PostModel(
                    imagePaths: post[index]['images'],
                    postText: post[index]['text'],
                    imagePath: post[index]['user']['profileImage'] == "assets/images/aboutmy.png"
                        ? "assets/images/aboutmy.png"
                        : post[index]['user']['profileImage'],
                    name: post[index]['user']['fullName'],
                    numberOfCommit: "67",
                    time: post[index]['publishedAt'],
                    onPressedForCommit: () {
                      navigateTo(context: context, widget: CommitScreen(idPost: post[index]['_id'], typePost: "post"));
                    },
                    onPressedForFavorit: () {},
                    onTapImage: () {
                      if(post[index]['user']['_id'] != id) {
                        navigateTo(context: context,widget: Information(idCustomer:post[index]['user']['_id']));
                      }
                    },
                    videoUrl: post[index]['videos'],
                    onPressed: () {
                    },
                    deleteAndEdit:  false, // post[index]['postAuthor']['id'] == id ? true : false
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
