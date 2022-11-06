import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plants_orange/modules/home_screen/home_cubit/plants_cubit.dart';
import 'package:plants_orange/modules/home_screen/home_cubit/plants_states.dart';

import '../../models/forums_model.dart';

var commentController = TextEditingController();
String yourComment = '';

class CommentsScreen extends StatefulWidget {
  List<ForumComments> data;
  var forumId;

  CommentsScreen({this.forumId, required this.data, Key? key})
      : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlantsCubit, PlantsState>(
      listener: (context, state) {
        if (state is ForumsLoadingState) {
          Fluttertoast.showToast(
            msg: 'Comments Loading...',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.sp,
          );
        }
        if (state is ForumsSuccessState) {
          Navigator.pop(context);
          commentController.clear();
          yourComment = '';
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
                  commentController.clear();
                  yourComment = '';
                },
              ),
            ),
            title: Text(
              'Comments',
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
                        return _buildItem(widget.data[index]);
                      },
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                          ),
                          child: Divider(
                            color: Colors.grey,
                            height: 3.h,
                          ),
                        );
                      },
                      itemCount: widget.data.length),
                ),
                Container(
                  color: Colors.white,
                  height: 60.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: commentController,
                            cursorColor: Colors.black,
                            onFieldSubmitted: (value) {
                              print(value);
                              PlantsCubit.get(context).addComment(
                                  comment: commentController.text,
                                  id: widget.forumId);
                            },
                            onChanged: (value) {
                              setState(() {
                                yourComment = value;
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: 'Write a comment',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        PlantsCubit.get(context).isComment
                            ? Center(
                                child: CupertinoActivityIndicator(
                                  color: Colors.black,
                                  radius: 12.r,
                                ),
                              )
                            : IconButton(
                                icon: const Icon(Icons.send),
                                onPressed: () {
                                  print(yourComment);
                                  print(widget.forumId);
                                  PlantsCubit.get(context).addComment(
                                      comment: yourComment, id: widget.forumId);
                                },
                              ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildItem(data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              'assets/images/close-up-young.jpg',
              height: 40.h,
              width: 40.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.comment,
                    style: TextStyle(
                      fontSize: 14.sp,
                      height: 1.6.h,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1A1F36),
                    )),
                Text(data.createdAt,
                    style: TextStyle(
                      fontSize: 11.sp,
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
