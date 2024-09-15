import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_tester/features/horoscope/domain/entities/horoscope.dart';
import 'package:youapp_tester/features/horoscope/domain/usecases/get_horoscope.dart';

void main() {
  test("must be false when insert data before start date", () async {
    expect(
      GetHoroscope().call(DateTime(2022, 03, 20)) == Horoscope.aries,
      false,
    );
  });
  test("must be correct when insert data on start date", () async {
    expect(
      GetHoroscope().call(DateTime(2022, 03, 21)),
      Horoscope.aries,
    );
  });
  test("must be correct", () async {
    expect(
      GetHoroscope().call(DateTime(2022, 4, 18)),
      Horoscope.aries,
    );
  });
  test("must be correct when insert data on end date", () async {
    expect(
      GetHoroscope().call(DateTime(2023, 4, 19)),
      Horoscope.aries,
    );
  });
  test("must be false when insert data after end date", () async {
    expect(
      GetHoroscope().call(DateTime(2023, 4, 20)) == Horoscope.aries,
      false,
    );
  });
}
