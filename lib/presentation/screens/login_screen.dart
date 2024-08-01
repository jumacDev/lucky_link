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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Responsive(
        mobile: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: size.height < 500? 100 :
            size.height < 600? 150 :
            size.height > 800? 300 : 200),
              child: const LoginContainer(width: 250)),
        ),
        tablet: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 300),
            child: LoginContainer(width: 450),
          ),
        ),
        desktop: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 180),
            child: LoginContainer(width: 400),
          ),
        ),
      ),
    );
  }
}
