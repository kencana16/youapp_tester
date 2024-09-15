
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:youapp_tester/features/profile/domain/entities/profile.dart';
import 'package:youapp_tester/features/profile/domain/usecases/get_profile.dart';
import 'package:youapp_tester/features/profile/domain/usecases/update_profile.dart';

import '../../../../base/error/custom_exception.dart';
import '../../../../dependencies.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile _getProfile;
  final UpdateProfile _updateProfile;
  final VoidCallback? revokeAccessToken;

  ProfileBloc({
    this.revokeAccessToken,
    GetProfile? getProfile,
    UpdateProfile? updateProfile,
  })  : _getProfile = getProfile ?? getIt(),
        _updateProfile = updateProfile ?? getIt(),
        super(ProfileInitial()) {
    on<ProfileEventReset>(_reset);
    on<ProfileEventChangeToken>(_getData);
    on<ProfileEventUpdateData>(_updateData);
    on<ProfileEventUpdateInterests>(_updateInterests);
  }

  void _reset(
    ProfileEventReset event,
    Emitter emit,
  ) {
    emit(ProfileInitial());
  }

  Future<void> _getData(
    ProfileEventChangeToken event,
    Emitter emit,
  ) async {
    emit(ProfileLoading());
    await _getProfile.call(event.accessToken).then(
      (value) {
        emit(
          ProfileFound(
            profile: value,
          ),
        );
      },
      onError: (e, s) {
        revokeAccessToken?.call();
        emit(
          ProfileError(
            exception: e,
          ),
        );
      },
    );
  }

  Future<void> _updateData(
    ProfileEventUpdateData event,
    Emitter emit,
  ) async {
    emit(ProfileLoading());
    await _updateProfile
        .call(
      UpdateProfileParam(
        accessToken: event.accessToken,
        profile: event.profile,
      ),
    )
        .then(
      (value) {
        add(ProfileEventChangeToken(accessToken: event.accessToken));
      },
      onError: (e, s) {
        emit(
          ProfileError(
            exception: e,
          ),
        );
      },
    );
  }

  Future<void> _updateInterests(
    ProfileEventUpdateInterests event,
    Emitter emit,
  ) async {
    var state = this.state;
    if (state is ProfileFound) {
      var profile = state.profile.copyWith(interests: event.interests);

      add(
        ProfileEventUpdateData(
            accessToken: event.accessToken, profile: profile),
      );
    } else {
      emit(ProfileError(exception: CustomException("User Belum Login")));
    }
  }
}

sealed class ProfileEvent {}

class ProfileEventReset extends ProfileEvent {}

class ProfileEventChangeToken extends ProfileEvent {
  final String accessToken;

  ProfileEventChangeToken({required this.accessToken});
}

class ProfileEventUpdateData extends ProfileEvent {
  final String accessToken;
  final Profile profile;

  ProfileEventUpdateData({required this.accessToken, required this.profile});
}

class ProfileEventUpdateInterests extends ProfileEvent {
  final String accessToken;
  final List<String> interests;

  ProfileEventUpdateInterests(
      {required this.accessToken, required this.interests});
}
