import 'package:youapp_tester/features/login/domain/entities/login_dto.dart';
import 'package:youapp_tester/features/login/domain/repositories/login_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../base/usecase.dart';

@injectable
class PostLogin extends UseCaseAsync<String, LoginDto> {
  final LoginRepository _loginRepository;

  PostLogin(this._loginRepository);

  @override
  Future<String> call(LoginDto dto) => _loginRepository.login(dto);
}
