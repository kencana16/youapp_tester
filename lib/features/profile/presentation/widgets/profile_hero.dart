import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recase/recase.dart';
import 'package:youapp_tester/features/horoscope/domain/entities/horoscope.dart';
import 'package:youapp_tester/features/profile/domain/entities/profile.dart';
import 'package:youapp_tester/features/zodiac/domain/entities/zodiac.dart';

class ProfileHero extends StatelessWidget {
  const ProfileHero({
    super.key,
    required this.profile,
  });

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    Uint8List? imageBytes = profile.imageBytes;
    String? username = profile.username;
    int? age = profile.age;
    Gender? gender = profile.gender;
    Zodiac? zodiac = profile.zodiac;
    Horoscope? horoscope = profile.horoscope;

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      child: Container(
        color: const Color(0XFF162329),
        height: 190,
        width: double.infinity,
        child: Stack(
          children: [
            if (imageBytes != null)
              Image.memory(
                imageBytes,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.contain,
              )
            else
              Image.network(
                'https://picsum.photos/seed/${profile.name}/400/200',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.contain,
              ),
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [
                    Colors.black12,
                    Colors.black45,
                  ])),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("@$username, ${age ?? ""}"),
                  if (gender != null) Text(gender.name.titleCase),
                  Row(
                    children: [
                      if (zodiac != null) ...[
                        FilterChip.elevated(
                          label: Text(zodiac.name.titleCase),
                          onSelected: (_) {},
                        ),
                        const Gap(4),
                      ],
                      if (horoscope != null)
                        FilterChip.elevated(
                          label: Text(horoscope.name.titleCase),
                          onSelected: (_) {},
                        )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
