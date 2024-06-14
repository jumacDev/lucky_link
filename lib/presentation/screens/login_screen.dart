import 'package:flutter/material.dart';
import 'package:vende_bet/presentation/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Responsive(
        mobile: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 300),
              child: LoginContainer(width: 250)),
        ),
        tablet: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 300),
            child: LoginContainer(width: 450),
          ),
        ),
        desktop: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 180),
            child: LoginContainer(width: 400),
          ),
        ),
      ),
    );
  }
}
