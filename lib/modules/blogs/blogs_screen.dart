import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plants_orange/modules/details_blogs/details_blocs.dart';
import 'package:plants_orange/modules/home_screen/home_cubit/plants_cubit.dart';

import '../../shared/constant.dart';
import '../../style/colors.dart';

class CarePlantsScreen extends StatelessWidget {
  const CarePlantsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Blogs',
          style: TextStyle(
            fontSize: 19.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 10.h),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 8.h,
                ),
                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 22.h),
                    itemBuilder: (context, index) {
                      return _buildItemPlants(
                          context,
                          PlantsCubit.get(context)
                              .blogsModel!
                              .data!
                              .plants![index]);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 22.h,
                      );
                    },
                    itemCount: PlantsCubit.get(context)
                        .blogsModel!
                        .data!
                        .plants!
                        .length),
                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 22.h),
                    itemBuilder: (context, index) {
                      return _buildItemSeeds(
                          context,
                          PlantsCubit.get(context)
                              .blogsModel!
                              .data!
                              .seeds![index]);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 22.h,
                      );
                    },
                    itemCount: PlantsCubit.get(context)
                        .blogsModel!
                        .data!
                        .seeds!
                        .length),
                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 22.h),
                    itemBuilder: (context, index) {
                      return _buildItemTools(
                          context,
                          PlantsCubit.get(context)
                              .blogsModel!
                              .data!
                              .tools![index]);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 22.h,
                      );
                    },
                    itemCount: PlantsCubit.get(context)
                        .blogsModel!
                        .data!
                        .tools!
                        .length),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemPlants(context, data) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsBlocsScreen(data: data)));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 14.h),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.network(
                    // 'https://assets.reedpopcdn.com/sonic-the-hedgehog-movie-reveals-less-awful-design-1573557005841.jpg/BROK/thumbnail/1600x800/format/jpg/quality/80/sonic-the-hedgehog-movie-reveals-less-awful-design-1573557005841.jpg',
                    '$BASE_URL${data.imageUrl}',
                    fit: BoxFit.cover,
                    height: 140.h,
                    width: 150.w, errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/ex_plant.png',
                    fit: BoxFit.cover,
                    width: 150.w,
                    height: 140.h,
                  );
                }, loadingBuilder: (context, child, loadingProgress) {
                  return loadingProgress == null
                      ? child
                      : SizedBox(
                          width: 150.w,
                          height: 140.h,
                          child: Center(
                            child: CupertinoActivityIndicator(
                              color: PrimaryGreen,
                            ),
                          ),
                        );
                }),
              ),
              SizedBox(
                width: 16.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.name!,
                        style: TextStyle(
                          fontSize: 16.sp,
                          height: 1.6.h,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000000),
                        )),
                    Text(data.description!,
                        style: TextStyle(
                          fontSize: 13.sp,
                          height: 1.6.h,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF7D7B7B),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemSeeds(context, data) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsBlocsScreen(data: data)));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 14.h),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.network(
                    // 'https://assets.reedpopcdn.com/sonic-the-hedgehog-movie-reveals-less-awful-design-1573557005841.jpg/BROK/thumbnail/1600x800/format/jpg/quality/80/sonic-the-hedgehog-movie-reveals-less-awful-design-1573557005841.jpg',
                    '$BASE_URL${data.imageUrl}',
                    fit: BoxFit.cover,
                    height: 140.h,
                    width: 150.w, errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/ex_plant.png',
                    fit: BoxFit.cover,
                    width: 150.w,
                    height: 140.h,
                  );
                }, loadingBuilder: (context, child, loadingProgress) {
                  return loadingProgress == null
                      ? child
                      : SizedBox(
                          width: 150.w,
                          height: 140.h,
                          child: Center(
                            child: CupertinoActivityIndicator(
                              color: PrimaryGreen,
                            ),
                          ),
                        );
                }),
              ),
              SizedBox(
                width: 16.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.name!,
                        style: TextStyle(
                          fontSize: 16.sp,
                          height: 1.6.h,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000000),
                        )),
                    Text(data.description!,
                        style: TextStyle(
                          fontSize: 13.sp,
                          height: 1.6.h,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF7D7B7B),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemTools(context, data) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsBlocsScreen(data: data)));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 14.h),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.network(
                    // 'https://assets.reedpopcdn.com/sonic-the-hedgehog-movie-reveals-less-awful-design-1573557005841.jpg/BROK/thumbnail/1600x800/format/jpg/quality/80/sonic-the-hedgehog-movie-reveals-less-awful-design-1573557005841.jpg',
                    '$BASE_URL${data.imageUrl}',
                    fit: BoxFit.cover,
                    height: 140.h,
                    width: 150.w, errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/ex_plant.png',
                    fit: BoxFit.cover,
                    width: 150.w,
                    height: 140.h,
                  );
                }, loadingBuilder: (context, child, loadingProgress) {
                  return loadingProgress == null
                      ? child
                      : SizedBox(
                          width: 150.w,
                          height: 140.h,
                          child: Center(
                            child: CupertinoActivityIndicator(
                              color: PrimaryGreen,
                            ),
                          ),
                        );
                }),
              ),
              SizedBox(
                width: 16.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.name!,
                        style: TextStyle(
                          fontSize: 16.sp,
                          height: 1.6.h,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000000),
                        )),
                    Text(data.description!,
                        style: TextStyle(
                          fontSize: 13.sp,
                          height: 1.6.h,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF7D7B7B),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
