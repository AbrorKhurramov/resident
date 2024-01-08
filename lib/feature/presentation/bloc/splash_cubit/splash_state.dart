
import 'package:equatable/equatable.dart';

import '../../../../core/enum/state_status.dart';
import '../../../../core/error/failure.dart';

class SplashState extends Equatable{
 final bool isForceUpdate;
 final Failure? failure;
 final StateStatus stateStatus;

 const SplashState({required this.isForceUpdate, this.failure,required this.stateStatus});


 SplashState copyWith(
     {StateStatus? stateStatus,
      bool? isForceUpdate,
      Failure? failure}) {
  return SplashState(
      stateStatus: stateStatus ?? this.stateStatus,
      isForceUpdate: isForceUpdate ?? this.isForceUpdate,
      failure: failure);
 }



 @override
 List<Object?> get props => [isForceUpdate,stateStatus,failure];

}

