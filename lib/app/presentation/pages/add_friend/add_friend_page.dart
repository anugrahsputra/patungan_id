import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../../injection.dart';
import '../../presentation.dart';

class AddFriendPage extends StatefulWidget {
  const AddFriendPage({super.key, required this.friendId});

  final String friendId;

  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  final AppNavigator navigate = sl<AppNavigator>();

  @override
  Widget build(BuildContext context) {
    context.read<DetailUserCubit>().getUser(widget.friendId);
    return BlocListener<DetailUserCubit, DetailUserState>(
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
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(user!.profilePic),
                      ),
                      Text(user.name),
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
