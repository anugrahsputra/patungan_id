import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/core.dart';
import '../../../injection.dart';
import '../../presentation.dart';

class SetupProfilePage extends StatefulWidget {
  const SetupProfilePage({super.key});

  @override
  State<SetupProfilePage> createState() => _SetupProfilePageState();
}

class _SetupProfilePageState extends State<SetupProfilePage> {
  final AppNavigator navigator = sl<AppNavigator>();
  final TextEditingController nameController = TextEditingController();

  saveData(String name, String photoUrl) {
    context.read<AuthCubit>().saveToDatabase(name: name, photoUrl: photoUrl);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          success: () => navigator.goToHome(context),
          error: (_) {},
          otpResent: () {},
        );
      },
      builder: (context, state) {
        final url = context.read<AuthCubit>().getDefaultProfilePic();

        return ScaffoldBuilder(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            title: Text(
              'Set up your profile',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          extendBodyBehindAppBar: true,
          onThemeModeChange: (_) => setState(() {}),
          body: Align(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 1.4,
              margin: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 96,
              ),
              padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60,
                  ),
                  const SizedBox(height: 45),
                  DefaultTextField(
                    controller: nameController,
                    hintText: "What should we call you?",
                  ),
                  const SizedBox(height: 23),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'It will be shown in your profile',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 97,
                        child: DefaultButton(
                          onTap: () async {
                            if (nameController.text.isNotEmpty) {
                              String picUrl = await url;
                              saveData(nameController.text, picUrl);
                            }
                            log('name cannot be emtpy');
                          },
                          text: 'Ok',
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
