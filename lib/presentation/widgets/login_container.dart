import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vende_bet/presentation/widgets/shared/cool_alert.dart';

import '../bloc/blocs.dart';

class LoginContainer extends StatefulWidget {
  final double width;

  const LoginContainer({super.key, required this.width});

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _obscureText = true;
  late LoginBloc _loginBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = context.read<LoginBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if(state is LoginError) {
          debugPrint(state.vcMensaje);
          showCoolAlert(context, CoolAlertType.error, 'Error de Login', state.vcMensaje);
        }
      },
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20)),
          width: widget.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 16.0, horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Lucky Link',
                  style: GoogleFonts.openSans(
                      fontSize: 25, color: Colors.white),
                ),
                const Gap(16),
                TextFormField(
                  controller: _userController,
                  cursorColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        )),
                  ),
                ),
                const Gap(16),
                TextFormField(
                  controller: _passController,
                  cursorColor: Colors.white,
                  obscureText: _obscureText,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          )),
                      suffixIcon: IconButton(
                        icon: Icon(
                            _obscureText
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash,
                            color: Colors.white),
                        onPressed: () {
                          _obscureText = !_obscureText;
                          setState(() {});
                        },
                      )),
                ),
                const Gap(32),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      );
                    }
                    return ElevatedButton(
                        onPressed: () {
                          _loginBloc.add(LoginPress(
                              vcUser: _userController.text,
                              vcPass: _passController.text));
                        },
                        child: const Text('Ingresar'));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
