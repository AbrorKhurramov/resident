import 'package:flutter/material.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class VoteSelect extends StatefulWidget {
  final bool isAnswered;

  VoteSelect(this.isAnswered);

  @override
  State<StatefulWidget> createState() {
    return VoteSelectState();
  }
}

class VoteSelectState extends State<VoteSelect> {
  int value = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        color: AppColor.c6000,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Theme(
              data: Theme.of(context)
                  .copyWith(unselectedWidgetColor: Colors.white),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    color: value == index ? Colors.white : AppColor.c6000,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: widget.isAnswered
                    ? _initVoteItem(value == index)
                    : _initRadioItem(value == index),
              ),
            );
          },
        ),
      ),
    );
  }

  _initRadioItem(index) {
    return RadioListTile(
      dense: true,
      value: index,
      groupValue: value,
      activeColor: AppColor.c6000,
      controlAffinity: ListTileControlAffinity.trailing,
      onChanged: widget.isAnswered ? null : _onRadioClick,
      title: Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Text(
          "MMG Facility Management Group",
          style: _getRadioTitleStyle(value == index),
        ),
      ),
      subtitle: Text(
          "Expedita blanditiis commodi ullam expedita egestas rhoncus facilis.",
          style: _getRadioSubTitleStyle(value == index)),
    );
  }

  _initVoteItem(isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isSelected
            ? Text('Ваш голос:', style: _getRadioTitleStyle(isSelected))
            : Container(),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text('Отлично', style: _getTitlePercentStyle(isSelected)),
            Text('35%', style: _getPercentCountStyle(isSelected)),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        LinearPercentIndicator(
          lineHeight: 16,
          percent: 0.963,
          progressColor: isSelected ? AppColor.c6000 : Colors.white,
          backgroundColor: isSelected
              ? AppColor.c6000.withOpacity(0.5)
              : Colors.white.withOpacity(0.5),
        )
      ],
    );
  }

  _onRadioClick(val) {
    setState(() {
      return value = val;
    });
  }

  _getRadioTitleStyle(isSelected) {
    return Theme.of(context).textTheme.headline3!.copyWith(
        color: isSelected ? AppColor.c4000 : Colors.white, fontSize: 14);
  }

  _getRadioSubTitleStyle(isSelected) {
    return Theme.of(context).textTheme.headline4!.copyWith(
        color: isSelected ? AppColor.c3000 : Colors.white.withOpacity(0.6),
        fontSize: 13);
  }

  _getPercentCountStyle(isSelected) {
    return Theme.of(context).textTheme.headline1!.copyWith(
        color: isSelected ? AppColor.c4000 : Colors.white, fontSize: 16);
  }

  _getTitlePercentStyle(isSelected) {
    return Theme.of(context).textTheme.headline3!.copyWith(
        color: isSelected ? AppColor.c4000 : Colors.white, fontSize: 16);
  }
}
