import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plants_orange/modules/home_screen/home_cubit/plants_cubit.dart';
import 'package:plants_orange/modules/home_screen/home_cubit/plants_states.dart';
import '../../shared/constant.dart';
import '../../style/colors.dart';

var searchController = TextEditingController();

class SearchForumsScreen extends StatefulWidget {
  const SearchForumsScreen({Key? key}) : super(key: key);

  @override
  State<SearchForumsScreen> createState() => _SearchForumsScreenState();
}

class _SearchForumsScreenState extends State<SearchForumsScreen> {
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
          .forumsModel!
          .data!
          .where((element) =>
          element.title!.toLowerCase().contains(value.toLowerCase()))
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
                          return _buildItemSearch(context, listSearch[index]);
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

  Widget _buildItemSearch(context, data) {
    return Card(
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
                          '${data.user!.firstName} ${data.user!.lastName}',
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
              '${data.title}',
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
                '${data.description}',
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
                  '$BASE_URL${data.imageUrl}',
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
                              '${data.forumLikes!.length} Likes',
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
                              '${data.forumComments!.length} Replies',
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
                    onTap: () {},
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
                      SvgPicture.asset('assets/icons/like.svg'),
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
                        id: data
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
}
