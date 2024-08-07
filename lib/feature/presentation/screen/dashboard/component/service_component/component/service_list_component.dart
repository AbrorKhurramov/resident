import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';

class ServiceListComponent extends StatefulWidget {
  const ServiceListComponent({Key? key}) : super(key: key);
  
  @override
  State<ServiceListComponent> createState() => _ServiceListComponentState();
}

class _ServiceListComponentState extends State<ServiceListComponent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _initItem(index,state.servicesList?[index]);
        },
        separatorBuilder: (context, index) {
          return AppDimension.verticalSize_24;
        },
        itemCount: state.servicesList?.length??0);
  },
);
  }

  Widget _initItem(int index,MerchantResponse? resp) {

     String iconPath = resp?.type=="Sport"?'assets/icons/gym.svg': 'assets/icons/baby.svg';


    return Container(
      width: AppConfig.screenWidth(context),
      height: 148,
      padding: const EdgeInsets.all(20),
      decoration:  BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
              resp?.imageFile.path??"",
            ),
            fit: BoxFit.cover),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
         SvgPicture.asset(iconPath),
          const Spacer(),
          Text(
            resp?.name.uz??"",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 24, color: Colors.white),
          )
        ],
      ),
    );
  }
}
