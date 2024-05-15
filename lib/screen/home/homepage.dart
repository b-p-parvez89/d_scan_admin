import 'package:d_scan_admin/screen/home/data.dart';
import 'package:d_scan_admin/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../banners/image_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomepageData data = Get.put(HomepageData());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "D SCAN HOSPITAL",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      // backgroundColor: HomeColors.bgColor,
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          ImageSlider(),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: data.homeData.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                var _data = data.homeData[index];
                return GestureDetector(
                  onTap: () async {
                    if (_data["pages"] != null) {
                      Get.to(_data["pages"]);
                    } else {
                      print("This page is null");
                    }
                  },
                  child: Container(
                    height: 100.h,
                    width: size.width / 2.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.indigo),
                        color: HomeColors.sectionColor),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _data["icon"],
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            _data['text'],
                            style: TextStyle(
                                color: HomeColors.iconColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          )
                        ]),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
