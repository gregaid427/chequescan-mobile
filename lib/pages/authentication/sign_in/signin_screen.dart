import 'package:chequescan/pages/authentication/sign_in/sign_in_view_model.dart';
import 'package:chequescan/pages/introduction_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/api_client.dart';
import '../../../constants/shared_preference.dart';
import '../../../constants/user.dart';
import '../../../constants/validator.dart';
import '../../../components/rounded_button.dart';
import '../../../constants/constants.dart';
import '../../../core/custom_textfield.dart';
import '../../../core/enums/textfield_type.dart';
import '../../homescreen/home_screen.dart';
import '../sign_up/signup_screen.dart';
import 'package:stacked_services/stacked_services.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(children: [
            Expanded(
              flex: 2,
              child: Container(
                child: const Center(
                  child: Image(
                    image: AssetImage(
                      'assets/images/logo.PNG',
                    ),
                    width: 200.0,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  decoration: const BoxDecoration(
                      gradient: kButtonGradientColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(50))),
                  child: SingleChildScrollView(
                    child: Form(
                  key: model.formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              // controller:signInViewModel.usernameController,
                              controller: model.emailController,
                              validator: (value) {
                                return Validator.validateEmail(value ?? "");
                              },
                              type: TextFieldType.email,
                              //  prefixImage: 'assets/icons/lock.svg',
                              hintText: 'Email',
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomTextField(
                              //  controller:signInViewModel.passwordController,
                              //  obscure: _showPassword,
                              controller: model.passwordController,
                              validator: (value) {
                                return Validator.validatePassword(
                                    value ?? "");
                              },

                              //  prefixImage: 'assets/icons/password.svg',
                              hintText: 'Password',
                              obscure: model.obscure,
                              type: TextFieldType.password,
                              suffixFunc: () => model.changePasswordvisibility(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                              onTap: () {},
                              child: const Text(
                                'Forgot Password?',
                                style: kTitleStyle,
                              )),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: RoundedButton(
                            title: 'Login',
                            color: kPrimaryColor,
                            backgroundColor: Colors.white,
                            press: () => model.login(context),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: GestureDetector(
                              onTap: () {
                                model.navigatetosignup(context);
                              },
                              child: const Text(
                                'Don\'t have an account? Sign-Up',
                                style: kTitleStyle,
                              )),
                        ),
                      ]),
                    ),
                  )),
            ),
          ]),
        )), viewModelBuilder: () =>  SignInViewModel(), );
  }
}
