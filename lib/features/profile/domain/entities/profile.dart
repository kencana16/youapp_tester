// ignore_for_file: public_member_api_docs, sort_constructors_first, empty_catches

import 'dart:convert';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youapp_tester/features/horoscope/domain/entities/horoscope.dart';
import 'package:youapp_tester/features/horoscope/domain/usecases/get_horoscope.dart';
import 'package:youapp_tester/features/zodiac/domain/entities/zodiac.dart';
import 'package:youapp_tester/features/zodiac/domain/usecases/get_zodiac.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

enum Gender {
  male,
  female,
}

class Uint8ListJsonConverter implements JsonConverter<Uint8List, String> {
  const Uint8ListJsonConverter();

  @override
  Uint8List fromJson(String json) {
    return base64Decode(json); // Convert from base64 string to Uint8List
  }

  @override
  String toJson(Uint8List object) {
    return base64Encode(object); // Convert from Uint8List to base64 string
  }
}

@Freezed()
class Profile with _$Profile {
  // Added constructor. Must not have any parameter
  const Profile._();

  const factory Profile({
    @Uint8ListJsonConverter() Uint8List? imageBytes,
    String? email,
    String? username,
    String? imageUrl,
    Gender? gender,
    String? name,
    DateTime? birthday,
    double? height,
    double? weight,
    List<String>? interests,
  }) = _Profile;

  factory Profile.fromJson(Map<String, Object?> json) =>
      _$ProfileFromJson(json);

  int? get age {
    var birthday = this.birthday;
    return birthday == null
        ? null
        : (DateTime.now().difference(birthday).inDays / 360).floor();
  }

  Zodiac? get zodiac {
    var birthday = this.birthday;
    return birthday == null ? null : GetZodiac().call(birthday);
  }

  Horoscope? get horoscope {
    var birthday = this.birthday;
    return birthday == null ? null : GetHoroscope().call(birthday);
  }
}

// class Profile extends Equatable {
//   final String? email;
//   final String? username;

//   final Uint8List? imageBytes;
//   final Gender? gender;
//   final String? name;
//   final DateTime? birthday;
//   final double? height;
//   final double? weight;
//   final List<String>? interests;

//   const Profile({
//     this.email,
//     this.username,
//     this.imageBytes,
//     this.gender,
//     this.name,
//     this.birthday,
//     this.height,
//     this.weight,
//     this.interests,
//   });

//   int? get age {
//     var birthday = this.birthday;
//     return birthday == null
//         ? null
//         : (DateTime.now().difference(birthday).inDays / 360).floor();
//   }

//   Zodiac? get zodiac {
//     var birthday = this.birthday;
//     return birthday == null ? null : GetZodiac().call(birthday);
//   }

//   Horoscope? get horoscope {
//     var birthday = this.birthday;
//     return birthday == null ? null : GetHoroscope().call(birthday);
//   }

//   Profile copyWith({
//     String? email,
//     String? username,
//     Uint8List? imageBytes,
//     Gender? gender,
//     String? name,
//     DateTime? birthday,
//     double? height,
//     double? weight,
//     List<String>? interests,
//   }) {
//     return Profile(
//       email: email ?? this.email,
//       username: username ?? this.username,
//       imageBytes: imageBytes ?? this.imageBytes,
//       gender: gender ?? this.gender,
//       name: name ?? this.name,
//       birthday: birthday ?? this.birthday,
//       height: height ?? this.height,
//       weight: weight ?? this.weight,
//       interests: interests ?? this.interests,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'email': email,
//       'username': username,
//       'imageBytes': imageBytes?.toList(),
//       'gender': gender?.name,
//       'name': name,
//       'birthday': birthday?.millisecondsSinceEpoch,
//       'height': height,
//       'weight': weight,
//       'interests': interests,
//     };
//   }

//   factory Profile.fromMap(Map<String, dynamic> map) {
//     Gender? gender;
//     try {
//       Gender.values.byName(map['gender']);
//     } catch (e) {}

//     return Profile(
//       email: map['email'] != null ? map['email'] as String : null,
//       username: map['username'] != null ? map['username'] as String : null,
//       imageBytes: map['imageBytes'] != null
//           ? Uint8List.fromList(map['imageBytes'])
//           : null,
//       gender: gender,
//       name: map['name'] != null ? map['name'] as String : null,
//       birthday: map['birthday'] != null
//           ? DateTime.fromMillisecondsSinceEpoch(map['birthday'] as int)
//           : null,
//       height: map['height'] != null ? map['height'] as double : null,
//       weight: map['weight'] != null ? map['weight'] as double : null,
//       interests: map['interests'] != null
//           ? List<String>.from((map['interests'] as List<String>))
//           : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Profile.fromJson(String source) =>
//       Profile.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   bool get stringify => true;

//   @override
//   List<Object?> get props {
//     return [
//       email,
//       username,
//       imageBytes,
//       gender,
//       zodiac,
//       horoscope,
//       name,
//       birthday,
//       height,
//       weight,
//       interests,
//     ];
//   }
// }
