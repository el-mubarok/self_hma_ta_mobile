import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:housing_management_mobile/config/assets.dart';
import 'package:housing_management_mobile/config/routes/route_names.dart';
import 'package:housing_management_mobile/shared/models/shared_user_data_model.dart';
import 'package:housing_management_mobile/shared/utils/extension/extension_string_caiptalize.dart';
import 'package:housing_management_mobile/shared/utils/utils_global.dart';

import '../../../../../shared/utils/helper/helper_storage.dart';

class ModuleUserDashboardHeader extends StatefulWidget {
  const ModuleUserDashboardHeader({super.key});

  @override
  State<StatefulWidget> createState() => _ModuleUserDashboardHeader();
}

class _ModuleUserDashboardHeader extends State<ModuleUserDashboardHeader> {
  SharedUserData? user;

  @override
  void initState() {
    super.initState();

    user = AppUtilsGlobal().userData.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(300),
          child: Image.asset(
            AppAsset.avatar,
            width: 48,
          ),
        ),
        //
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 32),
            child: Text(
              'Hi, ${user?.data.fullName.toString().toCapitalizeEachWordCase()}',
              maxLines: 1,
              softWrap: false,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Source Sans 3',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        //
        // GestureDetector(
        //   onTap: () async {
        //     AppHelperStorage().clear().then((value) {
        //       Navigator.pushNamedAndRemoveUntil(
        //         context,
        //         NamedRoute.moduleLogin,
        //         (route) => false,
        //       );
        //     });
        //   },
        //   child: const Icon(
        //     BootstrapIcons.box_arrow_left,
        //   ),
        // ),
        GestureDetector(
          onTap: () async {
            Navigator.pushNamed(
              context,
              NamedRoute.moduleUserSetting,
            );
          },
          child: const Icon(
            BootstrapIcons.gear_fill,
          ),
        ),
      ],
    );
  }
}
