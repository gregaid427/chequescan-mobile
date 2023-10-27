import 'package:chequescan/pages/authentication/sign_in/sign_in_view_model.dart';
import 'package:chequescan/pages/authentication/sign_up/sign_up_view_model.dart';
import 'package:chequescan/pages/introduction_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/api_client.dart';
import '../../../constants/shared_preference.dart';
import '../../../constants/validator.dart';
import '../../../components/rounded_button.dart';
import '../../../constants/constants.dart';
import '../../../core/custom_textfield.dart';
import '../../../core/enums/textfield_type.dart';
import '../otp/otp_screen.dart';
import '../sign_in/signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}


class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
        builder: (context, model, child) => SafeArea(
              child: Scaffold(
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
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(50))),
                            child: Center(
                                child: SingleChildScrollView(
                              child: Form(
                                key: model.formKey,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomTextField(
                                            validator: (value) =>
                                                Validator.validateName(
                                                    value ?? ""),
                                            controller:
                                                model.firstNameController,
                                            type: TextFieldType.name,
                                            //  prefixImage: 'assets/icons/lock.svg',
                                            hintText: 'First Name',
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          CustomTextField(
                                            validator: (value) =>
                                                Validator.validateName(
                                                    value ?? ""),
                                            controller:
                                                model.lastNameController,
                                            type: TextFieldType.name,
                                            //  prefixImage: 'assets/icons/lock.svg',
                                            hintText: 'Last Name',
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          CustomTextField(
                                            // validator: (value) =>
                                            //     Validator.validateName(value ?? ""),
                                            controller:
                                                model.otherNameController,
                                            type: TextFieldType.name,
                                            //  prefixImage: 'assets/icons/lock.svg',
                                            hintText: 'Other Names',
                                            validate: false,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          CustomTextField(
                                            validator: (value) =>
                                                Validator.validateEmail(
                                                    value ?? ""),
                                            controller: model.emailController,
                                            type: TextFieldType.email,
                                            //  prefixImage: 'assets/icons/lock.svg',
                                            hintText: 'Email',
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          CustomTextField(
                                            validator: (value) =>
                                                Validator.validatePassword(
                                                    value ?? ""),
                                            controller: model.contactController,
                                            type: TextFieldType.phone,
                                            inputType: TextInputType.number,
                                            //  prefixImage: 'assets/icons/lock.svg',
                                            hintText: 'Phone Number',
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          CustomTextField(
                                            validator: (value) =>
                                                Validator.validateName(
                                                    value ?? ""),
                                            controller:
                                                model.ghanaCardController,
                                            type: TextFieldType.others,
                                            //  prefixImage: 'assets/icons/lock.svg',
                                            hintText: 'Ghana Card Number',
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          CustomTextField(
                                            validator: (value) =>
                                                Validator.validatePassword(
                                                    value ?? ""),
                                            controller:
                                                model.passwordController,
                                            //  prefixImage: 'assets/icons/password.svg',
                                            hintText: 'Password',
                                            obscure: model.obscure,
                                            type: TextFieldType.password,
                                            suffixFunc: () => model
                                                .changePasswordvisibility(),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          CustomTextField(
                                            validator: (value) => Validator
                                                .validateConfirmPassword(
                                                    value,
                                                    model.passwordController
                                                        .text),
                                            controller:
                                                model.confirmpasswordController,
                                            //  prefixImage: 'assets/icons/password.svg',
                                            hintText: 'Confirm Password',
                                            obscure: model.obscure,
                                            type: TextFieldType.password,
                                            suffixFunc: () => model
                                                .changePasswordvisibility(),
                                          ),
                                          const SizedBox(
                                            height: 15,
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
                                          title: 'Submit',
                                          color: kPrimaryColor,
                                          backgroundColor: Colors.white,
                                          press: () =>
                                              model.registerUsers(context),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Center(
                                        child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginScreen()));
                                            },
                                            child: const Text(
                                              'Already Registered? Log In',
                                              style: kTitleStyle,
                                            )),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      )
                                    ]),
                              ),
                            ))),
                      ),
                    ]),
                  )),
            ),
        viewModelBuilder: () => SignupViewModel());
  }
}
