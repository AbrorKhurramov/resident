import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:resident/feature/presentation/bloc/by_biometrics_permission_cubit/by_biometrics_permission_cubit.dart';

class PermissionComponent extends StatefulWidget {
  const PermissionComponent({Key? key}) : super(key: key);

  @override
  State<PermissionComponent> createState() => _PermissionComponentState();
}

class _PermissionComponentState extends State<PermissionComponent> {
  late final AppLocalizations _appLocalization;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;
  }

  void _onPressedPermission(bool permission) {
    if (permission) {
      context.read<ByBiometricsPermissionCubit>().turnOnPermission();
    } else {
      context.read<ByBiometricsPermissionCubit>().turnOffPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ByBiometricsPermissionCubit, bool>(builder: (context, state) {
      return ElevatedButton(
        onPressed: () {
          _onPressedPermission(!state);
        },
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.blue, fixedSize: const Size(double.infinity, 64), backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0),
        child: Padding(
          padding: const EdgeInsets.symmetric( horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  _appLocalization.login_by_biometrics.capitalize(),
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: AppColor.c4000, fontSize: 14.sf(context)),
                  maxLines: 2,
                ),
              ),
              CupertinoSwitch(
                  value: state,
                  onChanged: (changed) {
                    _onPressedPermission(changed);
                  })
            ],
          ),
        ),
      );
    });
  }
}
