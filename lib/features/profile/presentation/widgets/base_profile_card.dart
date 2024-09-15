// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:youapp_tester/base/widget/golden_widget.dart';

class ProfileCard extends StatefulWidget {
  String get title => "";

  ValueChanged<ProfileCardState>? get onClickEdit => (ProfileCardState state) {
        state.toogleEditMode();
      };
  ValueChanged<ProfileCardState>? get onClickSave => null;

  Widget child(ProfileCardState state) => const SizedBox.shrink();
  Widget saveWidget(ProfileCardState state) => GoldenWidget(
        child: TextButton(
          onPressed: () => onClickSave?.call(state),
          child: const Text("Save & Update"),
        ),
      );
  Widget changeEditModeWidget(ProfileCardState state) => IconButton(
        visualDensity: VisualDensity.compact,
        onPressed: () => onClickEdit?.call(state),
        icon: const Icon(
          Icons.border_color,
          size: 14,
        ),
        iconSize: 14,
      );

  const ProfileCard({
    super.key,
  });

  @override
  State<ProfileCard> createState() => ProfileCardState();
}

class ProfileCardState extends State<ProfileCard> {
  bool editMode = false;
  void toogleEditMode() {
    if (mounted) {
      setState(() {
        editMode = !editMode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8.0, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(widget.title),
                const Spacer(),
                editMode
                    ? widget.saveWidget(this)
                    : widget.changeEditModeWidget(this),
              ],
            ),
            const Gap(24),
            widget.child(this),
          ],
        ),
      ),
    );
  }
}
