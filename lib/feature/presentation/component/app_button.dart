import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resident/core/extension/size_extension.dart';

class AppButton extends StatefulWidget {
  final Color primaryColor;
  final Color onPrimaryColor;
  final VoidCallback? onClick;
  final String label;
  final Color labelColor;
  final bool isSmallSize;
  final bool isLoading;

  const AppButton(
      {Key? key,
      required this.primaryColor,
      required this.onPrimaryColor,
      required this.onClick,
      required this.label,
      required this.labelColor,
      required this.isSmallSize,
      required this.isLoading})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppButtonState();
  }
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
          width: widget.isSmallSize ? null : MediaQuery.of(context).size.width,
          height: 56),
      child: ElevatedButton(
        onPressed: widget.isLoading ? null : widget.onClick,
        style: _initStyle(),
        child: widget.isLoading
            ? CupertinoActivityIndicator(radius: 10)
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Text(widget.label.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: widget.labelColor,fontSize: 14.sf(context))),
              ),
      ),
    );
  }

  _initStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.resolveWith<StadiumBorder>(
        (Set<MaterialState> states) {
          return StadiumBorder(side: BorderSide(color: Colors.transparent));
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return widget.primaryColor;
          } else if (states.contains(MaterialState.disabled)) {
            return widget.primaryColor;
          }
          return widget.primaryColor;
        },
      ),
    );
  }
}
