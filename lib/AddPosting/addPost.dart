import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/BottonNavigationBar.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:video_player/video_player.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/searchLocation.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/searchService.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';


class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController _textControllerService = TextEditingController();
  final TextEditingController _textControllerLocation = TextEditingController();
  List<XFile> _selectedImages = [];
  XFile? _selectedVideo;
  VideoPlayerController? _videoPlayerController;
  bool selectService=false;
  bool selectLocation=false;


  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImagesFromGallery() async {
    try {
      List<XFile>? images = await _picker.pickMultiImage(
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
        limit: 10 - _selectedImages.length,
      );

      if (images != null) {
        if (_selectedImages.length + images.length > 10) {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text("Limit Exceeded", style: TextStyle(color: AppColor.bluColor),),
              content: Text("You can select up to ${10 - _selectedImages.length} more images.", style: TextStyle(color: AppColor.grayColorFont),),
              actions: [
                TextButton(
                  child: Text("OK", style: TextStyle(color: AppColor.orangeColor),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
          return;
        }

        setState(() {
          _selectedImages.addAll(images);
          _selectedVideo = null;
          _videoPlayerController?.dispose();
          _videoPlayerController = null;
        });
      }
    } catch (e) {
      print("Error picking images: $e");
    }
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedImages.add(image);
          _selectedVideo = null;
          _videoPlayerController?.dispose();
          _videoPlayerController = null;
        });
      }
    } catch (e) {
      print("Error taking image: $e");
    }
  }

  Future<void> _pickVideoFromGallery() async {
    try {
      final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);

      if (video != null) {
        setState(() {
          _selectedVideo = video;
          _selectedImages.clear();
          _videoPlayerController?.dispose();
          _videoPlayerController = VideoPlayerController.file(File(video.path))
            ..initialize().then((_) {
              setState(() {});
            });
        });
      }
    } catch (e) {
      print("Error picking video: $e");
    }
  }

  Future<void> _pickVideoFromCamera() async {
    try {
      final XFile? video = await _picker.pickVideo(source: ImageSource.camera);

      if (video != null) {
        setState(() {
          _selectedVideo = video;
          _selectedImages.clear();
          _videoPlayerController?.dispose();
          _videoPlayerController = VideoPlayerController.file(File(video.path))
            ..initialize().then((_) {
              setState(() {});
            });
        });
      }
    } catch (e) {
      print("Error recording video: $e");
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  Widget _buildSelectedImagesPreview() {
    int remainingImagesCount = _selectedImages.length - 5;
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: _selectedImages.length > 5 ? 5 : _selectedImages.length,
          itemBuilder: (BuildContext context, int index) {
            XFile image = _selectedImages[index];
            return GestureDetector(
              onTap: () {
                _showImageInDialog(image);
              },
              child: Stack(
                children: [
                  Image.file(
                    File(image.path),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: AppColor.orangeColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedImages.removeAt(index);
                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        if (remainingImagesCount > 0)
          GestureDetector(
            onTap: _showAllImages,
            child: Text("+$remainingImagesCount more"),
          ),
      ],
    );
  }

  void _showImageInDialog(XFile image) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Image Preview",
      barrierColor: Colors.transparent,
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (context, animation1, animation2) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: Image.file(
              File(image.path),
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        );
      },
    );
  }

  void _showAllImages() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "All Images",
      barrierColor:AppColor.backgroundColor,
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (context, animation1, animation2) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: _selectedImages.length,
            itemBuilder: (BuildContext context, int index) {
              XFile image = _selectedImages[index];
              return GestureDetector(
                onTap: () {
                  _showImageInDialog(image);
                },
                child: Stack(
                  children: [
                    Image.file(
                      File(image.path),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: AppColor.orangeColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedImages.removeAt(index);
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      backgroundColor: AppColor.backgroundColor,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(

          child: Wrap(

            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library,color: AppColor.orangeColor,),
                title: Text("Choose from Gallery",style: TextStyle(color: AppColor.bluColor)),
                onTap: () {
                  Navigator.pop(context);
                  _pickImagesFromGallery();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt,color: AppColor.orangeColor),
                title: Text("Take Photo",style: TextStyle(color: AppColor.bluColor),),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showVideoSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.video_library,color: AppColor.orangeColor,),
                title: Text("Choose from Gallery",style: TextStyle(color: AppColor.bluColor),),
                onTap: () {
                  Navigator.pop(context);
                  _pickVideoFromGallery();
                },
              ),
              ListTile(
                leading: Icon(Icons.videocam,color: AppColor.orangeColor,),
                title: Text("Record Video",style: TextStyle(color:AppColor.bluColor ),),
                onTap: () {
                  Navigator.pop(context);
                  _pickVideoFromCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor:  AppColor.backgroundColor,

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.arrowBackColor,
          ),
          onPressed: () {
            navigateAndFinish(widget:BottomNavigationScreen(),context: context);
          },
        ),
        actions: [
          TextButton(onPressed:() {

          }, child:Text("post",style:TextStyle(
              fontSize: AppFontStyles.descriptionLoginFontSize,
              fontWeight: AppFontStyles.fontWeightBold,
              color: AppColor.bottomNavigationBar
          ) ,))
        ],
        elevation: 0.0,
        backgroundColor: AppColor.backgroundColor,
      ),
      body: Container(
        color: AppColor.backgroundColor,
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(AppFontStyles.padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Post",
                  style: TextStyle(
                    fontSize: AppFontStyles.aboutMe,
                    fontWeight: AppFontStyles.fontWeightSemiBold,
                    color: AppColor.bluColor,
                  ),
                ),
                const SizedBox(
                  height: AppFontStyles.sizeBetweenTitleAndSubTitle,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,

                  leading: ClipOval(
                    child: Image.asset(
                      "assets/images/Mask group.png",
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  title:  Text(
                    "Orlando Diggs",
                    style: TextStyle(
                      fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                      color: AppColor.bluColor,
                      fontWeight: AppFontStyles.fontWeightBold,
                    ),
                  ),
                  subtitle:    Text(
                    " 21 minutes ago",
                    style: TextStyle(
                      fontSize: AppFontStyles.descriptionLoginFontSize,
                      color: AppColor.fontColorDescription,
                      fontWeight: AppFontStyles.fontWeightMedium,
                    ),
                  ),
                ),
                const SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle),
                Text(
                  " Service Type",
                  style: TextStyle(
                    fontWeight: AppFontStyles.fontWeightSemiBold,
                    fontSize: AppFontStyles.descriptionLoginFontSize,
                    color: AppColor.bluColor,
                  ),
                ),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),
                Box(
                  widget: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Service(
                              textController: _textControllerService,
                              title: "Add Service",
                              titleSearch: "Search",
                              widget: const AddPost(),
                            ),
                          ),
                        );
                        if (result != null && result is String) {
                          setState(() {
                            _textControllerService.text = result;
                            selectService=true;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding, vertical: 8),
                        child: Text(
                          _textControllerService.text.isEmpty ? "Select service" : _textControllerService.text,
                          style: TextStyle(
                            color: AppColor.grayColorFont,
                            fontSize: AppFontStyles.descriptionLoginFontSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                  height: 40,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),
                Text(
                  " Location",
                  style: TextStyle(
                    fontWeight: AppFontStyles.fontWeightSemiBold,
                    fontSize: AppFontStyles.descriptionLoginFontSize,
                    color: AppColor.bluColor,
                  ),
                ),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),
                Box(
                  widget: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Location(
                              textController: _textControllerLocation,
                              widget: const AddPost(),
                            ),
                          ),
                        );
                        if (result != null && result is String) {
                          setState(() {
                            _textControllerLocation.text = result;
                            selectLocation=true;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding, vertical: 8),
                        child: Text(
                          _textControllerLocation.text.isEmpty ? "Select location" : _textControllerLocation.text,
                          style: TextStyle(
                            color: AppColor.grayColorFont,
                            fontSize: AppFontStyles.descriptionLoginFontSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                  height: 40,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle + 20),

                if (_selectedImages.isNotEmpty) _buildSelectedImagesPreview(),
                if (_selectedVideo != null && _videoPlayerController != null)
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: _videoPlayerController!.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController!),
                        ),
                        if (!_videoPlayerController!.value.isPlaying)
                          IconButton(
                            icon: Icon(Icons.play_arrow, color: Colors.white, size: 50.0),
                            onPressed: () {
                              setState(() {
                                _videoPlayerController!.play();
                              });
                            },
                          ),
                        if (_videoPlayerController!.value.isPlaying)
                          IconButton(
                            icon: Icon(Icons.pause, color: Colors.white, size: 50.0),
                            onPressed: () {
                              setState(() {
                                _videoPlayerController!.pause();
                              });
                            },
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 10),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              IconButton(
                onPressed:(){
              if (selectService && selectLocation) {
              _showImageSourceDialog();
              } else {
              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColor.backgroundColor,

                content: Center(child: Text('Please select service and location first',style: TextStyle(color: AppColor.grayColorFont))),
              duration: Duration(seconds: 2),
              ),
              );
              }
                },
                icon: Icon(Icons.image, color: AppColor.orangeColor, size: 24),
              ),

              IconButton(
                onPressed:() {

                  if (selectService && selectLocation) {
                    _showVideoSourceDialog();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(

                        backgroundColor: AppColor.backgroundColor,
                        content: Center(child: Text('Please select service and location first',style: TextStyle(color: AppColor.grayColorFont),)),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }

                },
                icon: Icon(Icons.video_collection, color: AppColor.orangeColor, size: 24),
              ),
              Spacer(),
              Text(
                " Add Image or Video ",
                style: TextStyle(
                  fontWeight: AppFontStyles.fontWeightSemiBold,
                  fontSize: AppFontStyles.descriptionLoginFontSize,
                  color: AppColor.orangeColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
