import 'package:d_scan_admin/screen/banners/bannars_home.dart';
import 'package:d_scan_admin/screen/users/userPage.dart';
import 'package:d_scan_admin/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../admision/admisionHome.dart';
import '../advices/advice_home.dart';
import '../all_apoinment/appointmentHome.dart';
import '../all_doctors/doctors.dart';
import '../best_doctors/best_doctors_homes.dart';
import '../lesar_tritment/leserPage.dart';
import '../our_service/service_home.dart';

class HomepageData extends GetxController {
  RxList homeData = [
    {
      'icon': Icon(
        Icons.person,
        size: 70.sp,
        color: HomeColors.iconColor,
      ),
      "text": "ব্যবহার কারি",
      "pages": UserPage()
    },
    {
      'icon': Container(
        height: 80.h,
        width: 150.h,
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            HomeColors.iconColor,
            BlendMode.srcIn,
          ),
          child: Image.asset(
            fit: BoxFit.cover,
            'assets/icon/leser.png',
          ),
        ),
      ),
      "text": "লেসার ট্রিটমেন্ট",
      "pages": LessarPage()
    },
    {
      'icon': SvgPicture.string(
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M224 256A128 128 0 1 0 224 0a128 128 0 1 0 0 256zm-96 55.2C54 332.9 0 401.3 0 482.3C0 498.7 13.3 512 29.7 512H418.3c16.4 0 29.7-13.3 29.7-29.7c0-81-54-149.4-128-171.1V362c27.6 7.1 48 32.2 48 62v40c0 8.8-7.2 16-16 16H336c-8.8 0-16-7.2-16-16s7.2-16 16-16V424c0-17.7-14.3-32-32-32s-32 14.3-32 32v24c8.8 0 16 7.2 16 16s-7.2 16-16 16H256c-8.8 0-16-7.2-16-16V424c0-29.8 20.4-54.9 48-62V304.9c-6-.6-12.1-.9-18.3-.9H178.3c-6.2 0-12.3 .3-18.3 .9v65.4c23.1 6.9 40 28.3 40 53.7c0 30.9-25.1 56-56 56s-56-25.1-56-56c0-25.4 16.9-46.8 40-53.7V311.2zM144 448a24 24 0 1 0 0-48 24 24 0 1 0 0 48z"/></svg>',
        width: 70.w,
        height: 70.h,
        color: HomeColors.iconColor,
      ),
      "text": "জনপ্রিয় ডাক্তার",
      "pages": BestDoctors()
    },
    {
      'icon': SvgPicture.string(
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M112 48a48 48 0 1 1 96 0 48 48 0 1 1 -96 0zm40 304V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V256.9L59.4 304.5c-9.1 15.1-28.8 20-43.9 10.9s-20-28.8-10.9-43.9l58.3-97c17.4-28.9 48.6-46.6 82.3-46.6h29.7c33.7 0 64.9 17.7 82.3 46.6l58.3 97c9.1 15.1 4.2 34.8-10.9 43.9s-34.8 4.2-43.9-10.9L232 256.9V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V352H152z"/></svg>',
        width: 70.w,
        height: 70.h,
        color: Colors.blue,
      ),
      "text": "সকল ডাক্তার",
      "pages": DoctorHome()
    },
    {
      'icon': SvgPicture.string(
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M112 48a48 48 0 1 1 96 0 48 48 0 1 1 -96 0zm40 304V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V256.9L59.4 304.5c-9.1 15.1-28.8 20-43.9 10.9s-20-28.8-10.9-43.9l58.3-97c17.4-28.9 48.6-46.6 82.3-46.6h29.7c33.7 0 64.9 17.7 82.3 46.6l58.3 97c9.1 15.1 4.2 34.8-10.9 43.9s-34.8 4.2-43.9-10.9L232 256.9V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V352H152z"/></svg>',
        width: 70.w,
        height: 70.h,
        color: Colors.blue,
      ),
      "text": "সকল পরমর্শ",
      "pages": MyAppointmentsScreen()
    },
    {
      'icon': SvgPicture.string(
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M48 0C21.5 0 0 21.5 0 48V256H144c8.8 0 16 7.2 16 16s-7.2 16-16 16H0v64H144c8.8 0 16 7.2 16 16s-7.2 16-16 16H0v80c0 26.5 21.5 48 48 48H265.9c-6.3-10.2-9.9-22.2-9.9-35.1c0-46.9 25.8-87.8 64-109.2V271.8 48c0-26.5-21.5-48-48-48H48zM152 64h16c8.8 0 16 7.2 16 16v24h24c8.8 0 16 7.2 16 16v16c0 8.8-7.2 16-16 16H184v24c0 8.8-7.2 16-16 16H152c-8.8 0-16-7.2-16-16V152H112c-8.8 0-16-7.2-16-16V120c0-8.8 7.2-16 16-16h24V80c0-8.8 7.2-16 16-16zM512 272a80 80 0 1 0 -160 0 80 80 0 1 0 160 0zM288 477.1c0 19.3 15.6 34.9 34.9 34.9H541.1c19.3 0 34.9-15.6 34.9-34.9c0-51.4-41.7-93.1-93.1-93.1H381.1c-51.4 0-93.1 41.7-93.1 93.1z"/></svg>',
        width: 70.w,
        height: 70.h,
        color: Colors.blue,
      ),
      "text": "ভর্তি আছে",
      "pages": AdmissionScreen()
    },
    {
      'icon': SvgPicture.string(
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M64 64C28.7 64 0 92.7 0 128V384c0 35.3 28.7 64 64 64H512c35.3 0 64-28.7 64-64V128c0-35.3-28.7-64-64-64H64zm48 160H272c8.8 0 16 7.2 16 16s-7.2 16-16 16H112c-8.8 0-16-7.2-16-16s7.2-16 16-16zM96 336c0-8.8 7.2-16 16-16H464c8.8 0 16 7.2 16 16s-7.2 16-16 16H112c-8.8 0-16-7.2-16-16zM376 160h80c13.3 0 24 10.7 24 24v48c0 13.3-10.7 24-24 24H376c-13.3 0-24-10.7-24-24V184c0-13.3 10.7-24 24-24z"/></svg>',
        width: 70.w,
        height: 70.h,
        color: Colors.blue,
      ),
      "text": "সকল পেমেন্ট",
      // "pages": SizedBox()
    },
    {
      'icon': Icon(
        Icons.medical_services,
        size: 70.sp,
        color: HomeColors.iconColor,
      ),
      "text": "আমাদের সেবা",
      "pages": ServiceHome()
    },
    {
      'icon': Icon(
        Icons.tips_and_updates,
        size: 70.sp,
        color: HomeColors.iconColor,
      ),
      "text": "উপদেশ",
      "pages": AdviceScreen()
    },
    {
      'icon': Icon(
        Icons.local_offer,
        size: 70.sp,
        color: HomeColors.iconColor,
      ),
      "text": "ব্যানার/অফার",
      "pages": BannersHome()
    },
  ].obs;
}
