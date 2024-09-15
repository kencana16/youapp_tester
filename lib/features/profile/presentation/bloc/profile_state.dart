part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileFound extends ProfileState {
  final Profile profile;
  const ProfileFound({
    required this.profile,
  });

  ProfileFound copyWith({
    Profile? profile,
  }) {
    return ProfileFound(
      profile: profile ?? this.profile,
    );
  }

  @override
  List<Object> get props => [profile];
}

class ProfileError extends ProfileState {
  final Exception exception;
  const ProfileError({
    required this.exception,
  });

  ProfileError copyWith({
    Exception? exception,
  }) {
    return ProfileError(
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object> get props => [exception];
}
