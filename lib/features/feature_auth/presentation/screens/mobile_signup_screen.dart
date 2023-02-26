
import 'package:android_sms_retriever/android_sms_retriever.dart';
import 'package:besenior_shop_course/common/utils/prefs_operator.dart';
import 'package:besenior_shop_course/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/params/signup_params.dart';
import '../../../../common/widgets/dot_loading_widget.dart';
import '../../../../common/widgets/main_wrapper.dart';
import '../../data/models/login_with_sms_model.dart';
import '../../data/models/signup_model.dart';
import '../bloc/login_bloc/login_bloc.dart';
import '../bloc/signup_bloc/signup_bloc.dart';
import '../widgets/cutom_clippath_signup.dart';
import 'mobile_login_screen.dart';

class MobileSignUpScreen extends StatefulWidget {
  static const routeName = '/mobile_signup_screen';

  MobileSignUpScreen({Key? key}) : super(key: key);

  @override
  State<MobileSignUpScreen> createState() => _MobileSignUpScreenState();
}

class _MobileSignUpScreenState extends State<MobileSignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// sms init
    initSmsRetriever();
  }

  @override
  void dispose() {
    AndroidSmsRetriever.stopSmsListener();
    super.dispose();
  }

  initSmsRetriever() async {
    await AndroidSmsRetriever.listenForSms().then((value) {

      if(value == null) {
        return;
      }

      value = value.substring(10,17);


      codeController.text = value;
      BlocProvider.of<SignupBloc>(context).add(LoadSignUp(SignUpParams(usernameController.text, phoneController.text)));
    });
  }

  @override
  Widget build(BuildContext context) {

    /// get device size
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          elevation: 0,
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// red container
                ClipPath(
                    clipper: CustomClipPathSignUp(),
                    child: Container(
                      width: width,
                      height: height * 0.18,
                      color: Colors.redAccent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                                baseColor: Colors.white,
                                highlightColor: Colors.grey,
                                child: const Text('ثبت نام', style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold, fontFamily: 'Vazir'),)),
                            Text('ساخت حساب جدید', style: TextStyle(fontSize: 18,color: Colors.grey[200],fontWeight: FontWeight.w500, fontFamily: 'Vazir'),)
                          ],
                        ),
                      ),
                    )
                ),
                // const Text('فروشگاه نیاز', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'Vazir',color: Colors.redAccent),),

                SizedBox(height: 20,),

                /// sign up btn -- form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('نام و نام خانوادگی', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Vazir',color: Colors.black),),
                        SizedBox(height: height * 0.005,),
                        SizedBox(
                          height: 80,
                          child: TextFormField(
                            controller: usernameController,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            onTap: () {

                              if (usernameController.text[usernameController.text.length - 1] != ' ') {
                                usernameController.text = (usernameController.text + ' ');
                              }
                              if (usernameController.selection ==TextSelection.fromPosition(
                                  TextPosition(offset:
                                  usernameController.text.length - 1))) {
                              }
                            },
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                              fillColor: Colors.grey[300],
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 0,color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 0,color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 0,color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 1, color: Colors.blue),
                                  borderRadius: BorderRadius.circular(10)
                              ),

                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'نام کاربری خالی است.';
                              }else if(value.length < 2){
                                return 'نام کاربری باید بیشتر از ۷ کاراکتر باشد';
                              }else if(value.length > 24){
                                return 'نام کاربری باید کمتر از ۲۰ کاراکتر باشد';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: height * 0.02,),
                        const Text('شماره همراه', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Vazir',color: Colors.black),),
                        SizedBox(height: height * 0.005,),
                        SizedBox(
                          height: 80,
                          child: TextFormField(
                            controller: phoneController,
                            maxLength: 11,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                              fillColor: Colors.grey[300],
                              counterText: "",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 0,color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 0,color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 0,color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 1, color: Colors.blue),
                                  borderRadius: BorderRadius.circular(10)
                              ),

                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'شماره همراه را وارد کنید';
                              }else if(value.length != 11){
                                return 'شماره همراه اشتباه است';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: height * 0.01,),

                        /// submit button
                        BlocConsumer<SignupBloc, SignupState>(
                          listenWhen: (previous, current){
                            if(current.callCodeStatus == previous.callCodeStatus){
                              return false;
                            }
                            return true;
                          },
                          buildWhen: (previous, current){
                            if(current.callCodeStatus == previous.callCodeStatus){
                              return false;
                            }
                            return true;
                          },
                          listener: (context, state) {
                            if(state.callCodeStatus is CallCodeError){
                              CallCodeError callCodeError = state.callCodeStatus as CallCodeError;
                              showSnack(context, callCodeError.errorMessage, Colors.red);
                            }

                            if(state.callCodeStatus is CallCodeCompleted){
                              CallCodeCompleted callCodeCompleted = state.callCodeStatus as CallCodeCompleted;
                              // saveDataToPrefs(signUpCompleted.signupModel);
                              showMyBottomSheet(context,callCodeCompleted.loginWithSmsModel);

                              // Navigator.pushNamedAndRemoveUntil(context, MainWrapper.routeName, ModalRoute.withName("/main_wrapper"),);

                            }
                          },
                          builder: (context, state) {

                            if(state.callCodeStatus is CallCodeLoading){
                              return const Center(
                                child: DotLoadingWidget(size: 30),
                              );
                            }

                            return SizedBox(
                                            width: width,
                                            height: 58,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.redAccent,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10)
                                                  )
                                              ),
                                              onPressed: (){
                                                if (_formKey.currentState!.validate()) {
                                                  BlocProvider.of<SignupBloc>(context).add(LoadRegisterCodeCheck(phoneController.text));
                                                }
                                              },
                                              child: const Text('ثبت نام', style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'Vazir'),),
                                            ),
                                          );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                /// login btn
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: width,
                    height: 58,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(width: 1, color: Colors.grey[300]!)
                          )
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, MobileLoginScreen.routeName);
                      },
                      child: const Text('حساب دارید؟', style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'Vazir'),),
                    ),
                  ),
                ),
                SizedBox(height: 10),


              ],
            ),
          ),
        ),
      ),
    );
  }

  showSnack(context, String message,Color color){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message,style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontFamily: "Vazir"),),backgroundColor: color,));
  }

  void showMyBottomSheet(BuildContext context, LoginWithSmsModel loginWithSmsModel) {
    /// get device size
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30),)
        ),
        context: context,
        builder: (context){
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.04,),
                  const Center(child: Text('کد ورود را وارد کنید', style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700,fontFamily: 'Vazir',color: Colors.black),)),
                  SizedBox(height: height * 0.06,),
                  const Text('کد ورود', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Vazir',color: Colors.black),),
                  SizedBox(height: height * 0.005,),
                  SizedBox(
                    height: 80,
                    child: TextField(
                      onChanged: (value){
                        if(value.length == 6){
                          // BlocProvider.of<LoginBloc>(context).add(LoadCodeCheck(codeController.text));
                        }
                      },
                      controller: codeController,
                      maxLength: 6,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                        fillColor: Colors.grey[200],
                        counterText: "",
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0,color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0,color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: Colors.blue),
                            borderRadius: BorderRadius.circular(10)
                        ),

                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  /// code submit button
                  BlocConsumer<SignupBloc, SignupState>(
                    buildWhen: (previous, current){
                      if(previous.signUpDataStatus == current.signUpDataStatus){
                        return false;
                      }
                      return true;
                    },
                    listenWhen: (previous, current){
                      if(previous.signUpDataStatus == current.signUpDataStatus){
                        return false;
                      }
                      return true;
                    },
                    listener: (context, state) {
                      if(state.signUpDataStatus is SignUpDataError){
                        Navigator.pop(context);
                        SignUpDataError signUpDataError = state.signUpDataStatus as SignUpDataError;
                        showSnack(context, signUpDataError.errorMessage, Colors.red);
                      }

                      if(state.signUpDataStatus is SignUpCompleted) {
                        SignUpCompleted signUpCompleted = state.signUpDataStatus as SignUpCompleted;
                        SignupModel signupModel = signUpCompleted.signupModel;
                        showSnack(context, "ثبت نام با موفقیت انجام شد", Colors.green);
                        PrefsOperator prefsOperator = locator();
                        prefsOperator.saveUserData(signupModel.data!.token!, signupModel.data!.name ?? "نام کاربری", signupModel.data!.mobile.toString().toEnglishDigit());                        Navigator.pushNamedAndRemoveUntil(context, MainWrapper.routeName, ModalRoute.withName("/main_wrapper"),);
                      }
                    },
                    builder: (context, state) {

                      if(state.signUpDataStatus is SignUpDataLoading){
                        return const Center(
                          child: DotLoadingWidget(size: 30),
                        );
                      }

                      return SizedBox(
                        width: width,
                        height: 58,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                          onPressed: (){
                            if(codeController.text == loginWithSmsModel.data!.code.toString()){
                              BlocProvider.of<SignupBloc>(context).add(LoadSignUp(SignUpParams(usernameController.text, phoneController.text)));
                            }else{
                              Navigator.pop(context);
                              showSnack(context, "کد وارد شده اشتباه است", Colors.red);
                            }
                          },
                          child: const Text('ثبت نام', style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'Vazir'),),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),

                ],
              ),
            ),
          );
        }
    );
  }
}
