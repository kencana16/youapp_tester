import 'package:youapp_tester/base/usecase.dart';
import 'package:collection/collection.dart';
import 'package:youapp_tester/features/zodiac/data/datasources/zodiac_data.dart';
import 'package:youapp_tester/features/zodiac/domain/entities/zodiac.dart';

class GetZodiac extends UseCase<Zodiac?, DateTime> {
  @override
  Zodiac? call(DateTime params) {
    // Reset hour,min,etc
    params = DateTime(
      params.year,
      params.month,
      params.day,
    );

    return LIST_ZODIAC_DATA.firstWhereOrNull((element) {
      var atSameMomentAs = params.isAtSameMomentAs(element.start);
      var after = params.isAfter(element.start);
      var atSameMomentAs2 = params.isAtSameMomentAs(element.end);
      var before = params.isBefore(element.end);
      return (atSameMomentAs || after) && (atSameMomentAs2 || before);
    })?.zodiac;
  }
}
