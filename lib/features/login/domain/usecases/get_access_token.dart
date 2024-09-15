import 'package:injectable/injectable.dart';
import 'package:youapp_tester/features/login/domain/repositories/login_repository.dart';

import '../../../../base/usecase.dart';

@injectable
class GetAccessToken extends UseCaseAsync<String?, NoParams> {
  final LoginRepository _loginRepository;

  GetAccessToken(this._loginRepository);

  @override
  Future<String?> call(NoParams params) => _loginRepository.getAccessToken();
}
