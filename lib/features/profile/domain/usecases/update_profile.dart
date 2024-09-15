// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:youapp_tester/base/usecase.dart';
import 'package:youapp_tester/features/profile/domain/entities/profile.dart';
import 'package:youapp_tester/features/profile/domain/repositories/profile_repository.dart';

@injectable
class UpdateProfile extends UseCaseAsync<bool, UpdateProfileParam> {
  final ProfileRepository _profileRepository;

  UpdateProfile(this._profileRepository);

  @override
  Future<bool> call(UpdateProfileParam param) =>
      _profileRepository.updateProfile(
        param.accessToken,
        param.profile,
      );
}

class UpdateProfileParam extends Equatable {
  final String accessToken;
  final Profile profile;

  const UpdateProfileParam({
    required this.accessToken,
    required this.profile,
  });

  @override
  List<Object> get props => [accessToken, profile];
}
