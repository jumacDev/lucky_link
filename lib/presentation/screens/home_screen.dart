import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import '/presentation/bloc/blocs.dart';
import '/presentation/pages/pages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int vnIndex = 0;
  late HistorialBloc _histoBloc;
  late LoginBloc _loginBloc;
  late ResultadosBloc _resulBloc;
  late VentaBloc _ventaBloc;
  late int _vnUsuaId;

  @override
  void initState() {
    super.initState();
    _loginBloc = context.read<LoginBloc>();
    _histoBloc = context.read<HistorialBloc>();
    _ventaBloc = context.read<VentaBloc>();
    _resulBloc = context.read<ResultadosBloc>();
    var state = context.read<LoginBloc>().state;
    if(state is LoginOk){
      _vnUsuaId = state.voSesion.vnUsuario;
    }
  }

  _onCerrarSesion(){
    _loginBloc.add(LogOutPress());
    _ventaBloc.add(LogOutVenta());
    _histoBloc.add(LogOutHisto());
    _resulBloc.add(LogOutResul());
  }

  @override
  Widget build(BuildContext context) {

    int vnUsuaId = _vnUsuaId;
    List<Widget> pages = [
      const SalePage(),
      HistoPage(vnUsuaId: vnUsuaId),
      const ResultPage()
    ];

    List<String> vcTitle = ['Venta', 'Historial', 'Resultados'];

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if(state is LoginOk){
          _vnUsuaId = state.voSesion.vnUsuario;
          setState(() { });
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              vcTitle[vnIndex],
              style: GoogleFonts.openSans(fontSize: 20, color: Colors.white),
            ),
            backgroundColor: Colors.lightGreen,
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    _onCerrarSesion();
                    context.pushReplacement('/login');
                  },
                  icon: const Icon(
                    Icons.logout_outlined,
                    size: 35,
                    color: Colors.white,
                  ))
            ],
          ),
          bottomNavigationBar: CustomLineIndicatorBottomNavbar(
            selectedColor: Colors.white,
            unSelectedColor: Colors.grey.shade100,
            unselectedFontSize: 15,
            selectedFontSize: 18,
            backgroundColor: Colors.lightGreen,
            currentIndex: vnIndex,
            unselectedIconSize: 25,
            selectedIconSize: 30,
            onTap: (index) {
              setState(() {
                vnIndex = index;
              });
            },
            enableLineIndicator: true,
            lineIndicatorWidth: 8,
            indicatorType: IndicatorType.Bottom,
            customBottomBarItems: [
              CustomBottomBarItems(
                label: 'Venta',
                icon: Icons.shopping_bag,
              ),
              CustomBottomBarItems(
                label: 'Historial',
                icon: Icons.history,
              ),
              CustomBottomBarItems(
                  label: 'Resultados', icon: Icons.fact_check_rounded),
            ],
          ),
          body: pages[vnIndex]
      ),
    );
  }
}
