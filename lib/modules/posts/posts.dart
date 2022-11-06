import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plants_orange/modules/home_screen/home_cubit/plants_cubit.dart';
import 'package:plants_orange/modules/home_screen/home_cubit/plants_states.dart';
import 'package:plants_orange/modules/posts/search_forums_screen.dart';

import '../../shared/constant.dart';
import '../../style/colors.dart';
import 'comments_screen.dart';
import 'new_posts_screen.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlantsCubit, PlantsState>(
      listener: (context, state) {
        if (PlantsCubit.get(context).isLiked) {
          Fluttertoast.showToast(
            msg: 'Liked 👍🏼',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.sp,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Padding(
              padding: EdgeInsets.only(
                left: 15.w,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            title: Text(
              'Discussion Forums',
              style: TextStyle(
                fontSize: 21.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                top: 30.h,
                left: 22.w,
                right: 22.w,
              ),
              child: Column(
                children: [
                  Container(
                    height: 56.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SearchForumsScreen()));
                      },
                      elevation: 0,
                      child: Row(
                        children: [
                          Icon(
                            Icons.search_sharp,
                            color: const Color(0xFF979797),
                            size: 26.w,
                          ),
                          SizedBox(width: 13.w),
                          Text(
                            'Search',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF979797),
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      PlantsCubit.get(context).isAllForums
                          ? SizedBox(
                              width: 130.w,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: PrimaryGreen,
                                  ),
                                  backgroundColor: PrimaryGreen,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                ),
                                child: Text(
                                  'All forums',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontFamily: 'Roboto'),
                                ),
                              ),
                            )
                          : SizedBox(
                              width: 130.w,
                              child: OutlinedButton(
                                onPressed: () {
                                  PlantsCubit.get(context).pressAllForums();
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: Colors.grey.shade400,
                                  ),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                ),
                                child: Text(
                                  'All forums',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF979797),
                                      fontFamily: 'Roboto'),
                                ),
                              ),
                            ),
                      SizedBox(width: 12.w),
                      PlantsCubit.get(context).isAllForums
                          ? SizedBox(
                              width: 130.w,
                              child: OutlinedButton(
                                onPressed: () {
                                  PlantsCubit.get(context).pressMeForums();
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: Colors.grey.shade400,
                                  ),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                ),
                                child: Text(
                                  'My forums',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF979797),
                                      fontFamily: 'Roboto'),
                                ),
                              ),
                            )
                          : SizedBox(
                              width: 130.w,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: PrimaryGreen,
                                  ),
                                  backgroundColor: PrimaryGreen,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                ),
                                child: Text(
                                  'My forums',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontFamily: 'Roboto'),
                                ),
                              ),
                            ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => (PlantsCubit.get(context)
                              .isAllForums)
                          ? buildPostItem(context, index)
                          : (PlantsCubit.get(context).myForumsModel!.data == [])
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 100.h,
                                    ),
                                    Image.asset('assets/images/NotFound.png'),
                                    SizedBox(
                                      height: 40.h,
                                    ),
                                     Text('Your forums will appear here',
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontFamily: 'Roboto',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff212121),
                                        )),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Text(
                                        textAlign: TextAlign.center,
                                        'You can create your own forum by clicking on the button below',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontFamily: 'Roboto',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                        )),
                                    SizedBox(
                                      height: 160.h,
                                    ),
                                  ],
                                )
                              : buildMyPostItem(context, index),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 15.h),
                      itemCount: (PlantsCubit.get(context).isAllForums)
                          ? PlantsCubit.get(context).forumsModel!.data!.length
                          : PlantsCubit.get(context)
                              .myForumsModel!
                              .data!
                              .length),
                ],
              ),
            ),
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(
              bottom: 33.h,
              right: 13.w,
            ),
            child: FloatingActionButton(
              onPressed: () async {
                String refresh = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewPostsScreen()));
                if (refresh == 'refresh') {
                  PlantsCubit.get(context).getForums();
                  PlantsCubit.get(context).getMyForums();
                }
              },
              backgroundColor: PrimaryGreen,
              elevation: 0,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildPostItem(context, index) => Card(
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  //profile photo
                  CircleAvatar(
                    radius: 25.r,
                    backgroundImage: const NetworkImage(
                      'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=996&t=st=1661287053~exp=1661287653~hmac=24fc408af533afa9006d5f47ba23f4ba9deca0c2d0065f4230f223947127524d',
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  //name , check mark & date
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //name & check mark
                        Text(
                            '${PlantsCubit.get(context).forumsModel!.data![index].user!.firstName} ${PlantsCubit.get(context).forumsModel!.data![index].user!.lastName}',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontFamily: 'Roboto')),
                        //date and time
                        Text(
                          'Marsh 21 ,2022 at 11:00 pm',
                          style: TextStyle(
                              fontSize: 11.sp,
                              height: 1.6.h,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF979797),
                              fontFamily: 'Roboto'),
                        ),
                      ],
                    ),
                  ),
                  //three dots
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 18,
                    ),
                  ),
                ],
              ),
              //separator
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: Container(
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${PlantsCubit.get(context).forumsModel!.data![index].title}',
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: PrimaryGreen),
              ),
              //hashtag text
              Padding(
                padding: EdgeInsets.only(
                  bottom: 8.h,
                  top: 12.h,
                ),
                child: Text(
                  '${PlantsCubit.get(context).forumsModel!.data![index].description}',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF8F8D8D),
                  ),
                ),
              ),
              //photo of post
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: SizedBox(
                  height: 180.h,
                  width: double.infinity,
                  child: Image.network(
                    '$BASE_URL${PlantsCubit.get(context).forumsModel!.data![index].imageUrl}',
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CupertinoActivityIndicator(
                          color: PrimaryGreen,
                        ),
                      );
                    },
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Image.asset(
                        'assets/images/beautiful-natural-landscape (1).jpg',
                        fit: BoxFit.cover,
                      );
                    },
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //likes and comments
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/icons/like.svg'),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                '${PlantsCubit.get(context).forumsModel!.data![index].forumLikes!.length} Likes',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.comment_outlined,
                                size: 18.w,
                                color: Colors.grey.shade500,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${PlantsCubit.get(context).forumsModel!.data![index].forumComments!.length} Replies',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              //separator
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Container(
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              //comment like share
              Row(
                children: [
                  //write a comment
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentsScreen(
                              data: PlantsCubit.get(context)
                                  .forumsModel!
                                  .data![index]
                                  .forumComments!,
                              forumId: PlantsCubit.get(context)
                                  .forumsModel!
                                  .data![index]
                                  .forumId,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16.r,
                            backgroundImage: const NetworkImage(
                              'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=996&t=st=1661287053~exp=1661287653~hmac=24fc408af533afa9006d5f47ba23f4ba9deca0c2d0065f4230f223947127524d',
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            'write a comment',
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //like button
                  InkWell(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/like.svg',
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {
                      PlantsCubit.get(context).addLike(
                          id: PlantsCubit.get(context)
                              .forumsModel!
                              .data![index]
                              .forumId!);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      );

  Widget buildMyPostItem(context, index) => Card(
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  //profile photo
                  CircleAvatar(
                    radius: 25.r,
                    backgroundImage: const NetworkImage(
                      'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=996&t=st=1661287053~exp=1661287653~hmac=24fc408af533afa9006d5f47ba23f4ba9deca0c2d0065f4230f223947127524d',
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  //name , check mark & date
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //name & check mark
                        Text(
                            '${PlantsCubit.get(context).myForumsModel!.data![index].user!.firstName} ${PlantsCubit.get(context).myForumsModel!.data![index].user!.lastName}',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontFamily: 'Roboto')),
                        //date and time
                        Text(
                          'Marsh 21 ,2022 at 11:00 pm',
                          style: TextStyle(
                              fontSize: 11.sp,
                              height: 1.6.h,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF979797),
                              fontFamily: 'Roboto'),
                        ),
                      ],
                    ),
                  ),
                  //three dots
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 18,
                    ),
                  ),
                ],
              ),
              //separator
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: Container(
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${PlantsCubit.get(context).myForumsModel!.data![index].title}',
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: PrimaryGreen),
              ),
              //hashtag text
              Padding(
                padding: EdgeInsets.only(
                  bottom: 8.h,
                  top: 12.h,
                ),
                child: Text(
                  '${PlantsCubit.get(context).myForumsModel!.data![index].description}',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF8F8D8D),
                  ),
                ),
              ),
              //photo of post
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: SizedBox(
                  height: 180.h,
                  width: double.infinity,
                  child: Image.network(
                    '$BASE_URL${PlantsCubit.get(context).myForumsModel!.data![index].imageUrl}',
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CupertinoActivityIndicator(
                          color: PrimaryGreen,
                        ),
                      );
                    },
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Image.asset(
                        'assets/images/beautiful-natural-landscape (1).jpg',
                        fit: BoxFit.cover,
                      );
                    },
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //likes and comments
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/icons/like.svg'),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                '${PlantsCubit.get(context).myForumsModel!.data![index].forumLikes!.length} Likes',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.comment_outlined,
                                size: 18.w,
                                color: Colors.grey.shade500,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${PlantsCubit.get(context).myForumsModel!.data![index].forumComments!.length} Replies',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              //separator
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Container(
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              //comment like share
              Row(
                children: [
                  //write a comment
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentsScreen(
                              data: PlantsCubit.get(context)
                                  .myForumsModel!
                                  .data![index]
                                  .forumComments!,
                              forumId: PlantsCubit.get(context)
                                  .myForumsModel!
                                  .data![index]
                                  .forumId!,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16.r,
                            backgroundImage: const NetworkImage(
                              'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=996&t=st=1661287053~exp=1661287653~hmac=24fc408af533afa9006d5f47ba23f4ba9deca0c2d0065f4230f223947127524d',
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            'write a comment',
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //like button
                  InkWell(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/like.svg',
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {
                      PlantsCubit.get(context).addLike(
                          id: PlantsCubit.get(context)
                              .myForumsModel!
                              .data![index]
                              .forumId!);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
