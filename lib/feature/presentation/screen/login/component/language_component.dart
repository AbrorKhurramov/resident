import 'package:resident/app_package/core_package.dart';
import 'package:resident/core/extension/size_extension.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';

class LanguageComponent extends StatefulWidget {
  const LanguageComponent({Key? key}) : super(key: key);

  @override
  State<LanguageComponent> createState() => _LanguageComponentState();
}

class _LanguageComponentState extends State<LanguageComponent> {
  late AppLocalizations _appLocalization;

  @override
  Widget build(BuildContext context) {
    _appLocalization = AppLocalizations.of(context)!;
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 40, right: 20),
          child: state.isOpen
              ? AnimatedContainer(
                  duration: const Duration(seconds: 300),
                  child: Container(
                    width: 48,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(100)),
                        border: Border.all(color: Colors.white.withOpacity(0.5)),
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _initLanguageItem(_appLocalization.russian, LanguageConst.russian,
                            LanguageConst.russian == state.languageCode),
                        _initLanguageItem(
                            _appLocalization.uzbek, LanguageConst.uzbek, LanguageConst.uzbek == state.languageCode),
                        _initLanguageItem(_appLocalization.english, LanguageConst.english,
                            LanguageConst.english == state.languageCode),
                      ],
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    context.read<LanguageCubit>().changeIsOpen(true);
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white)),
                    child: Center(
                      child: Text(
                        _getDefaultLanguageLabel(state.languageCode),
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.white, fontSize: 12.sf(context)),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }

  _getDefaultLanguageLabel(String sysLang) {
    switch (sysLang) {
      case LanguageConst.english:
        return _appLocalization.english;
      case LanguageConst.russian:
        return _appLocalization.russian;
      default:
        return _appLocalization.uzbek;
    }
  }

  _initLanguageItem(String title, String languageCode, bool isChosen) {
    return TextButton(
      onPressed: () {
        context.read<LanguageCubit>().changeLanguage(languageCode);
      },
      child: Text(
        title,
        style: isChosen
            ? Theme.of(context).textTheme.displaySmall!.copyWith(color: AppColor.c4000, fontSize: 12.sf(context))
            : Theme.of(context).textTheme.headlineMedium!.copyWith(color: AppColor.c3000, fontSize: 12.sf(context)),
      ),
    );
  }
}
