import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '/presentation/widgets/shared/cool_alert.dart';
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
  late LoteriaBloc _loteriaBloc;

  _onTapOutside(pointer){
    final FocusScopeNode focus = FocusScope.of(context);
    if (!focus.hasPrimaryFocus && focus.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = context.read<LoginBloc>();
    _loteriaBloc = context.read<LoteriaBloc>();
    _loteriaBloc.add(ObtenerLoteria());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if(state is LoginError) {
          debugPrint(state.vcMensaje);
          showCoolAlert(context, CoolAlertType.error, 'Error de Login', state.vcMensaje);
        } else if(state is LoginOk){
          context.pushReplacement('/');
        }
      },
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.lightGreen,
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
                      fontSize: 23, color: Colors.white),
                ),
                const Gap(8),
                Text('1.0.2',style: GoogleFonts.openSans(
                    fontSize: 14, color: Colors.white),),
                const Gap(16),
                TextFormField(
                  controller: _userController,
                  cursorColor: Colors.white,
                  onTapOutside: _onTapOutside,
                  textInputAction: TextInputAction.next,
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
                  onTapOutside: _onTapOutside,
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
                const Gap(24),
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
                          if(_userController.text.isNotEmpty && _passController.text.isNotEmpty){
                            _loginBloc.add(LoginPress(
                                vcUser: _userController.text,
                                vcPass: _passController.text));
                          }else{
                            showCoolAlert(context, CoolAlertType.warning, 'Cuidado', 'Alguno de los campos está vacío');
                          }
                        },
                        child: const Text('Ingresar', style: TextStyle(color: Colors.lightGreen),));
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
