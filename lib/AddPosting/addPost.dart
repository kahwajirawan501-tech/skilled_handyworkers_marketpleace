import 'dart:io';
import 'dart:typed_data';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skilled_handyworkers_marketpleace/AddPosting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/AddPosting/cubit/states.dart';
import 'package:skilled_handyworkers_marketpleace/Posting/cubit/cubit.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
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


class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController _textControllerService = TextEditingController();
  final TextEditingController _textControllerLocation = TextEditingController();
  final TextEditingController _textControllerDescription=TextEditingController();
  List<XFile> _selectedImages = [];
  List<XFile> _selectedVideos = [];
  VideoPlayerController? _videoPlayerController;

  bool selectService=false;
  bool selectLocation=false;



  void printSelectedVideos() {
    for (int i = 0; i < _selectedImages.length; i++) {
      print("Video ${i + 1}: ${_selectedImages[i].path}");
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

      if (images != null) {
        if (_selectedImages.length + images.length > 10) {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(
                "Limit Exceeded",
                style: TextStyle(color: AppColor.bluColor),
              ),
              content: Text(
                "You can select up to ${10 - _selectedImages.length} more images.",
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
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 200),
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
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation1, animation2) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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

//////////////////////////////////////////////////////////////////////////////////////////////
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

  Future<void> _pickVideosFromGallery() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: true,
      );

      if (result != null) {
        if (_selectedVideos.length + result.files.length > 10) {
          _showLimitExceededDialog(10 - _selectedVideos.length);
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
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Dialog(
          backgroundColor: Colors.transparent,
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
      barrierLabel: "All video Preview",
      barrierColor: AppColor.backgroundColor,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                  childAspectRatio: 1.0, // Added to make the videos square
                ),
                itemCount: _selectedVideos.length,
                itemBuilder: (BuildContext context, int index) {
                  XFile video = _selectedVideos[index];
                  VideoPlayerController videoPlayerController = VideoPlayerController.file(File(video.path));

                  return GestureDetector(
                    onTap: () {
                      _showVideoInDialog(video);
                    },
                    child: Stack(
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
                              return  Center(child: CircularProgressIndicator(color: AppColor.orangeColor));
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
                                  if (videoPlayerController.value.isPlaying) {
                                    videoPlayerController.pause();
                                  }
                                  videoPlayerController.dispose(); // Dispose the video player
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
                  );
                },
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
          itemCount: _selectedVideos.length > 5 ? 5 : _selectedVideos.length,
          itemBuilder: (BuildContext context, int index) {
            XFile video = _selectedVideos[index];
            VideoPlayerController videoPlayerController = VideoPlayerController.file(File(video.path));

            return GestureDetector(
              onTap: () {
                _showVideoInDialog(video);
              },
              child: Stack(
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
                          printSelectedVideos();
                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        if (remainingVideosCount > 0)
          GestureDetector(
            onTap: _showAllVideos,
            child: Text("+$remainingVideosCount more"),
          ),
      ],
    );
  }







  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPostCubit,AddPostStates>(
      listener: (context, state) {

        if(state is PostFileSucssessfullStateStates){

           AddPostCubit.get(context).addPost( _textControllerService.text,
               _textControllerLocation.text, _textControllerDescription.text
               ,AddPostCubit.get(context).ima, AddPostCubit.get(context).video);

        }
        else if(state is PostFileErrorStateStates){
           showToast(text:"error !! , when upload image and video \n"+state.message, state: ToastStates.EROOR);
        }

        if(state is AddPostSucssessfullStateStates){
          showToast(text:"The post has been published successfully", state: ToastStates.EROOR);
          Navigator.pop(context);
          CubitYourPost.get(context).getPost();
        }
        else if(state is AddPostErrorStateStates){
          showToast(text:"The post hasn't been published successfully \n"+state.message, state: ToastStates.EROOR);

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
                navigateAndFinish(widget:const BottomNavigationScreen(),context: context);
              },
            ),
            actions: [
              TextButton(onPressed:() {
                if(_textControllerLocation.text.isEmpty
                    &&_textControllerService.text.isEmpty
                    &&(_selectedImages.isEmpty&&_selectedVideos.isEmpty)){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(

                      backgroundColor: AppColor.backgroundColor,
                      content: Center(child: Text('You must fill in the service field and the location field and  choose the videos or photos that you want to publish',style: TextStyle(color: AppColor.grayColorFont),)),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }else if(_textControllerLocation.text.isNotEmpty
                    &&_textControllerService.text.isEmpty
                    &&(_selectedImages.isEmpty&&_selectedVideos.isEmpty)){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(

                      backgroundColor: AppColor.backgroundColor,
                      content: Center(child: Text('You must fill in the service field  and  choose the videos or photos that you want to publish',style: TextStyle(color: AppColor.grayColorFont),)),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
                else if(_textControllerLocation.text.isEmpty
                    &&_textControllerService.text.isNotEmpty
                    &&(_selectedImages.isEmpty&&_selectedVideos.isEmpty)){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(

                      backgroundColor: AppColor.backgroundColor,
                      content: Center(child: Text('You must fill in the location field  and  choose the videos or photos that you want to publish',style: TextStyle(color: AppColor.grayColorFont),)),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
                else if(_textControllerLocation.text.isNotEmpty
                    &&_textControllerService.text.isNotEmpty
                    &&_selectedImages.isEmpty&&_selectedVideos.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(

                      backgroundColor: AppColor.backgroundColor,
                      content: Center(child: Text('choose the videos or photos that you want to publish',
                        style: TextStyle(color: AppColor.grayColorFont),)),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
                else{
                  AddPostCubit.get(context).postFile(_selectedImages, _selectedVideos);
                }

              }, child:Text("post",style:TextStyle(
                  fontSize: AppFontStyles.descriptionLoginFontSize,
                  fontWeight: AppFontStyles.fontWeightBold,
                  color: AppColor.bottomNavigationBar
              ) ,))
            ],
            elevation: 0.0,
            backgroundColor: AppColor.backgroundColor,
          ),
          body: BlocConsumer<AddPostCubit,AddPostStates>(

            listener: (context, state) {

            },
            builder: (context, state) {
              return  Container(
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
                        ConditionalBuilder(
                          condition:state is !PostFileLoadStateStates ,
                          builder: (context) => ConditionalBuilder(
                            condition:state is !AddPostLoadStateStates ,
                            builder: (context) => const SizedBox(),
                            fallback:(context) => LinearProgressIndicator(color: AppColor.orangeColor,minHeight:1.0,),),
                          fallback: (context) => LinearProgressIndicator(color: AppColor.orangeColor,minHeight:1.0,) ,

                        ),
                        SizedBox(height:AppFontStyles.aboutMe,),
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
                        const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),
                        Text(
                          " Add Description ",
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

                                hintText:'add your description ..',
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

                        if (_selectedImages.isNotEmpty) _buildSelectedImagesPreview(),
                        const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),

                        if (_selectedVideos .isNotEmpty && _videoPlayerController != null)
                          _buildSelectedVideosPreview()
                      ],
                    ),
                  ),
                ),
              );
            },
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
                            duration: const Duration(seconds: 2),
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
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }

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