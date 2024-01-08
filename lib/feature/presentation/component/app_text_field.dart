import 'package:flutter/material.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/core/extension/size_extension.dart';

class AppTextField extends StatefulWidget {
  final TextFormField textFormField;
  final FocusNode? focusNode;
  final String label;
  final String hintLabel;
  final Color? backgroundColor;
  final Color borderColor;
  final Color labelColor;
  late final bool formatError;

  AppTextField(
      {Key? key,
      required this.textFormField,
      this.focusNode,
      this.backgroundColor,
      required this.borderColor,
      required this.label,
      required this.hintLabel,
      required this.labelColor,
      bool? formatError})
      : super(key: key) {
    this.formatError = formatError ?? false;
  }

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      focusColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        if (widget.focusNode != null) {
          FocusScope.of(context).requestFocus(widget.focusNode);
        }
      },
      child: Container(
        width: AppConfig.screenWidth(context),
        height: 90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: widget.backgroundColor ?? Colors.transparent,
            border: Border.all(
                color: !widget.formatError ? widget.borderColor : Colors.red)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.label,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontSize: 15.sf(context), color: widget.labelColor),
              ),
              AppDimension.verticalSize_8,
              Expanded(child: widget.textFormField)
            ],
          ),
        ),
      ),
    );
  }
}
