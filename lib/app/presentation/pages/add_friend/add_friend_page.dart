import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../../injection.dart';
import '../../presentation.dart';

part 'add_friend_page.component.dart';

class AddFriendPage extends StatefulWidget {
  const AddFriendPage({super.key, required this.friendId});

  final String friendId;

  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  final AppNavigator navigate = sl<AppNavigator>();
  final AppSettings appSettings = sl<AppSettings>();
  final FriendRequestCubit friendRequestCubit = sl<FriendRequestCubit>();

  @override
  Widget build(BuildContext context) {
    context.read<DetailUserCubit>().getUser(widget.friendId);
    return MultiBlocListener(
      listeners: [
        BlocListener<DetailUserCubit, DetailUserState>(
          listener: (context, state) {
            state.when(
              initial: () {},
              loading: () {},
              loaded: (user) {},
              error: (message) {
                navigate.notFound(context);
                log(message);
              },
            );
          },
        ),
        BlocListener<FriendRequestCubit, FriendRequestState>(
          listener: (context, state) {
            state.whenOrNull(
              error: (message) {
                log(message);
                showAdaptiveDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('did you forget?'),
                      content: const SizedBox(
                        height: 200,
                        child: Center(
                          child: Text('You already sent it!'),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            navigate.goToSplah(context);
                          },
                          child: const Text('Go Back'),
                        ),
                      ],
                    );
                  },
                );
              },
              sendFriendReq: () {
                log('sent');
                showAdaptiveDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        title: Text('Friend request sent!'),
                        content: SizedBox(
                          height: 200,
                          child: Center(child: Text('Friend request sent!')),
                        ),
                      );
                    });

                Future.delayed(const Duration(seconds: 3))
                    .then((value) => navigate.goToSplah(context));
              },
            );
          },
        ),
      ],
      child: ScaffoldBuilder(
        appBar: const DefaultAppBar(
          title: Text('Add to friend list'),
        ),
        body: BlocBuilder<DetailUserCubit, DetailUserState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => const Center(
                child: Text('Loading...'),
              ),
              loaded: (userEntity) {
                UserEntity? user = userEntity;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FriendView(user: user!),
                      const Gap(10),
                      DefaultButton(
                        onTap: () {
                          context.read<FriendRequestCubit>().addFriend(user.id);
                        },
                        text: 'Add',
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
