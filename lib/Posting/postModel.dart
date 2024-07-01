import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class PostModel extends StatefulWidget {
  final List<dynamic>? videoUrl;
  final List<dynamic>? imagePaths;
  final GestureTapCallback? onTapImage;
  final String imagePath; // "assets/images/Mask group.png"
  final String name; // Orlando Diggs
  final String time; // 21 minutes ago
  final VoidCallback? onPressedForCommit;
  final VoidCallback? onPressedForFavorit;
  final String numberOfCommit;
  final VoidCallback? onPressed;
  final bool deleteAndEdit;

  const PostModel({
    Key? key,
    this.videoUrl,
    this.imagePaths,
    this.onTapImage,
    required this.imagePath,
    required this.name,
    required this.time,
    this.onPressedForCommit,
    required this.numberOfCommit,
    this.onPressedForFavorit,
    this.onPressed,
    required this.deleteAndEdit,
  }) : super(key: key);

  @override
  State<PostModel> createState() => _PostModelState();
}

class _PostModelState extends State<PostModel> {
  void _openImageDialog(String imagePath) {
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
            padding: const EdgeInsets.symmetric(vertical: AppFontStyles.padding),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:NetworkImage("http://192.168.43.142:3000$imagePath"),
                      //mediaPaths[index]=="assets/images/aboutmy.png"?
                      // Image.asset("assets/images/aboutmy.png",fit: BoxFit.cover):
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                //imagePath=="assets/images/aboutmy.png"?AssetImage(imagePath)as ImageProvider<Object>:
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    icon: Icon(Icons.download_outlined, color: AppColor.orangeColor),
                    onPressed: () {
                      _saveImageToDevice("http://192.168.43.142:3000$imagePath");
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAllImagesDialog() {
    showGeneralDialog(
      context: context,
      barrierColor: AppColor.backgroundColor,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
        return Dialog(
          backgroundColor: AppColor.backgroundColor,
          insetPadding: EdgeInsets.symmetric(vertical: AppFontStyles.aboutMe, horizontal: 0),
          child: ListView.separated(
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                _openImageDialog(widget.imagePaths![index]);
              },
              child: Image.network(
                "http://192.168.43.142:3000${widget.imagePaths![index]}",
                fit: BoxFit.cover,
              ),
            ),
            separatorBuilder: (context, index) => SizedBox(
              height: AppFontStyles.aboutMe - 4,
            ),
            itemCount: widget.imagePaths!.length,
          ),
        );
      },
    );
  }

  Future<void> _saveImageToDevice(String imagePath) async {
    try {
      // Get the byte data from the image file
      final ByteData bytes = await rootBundle.load("http://192.168.43.142:3000$imagePath");
      final Uint8List list = bytes.buffer.asUint8List();

      // Save the image to the device gallery
      final result = await ImageGallerySaver.saveImage(list);

      // Show a confirmation dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Saved Successfully', style: TextStyle(color: AppColor.bluColor)),
          content: Text('Image saved to gallery.', style: TextStyle(color: AppColor.grayColorFont)),
          actions: [
            TextButton(
              child: Text('OK', style: TextStyle(color: AppColor.orangeColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } catch (e) {
      print('Error saving image: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error', style: TextStyle(color: AppColor.bluColor)),
          content: Text('Failed to save image.', style: TextStyle(color: AppColor.grayColorFont)),
          actions: [
            TextButton(
              child: Text('OK', style: TextStyle(color: AppColor.orangeColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(AppFontStyles.aboutMe),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: GestureDetector(
                    onTap: widget.onTapImage,
                    child: ClipOval(
                      child: widget.imagePath != "assets/images/aboutmy.png"
                          ? Image.network(
                        "http://192.168.43.142:3000${widget.imagePath}",
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                      )
                          : Image.asset(
                        widget.imagePath,
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                  title: Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: AppFontStyles.descriptionSplashScreenFontSize,
                      color: AppColor.bluColor,
                      fontWeight: AppFontStyles.fontWeightBold,
                    ),
                  ),
                  subtitle: Text(
                    widget.time,
                    style: TextStyle(
                      fontSize: AppFontStyles.descriptionLoginFontSize,
                      color: AppColor.fontColorDescription,
                      fontWeight: AppFontStyles.fontWeightMedium,
                    ),
                  ),
                  trailing: widget.deleteAndEdit
                      ? IconButton(onPressed: widget.onPressed, icon: Icon(Icons.more_vert))
                      : SizedBox(),
                ),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),
                _buildMediaGrid(),
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: AppColor.comment,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
            child: Row(
              children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.favorite, color: Colors.red),
                      onPressed: widget.onPressedForFavorit,
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(CupertinoIcons.bubble_left),
                      onPressed: widget.onPressedForCommit,
                    ),
                    Text(
                      widget.numberOfCommit,
                      style: TextStyle(fontSize: AppFontStyles.aboutMe, color: AppColor.commentFont),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaGrid() {
    List<String> mediaPaths = [];
    if (widget.videoUrl != null) {
      mediaPaths.addAll(widget.videoUrl!.cast<String>());
    }
    if (widget.imagePaths != null) {
      mediaPaths.addAll(widget.imagePaths!.cast<String>());
    }

    int itemCount = mediaPaths.length > 5 ? 5 : mediaPaths.length;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      itemCount: itemCount + (mediaPaths.length > 5 ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < 5) {
          bool isVideo = widget.videoUrl != null && widget.videoUrl!.contains(mediaPaths[index]);
          return GestureDetector(
            onTap: () {
              if (isVideo) {
                // Play the video
              } else {
                _openImageDialog(mediaPaths[index]);
              }
            },
            child: isVideo
                ? Container(
              color: Colors.black,
              child: const Center(
                child: Icon(Icons.play_circle_outline, color: Colors.white, size: 50),
              ),
            )
                :Image(image: NetworkImage("http://192.168.43.142:3000${mediaPaths[index]}"),fit: BoxFit.cover),
          );
        } else {
          return GestureDetector(

            onTap: () {
              _showAllImagesDialog();
            },
            child: Container(
              color: AppColor.comment,
              child: Center(
                child: Text(
                  '+${mediaPaths.length - 5}',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
