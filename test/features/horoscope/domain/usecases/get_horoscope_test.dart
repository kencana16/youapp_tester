import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_tester/features/horoscope/domain/entities/horoscope.dart';
import 'package:youapp_tester/features/horoscope/domain/usecases/get_horoscope.dart';

void main() {
  test("must be correct when insert data on start date", () async {
    expect(
      await GetHoroscope().call(DateTime(2022, 02, 01)),
      Horoscope.tiger,
    );
  });
    test("must be correct", () async {
    expect(
      await GetHoroscope().call( DateTime(2022, 06, 11)),
      Horoscope.tiger,
    );
  });
  test("must be correct when insert data on end date", () async {
    expect(
      await GetHoroscope().call( DateTime(2023, 01, 21)),
      Horoscope.tiger,
    );
  });
}
