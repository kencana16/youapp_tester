import 'package:injectable/injectable.dart';
import 'package:youapp_tester/base/usecase.dart';
import 'package:youapp_tester/features/profile/domain/entities/profile.dart';
import 'package:youapp_tester/features/profile/domain/repositories/profile_repository.dart';

@injectable
class GetProfile extends UseCaseAsync<Profile?, String> {
  final ProfileRepository _profileRepository;

  GetProfile(this._profileRepository);

  @override
  Future<Profile?> call(String accessToken) =>
      _profileRepository.getProfile(accessToken);
}
