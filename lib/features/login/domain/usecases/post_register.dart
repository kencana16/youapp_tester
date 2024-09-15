import 'package:youapp_tester/features/login/domain/repositories/login_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../base/usecase.dart';
import '../entities/register_dto.dart';

@injectable
class PostRegister extends UseCaseAsync<bool, RegisterDto> {
  final LoginRepository _loginRepository;

  PostRegister(this._loginRepository);

  @override
  Future<bool> call(RegisterDto dto) => _loginRepository.register(dto);
}
