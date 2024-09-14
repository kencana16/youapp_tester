import 'package:youapp_tester/base/usecase.dart';
import 'package:collection/collection.dart';
import 'package:youapp_tester/features/horoscope/domain/entities/horoscope.dart';
import 'package:youapp_tester/features/horoscope/data/datasources/horoscope_data.dart';

class GetHoroscope extends UseCase<Horoscope?, DateTime> {
  @override
  Future<Horoscope?> call(DateTime params) async {
    // Reset hour,min,etc
    params = DateTime(
      2024,
      params.month,
      params.day,
    );

    return LIST_HOROSCOPE_DATA
        .firstWhereOrNull((element) =>
            (params
                    .copyWith(year: 2024)
                    .isAtSameMomentAs(element.start.copyWith(year: 2024)) ||
                params
                    .copyWith(year: 2024)
                    .isAfter(element.start.copyWith(year: 2024))) &&
            (params
                    .copyWith(year: 2024)
                    .isAtSameMomentAs(element.end.copyWith(year: 2024)) ||
                params
                    .copyWith(year: 2024)
                    .isBefore(element.end.copyWith(year: 2024))))
        ?.horoscope;
  }
}
