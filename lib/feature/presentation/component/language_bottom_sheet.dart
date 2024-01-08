import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/size_extension.dart';

class LanguageBottomSheet extends StatefulWidget {

  const LanguageBottomSheet({Key? key}) : super(key: key);

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  late AppLocalizations _appLocalization;

  @override
  Widget build(BuildContext context) {
    _appLocalization = AppLocalizations.of(context)!;
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/icons/modal_bottom_top_line.svg'),
              AppDimension.verticalSize_16,
              Text(
                _appLocalization.select_language.capitalize(),
                style: Theme
                    .of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: AppColor.c4000, fontSize: 17.sf(context)),
              ),
              const SizedBox(height: 40),
              const Divider(thickness: 1, color: AppColor.c40000),
              _initRowItem(
                  _appLocalization.en.capitalize(),LanguageConst.english, LanguageConst.english == state.languageCode
              ),
              const Divider(thickness: 1, color: AppColor.c40000),
              _initRowItem(
                  _appLocalization.ru.capitalize(),LanguageConst.russian, LanguageConst.russian == state.languageCode
              ), const Divider(thickness: 1, color: AppColor.c40000),
              _initRowItem(
                  _appLocalization.uz.capitalize(), LanguageConst.uzbek,LanguageConst.uzbek == state.languageCode
              ),
              const Divider(thickness: 1, color: AppColor.c40000),
              AppDimension.verticalSize_24,
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(_appLocalization.close.toUpperCase(),style: TextStyle(fontSize: 14.sf(context)),))
            ],
          ),
        );
      },
    );
  }

  Widget _initRowItem(String label, String languageCode, bool isChosen) {
    return InkWell(
      onTap: (){
        print("Edit");
        context.read<LanguageCubit>().changeLanguage(languageCode);
      },
      child: SizedBox(
        height: 56,
        child: Row(
          children: [
            Text(
              label,
              style: Theme
                  .of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: AppColor.c3000, fontSize: 13.sf(context)),
            ),
            const Spacer(),
            if(isChosen) const Icon(Icons.check_circle, color: Colors.blue)
          ],
        ),
      ),
    );
  }

}
