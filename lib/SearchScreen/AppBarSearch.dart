import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/searchLocation.dart';
import 'package:skilled_handyworkers_marketpleace/SearchModel/searchService.dart';
import 'package:skilled_handyworkers_marketpleace/SearchScreen/Search.dart';
import 'package:skilled_handyworkers_marketpleace/profileScreens/Box.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/colors.dart';
import 'package:skilled_handyworkers_marketpleace/shared/styles/styles.dart';

class AppBarSearch extends StatefulWidget implements PreferredSizeWidget {
  final TextEditingController textControllerService ;
  final TextEditingController textControllerLocation ;

  const AppBarSearch({
    Key? key, required this.textControllerService, required this.textControllerLocation,
  }) : super(key: key);

  @override
  State<AppBarSearch> createState() => _AppBarSearchState();
  @override
  Size get preferredSize => const Size.fromHeight(220);

}

class _AppBarSearchState extends State<AppBarSearch> {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      surfaceTintColor:  AppColor.backgroundColor,

      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      flexibleSpace: Container(
        height: MediaQuery.of(context).size.height * (220 / 100),
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(35), bottomLeft: Radius.circular(35)),
          image: DecorationImage(
            image: AssetImage('assets/images/Background (1).png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle,),
            SizedBox(height: AppFontStyles.sizeBetweenTitleAndSubTitle,),

            Box(
              widget: SizedBox(
                width:MediaQuery.of(context).size.width-60,
                height: 40,
                child: GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Service(
                          textController: widget.textControllerService,
                          title: "Add Service",
                          titleSearch: "Search",
                          widget: const Search(),
                        ),
                      ),
                    );
                    if (result != null && result is String) {
                      setState(() {
                        widget.textControllerService.text = result;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.aboutMe, vertical: 8),
                    child: Row(
                      children: [
                        Icon(Icons.search_rounded,color:AppColor.grayColorFont ,),
                        SizedBox(width: 10,),
                        Text(
                          widget.textControllerService.text.isEmpty ? "Select service" :widget.textControllerService.text,
                          style: TextStyle(
                            color: AppColor.grayColorFont,
                            fontSize: AppFontStyles.descriptionLoginFontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              height: 40,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            SizedBox(height: AppFontStyles.sizeBetweenBoxAndSubTitle,),
            Box(
              widget: SizedBox(
                width:MediaQuery.of(context).size.width-60,
                height: 40,
                child: GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Location(
                          textController: widget.textControllerLocation,
                          widget: const Search(),
                        ),
                      ),
                    );
                    if (result != null && result is String) {
                      setState(() {
                        widget.textControllerLocation.text = result;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppFontStyles.aboutMe, vertical: 8),
                    child: Row(
                      children: [
                        Icon(Icons.location_on_outlined,color:AppColor.orangeColor ,),
                        SizedBox(width: 10,),
                        Text(
                          widget.textControllerLocation.text.isEmpty ? "Select location" : widget.textControllerLocation.text,
                          style: TextStyle(
                            color: AppColor.grayColorFont,
                            fontSize: AppFontStyles.descriptionLoginFontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              height: 40,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ],
        ),
      ),
    );
  }


}
