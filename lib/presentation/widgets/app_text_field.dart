import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../app/constants/app_constants.dart';

// ignore: must_be_immutable
class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  FocusNode? focusNode;
  bool autoFocus;
  bool showPassword;
  final Color colorText;
  final Color colorHint;
  final double fontSize;
  bool autoCorrect;
  final String? hinText;
  final double radius;
  final Widget? suffixIcon;
  final TextInputType keyBoardType;
  final int? maxLenght;
  final int? maxLine;
  final TextInputAction? textInputAction;

  AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    required this.autoFocus,
    required this.colorText,
    required this.colorHint,
    this.hinText,
    required this.autoCorrect,
    required this.radius,
    required this.fontSize,
    this.suffixIcon,
    this.showPassword = false,
    this.keyBoardType = TextInputType.text,
    this.maxLenght,
    this.maxLine = 1,
    this.textInputAction,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _visibleClear = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      autofocus: widget.autoFocus,
      textAlignVertical: TextAlignVertical.center,
      autocorrect: widget.autoCorrect,
      keyboardType: widget.keyBoardType,
      textInputAction: widget.textInputAction ?? TextInputAction.done,
      obscureText: widget.showPassword,
      maxLength: widget.maxLenght ?? 20,
      maxLines: widget.maxLine,
      onChanged: (value) {
        if (value.isNotEmpty && !_visibleClear) {
          setState(() {
            _visibleClear = true;
          });
          return;
        }
        if (value.isEmpty) {
          setState(() {
            _visibleClear = false;
          });
        }
      },
      style: TextStyle(
        color: widget.colorText,
        fontSize: widget.fontSize,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(17, 0, 17, 0),
        hintText: widget.hinText?.tr,
        suffixIcon: SizedBox(
          width: 88,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: _visibleClear,
                child: InkWell(
                  onTap: () {
                    widget.controller?.clear();
                    setState(() {
                      _visibleClear = false;
                    });
                  },
                  child: Container(
                    height: 20,
                    width: 20,
                    margin: const EdgeInsets.fromLTRB(13, 11, 13, 11),
                    child: SvgPicture.asset(
                      SvgPath.svgClear,
                    ),
                  ),
                ),
              ),
              Container(
                child: widget.suffixIcon,
              )
            ],
          ),
        ),
        counterText: '',
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AppColors.greyECECEC),
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AppColors.greyECECEC),
          borderRadius: BorderRadius.circular(widget.radius),
        ),
      ),
    );
  }
}
