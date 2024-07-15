import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Add this import
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart' as p;
import 'package:skilled_handyworkers_marketpleace/shared/components/constant.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

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
  VideoPlayerController? _videoPlayerController;
  Future<Uint8List?> generateThumbnail(String videoPath) async {
    return await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.PNG,
      maxHeight: 64, // specify the height of the thumbnail, keep aspect ratio
      quality: 75,
    );
  }

  void _showAllMediaDialog(List<dynamic> mediaItems) {
    List<dynamic> images = [];
    List<dynamic> videos = [];

    for (var path in mediaItems) {
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
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.only(top: 32.0),
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(mediaItems.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (videos.contains(mediaItems[index])) {
                        _openVideoDialog(mediaItems[index]); // Passes the video URL
                      } else {
                        _openImageDialog(mediaItems[index]); // Passes the image URL
                      }
                    },
                    child: videos.contains(mediaItems[index])
                        ? FutureBuilder<Uint8List?>(
                      future: generateThumbnail(mediaItems[index]),
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
                    )
                        : Image.network(
                      mediaItems[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }

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
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    icon: Icon(Icons.download_outlined, color: Colors.orange),
                    onPressed: () {
                      _saveImageToDevice(imagePath);
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

  void _openVideoDialog(String videoUrl) {
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
  Future<void> _saveImageToDevice(String imagePath) async {
    try {
      final response = await http.get(Uri.parse("$api$imagePath"));
      final Uint8List list = response.bodyBytes;
      final result = await ImageGallerySaver.saveImage(list);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Saved Successfully', style: TextStyle(color: Colors.blue)),
          content: Text('Image saved to gallery.', style: TextStyle(color: Colors.grey)),
          actions: [
            TextButton(
              child: Text('OK', style: TextStyle(color: Colors.orange)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error', style: TextStyle(color: Colors.blue)),
          content: Text('Failed to save image.', style: TextStyle(color: Colors.grey)),
          actions: [
            TextButton(
              child: Text('OK', style: TextStyle(color: Colors.orange)),
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
                      child: widget.imagePath != imageCope
                          ? Image.network(
                        "$api${widget.imagePath}",
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
                const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),

                _buildMediaGrid(),
              ],
            ),
          ),
          const SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle),
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
    List<dynamic> mediaItems = [];
    if (widget.videoUrl != null) {
      mediaItems.addAll(widget.videoUrl!.map((url) => "$api$url"));
    }
    if (widget.imagePaths != null) {
      mediaItems.addAll(widget.imagePaths!.map((url) => "$api$url"));
    }

    int itemCount = mediaItems.length > 5 ? 5 : mediaItems.length;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      itemCount: itemCount + (mediaItems.length > 5 ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < 5) {
          if (widget.videoUrl != null && index < widget.videoUrl!.length) {
            return GestureDetector(
              onTap: () {
                _openVideoDialog(mediaItems[index]);
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  FutureBuilder<Uint8List?>(
                    future: generateThumbnail(mediaItems[index]),
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
                ],
              ),
            );
          } else {
            return GestureDetector(
              onTap: () {
                _openImageDialog(mediaItems[index]);
              },
              child: Image.network(
                mediaItems[index],
                fit: BoxFit.cover,
              ),
            );
          }
        } else {
          return GestureDetector(
            onTap: () {
              _showAllMediaDialog(mediaItems);
            },
            child: Container(
              color: Colors.grey,
              child: Center(
                child: Text(
                  '+${mediaItems.length - 5}',
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
