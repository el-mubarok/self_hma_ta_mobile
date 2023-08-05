import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/admin/setting_module/bloc/admin_setting_bloc.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/admin/setting_module/data/admin_setting_repository.dart';
import 'package:housing_management_mobile/shared/models/shared_billing_data.dart';
import 'package:housing_management_mobile/shared/models/shared_billing_list_data.dart';
import 'package:housing_management_mobile/shared/models/shared_user_data_model.dart';
import 'package:housing_management_mobile/shared/ui/widgets/widget_appbar.dart';
import 'package:housing_management_mobile/shared/ui/widgets/widget_button.dart';
import 'package:housing_management_mobile/shared/ui/widgets/widget_input.dart';
import 'package:housing_management_mobile/shared/ui/widgets/widget_item_card.dart';
import 'package:housing_management_mobile/shared/utils/extension/color_brightness.dart';
import 'package:housing_management_mobile/shared/utils/helper/helper_common.dart';
import 'package:housing_management_mobile/shared/utils/utils.dart';
import 'package:housing_management_mobile/shared/utils/utils_global.dart';
import 'package:housing_management_mobile/themes/color.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../../../shared/ui/wrappers/wrapper_page.dart';

class ModuleAdminSettingSchedule extends StatefulWidget {
  const ModuleAdminSettingSchedule({super.key});

  @override
  State<StatefulWidget> createState() => _ModuleAdminSettingSchedule();
}

class _ModuleAdminSettingSchedule extends State<ModuleAdminSettingSchedule> {
  SharedBillingData? billingData;
  Map<String, dynamic> times = {};
  String dayFrom = '01';
  String dayTo = '01';
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController monthCtrl = TextEditingController();
  TextEditingController yearCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminSettingBloc(
        repository: AdminSettingRepository(),
      ),
      child: WrapperPage(
        safeTop: true,
        hasPadding: false,
        statusBarColor: AppColors.adminPrimary.darken(0.01),
        backgroundColor: AppColors.adminPrimary,
        height: MediaQuery.of(context).size.height,
        appBar: WidgetAppBar(
          title: 'Set Bills Payment Time',
          subtitle: 'Manage payment schedule',
          onTap: () => Navigator.pop(context),
        ),
        bottomNavigationBar: billingData != null
            ? Padding(
                padding: const EdgeInsets.all(16),
                child: BlocConsumer<AdminSettingBloc, AdminSettingState>(
                  listener: (context, state) {
                    if (state is ASUpdateSuccess) {
                      AppHelperCommon().showAlert(
                        context: context,
                        title: 'Success',
                        content: 'Schedule data updated',
                        okOnly: true,
                        onTapOk: (contextAlert) {},
                      );
                    } else if (state is ASUpdateFailed) {
                      AppHelperCommon().showAlert(
                        context: context,
                        title: 'Error',
                        content: 'Failed to update schedule data',
                        okOnly: true,
                        onTapOk: (contextAlert) {},
                      );
                    }
                  },
                  builder: (context, state) {
                    return WidgetButton(
                      fullRounded: false,
                      isLoading: state is ASUpdateLoadingState,
                      // isDisabled: !state.status.isValid,
                      color: AppColors.adminLime,
                      label: 'Save',
                      onTap: () {
                        times.forEach((key, value) {
                          context.read<AdminSettingBloc>().add(
                                ASUpdateSessionTime(times),
                              );
                        });
                        print("OOOOOO: ${nameCtrl.text}");
                        //
                        context.read<AdminSettingBloc>().add(
                              AdminSettingUpdateSession(
                                data: billingData,
                                from: dayFrom,
                                to: dayTo,
                                namee: nameCtrl.text,
                                price: priceCtrl.text,
                                month: monthCtrl.text,
                                year: yearCtrl.text,
                              ),
                            );
                      },
                    );
                  },
                ),
              )
            : null,
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.only(
            right: 16,
            bottom: 16,
            left: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocConsumer<AdminSettingBloc, AdminSettingState>(
                listener: (context, state) {
                  if (state is ASBillingState) {
                    billingData = state.data;
                    nameCtrl.text = billingData?.data.name ?? '';
                    var date = DateTime.parse(
                      billingData?.data.fromDate.toIso8601String() ??
                          DateTime.now().toIso8601String(),
                    );
                    monthCtrl.text = DateFormat('M').format(date);
                    yearCtrl.text = DateFormat('y').format(date);
                    priceCtrl.text = billingData?.data.price ?? '0';
                    setState(() {});
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      _SelectSession(
                        onTap: (id) {
                          AppUtils.logD(id);
                          context
                              .read<AdminSettingBloc>()
                              .add(AdminSettingSession(id));
                        },
                      ),
                      // WidgetButton(
                      //   label: 'Create',
                      //   fullRounded: false,
                      //   color: AppColors.adminPrimary1,
                      //   onTap: () {},
                      // ),
                      _CreateSession(),
                    ],
                  );
                },
              ),
              //
              if (billingData != null) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: _MetadataForm(
                    name: nameCtrl,
                    month: monthCtrl,
                    year: yearCtrl,
                    price: priceCtrl,
                  ),
                ),
                //
                const Padding(
                  padding: EdgeInsets.only(bottom: 8, top: 16),
                  child: Text(
                    'Set range of days',
                    style: TextStyle(
                      fontFamily: 'Source Sans 3',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _RangeSelection(
                    data: billingData,
                    dayFrom: billingData?.data.fromDate.toIso8601String() ?? '',
                    dayTo: billingData?.data.toDate.toIso8601String() ?? '',
                    sessionId: billingData?.data.id ?? '',
                    onDate: (from, to) {
                      setState(() {
                        dayFrom = from;
                        dayTo = to;
                      });
                    },
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Set reminder time',
                        style: TextStyle(
                          fontFamily: 'Source Sans 3',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      //
                      BlocConsumer<AdminSettingBloc, AdminSettingState>(
                        listener: (context, state) {
                          if (state is ASSessionTimeCreateSuccess) {
                            context.read<AdminSettingBloc>().add(
                                  AdminSettingSession(billingData?.data.id),
                                );
                          }
                        },
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () {
                              context.read<AdminSettingBloc>().add(
                                    ASCreateSessionTime(billingData?.data.id),
                                  );
                            },
                            child: const Icon(
                              BootstrapIcons.plus_square_fill,
                              color: Colors.white,
                              size: 20,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                //
                ListView.builder(
                  itemCount: billingData?.data.reminder.length ?? 0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  addAutomaticKeepAlives: false,
                  reverse: true,
                  itemBuilder: (context, index) {
                    var d = billingData?.data.reminder[index];
                    var t = billingData?.data.reminder[index].timeStamp;
                    var h = t?.split(':')[0];
                    var m = t?.split(':')[1];

                    return BlocConsumer<AdminSettingBloc, AdminSettingState>(
                      listener: (context, state) {
                        if (state is ASSessionTimeDeleteSuccess) {
                          context.read<AdminSettingBloc>().add(
                                AdminSettingSession(billingData?.data.id),
                              );
                        }
                      },
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            AppHelperCommon().showAlert(
                              context: context,
                              title: 'Remove item',
                              content: AppUtils.getScheduleTimeRemoveAlertText(
                                d?.timeStamp,
                                index,
                              ),
                              onTapOk: (contextAlert) {
                                context.read<AdminSettingBloc>().add(
                                      ASDeleteSessionTime(d?.id),
                                    );
                              },
                            );
                          },
                          child: _ItemTime(
                            hour: h.toString(),
                            minute: m.toString(),
                            index: index + 1,
                            timeId: billingData?.data.reminder[index].id,
                            onTime: (timeSet) {
                              times[(billingData?.data.reminder[index].id)
                                  .toString()] = timeSet;
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _RangeSelection extends StatefulWidget {
  final String dayFrom;
  final String dayTo;
  final dynamic sessionId;
  final Function onDate;
  final SharedBillingData? data;

  const _RangeSelection({
    required this.dayFrom,
    required this.dayTo,
    required this.sessionId,
    required this.onDate,
    this.data,
  });

  @override
  State<StatefulWidget> createState() => _RangeSelectionState();
}

class _RangeSelectionState extends State<_RangeSelection> {
  SharedBillingData? data;
  int dayFrom = 8;
  int dayTo = 1;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      dayFrom = int.parse(
        DateFormat('d').format(
          widget.data?.data.fromDate ?? DateTime.now(),
        ),
      );
      dayTo = int.parse(
        DateFormat('d').format(
          widget.data?.data.toDate ?? DateTime.now(),
        ),
      );
      if (mounted) {
        setState(() {});
      }
    });
  }

  void update(BuildContext context) {
    widget.onDate(
      dayFrom.toString().padLeft(2, '0'),
      dayTo.toString().padLeft(2, '0'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminSettingBloc, AdminSettingState>(
      listener: (context, state) {
        if (state is ASBillingState) {
          data = state.data;
          var fromDate = DateFormat('d').format(
            data?.data.fromDate ?? DateTime.now(),
          );
          var toDate = DateFormat('d').format(
            data?.data.toDate ?? DateTime.now(),
          );
          dayFrom = int.parse(fromDate);
          dayTo = int.parse(toDate);
          update(context);
          setState(() {});
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              // column header
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.black12,
                    ),
                    bottom: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      'FROM',
                      style: TextStyle(
                        fontFamily: 'Source Sans 3',
                        fontWeight: FontWeight.w600,
                        color: AppColors.adminPrimary,
                      ),
                    ),
                    Text(
                      'TO',
                      style: TextStyle(
                        fontFamily: 'Source Sans 3',
                        fontWeight: FontWeight.w600,
                        color: AppColors.adminPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              // content
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 36),
                    child: NumberPicker(
                      value: dayFrom,
                      minValue: 1,
                      maxValue: 28,
                      haptics: true,
                      zeroPad: true,
                      itemHeight: 40,
                      textStyle: const TextStyle(
                        fontFamily: 'Source Sans 3',
                        color: Colors.black38,
                      ),
                      selectedTextStyle: const TextStyle(
                        fontFamily: 'Source Sans 3',
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: AppColors.adminPrimary,
                      ),
                      onChanged: (value) {
                        setState(() => dayFrom = value);
                        update(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 28),
                    child: NumberPicker(
                      value: dayTo,
                      minValue: 1,
                      maxValue: 28,
                      haptics: true,
                      zeroPad: true,
                      itemHeight: 40,
                      textStyle: const TextStyle(
                        fontFamily: 'Source Sans 3',
                        color: Colors.black38,
                      ),
                      selectedTextStyle: const TextStyle(
                        fontFamily: 'Source Sans 3',
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: AppColors.adminPrimary,
                      ),
                      onChanged: (value) {
                        setState(() => dayTo = value);
                        update(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ItemTime extends StatefulWidget {
  final String hour;
  final String minute;
  final int index;
  final dynamic timeId;
  final Function onTime;

  const _ItemTime({
    required this.hour,
    required this.minute,
    required this.index,
    required this.timeId,
    required this.onTime,
  });

  @override
  State<StatefulWidget> createState() => _ItemTimeState();
}

class _ItemTimeState extends State<_ItemTime> {
  int hours = 8;
  int minutes = 0;

  @override
  void initState() {
    super.initState();
    hours = int.parse(widget.hour);
    minutes = int.parse(widget.minute);

    widget.onTime('$hours:$minutes');
  }

  void update(BuildContext context) {
    // context.read<AdminSettingBloc>().add(
    //       ASUpdateSessionTime(widget.timeId, '$hours:$minutes'),
    //     );
    widget.onTime('$hours:$minutes');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.adminPrimary1,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: 'Time ${widget.index}',
              style: const TextStyle(
                fontFamily: 'Source Sans 3',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.25,
                color: Colors.white,
              ),
              children: [
                TextSpan(
                  text:
                      '\nat ${DateFormat.jm().format(DateTime.parse('2020-12-12 ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:00'))}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          //
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocBuilder<AdminSettingBloc, AdminSettingState>(
                  builder: (context, state) {
                    return NumberPicker(
                      value: hours,
                      minValue: 1,
                      maxValue: 24,
                      haptics: true,
                      zeroPad: true,
                      itemHeight: 32,
                      itemWidth: 40,
                      textStyle: const TextStyle(
                        fontFamily: 'Source Sans 3',
                        fontSize: 10,
                        color: Colors.white30,
                      ),
                      selectedTextStyle: const TextStyle(
                        fontFamily: 'Source Sans 3',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() => hours = value);
                        update(context);
                      },
                    );
                  },
                ),
                //
                const Padding(
                  padding: EdgeInsets.only(left: 4, right: 4),
                  child: Text(
                    ':',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Source Sans 3',
                      fontWeight: FontWeight.w600,
                      height: 1,
                    ),
                  ),
                ),
                //
                BlocBuilder<AdminSettingBloc, AdminSettingState>(
                  builder: (context, state) {
                    return NumberPicker(
                      value: minutes,
                      minValue: 0,
                      maxValue: 59,
                      haptics: true,
                      zeroPad: true,
                      itemHeight: 32,
                      itemWidth: 40,
                      textStyle: const TextStyle(
                        fontFamily: 'Source Sans 3',
                        fontSize: 10,
                        color: Colors.white30,
                      ),
                      selectedTextStyle: const TextStyle(
                        fontFamily: 'Source Sans 3',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() => minutes = value);
                        update(context);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectSession extends StatefulWidget {
  final Function onTap;

  const _SelectSession({required this.onTap});

  @override
  State<StatefulWidget> createState() => _SelectSessionState();
}

class _SelectSessionState extends State<_SelectSession> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: WidgetButton(
        label: 'Select Session',
        fullRounded: false,
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            builder: (BuildContext context) {
              return BlocProvider(
                create: (context) => AdminSettingBloc(
                  repository: AdminSettingRepository(),
                )..add(const AdminSettingSessionList()),
                child: FractionallySizedBox(
                  heightFactor: 0.7,
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.7,
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: BlocBuilder<AdminSettingBloc, AdminSettingState>(
                          builder: (context, state) {
                            SharedBillingListData? data;

                            if (state is ASListState) {
                              data = state.data;
                            }

                            return ListView.builder(
                              padding: const EdgeInsets.all(16),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: data?.data.length ?? 0,
                              itemBuilder: (context, index) {
                                var d = data?.data[index];
                                var f = DateFormat.yMMMd('en_US')
                                    .format(d?.fromDate ?? DateTime.now());
                                var t = DateFormat.yMMMd('en_US')
                                    .format(d?.toDate ?? DateTime.now());
                                return WidgetItemCard(
                                  title: d?.name ?? '',
                                  subtitle: '$f - $t',
                                  hasAvatar: false,
                                  hasStatus: false,
                                  onTap: () {
                                    widget.onTap(d?.id);
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _MetadataForm extends StatefulWidget {
  final TextEditingController name;
  final TextEditingController month;
  final TextEditingController year;
  final TextEditingController price;

  const _MetadataForm({
    required this.name,
    required this.month,
    required this.year,
    required this.price,
  });

  @override
  State<StatefulWidget> createState() => _MetadataFormState();
}

class _MetadataFormState extends State<_MetadataForm> {
  int price = 0;

  @override
  void initState() {
    super.initState();

    price = int.parse(widget.price.text);
    widget.price.addListener(() {
      setState(() {
        if (widget.price.text == '') {
          price = 0;
        } else {
          price = int.parse(widget.price.text);
        }
      });
    });
  }

  @override
  void dispose() {
    widget.price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WidgetInput(
          hint: '',
          label: 'Name',
          type: TextInputType.text,
          hasBorder: true,
          hasPadding: false,
          labelColor: Colors.white,
          textController: widget.name,
          onChanged: (value) {},
        ),
        //
        Row(
          children: [
            Expanded(
              child: WidgetInput(
                hint: '',
                label: 'Month',
                type: TextInputType.number,
                hasBorder: true,
                hasPadding: false,
                labelColor: Colors.white,
                textController: widget.month,
                onChanged: (value) {},
              ),
            ),
            //
            const Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
            //
            Expanded(
              child: WidgetInput(
                hint: '',
                label: 'Year',
                type: TextInputType.number,
                hasBorder: true,
                hasPadding: false,
                labelColor: Colors.white,
                textController: widget.year,
                onChanged: (value) {},
              ),
            ),
          ],
        ),
        //
        WidgetInput(
          hint: '',
          label: 'Price',
          type: TextInputType.number,
          hasBorder: true,
          hasPadding: false,
          hasBottomMargin: false,
          labelColor: Colors.white,
          textController: widget.price,
          notes: "Price in rupiah ${NumberFormat.simpleCurrency(
            locale: 'ID',
            decimalDigits: 0,
          ).format(price)}",
          notesColor: Colors.white,
          onChanged: (value) {},
        ),
      ],
    );
  }
}

class _CreateSession extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateSessionState();
}

class _CreateSessionState extends State<_CreateSession> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController dateFrom = TextEditingController();
  TextEditingController dateTo = TextEditingController();
  TextEditingController feeAmount = TextEditingController();
  SharedUserData? user = AppUtilsGlobal().userData.value;

  void clearField() {
    name.clear();
    description.clear();
    dateFrom.clear();
    dateTo.clear();
    feeAmount.clear();
  }

  void disposeField() {
    name.dispose();
    description.dispose();
    dateFrom.dispose();
    dateTo.dispose();
    feeAmount.dispose();
  }

  @override
  void dispose() {
    disposeField();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WidgetButton(
      label: 'Create',
      fullRounded: false,
      color: AppColors.adminPrimary1,
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: AppColors.transparent,
          builder: (BuildContext context) {
            return BlocProvider(
              create: (context) => AdminSettingBloc(
                repository: AdminSettingRepository(),
              ),
              child: FractionallySizedBox(
                heightFactor: 0.7,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: BlocBuilder<AdminSettingBloc, AdminSettingState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            WidgetInput(
                              label: 'Name',
                              hint: 'billing name',
                              type: TextInputType.text,
                              hasPadding: false,
                              textController: name,
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {},
                            ),
                            //
                            WidgetInput(
                              label: 'Description (optional)',
                              hint: 'billing description',
                              type: TextInputType.text,
                              hasPadding: false,
                              textController: description,
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {},
                            ),
                            //
                            WidgetInput(
                              label: 'Date From',
                              hint: 'eg: 2023-9-10 (y-m-d)',
                              type: TextInputType.text,
                              hasPadding: false,
                              textController: dateFrom,
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {},
                            ),
                            //
                            WidgetInput(
                              label: 'Date To',
                              hint: 'eg: 2023-9-10 (y-m-d)',
                              type: TextInputType.text,
                              hasPadding: false,
                              textController: dateTo,
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {},
                            ),
                            //
                            WidgetInput(
                              label: 'Fee Amount',
                              hint: '',
                              type: TextInputType.text,
                              hasPadding: false,
                              textController: feeAmount,
                              textInputAction: TextInputAction.done,
                              onChanged: (value) {},
                            ),
                            //
                            BlocConsumer<AdminSettingBloc, AdminSettingState>(
                              listener: (context, state) {
                                if (state is ASCreateSessionSuccess) {
                                  clearField();
                                  AppHelperCommon().showAlert(
                                    context: context,
                                    title: 'Success',
                                    content: 'Session created',
                                    okOnly: true,
                                    onTapOk: (c) {},
                                    onDismissed: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                } else if (state is ASCreateSessionFailed) {
                                  AppHelperCommon().showAlert(
                                    context: context,
                                    title: 'Error',
                                    content:
                                        'Failed to create session, please try again',
                                    okOnly: true,
                                    onTapOk: () {},
                                  );
                                }
                              },
                              builder: (context, state) {
                                return WidgetButton(
                                  label: 'Save',
                                  fullRounded: false,
                                  isLoading: state is ASCreateSessionLoading,
                                  color: AppColors.adminLime,
                                  onTap: () {
                                    SubmitParams params = SubmitParams(
                                      adminId: user?.data.id ?? '',
                                      name: name.text,
                                      description: description.text,
                                      fromDate: dateFrom.text,
                                      toDate: dateTo.text,
                                      price: feeAmount.text,
                                    );
                                    if (name.text.isNotEmpty &&
                                        dateTo.text.isNotEmpty &&
                                        dateFrom.text.isNotEmpty &&
                                        feeAmount.text.isNotEmpty) {
                                      context
                                          .read<AdminSettingBloc>()
                                          .add(ASCreateSession(params));
                                    } else {
                                      AppHelperCommon().showAlert(
                                        context: context,
                                        title: 'Error',
                                        content:
                                            'Please fill all required field!',
                                        okOnly: true,
                                        onTapOk: (c) {},
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
