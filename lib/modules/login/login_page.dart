import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow_nlw/shared/widgets/social_login/social_login_button.dart';
import '../../shared/themes/app_images.dart';
import '../../shared/themes/app_text_styles.dart';
import '../../shared/themes/app_colors.dart';

import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginController = LoginController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
              height: size.height * 0.37,
              width: size.width,
              color: AppColors.primary,
            ),
            Positioned(
              top: size.height * 0.07,
              left: 0,
              right: 0,
              child: Image.asset(
                AppImages.person,
                width: 208,
                height: 373,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: size.height * 0.13,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppImages.logomini),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 70, right: 70, top: 30, bottom: 20),
                    child: Text(
                      'Organize seus boletos em um só lugar',
                      style: TextStyles.titleHome,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  AnimatedCard(
                    direction: AnimatedCardDirection.bottom,
                    initDelay: Duration(milliseconds: 05),
                    child: Padding(
                      padding: EdgeInsets.only(left: 40, right: 40, top: 20),
                      child: SocialLoginButton(
                        onTap: () {
                          _loginController.googleSignIn(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}