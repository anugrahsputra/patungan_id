import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
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
  String picUrl = '';
  final AppNavigator navigator = sl<AppNavigator>();
  final AppSettings themeMode = sl<AppSettings>();
  final TextEditingController nameController = TextEditingController();

  saveData(String name, String photoUrl) {
    context.read<AuthCubit>().saveToDatabase(name: name, photoUrl: photoUrl);
  }

  getDefaultPic() async {
    final url = await context.read<AuthCubit>().getDefaultProfilePic();

    setState(() {
      picUrl = url;
    });
  }

  @override
  void initState() {
    getDefaultPic();
    super.initState();
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
        log(picUrl);

        return ScaffoldBuilder(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text(
              'Set up your profile',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: themeMode.isDarkMode() ? Colors.white : Colors.black,
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
                  CircleAvatar(
                    backgroundImage:
                        picUrl.isNotEmpty ? NetworkImage(picUrl) : null,
                    radius: 60,
                  ),
                  const Gap(45),
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
