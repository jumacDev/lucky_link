import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:vende_bet/presentation/pages/pages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int vnIndex = 0;


  @override
  Widget build(BuildContext context) {

    List<Widget> pages = [
      const SalePage(),
      const HistoPage(),
      const ResultPage()
    ];

    List<String> vcTitle = [
      'Venta',
      'Historial',
      'Resultados'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(vcTitle[vnIndex], style: GoogleFonts.openSans(fontSize: 20, color: Colors.white),),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
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
            label: 'Resultados',
            icon: Icons.fact_check_rounded
        ),

      ],
    ),
      body: pages[vnIndex],
    );
  }
}
