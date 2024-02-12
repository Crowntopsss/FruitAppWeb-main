import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruitshopweb/ui/auth/bloc/auth_bloc.dart';
import 'package:fruitshopweb/ui/auth/register_screen.dart';
import 'package:fruitshopweb/ui/home/base_home_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../constants/color_const.dart';
import '../../constants/imagepath.dart';
import '../widget/custom_button.dart';
import '../widget/custom_dialogs.dart';
import '../widget/custom_progress.dart';
import '../widget/text_field.dart';
import 'onboarding_banner_screen.dart';


class LoginScreen extends StatefulWidget {
  static const routeName = "/login-screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _bloc  =  AuthBloc();


  @override
  void initState() {
    super.initState();
    _bloc.authStream.listen((event) {
      Navigator.pushReplacementNamed(context, BaseHomeView.routeName);
    },onError: (error){
      showErrorDialog(context,error);
    });

  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return  Scaffold(
      backgroundColor: ColorPath.OFF_WHITE,
      body: Container(
          width: width,
          height: height,
          child: Stack(
            children: [
              ResponsiveBuilder(
                  builder: (context, sizingInformation) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Visibility(
                        visible: sizingInformation.screenSize.width>900,
                        child: Expanded(
                          child:  OnBoardingBannerScreen()
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 24, right: 24),
                            color: ColorPath.OFF_WHITE,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 32),
                                  Text("Sign In", textAlign: TextAlign.center,
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: ColorPath.BLACK,
                                    ),),
                                  SizedBox(height: 24,),
                                  Text("Get started with your fruit purchase below", textAlign: TextAlign.center,
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 16,
                                      color: ColorPath.GREY,
                                    ),),
                                  SizedBox(height: 32),
                                  customTextFormField("Email Address",width: width>900?400:null,
                                      textEditingController: _bloc.emailController,
                                      textInputType: TextInputType.name),
                                  SizedBox(height: 16),
                                  customTextFormField("Password",width: width>900?400:null,
                                      hideInput: true,
                                      textEditingController: _bloc.passwordController,
                                      textInputType: TextInputType.name),
                                  SizedBox(height: 32),
                                  Container(
                                    child: customButton("Continue", onClick: (){
                                     _bloc.login();
                                    }),
                                  ),
                                  SizedBox(height: 32),
                                  InkWell(
                                    child: Text("Register Here", textAlign: TextAlign.center,
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: ColorPath.DARK_COLOR,
                                      ),),
                                    onTap: (){
                                      Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 100.0,
                                  ),
                                ],
                              ),
                            )

                        ),
                      ),

                    ],
                  );
                }
              ),
             customProgress(_bloc.progressStatusStream)
            ],
          ),
      ),
    );
  }


  void showSuccessMessage(BuildContext context,message,[String title = "ERROR"]){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialogs.showMessageDialog(context, message.toString());
        }
    );
  }

  void showErrorDialog(BuildContext context,message,[String title = "ERROR"]){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialogs.showErrorDialog(context,message.toString());
        }
    );
  }

}
