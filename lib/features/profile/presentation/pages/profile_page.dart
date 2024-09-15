import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:youapp_tester/base/widget/you_app_scaffold.dart';
import 'package:youapp_tester/features/login/presentation/cubit/login_cubit.dart';
import 'package:youapp_tester/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:youapp_tester/features/profile/presentation/widgets/profile_widget.dart';

import '../../domain/entities/profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, ProfileState state) {
        switch (state) {
          case ProfileInitial():
          case ProfileLoading():
            EasyLoading.show();
            return;
          case ProfileError():
            EasyLoading.showError(state.exception.toString());
            return;
          case ProfileFound():
            EasyLoading.dismiss();
            return;
        }
      },
      builder: (context, ProfileState state) {
        Profile? profile;
        if (state is ProfileFound) {
          profile = state.profile;
        } else if (state is ProfileInitial || state is ProfileLoading) {
          return const YouAppScaffold(
              body: Center(child: CircularProgressIndicator.adaptive()));
        }
        String? username = profile?.username;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            leading: (GoRouter.of(context).canPop())
                ? InkWell(
                    onTap: () => GoRouter.of(context).pop(),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chevron_left),
                        Text("Back"),
                      ],
                    ),
                  )
                : null,
            title: username != null ? Text("@$username") : null,
            centerTitle: true,
            actions: [
              PopupMenuButton(
                itemBuilder: (_) => <PopupMenuEntry>[
                  PopupMenuItem(
                    child: const Text("Logout"),
                    onTap: () {
                      context.read<LoginCubit>().logout();
                    },
                  )
                ],
              )
            ],
          ),
          body: (profile == null)
              ? const Center(
                  child: Text("Profil Tidak Ditemukan"),
                )
              : ProfileWidget(
                  profile: profile,
                ),
        );
      },
    );
  }
}
