import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/EditPost/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/EditPost/cubit/states.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as p;

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:file_picker/file_picker.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skilled_handyworkers_marketpleace/ButtonNavigation/BottonNavigationBar.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/components.dart';
import 'package:video_player/video_player.dart';

import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';


class EditPost extends StatefulWidget {
  final String id;
  const EditPost({Key? key, required this.id}) : super(key: key);

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {

  final TextEditingController _textControllerDescription=TextEditingController();
  Map<String, dynamic> infomationPost = {};
  List<dynamic>image=[];
  List<dynamic>video=[];
  List<XFile> _selectedImages = [];
  List<XFile> _selectedVideos = [];

  VideoPlayerController? _videoPlayerController;

  bool selectService=false;
  bool selectLocation=false;


  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset('assets/placeholder.mp4');


  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    super.dispose();
  }


  void printSelectedVideos() {
    for (int i = 0; i < video.length; i++) {
      print("v ${i + 1}: ${video[i]}");
    }
  }
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImagesFromGallery() async {
    try {
      List<XFile>? images = await _picker.pickMultiImage(
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
        limit: 10 - _selectedImages.length,
      );

      if (images.isNotEmpty) {
        if (_selectedImages.length +image.length+ images.length > 10) {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(
                "Limit Exceeded",
                style: TextStyle(color: AppColor.bluColor),
              ),
              content: Text(
                "You can select up to ${10 - (_selectedImages.length+image.length)} more images.",
                style: TextStyle(color: AppColor.grayColorFont),
              ),
              actions: [
                TextButton(
                  child: Text(
                    "OK",
                    style: TextStyle(color: AppColor.orangeColor),
                  ),
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
          // _selectedVideos.clear();
          // _videoPlayerController?.dispose();
          // _videoPlayerController = null;
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
          // _selectedVideos.clear();
          // _videoPlayerController?.dispose();
          // _videoPlayerController = null;
        });
      }
    } catch (e) {
      print("Error taking image: $e");
    }
  }

  Widget _buildSelectedImagesPreview() {
    int remainingImagesCount = _selectedImages.length - 5;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Image :",
          style: TextStyle(
            fontWeight: AppFontStyles.fontWeightSemiBold,
            fontSize: AppFontStyles.descriptionLoginFontSize,
            color: AppColor.bluColor,
          ),
        ),
        const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: _selectedImages.length > 5 ? 6 : _selectedImages.length,
          itemBuilder: (BuildContext context, int index) {
            if (index < 5) {
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
            } else {
              // Last item to show the remaining images count
              return GestureDetector(
                onTap: () {
                  _showAllImages();
                },
                child: Container(
                  color: Colors.grey,
                  child: Center(
                    child: Text(
                      "+$remainingImagesCount",
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ],
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

  void _showImageInDialog(XFile image) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Image Preview",
      barrierColor: Colors.white,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation1, animation2) {
        return Dialog(
          insetPadding: EdgeInsets.zero,

          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Image.file(
                  File(image.path),
                  fit: BoxFit.contain,

                ),
              ),
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
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation1, animation2) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
           return Dialog(
             insetPadding: EdgeInsets.only(top: 32.0),

             backgroundColor: Colors.transparent,
              child: SingleChildScrollView(
                child: Column(
                  children:List.generate(_selectedImages.length,(index) {
                    XFile image = _selectedImages[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          _showImageInDialog(image);
                        },
                        child: Stack(
                          children: [
                            Image.file(
                              File(image.path),
                              fit: BoxFit.cover,

                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  color: AppColor.orangeColor,
                                ),
                                onPressed: () {

                                  setDialogState(() {
                                    setState(() {
                                      _selectedImages.removeAt(index);

                                      if (_selectedImages.isEmpty) {
                                        Navigator.pop(context);
                                      }
                                    });

                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },),
                ),
              ),
            );
          },

        );
      },
    );
  }

  

//////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> _pickVideosFromGallery() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: true,
      );

      if (result != null) {
        if (_selectedVideos.length+video.length+ result.files.length > 10) {
          _showLimitExceededDialog(10 - (_selectedVideos.length+video.length));
          return;
        }

        setState(() {
          _selectedVideos.addAll(result.files.map((file) => XFile(file.path!)).toList());
        });
      }
    } catch (e) {
      print("Error picking videos: $e");
    }
  }

  Future<void> _pickVideoFromCamera() async {
    try {
      final XFile? video = await _picker.pickVideo(source: ImageSource.camera);

      if (video != null) {
        setState(() {
          _selectedVideos.add(video);
        });
      }
    } catch (e) {
      print("Error recording video: $e");
    }
  }


  void _showVideoSourceDialog() {
    showModalBottomSheet(
      backgroundColor: AppColor.backgroundColor,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.video_library, color: AppColor.orangeColor),
                title: const Text("Choose from Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  _pickVideosFromGallery();
                },
              ),
              ListTile(
                leading: Icon(Icons.videocam,color:  AppColor.orangeColor),
                title: const Text("Record Video"),
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

  void _showLimitExceededDialog(int remainingCount) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Limit Exceeded",style: TextStyle(color: AppColor.bluColor),),
        content: Text("You can select up to $remainingCount more videos.",style: TextStyle(color: AppColor.grayColorFont)),
        actions: [
          TextButton(
            child: Text("OK",style: TextStyle(color: AppColor.orangeColor)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<Uint8List?> generateThumbnail(String videoPath) async {
    return await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.PNG,
      maxHeight: 64, // specify the height of the thumbnail, keep aspect ratio
      quality: 75,
    );
  }

  void _showVideoInDialog(XFile video) {
    VideoPlayerController _videoPlayerController = VideoPlayerController.file(File(video.path));
    _videoPlayerController.initialize().then((_) {
      setState(() {
        _videoPlayerController.play(); // Autoplay when dialog opens
      });
    });

    showGeneralDialog(
      context: context,

      barrierDismissible: false, // prevent closing on tap outside
      barrierLabel: "video Preview",
      barrierColor: Colors.white,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (_videoPlayerController.value.isPlaying) {
                      _videoPlayerController.pause();
                    } else {
                      _videoPlayerController.play();
                    }
                  });
                },
                child: VideoPlayer(_videoPlayerController),
              ),
            ),
          ),
        );
      },
    ).then((_) {
      _videoPlayerController.pause(); // Pause video when dialog is dismissed
      _videoPlayerController.dispose(); // Dispose the controller to release resources
    });
  }


  void _showAllVideos() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false, // prevent closing on tap outside
      barrierColor: Colors.white,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              insetPadding: EdgeInsets.only(top: 32.0),

              backgroundColor: Colors.transparent,
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(_selectedVideos.length, (index) {
                    XFile video = _selectedVideos[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          _showVideoInDialog(video);
                        },
                        child: Stack(

                          children: [
                            FutureBuilder<Uint8List?>(
                              future: generateThumbnail(video.path),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                                  return Stack(
                                    alignment: Alignment.center,

                                    children: [
                                      AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: Image.memory(snapshot.data!, fit: BoxFit.cover),
                                      ),
                                      Icon(Icons.play_arrow, color: AppColor.orangeColor, size: 40),

                                    ],

                                  );
                                } else {
                                  return Center(child: CircularProgressIndicator(color: AppColor.orangeColor));
                                }
                              },
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  color: AppColor.orangeColor,
                                ),
                                onPressed: () {
                                  setDialogState(() {
                                    setState(() {
                                      _selectedVideos.removeAt(index);
                                    });
                                    if (_selectedVideos.isEmpty) {
                                      Navigator.pop(context);
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSelectedVideosPreview() {
    printSelectedVideos();
    int remainingVideosCount = _selectedVideos.length - 5;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Video :",
          style: TextStyle(
            fontWeight: AppFontStyles.fontWeightSemiBold,
            fontSize: AppFontStyles.descriptionLoginFontSize,
            color: AppColor.bluColor,
          ),
        ),
        const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            childAspectRatio: 1.0, // Added to make the videos square
          ),
          itemCount: _selectedVideos.length > 5 ? 6 : _selectedVideos.length,
          itemBuilder: (BuildContext context, int index) {
            if(index<5){
              XFile video = _selectedVideos[index];
              VideoPlayerController videoPlayerController = VideoPlayerController.file(File(video.path));

              return GestureDetector(
                onTap: () {
                  _showVideoInDialog(video);
                },
                child: Stack(
                  fit: StackFit.expand,

                  children: [
                    FutureBuilder<Uint8List?>(
                      future: generateThumbnail(video.path),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                          return SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: Image.memory(snapshot.data!, fit: BoxFit.cover),
                          );
                        } else {
                          return  Center(child: CircularProgressIndicator(color: AppColor.orangeColor,));
                        }
                      },
                    ),
                    Icon(Icons.play_arrow, color: AppColor.orangeColor, size: 40),

                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: AppColor.orangeColor,
                        ),
                        onPressed: () {
                          setState(() {
                            if (videoPlayerController.value.isPlaying) {
                              videoPlayerController.pause();
                            }
                            videoPlayerController.dispose(); // Dispose the video player
                            _selectedVideos.removeAt(index);
                            // Remove the video from the list
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            else{
              return GestureDetector(
                onTap: () {
                  _showAllVideos();
                },
                child: Container(
                  color: Colors.grey,
                  child: Center(
                    child: Text(
                      "+$remainingVideosCount",
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              );

            }

          },
        ),

      ],
    );
  }



///////////////////////////////////////////////////////////////////////////////////////////////////////////old image
  String _getRelativePath(String fullPath) {
    Uri uri = Uri.parse(fullPath);
    return uri.path;
  }

  void _openImageDialogOld(String imagePath) {
    showGeneralDialog(
      barrierColor: Colors.white,
      barrierDismissible: true,
      barrierLabel: "Image Preview",
      transitionDuration: const Duration(milliseconds: 200),
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imagePath),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  void _openVideoDialogOld(String videoUrl) {
    VideoPlayerController _videoPlayerController = VideoPlayerController.network(videoUrl);

    _videoPlayerController.initialize().then((_) {
      setState(() {
        _videoPlayerController.play(); // Autoplay when dialog opens
      });
    });

    showGeneralDialog(
      context: context,
      barrierDismissible: false, // prevent closing on tap outside
      barrierLabel: "video Preview",
      barrierColor: Colors.white,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (_videoPlayerController.value.isPlaying) {
                      _videoPlayerController.pause();
                    } else {
                      _videoPlayerController.play();
                    }
                  });
                },
                child: VideoPlayer(_videoPlayerController),
              ),
            ),
          ),
        );
      },
    ).then((_) {
      _videoPlayerController.pause(); // Pause video when dialog is dismissed
      _videoPlayerController.dispose(); // Dispose the controller to release resources
    });
  }

  void _showAllMediaDialogOld(List<dynamic> media) {
    List<dynamic> images = [];
    List<dynamic> videos = [];

    for (var path in media) {
      String extension = p.extension(path).toLowerCase();

      if (extension == '.jpg' || extension == '.jpeg' || extension == '.png' || extension == '.gif' || extension == '.bmp') {
        images.add(path);
      } else if (extension == '.mp4' || extension == '.avi' || extension == '.mov' || extension == '.wmv' || extension == '.flv') {
        videos.add(path);
      }
    }

    showGeneralDialog(
      context: context,
      barrierColor: Colors.white,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
        return StatefulBuilder(
            builder: (context, setDialogState){
              return  Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.only(top: 32.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(

                        media.length,
                            (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric( vertical: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                if (videos.contains(media[index])) {
                                  _openVideoDialogOld(media[index]); // Passes the video URL
                                } else {
                                  _openImageDialogOld(media[index]); // Passes the image URL
                                }
                              },
                              child: videos.contains(media[index])
                                  ? Stack(
                                children: [
                                  FutureBuilder<Uint8List?>(
                                    future: generateThumbnail(media[index]),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                                        // Display a thumbnail for the video
                                        return Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            AspectRatio(
                                                aspectRatio: 16 / 9,
                                                child: Image.memory(snapshot.data!, fit: BoxFit.cover)),
                                            Icon(Icons.play_arrow, color: AppColor.orangeColor, size: 40),
                                          ],
                                        );
                                      } else {
                                        return Center(child: CircularProgressIndicator(color: AppColor.orangeColor));
                                      }
                                    },
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.cancel,
                                        color: AppColor.orangeColor,
                                      ),
                                      onPressed: () {
                                        setDialogState(() {

                                        setState(() {
                                          String imagePathWithOutApi=_getRelativePath(media[index]);
                                          video.remove(imagePathWithOutApi);

                                          media.removeAt(index);

                                        });

                                        });

                                      },
                                    ),
                                  ),
                                ],
                              )
                                  : Stack(
                                children: [
                                  Image.network(
                                    media[index],
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.cancel,
                                        color: AppColor.orangeColor,
                                      ),
                                      onPressed: () {
                                        setDialogState(() {
                                          setState(() {
                                            String imagePathWithOutApi=_getRelativePath(media[index]);
                                            image.remove(imagePathWithOutApi);
                                            // images.remove(media[index]);
                                            media.removeAt(index);

                                          });
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              );
            }

        );
      },
    );
  }
  Widget buildMediaGrid() {
    List<dynamic> _mediaItems = [];

    if (video.isNotEmpty) {
      _mediaItems.addAll(video.map((url) => "$api$url"));
    }
    if (image.isNotEmpty) {
      _mediaItems.addAll(image.map((url) => "$api$url"));
    }

    int itemCount = _mediaItems.length > 5 ? 5 : _mediaItems.length;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      itemCount: itemCount + (_mediaItems.length > 5 ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < 5) {
          if (video .isNotEmpty && index < video.length) {
            return GestureDetector(
              onTap: () {
                _openVideoDialogOld(_mediaItems[index]);
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  FutureBuilder<Uint8List?>(
                    future: generateThumbnail(_mediaItems[index]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                        return SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Image.memory(snapshot.data!, fit: BoxFit.cover),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator(color: AppColor.orangeColor));
                      }
                    },
                  ),
                  Icon(Icons.play_arrow, color: AppColor.orangeColor, size: 40),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: AppColor.orangeColor,
                      ),
                      onPressed: () {
                        setState(() {
                          String imagePathWithOutApi=_getRelativePath(_mediaItems[index]);
                          video.remove(imagePathWithOutApi);
                          _mediaItems.remove(index);
                        });
                      },
                    ),
                  ),

                ],
              ),
            );
          } else {
            return GestureDetector(
              onTap: () {
                _openImageDialogOld(_mediaItems[index]);
              },
              child: Stack(
                children: [
                  Image.network(
                    _mediaItems[index],
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
                          String imagePathWithOutApi=_getRelativePath(_mediaItems[index]);
                          image.remove(imagePathWithOutApi);
                          _mediaItems.remove(index);                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        } else {
          return GestureDetector(
            onTap: () {
              _showAllMediaDialogOld(_mediaItems);
            },
            child: Container(

              color: Colors.grey,
              child: Center(
                child: Text(
                  '+${_mediaItems.length - 5}',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          );
        }
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditPostCubit,EditPostStates>(
      listener: (context, state) {
        if (state is GetInformationPostSucssessfullStateStates) {
          infomationPost = EditPostCubit.get(context).postInformation;
          _textControllerDescription.text = infomationPost['text'];

          video=infomationPost['videos'];
          image=infomationPost['images'];

        }
        else if(state is GetInformationPostErrorStateStates){
          showToast(text:"Error!", state: ToastStates.EROOR);
          Navigator.pop(context);
        }
        if(state is EditPostPostSucssessfullStateStates){
          showToast(text:"The post has been update successfully", state: ToastStates.SUCCESS);
          image.clear();
          video.clear();
          Navigator.pop(context);
          CubitYourPost.get(context).getPost();
        }
        else if(state is EditPostPostErrorStateStates){
          showToast(text:"The post hasn't been update successfully", state: ToastStates.EROOR);

        }
        if(state is PostFileSucssessfullStateStates){

          EditPostCubit.get(context).editPost(widget.id,_textControllerDescription.text,EditPostCubit.get(context).ima,EditPostCubit.get(context).video
             );

        }
        else if(state is PostFileErrorStateStates){
          showToast(text:"error !! , when upload image and video \n"+state.message, state: ToastStates.EROOR);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            surfaceTintColor:  AppColor.backgroundColor,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColor.arrowBackColor,
              ),
              onPressed: () {
            Navigator.pop(context)   ;
},
            ),
            actions: [
              TextButton(onPressed:() {
                EditPostCubit.get(context).postFile(_selectedImages, _selectedVideos,image,video);

              }, child:Text("update",style:TextStyle(
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
            child: ConditionalBuilder(
              condition:state is! GetInformationPostLoadStateStates ,
              builder:(context) =>  SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(AppFontStyles.padding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConditionalBuilder(
                        condition: state is !PostFileLoadStateStates,
                        builder:(context) =>  ConditionalBuilder(
                          condition: state is !EditPostPostLoadStateStates  ,
                          builder: (context) => const SizedBox(),
                          fallback:(context) => LinearProgressIndicator(color: AppColor.orangeColor,minHeight:1.0,),),
                       fallback:(context) => LinearProgressIndicator(color: AppColor.orangeColor,minHeight:1.0,),
                      ),
                      SizedBox(height:AppFontStyles.aboutMe,),
                      Text(
                        "Edit Post",
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
                        leading: ClipOval(
                          child: imageNetwork!=null?Image.network(imageNetwork!,fit: BoxFit.cover,
                            height: 50,
                            width: 50,):Image.asset(
                            imageCope!,
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        title:  Text(
                          name!=null?name!:"",
                          style: TextStyle(
                            fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                            color: AppColor.bluColor,
                            fontWeight: AppFontStyles.fontWeightBold,
                          ),
                        ),
                        subtitle:    Text(
                          location!=null?location!:"",
                          style: TextStyle(
                            fontSize: AppFontStyles.descriptionLoginFontSize,
                            color: AppColor.fontColorDescription,
                            fontWeight: AppFontStyles.fontWeightMedium,
                          ),
                        ),
                      ),

                      const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),
                      Text(
                        " Edit Description ",
                        style: TextStyle(
                          fontWeight: AppFontStyles.fontWeightSemiBold,
                          fontSize: AppFontStyles.descriptionLoginFontSize,
                          color: AppColor.bluColor,
                        ),
                      ),
                      const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),
                      Box(
                        borderRadius: BorderRadius.circular(AppFontStyles.borderRadius),
                        height: 100,
                        widget:Padding(

                          padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.padding),
                          child: TextFormField(
                            controller: _textControllerDescription,
                            keyboardType: TextInputType.text,
                            maxLines: 20, // حدد الحد الأقصى لعدد الأسطر
                            decoration:  InputDecoration(

                              hintText:'Edit your description ..',
                              hintStyle: TextStyle(

                                color: AppColor.grayColorFont,
                                fontSize: AppFontStyles.descriptionLoginFontSize,
                              ),
                              border: InputBorder.none,

                              // هنا يمكنك تحديد نص التلميح
                            ),
                            cursorColor: AppColor.grayColorFont,
                            cursorHeight:24,
                          ),

                        ),),
                      const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle + 20),
                      if(image.isNotEmpty||video.isNotEmpty)
                        buildMediaGrid(),
                      const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle + 20),

                      if (_selectedImages.isNotEmpty) _buildSelectedImagesPreview(),
                      const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),

                      if (_selectedVideos .isNotEmpty && _videoPlayerController != null)
                        _buildSelectedVideosPreview()
                    ],
                  ),
                ),
              ),
              fallback: (context) => Center(
                child: CircularProgressIndicator(
                  color: AppColor.orangeColor,
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
                      _showImageSourceDialog();

                    },
                    icon: Icon(Icons.image, color: AppColor.orangeColor, size: 24),
                  ),

                  IconButton(
                    onPressed:() {
                      _showVideoSourceDialog();


                    },
                    icon: Icon(Icons.video_collection, color: AppColor.orangeColor, size: 24),
                  ),
                  const Spacer(),
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
      },
    );
  }
}
class Thumbnail {
  final Uint8List data;

  Thumbnail(this.data);
}