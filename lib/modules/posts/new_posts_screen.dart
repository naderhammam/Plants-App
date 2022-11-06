import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plants_orange/modules/home_screen/home_cubit/plants_cubit.dart';
import 'package:plants_orange/modules/home_screen/home_cubit/plants_states.dart';
import 'package:plants_orange/style/colors.dart';

var titleController = TextEditingController();
var bodyController = TextEditingController();
var formKey = GlobalKey<FormState>();
String urlImage64 = 'data:image/jpeg;base64,';

class NewPostsScreen extends StatefulWidget {
  const NewPostsScreen({Key? key}) : super(key: key);

  @override
  State<NewPostsScreen> createState() => _NewPostsScreenState();
}

class _NewPostsScreenState extends State<NewPostsScreen> {
  File? _image;
  Uint8List? bytes;
  String? image64;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        bytes = File(pickedFile.path).readAsBytesSync();
        image64 = base64Encode(bytes!);

      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlantsCubit, PlantsState>(
      listener: (context, state) {
        if (state is CreatePostSuccessState) {
          Navigator.pop(context, 'refresh');
          titleController.clear();
          bodyController.clear();
          _image = null;
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
                  titleController.clear();
                  bodyController.clear();
                  _image = null;
                },
              ),
            ),
            title: Text(
              'Create New Post',
              style: TextStyle(
                fontSize: 21.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.only(
                left: 30.w, right: 30.w, top: 50.h, bottom: 30.h),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: _image == null
                          ? SizedBox(
                              height: 150.h,
                              width: 150.w,
                              child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: PrimaryGreen,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                  onPressed: () {
                                    getImage();
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        size: 32.w,
                                        color: PrimaryGreen,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        'Add photo',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: PrimaryGreen,
                                        ),
                                      )
                                    ],
                                  )),
                            )
                          : Image.file(
                              _image!,
                              height: 240.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      'Title',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff6F6F6F),
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    TextFormField(
                      autofocus: false,
                      controller: titleController,
                      cursorColor: const Color(0xFF939393),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter your title";
                        }
                        return null;
                      },
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                      ),
                      decoration: InputDecoration(
                        isDense: true, // important line
                        contentPadding:
                            EdgeInsets.fromLTRB(10.w, 28.h, 10.w, 0.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.r),
                          borderSide: const BorderSide(
                            style: BorderStyle.solid,
                            color: Color(0xFF939393),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.r),
                          borderSide: const BorderSide(
                            color: Color(0xFF1ABC00),
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff6F6F6F),
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    TextFormField(
                      autofocus: false,
                      minLines: 4,
                      maxLines: 5,
                      controller: bodyController,
                      cursorColor: const Color(0xFF939393),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter your description";
                        }
                        return null;
                      },
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.r),
                          borderSide: const BorderSide(
                            style: BorderStyle.solid,
                            color: Color(0xFF939393),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.r),
                          borderSide: const BorderSide(
                            color: Color(0xFF1ABC00),
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    (state is CreatePostLoadingState)
                        ? Center(
                            child: CircularProgressIndicator(
                              color: PrimaryGreen,
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            height: 55.h,
                            decoration: BoxDecoration(
                              color: PrimaryGreen,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  PlantsCubit.get(context).createPost(
                                      title: titleController.text,
                                      description: bodyController.text,
                                      image: urlImage64 + image64!);
                                }
                              },
                              child: Text(
                                'Post',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
