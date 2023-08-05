library count_down_timer;

import 'dart:async';
import 'package:flutter/material.dart';

import 'countdown.dart';

///CountDownText : A simple text widget that display the countdown timer
///based on the dateTime given e.g DateTime.utc(2050)
class WidgetCountDownText extends StatefulWidget {
  const WidgetCountDownText({
    Key? key,
    required this.due,
    required this.finishedText,
    this.longDateName = false,
    this.style,
    this.showLabel = false,
    this.daysTextLong = " days ",
    this.hoursTextLong = " hours ",
    this.minutesTextLong = " minutes ",
    this.secondsTextLong = " seconds ",
    this.daysTextShort = " d ",
    this.hoursTextShort = " h ",
    this.minutesTextShort = " m ",
    this.secondsTextShort = " s ",
    required this.onDone,
  }) : super(key: key);

  final DateTime? due;
  final String? finishedText;
  final bool? longDateName;
  final bool? showLabel;
  final TextStyle? style;
  final String daysTextLong;
  final String hoursTextLong;
  final String minutesTextLong;
  final String secondsTextLong;
  final String daysTextShort;
  final String hoursTextShort;
  final String minutesTextShort;
  final String secondsTextShort;
  final VoidCallback onDone;

  @override
  _CountDownTextState createState() => _CountDownTextState();
}

class _CountDownTextState extends State<WidgetCountDownText> {
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      checkFinish();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  bool checkFinish() {
    Duration timeUntilDue = widget.due!.difference(DateTime.now());

    int daysUntil = timeUntilDue.inDays;
    int hoursUntil = timeUntilDue.inHours - (daysUntil * 24);
    int minUntil =
        timeUntilDue.inMinutes - (daysUntil * 24 * 60) - (hoursUntil * 60);
    int secUntil = timeUntilDue.inSeconds - (minUntil * 60);

    // finised
    if (secUntil <= 0) {
      widget.onDone();
      timer!.cancel();
      return true;
    }
    // unfinished
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      CountDown().timeLeft(
          widget.due!,
          widget.finishedText!,
          widget.daysTextLong,
          widget.hoursTextLong,
          widget.minutesTextLong,
          widget.secondsTextLong,
          widget.daysTextShort,
          widget.hoursTextShort,
          widget.minutesTextShort,
          widget.secondsTextShort,
          longDateName: widget.longDateName,
          showLabel: widget.showLabel),
      style: widget.style,
    );
  }
}
