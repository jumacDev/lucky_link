import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vende_bet/presentation/bloc/blocs.dart';
import '/config/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
      BlocProvider<LoteriaBloc>(create: (context) => LoteriaBloc()),
      BlocProvider<ResultadosBloc>(create: (context) => ResultadosBloc()),
    ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      title: 'Lucky Link',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        primaryColor: Colors.lightGreen,
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.lightGreen, // Cambiar color de los botones
        ),
        colorScheme: const ColorScheme.light(
          surface: Colors.white,
          primary: Colors.lightGreen,
          // Color del header
          onPrimary: Colors.white, // Color del texto en el header
          onSurface: Colors.black, // Color del texto en las fechas
        ),
        dialogBackgroundColor: Colors.white, // Color del fondo del diálogo
      ),
    );
  }
}


