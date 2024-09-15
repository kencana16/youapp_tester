import 'package:youapp_tester/features/login/domain/repositories/login_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../base/usecase.dart';

@injectable
class SaveAccessToken extends UseCaseAsync<bool, String> {
  final LoginRepository _loginRepository;

  SaveAccessToken(this._loginRepository);

  @override
  Future<bool> call(String params) => _loginRepository.saveAccessToken(params);
}
