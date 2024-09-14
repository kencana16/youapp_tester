import 'package:youapp_tester/base/usecase.dart';
import 'package:collection/collection.dart';
import 'package:youapp_tester/features/horoscope/domain/entities/horoscope.dart';
import 'package:youapp_tester/features/horoscope/data/datasources/horoscope_data.dart';

class GetHoroscope extends UseCase<Horoscope?, DateTime> {
  @override
  Future<Horoscope?> call(DateTime params) async {
    // Reset hour,min,etc
    params = DateTime(
      params.year,
      params.month,
      params.day,
    );

    return LIST_HOROSCOPE_DATA
        .firstWhereOrNull((element) =>
            (params.isAtSameMomentAs(element.start) ||
                params.isAfter(element.start)) &&
            (params.isAtSameMomentAs(element.end) || params.isBefore(element.end)))
        ?.horoscope;
  }
}
