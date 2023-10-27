import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import 'enums/textfield_type.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final TextStyle? style;
  final String? hintText;
  final String? prefixImage;
  final String? suffixImage;
  final Icon? suffixIcon;
  final Function? suffixIconFunc;
  final int? minLines;
  final int? maxLines;
  final TextEditingController? controller;
  final bool? obscure;
  final TextInputAction? action;
  final TextInputType? inputType;
  final Function? onChanged;
  final Function? suffixFunc;
  final String? errorText;
  final bool? enabled;
  final String? helperText;
  final TextStyle? helperStyle;
  final int? maxLength;
  final bool? center;
  final bool? showCusor;
  final bool? readOnly;
  final bool? autofocus;
  final Function? onSubmit;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final TextFieldType? type;
  final bool? validate;
  final bool? symbol;
  final bool? rounded;
  final bool? border;
  final Function? validator;
  // final UserBloc _userBloc = locator<UserBloc>();

  const CustomTextField(
      {Key? key,
      this.label,
      this.style,
      this.hintText,
      this.prefixImage,
      this.suffixImage,
      this.suffixIcon,
      this.suffixIconFunc,
      this.minLines,
      this.maxLines,
      this.controller,
      this.obscure,
      this.action,
      this.inputType,
      this.onChanged,
      this.suffixFunc,
      this.errorText,
      this.enabled = true,
      this.helperText,
      this.helperStyle,
      this.maxLength,
      this.onSubmit,
      this.focusNode,
      this.center = false,
      this.showCusor = true,
      this.readOnly = false,
      this.autofocus = false,
      this.textInputAction,
      this.inputFormatters,
      this.type = TextFieldType.others,
      this.symbol = false,
      this.validate = true,
      this.rounded = false,
      this.validator,
      this.border = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        label == null
            ? SizedBox()
            : Container(
                // margin: EdgeInsets.only(bottom: 5.h),
                child: Text(
                  label!,
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
        Expanded(
          flex: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  validator: validator == null
                      ? type == TextFieldType.bvn
                          ? (val) {
                              if (val!.isEmpty) {
                                return 'Field cannot be empty';
                              } else if (val.trim().isEmpty) {
                                return "Field cannot be empty";
                              } else if (val.length < 11) {
                                return 'Invalid Entry';
                              } else if (int.tryParse(val) == null) {
                                return 'Invalid entry';
                              }
                              return null;
                            }
                          : type == TextFieldType.accountNo
                              ? (val) {
                                  if (val!.isEmpty) {
                                    return 'Field cannot be empty';
                                  } else if (val.trim().isEmpty) {
                                    return "Field cannot be empty";
                                  } else if (val.length < 10) {
                                    return 'Invalid Entry';
                                  } else if (int.tryParse(val) == null) {
                                    return 'Invalid entry';
                                  }
                                  return null;
                                }
                              : type == TextFieldType.phone
                                  ? (val) {
                                      if (val!.isEmpty || val.trim().isEmpty) {
                                        return 'Field must not be empty';
                                      } else if (val.length < maxLength!) {
                                        return 'Invalid entry';
                                      } else if (int.tryParse(val
                                              .replaceAll('+', '')
                                              .replaceAll(' ', '')) ==
                                          null) {
                                        return 'Invalid entry';
                                      }
                                      return null;
                                    }
                                  : (value) {
                                      if (validate!) {
                                        if (value!.isEmpty) {
                                          return "Field cannot be empty";
                                        } else if (value.trim().isEmpty) {
                                          return "Field cannot be empty";
                                        } else if (type ==
                                            TextFieldType.amount) {
                                          if (double.tryParse(
                                                  value.replaceAll(',', '')) ==
                                              null) {
                                            return 'Enter a valid amount';
                                          } else if (double.tryParse(
                                                  value.replaceAll(',', ''))! <=
                                              0) {
                                            return 'Enter a valid amount';
                                          }
                                        } else if (type ==
                                            TextFieldType.email) {
                                          bool isValidEmail =
                                              RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                                      .hasMatch(value) &&
                                                  (checkEndSpace(value)) &&
                                                  RegExp(r'[A-Za-z0-9]')
                                                      .hasMatch(value[0]);

                                          return isValidEmail
                                              ? null
                                              : "Please provide a valid email address";
                                        } else if (type ==
                                            TextFieldType.setPassword) {
                                          bool isValidPassword = RegExp(
                                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,15}$')
                                              // bool isValidPassword = RegExp(r"^(?=.[a-z])(?=.[A-Z])(?=.\d)(?=.[^\da-zA-Z]).{8,15}$")
                                              .hasMatch(value);
                                          // if(!isValidPassword) flusher('Password must contain at least one special character,one number, one lower case letter, one upper case letter and between 8 and 15 characters long', color: Colors.red);

                                          return isValidPassword
                                              ? null
                                              : "Password must contain at least one special character,one number, one lower case letter, one upper case letter and between 8 and 15 characters long";
                                        }
                                      }

                                      return null;
                                    }
                      : (val) => validator!(val),
                  inputFormatters: getFormertter(),
                  focusNode: focusNode,
                  autofocus: autofocus!,
                  showCursor: showCusor,
                  readOnly: readOnly!,
                  enableInteractiveSelection: true,
                  enabled: enabled == null ? true : enabled,
                  controller: controller,
                  maxLines: maxLines == null ? 1 : maxLines,
                  minLines: minLines,
                  obscureText: obscure == null ? false : obscure!,
                  style: style ??
                      const TextStyle(fontSize: 17, color: Colors.white),
                  textAlign: center! ? TextAlign.center : TextAlign.start,
                  textInputAction: textInputAction ?? TextInputAction.done,
                  onEditingComplete: onSubmit as void Function()?,
                  keyboardType:
                      inputType == null ? TextInputType.text : inputType,
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: onChanged as void Function(String)?,
                  maxLength: maxLength,
                  decoration: InputDecoration(
                    filled: false,
                    hintText: hintText ?? '',
                    hintStyle: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                    helperText: helperText,
                    enabledBorder: const UnderlineInputBorder(
                      //<-- SEE HERE
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    disabledBorder: UnderlineInputBorder(
                      //<-- SEE HERE
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      //<-- SEE HERE
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                    suffixIconColor: Colors.white,
                    helperStyle: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                    errorText: errorText,
                    contentPadding: rounded!
                        ? const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10)
                        : const EdgeInsets.only(left: 20),
                    prefixIconConstraints:
                        BoxConstraints(minHeight: 40, minWidth: 10),
                    prefixIcon: prefixImage == null
                        ? null
                        : Container(
                            child: SvgPicture.asset(
                              prefixImage!,
                              fit: BoxFit.none,
                            ),
                          ),
                    suffixIconConstraints: BoxConstraints(
                        minHeight: this.type == TextFieldType.password ||
                                this.type == TextFieldType.setPassword
                            ? 40
                            : 0,
                        minWidth: this.type == TextFieldType.password ||
                                this.type == TextFieldType.setPassword
                            ? 60
                            : 0),
                    suffixIcon: setPasswordIcon(
                        obscuredText: this.obscure,
                        obscurePassword: this.suffixFunc),
                  ),
                ),
              ),
              suffixImage == null
                  ? SizedBox()
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: suffixFunc as void Function()?,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 5),
                          decoration: BoxDecoration(
                              color: Color(0xFFB9B9B9).withOpacity(0.12),
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                suffixImage!,
                                 color: Colors.white,
                                width: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ],
    );
  }

  Widget? setPasswordIcon({bool? obscuredText, Function? obscurePassword}) {
    if (this.type == TextFieldType.password ||
        this.type == TextFieldType.setPassword) {
      return IconButton(
        padding: EdgeInsets.all(0.0),
        icon:
            obscuredText! ? Icon(Icons.visibility_off, color: Colors.white,) : Icon(Icons.visibility, color: Colors.white),
        onPressed: obscurePassword as void Function()?,
        iconSize: 20.0,
      );
    } else {
      return null;
    }
  }

  bool checkEndSpace(String val) {
    if (val.split(' ').length > 1) {
      if (val.split(' ')[1].trim().isEmpty) {
        return true;
      } else {
        return false;
      }
    }
    return true;
  }

  List<TextInputFormatter>? getFormertter() {
    if (type == TextFieldType.amount) {
      return [
        FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
        ThousandsFormatter(allowFraction: true),
        // LengthLimitingTextInputFormatter(7),
      ];
    } else if (type == TextFieldType.bvn) {
      return [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11)
      ];
    } else if (type == TextFieldType.accountNo) {
      return [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(16)
      ];
    } else if (type == TextFieldType.phone) {
      return [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(maxLength)
      ];
    } else if (type == TextFieldType.customerNumber) {
      return [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10)
      ];
    } else if (type == TextFieldType.name) {
      return [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z-0-9]"))];
    }
    return inputFormatters;
  }
}
