import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotModel {
  String title;
  String time;
  String image;

  NotModel({required this.title, required this.time, required this.image});
}

List<dynamic> list = [
  NotModel(
      title: 'Joy Arnold left 6 comments on Your Post',
      time: 'Yesterday at 11:42 PM',
      image: 'assets/images/person_11.png'),
  NotModel(
      title: 'Dennis Nedry commented on Isla Nublar SOC2 compliance report',
      time: 'Yesterday at 5:42 PM',
      image: 'assets/images/person_2.png'),
  NotModel(
      title: 'John Hammond created Isla Nublar SOC2 compliance report  ',
      time: 'Wednesday at 11:15 AM',
      image: 'assets/images/person_3.png'),
  NotModel(
      title: 'Joy Arnold left 6 comments on Your Post',
      time: 'Yesterday at 11:42 PM',
      image: 'assets/images/person_11.png'),
  NotModel(
      title: 'Dennis Nedry commented on Isla Nublar SOC2 compliance report',
      time: 'Yesterday at 5:42 PM',
      image: 'assets/images/person_2.png'),
  NotModel(
      title: 'John Hammond created Isla Nublar SOC2 compliance report  ',
      time: 'Wednesday at 11:15 AM',
      image: 'assets/images/person_3.png'),
  NotModel(
      title: 'Joy Arnold left 6 comments on Your Post',
      time: 'Yesterday at 11:42 PM',
      image: 'assets/images/person_11.png'),
  NotModel(
      title: 'Dennis Nedry commented on Isla Nublar SOC2 compliance report',
      time: 'Yesterday at 5:42 PM',
      image: 'assets/images/person_2.png'),
  NotModel(
      title: 'John Hammond created Isla Nublar SOC2 compliance report  ',
      time: 'Wednesday at 11:15 AM',
      image: 'assets/images/person_3.png'),
  NotModel(
      title: 'Joy Arnold left 6 comments on Your Post',
      time: 'Yesterday at 11:42 PM',
      image: 'assets/images/person_11.png'),
  NotModel(
      title: 'Dennis Nedry commented on Isla Nublar SOC2 compliance report',
      time: 'Yesterday at 5:42 PM',
      image: 'assets/images/person_2.png'),
  NotModel(
      title: 'John Hammond created Isla Nublar SOC2 compliance report  ',
      time: 'Wednesday at 11:15 AM',
      image: 'assets/images/person_3.png'),
];

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Notification',
          style: TextStyle(
            fontSize: 19.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,

          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 8.h,
            ),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _buildItem(list[index]);
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.grey,
                      height: 3.h,
                    );
                  },
                  itemCount: list.length),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItem(NotModel model) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      child: Row(
        children: [
          Image.asset(
            model.image,
            height: 40.h,
            width: 40.w,
          ),
          SizedBox(
            width: 16.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      height: 1.6.h,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1A1F36),
                    )),
                Text(model.time,
                    style: TextStyle(
                      fontSize: 13.sp,
                      height: 1.6.h,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFA5ACB8),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
