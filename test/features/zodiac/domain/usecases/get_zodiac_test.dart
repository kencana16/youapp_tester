import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_tester/features/zodiac/domain/entities/zodiac.dart';
import 'package:youapp_tester/features/zodiac/domain/usecases/get_zodiac.dart';

void main() {
  test("must be false when insert data before start date", () async {
    expect(
        await GetZodiac().call(DateTime(2022, 01, 30)) == Zodiac.tiger, false);
  });
  test("must be correct when insert data on start date", () async {
    expect(
      await GetZodiac().call(DateTime(2022, 02, 01)),
      Zodiac.tiger,
    );
  });
  test("must be correct", () async {
    expect(
      await GetZodiac().call(DateTime(2022, 06, 11)),
      Zodiac.tiger,
    );
  });
  test("must be false when insert data after end date", () async {
    expect(
      await GetZodiac().call(DateTime(2023, 01, 22)) == Zodiac.tiger,
      false,
    );
  });
}
