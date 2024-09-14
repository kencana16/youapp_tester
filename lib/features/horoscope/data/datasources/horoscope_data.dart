import 'package:youapp_tester/features/horoscope/domain/entities/horoscope.dart';

class HoroscopeData {
  final DateTime start;
  final DateTime end;
  final Horoscope horoscope;

  const HoroscopeData({
    required this.start,
    required this.end,
    required this.horoscope,
  });
}

final List<HoroscopeData> LIST_HOROSCOPE_DATA = [
  HoroscopeData(
    start: DateTime(2024, 3, 21),
    end: DateTime(2024, 4, 19),
    horoscope: Horoscope.aries,
  ),
  HoroscopeData(
    start: DateTime(2024, 4, 20),
    end: DateTime(2024, 5, 20),
    horoscope: Horoscope.taurus,
  ),
  HoroscopeData(
    start: DateTime(2024, 5, 21),
    end: DateTime(2024, 6, 21),
    horoscope: Horoscope.gemini,
  ),
  HoroscopeData(
    start: DateTime(2024, 6, 22),
    end: DateTime(2024, 7, 22),
    horoscope: Horoscope.cancer,
  ),
  HoroscopeData(
    start: DateTime(2024, 7, 23),
    end: DateTime(2024, 8, 22),
    horoscope: Horoscope.leo,
  ),
  HoroscopeData(
    start: DateTime(2024, 8, 23),
    end: DateTime(2024, 9, 22),
    horoscope: Horoscope.virgo,
  ),
  HoroscopeData(
    start: DateTime(2024, 9, 23),
    end: DateTime(2024, 10, 23),
    horoscope: Horoscope.libra,
  ),
  HoroscopeData(
    start: DateTime(2024, 10, 24),
    end: DateTime(2024, 11, 21),
    horoscope: Horoscope.scorpius,
  ),
  HoroscopeData(
    start: DateTime(2024, 11, 22),
    end: DateTime(2024, 12, 21),
    horoscope: Horoscope.sagittarius,
  ),
  HoroscopeData(
    start: DateTime(2024, 12, 22),
    end: DateTime(2024, 1, 19),
    horoscope: Horoscope.capricornus,
  ),
  HoroscopeData(
    start: DateTime(2024, 1, 20),
    end: DateTime(2024, 2, 18),
    horoscope: Horoscope.aquarius,
  ),
  HoroscopeData(
    start: DateTime(2024, 2, 19),
    end: DateTime(2024, 3, 20),
    horoscope: Horoscope.pisces,
  ),
];
