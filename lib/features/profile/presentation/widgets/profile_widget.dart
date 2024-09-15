import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:youapp_tester/features/profile/domain/entities/profile.dart';
import 'package:youapp_tester/features/profile/presentation/widgets/about_card.dart';
import 'package:youapp_tester/features/profile/presentation/widgets/interest_card.dart';
import 'package:youapp_tester/features/profile/presentation/widgets/profile_hero.dart';

class ProfileWidget extends StatelessWidget {
  final Profile profile;

  const ProfileWidget({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    Profile? profile = this.profile;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          ProfileHero(
            profile: profile,
          ),
          const Gap(24),
          AboutCard(
            profile: profile,
          ),
          InterestCard(profile: profile)
        ],
      ),
    );
  }
}
