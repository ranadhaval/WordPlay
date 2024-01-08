import 'package:news/theme/app_theme.dart';
import 'package:news/util/_string.dart';
import 'package:news/util/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFeild extends StatefulWidget {
  CustomTextFeild(
      {super.key,
      this.hintText = Strings.emptyString,
      this.isObscureText = Constant.isFalse,
      this.leftPadding = Constant.SIZE20,
      this.rightPadding = Constant.SIZE20,
      this.topPadding = Constant.SIZE20,
      this.onChanged,
      this.onTap,
      this.bottomPadding = Constant.zero,
      this.contentLeftPadding = Constant.customfieldContentLeftPadding,
      this.contentRightPadding = Constant.customfieldContentRightPadding,
      this.contentTopPadding = Constant.customfieldContentTopPadding,
      this.contentBottomPadding = Constant.customfieldContentBottomPadding,
      this.hintSize = Constant.customfieldHintSize,
      this.prefixIcon,
      this.controller,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.suffixIcon});

  double contentLeftPadding;
  double contentRightPadding;
  double contentTopPadding;
  double contentBottomPadding;
  double bottomPadding;
  String hintText;
  Widget? prefixIcon;
  bool isObscureText;
  Widget? suffixIcon;
  double leftPadding;
  double rightPadding;
  double topPadding;
  double hintSize;
  TextInputType? keyboardType;
  String? Function(String?)? validator;
  void Function(String)? onChanged;
  void Function()? onTap;
  TextEditingController? controller;

  @override
  State<CustomTextFeild> createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            bottom: widget.bottomPadding,
            left: widget.leftPadding,
            right: widget.rightPadding,
            top: widget.topPadding),
        child: Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
              boxShadow: [Constant.boxShadow(color: AppTheme.greyColor)]),
          child: TextFormField(
            controller: widget.controller,
            onTap: widget.onTap,
            keyboardType: widget.keyboardType,
            validator: widget.validator ??
                (value) => value!.isNotEmpty ? null : Strings.invalidInput,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: widget.isObscureText,
            decoration: InputDecoration(
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                    fontFamily: Strings.fontfamily,
                    fontSize: widget.hintSize,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textFieldHintColor),
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(
                    widget.contentLeftPadding,
                    widget.contentTopPadding,
                    widget.contentRightPadding,
                    widget.contentBottomPadding),
                fillColor: AppTheme.colorWhite,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.customFocusColor),
                    borderRadius:
                        BorderRadius.circular(Constant.customTextfieldCorner)),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Constant.customTextfieldCorner)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: AppTheme.colorTransprant),
                    borderRadius:
                        BorderRadius.circular(Constant.customTextfieldCorner))),
          ),
        ));
  }
}
