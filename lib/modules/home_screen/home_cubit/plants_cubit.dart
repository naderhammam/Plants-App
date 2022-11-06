import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plants_orange/models/all_model.dart';
import 'package:plants_orange/models/blogs_model.dart';
import 'package:plants_orange/models/forums_model.dart';
import 'package:plants_orange/models/plants_model.dart';
import 'package:plants_orange/models/seeds_model.dart';
import 'package:plants_orange/models/tools_model.dart';
import 'package:plants_orange/models/update_user_model.dart';
import 'package:plants_orange/models/user_model.dart';
import 'package:plants_orange/modules/home_screen/home_cubit/plants_states.dart';
import 'package:plants_orange/modules/home_screen/home_screen.dart';
import 'package:plants_orange/modules/notification/notification_screen.dart';
import 'package:plants_orange/modules/profile/profile_screen.dart';
import 'package:plants_orange/modules/scanner/scanner_screen.dart';
import 'package:plants_orange/shared/component.dart';
import 'package:sqflite/sqflite.dart';

import '../../../network/dio_helper.dart';
import '../../../shared/constant.dart';
import '../../../style/colors.dart';
import '../../blogs/blogs_screen.dart';

class PlantsCubit extends Cubit<PlantsState> {
  PlantsCubit() : super(InitialState_());

  static PlantsCubit get(context) => BlocProvider.of(context);

  int count = 1;

  void changeCountCartPlus() {
    count++;
    emit(StateCountCartPlus());
  }

  void changeCountCartMinus() {
    count--;
    emit(StateCountCartMinus());
  }

  bool buttonAll = true;
  bool buttonPlants = false;
  bool buttonSeeds = false;
  bool buttonTools = false;
  bool buttonProducts = false;

  void changeButtonAll() {
    buttonAll = true;
    buttonPlants = false;
    buttonSeeds = false;
    buttonTools = false;
    buttonProducts = false;
    emit(StateButtonAll());
  }

  void changeButtonPlants() {
    buttonAll = false;
    buttonPlants = true;
    buttonSeeds = false;
    buttonTools = false;
    buttonProducts = false;
    emit(StateButtonPlants());
  }

  void changeButtonSeeds() {
    buttonAll = false;
    buttonPlants = false;
    buttonSeeds = true;
    buttonTools = false;
    buttonProducts = false;
    emit(StateButtonSeeds());
  }

  void changeButtonTools() {
    buttonAll = false;
    buttonPlants = false;
    buttonSeeds = false;
    buttonTools = true;
    buttonProducts = false;
    emit(StateButtonTools());
  }

  void changeButtonProducts() {
    buttonAll = false;
    buttonPlants = false;
    buttonSeeds = false;
    buttonTools = false;
    buttonProducts = true;
    emit(StateButtonProducts());
  }

  dynamic filterProducts(model) {
    if (model.seed == null && model.tool == null) {
      return model.plant;
    } else if (model.plant == null && model.tool == null) {
      return model.seed;
    } else {
      return model.tool;
    }
  }

  Widget buildGridItem(model, index, context) {
    return (model == allModel)
        ? Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.network(
                            '$BASE_URL${model.data![index].imageUrl!}',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/ex_plant.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          );
                        }, loadingBuilder: (context, child, loadingProgress) {
                          return loadingProgress == null
                              ? child
                              : Center(
                                  child: CupertinoActivityIndicator(
                                    color: PrimaryGreen,
                                  ),
                                );
                        }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          //     PlantsCubit.get(context).changeCountCartMinus();
                        },
                        child: Container(
                            width: 22.h,
                            height: 22.h,
                            color: Colors.grey.shade200,
                            child: FittedBox(
                              child: Text('-',
                                  style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.grey,
                                      fontFamily: 'Roboto')),
                            )),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        '${PlantsCubit.get(context).count}',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Roboto'),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      InkWell(
                        onTap: () {
                          insertToDatabase(
                            image: '$BASE_URL${model.data![index].imageUrl!}',
                            title: filterProducts(model.data![index]).name!,
                            des: '${model.data![index].price} EGP',
                          );
                        },
                        child: Container(
                            width: 22.h,
                            height: 22.h,
                            color: Colors.grey.shade200,
                            child: FittedBox(
                              child: Text('+',
                                  style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.grey,
                                      fontFamily: 'Roboto')),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  FittedBox(
                    child: Text(
                      filterProducts(model.data![index]).name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                  Text(
                    '${model.data![index].price} EGP',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Roboto'),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    width: double.infinity,
                    height: 35.h,
                    decoration: BoxDecoration(
                      color: PrimaryGreen,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        insertToDatabase(
                          image: '$BASE_URL${model.data![index].imageUrl!}',
                          title: filterProducts(model.data![index]).name!,
                          des: '${model.data![index].price} EGP',
                        );
                      },
                      child: Text(
                        'Add To Cart',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.network(
                          '$BASE_URL${model.data![index].imageUrl!}',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/ex_plant.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                        );
                      }, loadingBuilder: (context, child, loadingProgress) {
                        return loadingProgress == null
                            ? child
                            : Center(
                                child: CupertinoActivityIndicator(
                                  color: PrimaryGreen,
                                ),
                              );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          //     PlantsCubit.get(context).changeCountCartMinus();
                        },
                        child: Container(
                            width: 22.h,
                            height: 22.h,
                            color: Colors.grey.shade200,
                            child: FittedBox(
                              child: Text('-',
                                  style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.grey,
                                      fontFamily: 'Roboto')),
                            )),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        '${PlantsCubit.get(context).count}',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Roboto'),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      InkWell(
                        onTap: () {
                          //  PlantsCubit.get(context).changeCountCartPlus();
                        },
                        child: Container(
                            width: 22.h,
                            height: 22.h,
                            color: Colors.grey.shade200,
                            child: FittedBox(
                              child: Text('+',
                                  style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.grey,
                                      fontFamily: 'Roboto')),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  FittedBox(
                    child: Text(
                      model.data![index].name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                  Text(
                    model.data![index].description!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Roboto'),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    width: double.infinity,
                    height: 35.h,
                    decoration: BoxDecoration(
                      color: PrimaryGreen,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        insertToDatabase(
                          image: '$BASE_URL${model.data![index].imageUrl!}',
                          title: model.data![index].name!,
                          des: model.data![index].description!,
                        );
                      },
                      child: Text(
                        'Add To Cart',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  List<Widget>? typeGridView(context) {
    if (buttonSeeds) {
      return List.generate(seedsModel!.data!.length, (index) {
        return buildGridItem(seedsModel!, index, context);
      });
    }
    if (buttonPlants) {
      return List.generate(plantsModel!.data!.length, (index) {
        return buildGridItem(plantsModel!, index, context);
      });
    }
    if (buttonTools) {
      return List.generate(toolsModel!.data!.length, (index) {
        return buildGridItem(toolsModel!, index, context);
      });
    }
    return List.generate(allModel!.data!.length, (index) {
      return buildGridItem(allModel!, index, context);
    });
  }

  int currentIndex = 2;
  List<Widget> screens = [
    const CarePlantsScreen(),
    const ScannerScreen(),
    const HomeScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  void changeScreen(int index) {
    currentIndex = index;

    emit(changeIndexButton());
  }

  bool doneSeeds = false;
  bool donePlants = false;
  bool doneTools = false;
  bool doneAll = false;
  bool doneUser = false;
  bool doneBlogs = false;
  bool doneForums = false;
  bool doneMyForums = false;

  SeedsModel? seedsModel;

  void getSeeds() {
    emit(SeedsLoadingState());
    DioHelper.getData(
      url: GET_SEEDS,
      token: accessToken,
    ).then((value) {
      seedsModel = SeedsModel.fromJson(value.data);
      doneSeeds = true;
      emit(SeedsSuccessState());
    }).catchError((onError) {
      emit(SeedsErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  PlantsModel? plantsModel;

  void getPlants() {
    emit(PlantsLoadingState());
    DioHelper.getData(
      url: GET_PLANTS,
      token: accessToken,
    ).then((value) {
      plantsModel = PlantsModel.fromJson(value.data);
      donePlants = true;
      emit(PlantsSuccessState());
    }).catchError((onError) {
      emit(PlantsErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  ToolsModel? toolsModel;

  void getTools() {
    emit(ToolsLoadingState());
    DioHelper.getData(
      url: GET_TOOLS,
      token: accessToken,
    ).then((value) {
      toolsModel = ToolsModel.fromJson(value.data);
      doneTools = true;
      emit(ToolsSuccessState());
    }).catchError((onError) {
      emit(ToolsErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  AllProductModel? allModel;

  void getAll() {
    emit(AllLoadingState());
    DioHelper.getData(
      url: GET_ALL,
      token: accessToken,
    ).then((value) {
      allModel = AllProductModel.fromJson(value.data);
      doneAll = true;
      emit(AllSuccessState());
    }).catchError((onError) {
      emit(AllErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  UserModel? userModel;

  void getUser() {
    emit(UserLoadingState());
    DioHelper.getData(
      url: GET_USER,
      token: accessToken,
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      if (userModel!.data!.userPoints == null) {
        userModel!.data!.userPoints = '0';
      }
      if (userModel!.data!.address == null) {
        userModel!.data!.address = 'enter your address...';
      }
      doneUser = true;
      emit(UserSuccessState());
    }).catchError((onError) {
      emit(UserErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  BlogsModel? blogsModel;

  void getBlogs() {
    emit(BlogsLoadingState());
    DioHelper.getData(
      url: GET_BLOGS,
      token: accessToken,
    ).then((value) {
      blogsModel = BlogsModel.fromJson(value.data);
      doneBlogs = true;
      emit(BlogsSuccessState());
    }).catchError((onError) {
      emit(BlogsErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  void createPost({
    required String title,
    required String description,
    required String image,
  }) {
    emit(CreatePostLoadingState());
    DioHelper.postData(
      url: CREATE_POST,
      token: accessToken,
      data: {
        'title': title,
        'description': description,
        'imageBase64': image,
      },
    ).then((value) {
      Fluttertoast.showToast(
        msg: 'Post Created Successfully ✔',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0.sp,
      );
      emit(CreatePostSuccessState());
    }).catchError((onError) {
      emit(CreatePostErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  ForumsModel? forumsModel;

  Future<void> getForums() async {
    emit(ForumsLoadingState());
    await DioHelper.getData(
      url: GET_FORUMS,
      token: accessToken,
    ).then((value) {
      forumsModel = ForumsModel.fromJson(value.data);
      doneForums = true;
      emit(ForumsSuccessState());
    }).catchError((onError) {
      emit(ForumsErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  ForumsModel? myForumsModel;

  void getMyForums() {
    emit(MyForumsLoadingState());
    DioHelper.getData(
      url: GET_MY_FORUMS,
      token: accessToken,
    ).then((value) {

      myForumsModel = ForumsModel.fromJson(value.data);
      if (myForumsModel!.data == null) {
        myForumsModel!.data = [];
       }

      doneMyForums = true;
      emit(MyForumsSuccessState());
    }).catchError((onError) {
      emit(MyForumsErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  UpdateUserModel? updateUserModel;

  void updateUserName({
    required String firstName,
    required String lastName,
  }) {
    emit(UserLoadingState());
    DioHelper.patchData(
      url: GET_USER,
      token: accessToken,
      data: {
        "firstName": firstName,
        "lastName": lastName,
        "email": userModel!.data!.email,
        "address": userModel!.data!.address,
      },
    ).then((value) {
      updateUserModel = UpdateUserModel.fromJson(value.data);
      Fluttertoast.showToast(
        msg: 'Updated Successfully ✔',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      getUser();
      emit(UserSuccessState());
    }).catchError((onError) {
      emit(UserErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  void updateUserEmail({
    required String email,
    required String address,
  }) {
    emit(UserLoadingState());
    DioHelper.patchData(
      url: GET_USER,
      token: accessToken,
      data: {
        "firstName": userModel!.data!.firstName,
        "lastName": userModel!.data!.lastName,
        "email": email,
        "address": address,
      },
    ).then((value) {
      updateUserModel = UpdateUserModel.fromJson(value.data);
      Fluttertoast.showToast(
        msg: 'Updated Successfully ✔',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      getUser();
      emit(UserSuccessState());
    }).catchError((onError) {
      emit(UserErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  late Database database;
  late List<Map> newTasks = [];

  void createDataBase() {
    openDatabase('cart.db', version: 1, onCreate: (database, version) {
      print('DataBase Created !');
      database
          .execute(
              'CREATE TABLE carts (id INTEGER PRIMARY KEY,title TEXT,des TEXT,image TEXT,status TEXT)')
          .then((value) {
        print('Table Created !');
      }).onError((error, stackTrace) {
        print('error => ${error.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDataBase(database);
      print('DataBase Opened !');
    }).then((value) {
      database = value;
      emit(createCubitDataBase());
    });
  }

  insertToDatabase({
    required String title,
    required String des,
    required String image,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO carts (title,des,image,status) VALUES ("$title","$des","$image","new")')
          .then((value) {
        print('$value inserting successfully !');
        Fluttertoast.showToast(
          msg: 'Added Successfully ✔',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        emit(insertCubitToDatabase());
        getDataFromDataBase(database);
      }).onError((error, stackTrace) {
        print('error => ${error.toString()}');
      });
    });
  }

  Future<void> getDataFromDataBase(database) async {
    newTasks = [];
    emit(LoadingCirclarCubit());
    await database.rawQuery('SELECT * FROM carts').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        }
      });
      emit(getDataCubitFromDataBase());
    });
  }

  void updateDataBase({required String status, required int id}) {
    database.rawUpdate(
        'UPDATE carts SET status = ? WHERE id = ?', [status, id]).then((value) {
      getDataFromDataBase(database);
      emit(updateCubitDataBase());
    });
  }

  void deleteDataBase({required int id}) {
    database
        .rawDelete('DELETE FROM carts WHERE id = ?', [id]).then((value) async {
      await getDataFromDataBase(database);
      emit(deleteCubitDataBase());
    });
  }

  bool isAllForums = true;

  void pressAllForums() {
    isAllForums = true;
    print(isAllForums);
    emit(pressAllForumsState());
  }

  void pressMeForums() {
    isAllForums = false;
    print(isAllForums);

    emit(pressMeForumsState());
  }
bool isLiked = false;
  void addLike({required String id}) {
    emit(LikesLoadingState());
    DioHelper.postData(
      url: '/api/v1/forums/$id/like',
      token: accessToken,
    ).then((value) async {
      isLiked = true;
      await getForums();
      emit(LikesSuccessState());
      isLiked = false;
    }).catchError((onError) {
      emit(LikesErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  bool isComment = false;

  void addComment({
    required String id,
    required String comment,
  }) {
    isComment = true;
    emit(CommentLoadingState());
    DioHelper.postData(
      url: '/api/v1/forums/$id/comment',
      token: accessToken,
      data: {
        "comment": comment,
      },
    ).then((value) async {
      await getForums();
      emit(CommentSuccessState());
      isComment = false;
    }).catchError((onError) {
      emit(CommentErrorState(onError.toString()));
      print(onError.toString());
    });
  }
}
