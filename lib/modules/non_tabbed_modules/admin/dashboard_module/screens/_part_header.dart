import 'package:flutter/material.dart';
import 'package:housing_management_mobile/config/assets.dart';

import '../../../../../shared/utils/helper/helper_storage.dart';

class ModuleAdminDashboardHeader extends StatefulWidget {
  const ModuleAdminDashboardHeader({super.key});

  @override
  State<StatefulWidget> createState() => _ModuleAdminDashboardHeader();
}

class _ModuleAdminDashboardHeader extends State<ModuleAdminDashboardHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          text: const TextSpan(
            text: 'Hi, John doe\n',
            style: TextStyle(
              fontSize: 20,
            ),
            children: [
              TextSpan(
                text: 'as Admin',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
        //
        GestureDetector(
          onTap: () async {
            await AppHelperStorage().clear();
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(300),
            child: Image.asset(
              AppAsset.avatar,
              width: 64,
            ),
          ),
        ),
      ],
    );
  }
}
