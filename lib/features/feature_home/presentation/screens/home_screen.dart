import 'dart:async';

import 'package:besenior_shop_course/features/feature_home/data/models/home_model.dart';
import 'package:besenior_shop_course/features/feature_home/presentation/bloc/home_cubit.dart';
import 'package:besenior_shop_course/locator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../common/widgets/dot_loading_widget.dart';
import '../../../../config/responsive.dart';
import '../widgets/deep_links.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pageViewController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _timer;

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  var lat = 35.69611;
  var lon = 51.42306;
  LocationData? _userLocation;

  Future<void> getUserLocation(BuildContext context) async {
    Location location = Location();

    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        BlocProvider.of<HomeCubit>(context).callHomeDataEvent(lat, lon);
        return;
      }
    }

    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        /// call api with default lat lon
        BlocProvider.of<HomeCubit>(context).callHomeDataEvent(lat, lon);
        return;
      }
    }

    final _locationData = await location.getLocation();
    lat = _locationData.latitude!;
    lon = _locationData.longitude!;
    BlocProvider.of<HomeCubit>(context).callHomeDataEvent(lat, lon);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(_timer != null) {
      _timer!.cancel();
    }

  }

  @override
  Widget build(BuildContext context) {

    /// get device size
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => HomeCubit(locator()),
      child: Builder(
          builder: (context) {
            getUserLocation(context);

            return BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current){
                if(previous.homeDataStatus == current.homeDataStatus){
                  return false;
                }
                return true;
              },
              builder: (context, state) {

                /// loading
                if(state.homeDataStatus is HomeDataLoading){
                  return const Center(child: DotLoadingWidget(size: 30));
                }

                if(state.homeDataStatus is HomeDataCompleted){
                  HomeDataCompleted homeDataCompleted = state.homeDataStatus as HomeDataCompleted;
                  HomeModel homeModel = homeDataCompleted.homeModel;

                  SuggestionProducts? discountProducts = homeModel.data!.suggestionProducts?[1];
                  SuggestionProducts? organicProducts = homeModel.data!.suggestionProducts?[0];
                  SuggestionProducts? thirdProductsList = homeModel.data!.suggestionProducts?[2];

                  _timer ??= Timer.periodic(const Duration(seconds: 3), (Timer timer) {
                      if (_currentPage < homeModel.data!.sliders!.length - 1) {
                        _currentPage++;
                      } else {
                        _currentPage = 0;
                      }

                      if(pageViewController.positions.isNotEmpty){
                        pageViewController.animateToPage(
                          _currentPage,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeIn,
                        );
                      }

                    });


                  return SingleChildScrollView(
                    child: Column(
                      children: [

                        /// header banner
                        (homeModel.data!.sliders!.isNotEmpty)
                            ? SizedBox(
                          height: Responsive.isMobile(context) ? 180 : 300,
                          child: PageView.builder(
                            onPageChanged: (page){
                              // _timer.
                            },
                            allowImplicitScrolling: true,
                            controller: pageViewController,
                            physics: const BouncingScrollPhysics(),
                            itemCount: homeModel.data!.sliders!.length,
                            itemBuilder: (context, index){
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8.0,),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl: homeModel.data!.sliders![index].img!,
                                    placeholder: (context, string){
                                      return const Center(
                                        child: DotLoadingWidget(size: 40,),
                                      );
                                    },
                                    fit: BoxFit.cover,
                                    useOldImageOnUrlChange: true,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                            : Container(),
                        const SizedBox(height: 10,),

                        /// header banner indicator
                        (homeModel.data!.sliders!.length > 1)
                            ? Center(
                          child: SmoothPageIndicator(
                            controller: pageViewController,  // PageController
                            count:  homeModel.data!.sliders!.length,
                            effect: ExpandingDotsEffect(dotWidth: width * 0.02,dotHeight: width * 0.02,spacing: 5,activeDotColor: Colors.redAccent),  // your preferred effect
                          ),
                        )
                            : Container(),
                        const SizedBox(height: 10),

                        /// category 8
                        SizedBox(
                          height: 220,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

                              crossAxisCount: 4,
                              crossAxisSpacing: 0.0,
                              mainAxisSpacing: 8.0,
                            ),
                            itemCount: homeModel.data!.categories!.length,
                            // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            //   crossAxisCount: 4,
                            //   crossAxisSpacing: 4.0,
                            //   mainAxisSpacing: 4.0,
                            // ),
                            itemBuilder: (BuildContext context, int index){
                              final image = homeModel.data!.categories![index].img;
                              final categoryName = homeModel.data!.categories![index].title;

                              return GestureDetector(
                                // onTap: (){
                                //   Navigator.pushNamed(
                                //     context,
                                //     AllProductsScreen.routeName,
                                //     arguments: ProductsArguments(categoryId: homeModel.data!.categories![index].id!),);
                                // },
                                child: DeepLinks(image: image.toString(), title: categoryName.toString()),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: height * 0.01,),

                        /// middle banners
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            children: [
                              (homeModel.data!.banners!.isNotEmpty)
                                  ? GestureDetector(
                                onTap: (){
                                  // Navigator.pushNamed(context, SellerScreen.routeName);
                                  // if(homeModel.data!.banners![0].categoryId != null){
                                  //   Navigator.pushNamed(
                                  //     context,
                                  //     AllProductsScreen.routeName,
                                  //     arguments: ProductsArguments(categoryId: homeModel.data!.banners![0].categoryId!),);
                                  // }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl: homeModel.data!.banners![0].image!,
                                    placeholder: (context, string){
                                      return const Center(
                                        child: DotLoadingWidget(size: 40,),
                                      );
                                    },
                                    height: Responsive.isMobile(context) ? 120 : 320,
                                    width: width,
                                    fit: BoxFit.cover,
                                    useOldImageOnUrlChange: true,
                                  ),
                                ),
                              )
                                  : Container(),

                              SizedBox(height: 10),

                              (homeModel.data!.banners!.length > 1)
                                  ? GestureDetector(
                                onTap: (){
                                  // if(homeModel.data!.banners![1].categoryId != null){
                                  //   Navigator.pushNamed(
                                  //     context,
                                  //     AllProductsScreen.routeName,
                                  //     arguments: ProductsArguments(categoryId: homeModel.data!.banners![1].categoryId!),);
                                  // }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl: homeModel.data!.banners![1].image!,
                                    placeholder: (context, string){
                                      return const Center(
                                        child: DotLoadingWidget(size: 40,),
                                      );
                                    },
                                    height: Responsive.isMobile(context) ? 120 : 320,
                                    width: width,
                                    fit: BoxFit.cover,
                                    useOldImageOnUrlChange: true,
                                  ),
                                ),
                              )
                                  : Container(),
                            ],
                          ),
                        ),
                        (homeModel.data!.banners!.length > 0 || homeModel.data!.banners!.length > 1)
                            ? SizedBox(height: 20,)
                            : Container(),


                        /// discounts
                        (discountProducts != null)
                            ? Column(
                          children: [
                            Container(
                              height: 330,
                              color: Colors.grey.shade200,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: discountProducts.items!.length,
                                        itemBuilder: (context, index){
                                          if(index == 0){
                                            return Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SvgPicture.asset('assets/images/amazing.svg',width: 120,color: Colors.red,),
                                                Image.asset('assets/images/box.png',width: 150,),
                                              ],
                                            );
                                          }else{
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
                                              child: GestureDetector(
                                                onTap: (){
                                                  // Navigator.pushNamed(
                                                  //   context,
                                                  //   ProductDetailScreen.routeName,
                                                  //   arguments: ProductDetailArguments(discountProducts.items![index - 1].id!),);
                                                },
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                                    color: Colors.white,
                                                  ),
                                                  width: 170,
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(height: height * 0.01,),
                                                        const Text('شگفت انگیز اختصاصی اپ', style: TextStyle(fontFamily: 'Vazir',color: Colors.red, fontWeight: FontWeight.bold,fontSize: 12),),
                                                        SizedBox(height: height * 0.01,),
                                                        Expanded(
                                                          child: Center(
                                                            child: CachedNetworkImage(
                                                              // imageUrl: "https://niyaz.shop/uploads/products/thum-%D9%85%D9%86%DA%AF%D9%88%D8%B3%D8%AA%DB%8C%D9%86-16630585025886737.png",
                                                              imageUrl: discountProducts.items![index - 1].image!,
                                                              fit: BoxFit.cover,
                                                              useOldImageOnUrlChange: true,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: height * 0.01,),
                                                        Text(discountProducts.items![index - 1].name!, style: const TextStyle(fontFamily: 'Vazir',color: Colors.black, fontWeight: FontWeight.bold,fontSize: 12),),
                                                        SizedBox(height: height * 0.01,),
                                                        const Text('موجود در بیسینیور', style: TextStyle(fontFamily: 'Vazir',color: Colors.grey, fontWeight: FontWeight.bold,fontSize: 11),),
                                                        SizedBox(height: height * 0.03,),

                                                        /// discount and price
                                                        Row(
                                                          children: [

                                                            /// discount red container
                                                            (discountProducts.items![index - 1].discount! != 0)
                                                                ? Container(
                                                              width: 40,
                                                              height: 30,
                                                              decoration: BoxDecoration(
                                                                  color: Colors.red,
                                                                  borderRadius: BorderRadius.circular(20)
                                                              ),
                                                              child: Center(child: Text(discountProducts.items![index - 1].discount!.toString()+"%", style: const TextStyle(fontFamily: 'Vazir',color: Colors.white, fontWeight: FontWeight.bold,fontSize: 13),)),
                                                            )
                                                                : Container(),

                                                            const Spacer(),

                                                            Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Text(discountProducts.items![index - 1].price!, style: const TextStyle(fontFamily: 'Vazir',color: Colors.black, fontWeight: FontWeight.bold,fontSize: 13),),
                                                                    (discountProducts.items![index - 1].priceBeforDiscount != "0")
                                                                        ? Text(discountProducts.items![index - 1].priceBeforDiscount!, style: const TextStyle(fontFamily: 'Vazir',color: Colors.black, fontWeight: FontWeight.bold,fontSize: 11,decoration: TextDecoration.lineThrough),)
                                                                        : Container(),
                                                                  ],
                                                                ),
                                                                SizedBox(width: width * 0.01,),
                                                                const Text('تومان', style: TextStyle(fontFamily: 'Vazir',color: Colors.black, fontWeight: FontWeight.bold,fontSize: 10),),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: height * 0.02,),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                    ),
                                  ),
                                  SizedBox(height: height * 0.02,),
                                ],
                              ),
                            ),
                          ],
                        )
                            : Container(),
                        SizedBox(height: 10,),


                        /// bottom banners
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            children: [
                              (homeModel.data!.banners!.length > 2)
                                  ? GestureDetector(
                                onTap: (){
                                  // if(homeModel.data!.banners![2].categoryId != null){
                                  //   Navigator.pushNamed(
                                  //     context,
                                  //     AllProductsScreen.routeName,
                                  //     arguments: ProductsArguments(categoryId: homeModel.data!.banners![2].categoryId!),);
                                  // }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl: homeModel.data!.banners![2].image!,
                                    placeholder: (context, string){
                                      return const Center(
                                        child: DotLoadingWidget(size: 40,),
                                      );
                                    },
                                    height: Responsive.isMobile(context) ? 120 : 320,
                                    width: width,
                                    fit: BoxFit.cover,
                                    useOldImageOnUrlChange: true,
                                  ),
                                ),
                              )
                                  : Container(),

                              SizedBox(height: height * 0.02,),

                              (homeModel.data!.banners!.length > 3)
                                  ? GestureDetector(
                                onTap: (){
                                  if(homeModel.data!.banners![3].categoryId != null){
                                    // Navigator.pushNamed(
                                    //   context,
                                    //   AllProductsScreen.routeName,
                                    //   arguments: ProductsArguments(categoryId: homeModel.data!.banners![3].categoryId!),);
                                  }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl: homeModel.data!.banners![3].image!,
                                    placeholder: (context, string){
                                      return const Center(
                                        child: DotLoadingWidget(size: 40,),
                                      );
                                    },
                                    height: Responsive.isMobile(context) ? 120 : 320,
                                    width: width,
                                    fit: BoxFit.cover,
                                    useOldImageOnUrlChange: true,
                                  ),
                                ),
                              )
                                  : Container(),
                            ],
                          ),
                        ),
                        (homeModel.data!.banners!.length > 2 || homeModel.data!.banners!.length > 3)
                            ? SizedBox(height: height * 0.02,)
                            : Container(),

                        /// second green discounts
                        (organicProducts != null)
                            ? Column(
                          children: [
                            Container(
                              height: 370,
                              color: Colors.grey.shade200,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0,right: 15, top: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(organicProducts.title!, style: const TextStyle(fontFamily: 'Vazir',color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
                                        // Row(
                                        //   children: const [
                                        //     Text('مشاهده همه', style: TextStyle(fontFamily: 'Vazir',color: Colors.white),),
                                        //     SizedBox(width: 5,),
                                        //     Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 18,),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: organicProducts.items!.length,
                                        itemBuilder: (context, index){
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
                                            child: GestureDetector(
                                              onTap: (){
                                                // Navigator.pushNamed(
                                                //   context,
                                                //   ProductDetailScreen.routeName,
                                                //   arguments: ProductDetailArguments(organicProducts.items![index].id!),);
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                  color: Colors.white,
                                                ),
                                                width: 170,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(height: height * 0.01,),
                                                      Expanded(
                                                        child: Center(
                                                          child: CachedNetworkImage(
                                                            // imageUrl: "https://niyaz.shop/uploads/products/thum-%D9%BE%D8%B1%D8%AA%D9%82%D8%A7%D9%84-%D8%B1%D8%B3%D9%85%DB%8C-16630019485051793.png",
                                                            imageUrl: organicProducts.items![index].image!,
                                                            fit: BoxFit.cover,
                                                            useOldImageOnUrlChange: true,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: height * 0.01,),
                                                      Text(organicProducts.items![index].name!, style: const TextStyle(fontFamily: 'Vazir',color: Colors.black, fontWeight: FontWeight.bold,fontSize: 12),),
                                                      SizedBox(height: height * 0.01,),
                                                      const Text('موجود در انبار بیسینیور', style: TextStyle(fontFamily: 'Vazir',color: Colors.grey, fontWeight: FontWeight.bold,fontSize: 11),),
                                                      SizedBox(height: height * 0.03,),

                                                      Row(
                                                        children: [
                                                          /// discount red container
                                                          (organicProducts.items![index].discount! != 0)
                                                              ? Container(
                                                            width: 40,
                                                            height: 30,
                                                            decoration: BoxDecoration(
                                                                color: Colors.red,
                                                                borderRadius: BorderRadius.circular(20)
                                                            ),
                                                            child: Center(child: Text(organicProducts.items![index].discount!.toString()+"%", style: const TextStyle(fontFamily: 'Vazir',color: Colors.white, fontWeight: FontWeight.bold,fontSize: 13),)),
                                                          )
                                                              : Container(),

                                                          const Spacer(),

                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Text(organicProducts.items![index].price!, style: const TextStyle(fontFamily: 'Vazir',color: Colors.black, fontWeight: FontWeight.bold,fontSize: 13),),
                                                                  (organicProducts.items![index].priceBeforDiscount != "0")
                                                                      ? Text(organicProducts.items![index].priceBeforDiscount!, style: const TextStyle(fontFamily: 'Vazir',color: Colors.black, fontWeight: FontWeight.bold,fontSize: 11,decoration: TextDecoration.lineThrough),)
                                                                      : Container(),

                                                                ],
                                                              ),
                                                              SizedBox(width: width * 0.01,),
                                                              const Text('تومان', style: TextStyle(fontFamily: 'Vazir',color: Colors.black, fontWeight: FontWeight.bold,fontSize: 10),),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: height * 0.03,),

                                                      /// stars icon
                                                      Center(
                                                        child: RatingBar.builder(
                                                          itemSize: 20,
                                                          initialRating: organicProducts.items![index].star!.toDouble(),
                                                          direction: Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemBuilder: (context, _){
                                                            return const Icon(
                                                              Icons.star,
                                                              color: Colors.amber,
                                                              size: 10,
                                                            );
                                                          },
                                                          onRatingUpdate: (rating) {
                                                            print(rating);
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(height: height * 0.02,),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                            : Container(),

                        /// second green discounts
                        (thirdProductsList != null)
                            ? Column(
                          children: [
                            Container(
                              height: 370,
                              color: Colors.grey.shade200,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0,right: 15, top: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(thirdProductsList.title ?? 'محصولات', style: const TextStyle(fontFamily: 'Vazir',color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
                                        // Row(
                                        //   children: const [
                                        //     Text('مشاهده همه', style: TextStyle(fontFamily: 'Vazir',color: Colors.white),),
                                        //     SizedBox(width: 5,),
                                        //     Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 18,),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: thirdProductsList.items!.length,
                                        itemBuilder: (context, index){
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
                                            child: GestureDetector(
                                              onTap: (){
                                                // Navigator.pushNamed(
                                                //   context,
                                                //   ProductDetailScreen.routeName,
                                                //   arguments: ProductDetailArguments(thirdProductsList.items![index].id!),);
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                  color: Colors.white,
                                                ),
                                                width: 170,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(height: height * 0.01,),
                                                      Expanded(
                                                        child: Center(
                                                          child: CachedNetworkImage(
                                                            imageUrl: thirdProductsList.items![index].image!,
                                                            fit: BoxFit.cover,
                                                            useOldImageOnUrlChange: true,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: height * 0.01,),
                                                      Text(thirdProductsList.items![index].name!, style: const TextStyle(fontFamily: 'Vazir',color: Colors.black, fontWeight: FontWeight.bold,fontSize: 12),),
                                                      SizedBox(height: height * 0.01,),
                                                      const Text('موجود در انبار بیسینیور', style: TextStyle(fontFamily: 'Vazir',color: Colors.grey, fontWeight: FontWeight.bold,fontSize: 11),),
                                                      SizedBox(height: height * 0.03,),

                                                      Row(
                                                        children: [
                                                          /// discount red container
                                                          (thirdProductsList.items![index].discount! != 0)
                                                              ? Container(
                                                            width: 40,
                                                            height: 30,
                                                            decoration: BoxDecoration(
                                                                color: Colors.red,
                                                                borderRadius: BorderRadius.circular(20)
                                                            ),
                                                            child: Center(child: Text(thirdProductsList.items![index].discount!.toString()+"%", style: const TextStyle(fontFamily: 'Vazir',color: Colors.white, fontWeight: FontWeight.bold,fontSize: 13),)),
                                                          )
                                                              : Container(),

                                                          const Spacer(),

                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Text(thirdProductsList.items![index].price!, style: const TextStyle(fontFamily: 'Vazir',color: Colors.black, fontWeight: FontWeight.bold,fontSize: 13),),
                                                                  (thirdProductsList.items![index].priceBeforDiscount != "0")
                                                                      ? Text(thirdProductsList.items![index].priceBeforDiscount!, style: const TextStyle(fontFamily: 'Vazir',color: Colors.black, fontWeight: FontWeight.bold,fontSize: 11,decoration: TextDecoration.lineThrough),)
                                                                      : Container(),

                                                                ],
                                                              ),
                                                              SizedBox(width: width * 0.01,),
                                                              const Text('تومان', style: TextStyle(fontFamily: 'Vazir',color: Colors.black, fontWeight: FontWeight.bold,fontSize: 10),),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: height * 0.03,),

                                                      /// stars icon
                                                      Center(
                                                        child: RatingBar.builder(
                                                          itemSize: 20,
                                                          initialRating: thirdProductsList.items![index].star!.toDouble(),
                                                          direction: Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemBuilder: (context, _){
                                                            return const Icon(
                                                              Icons.star,
                                                              color: Colors.amber,
                                                              size: 10,
                                                            );
                                                          },
                                                          onRatingUpdate: (rating) {
                                                            print(rating);
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(height: height * 0.02,),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                            : Container(),
                        // SizedBox(height: height * 0.2,),

                      ],
                    ),
                  );
                }


                /// error
                if(state.homeDataStatus is HomeDataError){
                  final HomeDataError homeDataError = state.homeDataStatus as HomeDataError;

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Text(homeDataError.errorMessage,style: const TextStyle(color: Colors.white),),
                        const SizedBox(height: 10,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.amber.shade800),
                          onPressed: (){
                            /// call all data again
                            BlocProvider.of<HomeCubit>(context).callHomeDataEvent(lat, lon);
                          },
                          child: const Text("تلاش دوباره"),)
                      ],
                    ),
                  );
                }

                return Container();
              },
            );
          }
      ),
    );
  }
}
