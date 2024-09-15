// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:youapp_tester/features/profile/domain/entities/profile.dart';
import 'package:youapp_tester/features/profile/presentation/widgets/base_profile_card.dart';
import 'package:youapp_tester/routing/app_router.dart';

class InterestCard extends ProfileCard {
  final Profile? profile;
  const InterestCard({
    super.key,
    required this.profile,
  });

  @override
  String get title => "Interest";

  @override
  ValueChanged<ProfileCardState>? get onClickEdit => (ProfileCardState state) {
        const InterestFormRoute().push(state.context);
      };

  @override
  Widget child(ProfileCardState state) {
    List<String>? interests = profile?.interests;

    if (interests == null || interests.isEmpty) {
      return Text(
        "Add in your interest to find a better match",
        style: Theme.of(state.context).textTheme.labelSmall?.copyWith(
            color: Theme.of(state.context)
                .textTheme
                .labelSmall
                ?.color
                ?.withOpacity(.5)),
      );
    }
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: interests.map((e) => InputChip(label: Text(e))).toList(),
    );
  }
}
