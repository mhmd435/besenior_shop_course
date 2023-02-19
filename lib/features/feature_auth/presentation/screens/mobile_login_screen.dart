
import 'package:android_sms_retriever/android_sms_retriever.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../common/widgets/dot_loading_widget.dart';
import '../../../../common/widgets/main_wrapper.dart';
import '../../data/models/code_model.dart';
import '../bloc/login_bloc/login_bloc.dart';
import '../widgets/cutom_clippath_signup.dart';

class MobileLoginScreen extends StatefulWidget {
  static const routeName = '/mobile_login_screen';

  MobileLoginScreen({Key? key}) : super(key: key);

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  final _formKey = GlobalKey<FormState>();

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
      value = value?.substring(10,17);

      if(value == null)
        return;

      codeController.text = value;
      BlocProvider.of<LoginBloc>(context).add(LoadCodeCheck(codeController.text));
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
                      height: height * 0.3,
                      color: Colors.redAccent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer.fromColors(
                                    baseColor: Colors.white,
                                    highlightColor: Colors.grey,
                                    child: const Text('ورود', style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold, fontFamily: 'Vazir'),)),
                                Text('فروشگاه نیاز', style: TextStyle(fontSize: 18,color: Colors.grey[200],fontWeight: FontWeight.w500, fontFamily: 'Vazir'),)
                              ],
                            ),
                            Image.asset('assets/images/niaz_white.png', width: width * 0.3,),
                          ],
                        ),
                      ),
                    )
                ),
                // const Text('فروشگاه نیاز', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'Vazir',color: Colors.redAccent),),

                SizedBox(height: height * 0.1,),

                /// login btn -- form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        BlocConsumer<LoginBloc, LoginState>(
                          listenWhen: (previous, current){
                            if(previous.loginDataStatus == current.loginDataStatus){
                              return false;
                            }
                            return true;
                          },
                          buildWhen: (previous, current){
                            if(previous.loginDataStatus == current.loginDataStatus){
                              return false;
                            }
                            return true;
                          },
                          listener: (context, state) {
                            if(state.loginDataStatus is LoginDataError){
                              LoginDataError loginDataError = state.loginDataStatus as LoginDataError;
                              showSnack(context, loginDataError.errorMessage, Colors.red);
                            }

                            if(state.loginDataStatus is LoginDataCompleted){
                              LoginDataCompleted loginDataCompleted = state.loginDataStatus as LoginDataCompleted;
                              showSnack(context, "کد ورود ارسال شد", Colors.green);

                              showMyBottomSheet(context);

                            }
                          },
                          builder: (context, state) {

                            if(state.loginDataStatus is LoginDataLoading){
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
                                                  BlocProvider.of<LoginBloc>(context).add(LoadLoginSms(phoneController.text));
                                                }
                                              },
                                              child: const Text('ارسال کد ورود', style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'Vazir'),),
                                            ),
                                          );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01,),
                /// register btn
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
                        Navigator.pop(context);
                      },
                      child: const Text('ساخت حساب جدید', style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'Vazir'),),
                    ),
                  ),
                ),

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

  Future<void> saveDataToPrefs(CodeModel codeModel) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();


    await prefs.setString('user_token', codeModel.accessToken!);
    await prefs.setBool('user_loggedIn', true);
    await prefs.setString('user_name', codeModel.name ?? "نام کاربری");
    await prefs.setString('user_mobile', codeModel.mobile.toString().toEnglishDigit() ?? "شماره تماس");
  }

  void showMyBottomSheet(BuildContext context) {
    /// get device size
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
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
                          BlocProvider.of<LoginBloc>(context).add(LoadCodeCheck(codeController.text));
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
                  BlocConsumer<LoginBloc, LoginState>(
                    buildWhen: (previous, current){
                      if(previous.codeCheckStatus == current.codeCheckStatus){
                        return false;
                      }
                      return true;
                    },
                    listenWhen: (previous, current){
                      if(previous.codeCheckStatus == current.codeCheckStatus){
                        return false;
                      }
                      return true;
                    },
                    listener: (context, state) {
                      if(state.codeCheckStatus is CodeCheckError){
                        CodeCheckError codeCheckError = state.codeCheckStatus as CodeCheckError;
                        showSnack(context, codeCheckError.errorMessage, Colors.red);
                      }

                      if(state.codeCheckStatus is CodeCheckCompleted) {
                        CodeCheckCompleted codeCheckCompleted = state.codeCheckStatus as CodeCheckCompleted;
                        if(codeCheckCompleted.codeModel.name != null){
                          showSnack(context, codeCheckCompleted.codeModel.name.toString() + " به نیاز خوش آمدید", Colors.green);
                        }
                        saveDataToPrefs(codeCheckCompleted.codeModel);
                        Navigator.pushNamedAndRemoveUntil(context, MainWrapper.routeName, ModalRoute.withName("/main_wrapper"),);
                      }
                    },
                    builder: (context, state) {

                      if(state.codeCheckStatus is CodeCheckLoading){
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
                              BlocProvider.of<LoginBloc>(context).add(LoadCodeCheck(codeController.text));
                          },
                          child: const Text('ورود', style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold,fontFamily: 'Vazir'),),
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
