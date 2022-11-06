import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plants_orange/modules/home_screen/home_cubit/plants_cubit.dart';
import 'package:plants_orange/modules/home_screen/home_cubit/plants_states.dart';
import '../../shared/constant.dart';
import '../../style/colors.dart';

var searchController = TextEditingController();

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //List<dynamic> listSearch = [];
  dynamic listSearch;
  bool isNotFound = false;
  String? search;

  @override
  void initState() {
    // TODO: implement initState
    //   listSearch = PlantsCubit.get(context).blogsModel!.data!.seeds;
    listSearch = [];
    super.initState();
  }

  void searchFilter(String value) {
    dynamic result;

    if (value.isEmpty) {
      result = listSearch;
    } else {
      result = PlantsCubit.get(context)
          .allModel!
          .data!
          .where((element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    setState(() {
      search = value;
      if (result.isEmpty) {
        listSearch = result;
        isNotFound = true;
      } else {
        listSearch = result;
        isNotFound = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlantsCubit, PlantsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            searchController.clear();
            return true;
          },
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.only(
                left: 23.w,
                right: 23.w,
                top: 55.h,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),

                child: Column(
                  children: [
                    TextFormField(
                      controller: searchController,
                      cursorColor: Colors.grey,
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(
                              width: 3, color: Color(0xFFF8F8F8)), //<-- SEE HERE
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF8F8F8),
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF979797),
                          fontFamily: 'Roboto',
                        ),
                        prefixIcon: Icon(
                          Icons.search_sharp,
                          color: const Color(0xFF979797),
                          size: 27.w,
                        ),
                        contentPadding:
                            EdgeInsets.fromLTRB(10.w, 30.h, 10.w, 0.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(
                            style: BorderStyle.solid,
                            color: Color(0xFFF8F8F8),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(
                            color: Color(0xFFF8F8F8),
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value) {},
                      onChanged: (value) => searchFilter(value),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    (isNotFound)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Results for “$search”',
                                    style: TextStyle(
                                      fontSize: 19.sp,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '0 found',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                      color: PrimaryGreen,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 100.h,
                              ),
                              Image.asset('assets/images/NotFound.png'),
                              SizedBox(
                                height: 40.h,
                              ),
                              Text('Not found',
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
                                  'Sorry, the keyword you entered cannot be\nfound, please check again or search with\n another keyword.',
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
                        : ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.only(bottom: 22.h),
                            itemBuilder: (context, index) {
                              return _buildItemSeeds(context, listSearch[index]);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 22.h,
                              );
                            },
                            itemCount: listSearch.length),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildItemSeeds(context, data) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => DetailsBlocsScreen(data: data)));
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
                child: Image.network('$BASE_URL${data.imageUrl}',
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
                    Text(data.price!.toString(),
                        style: TextStyle(
                          fontSize: 13.sp,
                          height: 1.6.h,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF7D7B7B),
                        )),
                    SizedBox(
                      height: 18.h,
                    ),
                    Container(
                      width: 160.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                        color: PrimaryGreen,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                        PlantsCubit.get(context).  insertToDatabase(
                            image: '$BASE_URL${data.imageUrl}',
                            title: data.name!,
                            des: '${data.price!.toString()} EGP',
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
            ],
          ),
        ),
      ),
    );
  }
}
