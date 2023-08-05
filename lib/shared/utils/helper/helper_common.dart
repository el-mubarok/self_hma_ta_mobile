import 'package:flutter/material.dart';
import 'package:housing_management_mobile/shared/utils/extension/color_brightness.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import '../../../themes/color.dart';
import '../../ui/widgets/widget_dialog.dart';
import '../../ui/widgets/widget_input.dart';
import '../utils_global.dart';
import 'helper_device.dart';
import 'package:timeago/timeago.dart' as timeago;

class AppHelperCommon {
  showSnackBar(
    BuildContext context,
    String message, [
    Color backgroundColor = AppColors.black,
    int duration = 4,
    SnackBarBehavior behavior = SnackBarBehavior.fixed,
  ]) {
    // close all active snackbar
    AppUtilsGlobal().snackbarKey.currentState?.clearSnackBars();
    //
    final snackBarContent = SnackBar(
      behavior: behavior,
      content: Text(
        message,
        style: TextStyle(
          color: backgroundColor.computeLuminance() >= 0.5
              ? AppColors.black
              : AppColors.white,
        ),
      ),
      duration: Duration(seconds: duration),
      backgroundColor: backgroundColor.darken(0.1),
    );
    AppUtilsGlobal().snackbarKey.currentState?.showSnackBar(
          snackBarContent,
        );
  }

  // showDeviceId(BuildContext context) async {
  //   String deviceId = "";
  //   TextEditingController text = TextEditingController();

  //   AppHelperDevice().getEncodedDeviceId().then((value) {
  //     deviceId = value;
  //     text.text = deviceId;
  //     print(deviceId);
  //   });
  //   showModalBottomSheet<void>(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: AppColors.transparent,
  //     builder: (BuildContext context) {
  //       return FractionallySizedBox(
  //         heightFactor: 0.7,
  //         child: Container(
  //           decoration: const BoxDecoration(
  //             color: AppColors.white,
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(16),
  //               topRight: Radius.circular(16),
  //             ),
  //           ),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               PrettyQr(
  //                 size: 200,
  //                 data: deviceId,
  //                 errorCorrectLevel: QrErrorCorrectLevel.M,
  //                 roundEdges: true,
  //               ),
  //               //
  //               Padding(
  //                 padding: const EdgeInsets.only(
  //                   top: 16,
  //                 ),
  //                 child: WidgetInput(
  //                   hint: "My device ID",
  //                   textController: text,
  //                   type: TextInputType.text,
  //                   onChanged: (v) {},
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  showAlert({
    required BuildContext context,
    String? title,
    String? subtitle,
    String? content,
    Function? onTapOk,
    VoidCallback? onDismissed,
    bool okOnly = false,
  }) {
    BuildContext dialogContext;
    showDialog(
      context: context,
      builder: (BuildContext contextDialog) {
        dialogContext = contextDialog;
        return WidgetDialog(
          title: title,
          subtitle: subtitle,
          content: content,
          okOnly: okOnly,
          onOk: () {
            onTapOk!(dialogContext);
          },
        );
      },
    ).then((value) {
      if (onDismissed != null) {
        onDismissed();
      }
    });
  }

  String dateFormatterHistory(DateTime? date, [bool hoursOnly = false]) {
    var result = DateFormat("E, d LLL y").format(
      (date ?? DateTime.now()),
    );

    if (hoursOnly) {
      result = date != null ? DateFormat("HH:mm").format((date)) : '-';
    }

    return result;
  }

  Color getColor(Color background) {
    return background.computeLuminance() >= 0.5
        ? AppColors.black
        : AppColors.white;
  }

  String getTimeago(DateTime? date) {
    return timeago.format(date ?? DateTime.now());
  }
}
