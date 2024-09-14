import 'package:youapp_tester/base/usecase.dart';
import 'package:collection/collection.dart';
import 'package:youapp_tester/features/zodiac/data/datasources/zodiac_data.dart';
import 'package:youapp_tester/features/zodiac/domain/entities/zodiac.dart';

class GetZodiac extends UseCase<Zodiac?, DateTime> {
  @override
  Future<Zodiac?> call(DateTime params) async {
    // Reset hour,min,etc
    params = DateTime(
      params.year,
      params.month,
      params.day,
    );

    return LIST_ZODIAC_DATA
        .firstWhereOrNull((element) =>
            (params.isAtSameMomentAs(element.start) ||
                params.isAfter(element.start)) &&
            (params.isAtSameMomentAs(element.end) ||
                params.isBefore(element.end)))
        ?.zodiac;
  }
}
