import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/size_extension.dart';

import '../../../../../../data/data_source/remote_source/app_remote_source.dart';

class UserInfoComponent extends StatelessWidget {
  const UserInfoComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppCubit, AppState, UserInfoState>(selector: (state) {
      return UserInfoState(firstName: state.user!.firstName, lastName: state.user!.lastName, logo: state.user!.logo);
    }, builder: (context, state) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${state.firstName}\n${state.lastName}',
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: AppColor.c4000, fontSize: 18.sf(context), letterSpacing: 0.6),
          ),
          state.logo != null
              ? CachedNetworkImage(
                  imageBuilder: (context, imageProvider) => Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  imageUrl:  '${AppRemoteSourceImpl.BASE_URL}/file/download/${state.logo!.guid}.${state.logo!.extension}',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black.withOpacity(0.1), width: 0.5),
                    ),
                    child: ClipOval(
                      child: SvgPicture.asset('assets/icons/avatar_default.svg', fit: BoxFit.cover),
                    ),
                  ),
                )
              : Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black.withOpacity(0.1), width: 0.5),
                  ),
                  child: ClipOval(
                    child: SvgPicture.asset('assets/icons/avatar_default.svg', fit: BoxFit.cover),
                  ),
                ),
        ],
      );
    });
  }
}

class UserInfoState extends Equatable {
  final String firstName;
  final String lastName;
  final ImageFile? logo;

  const UserInfoState({required this.firstName, required this.lastName, this.logo});

  UserInfoState copyWith({String? firstName, String? lastName, ImageFile? logo}) {
    return UserInfoState(
        firstName: firstName ?? this.firstName, lastName: lastName ?? this.lastName, logo: logo ?? this.logo);
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        logo,
      ];
}
