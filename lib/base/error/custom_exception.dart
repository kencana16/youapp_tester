import 'package:equatable/equatable.dart';

class CustomException extends Equatable implements Exception {
  final String? message;

  const CustomException([this.message]);

  @override
  String toString() {
    return message ?? "CustomException";
  }

  @override
  List<Object?> get props => [message];
}
