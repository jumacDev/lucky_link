import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vende_bet/presentation/pages/sell_page.dart';

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
      const SellPage()
    ];

    List<String> vcTitle = [
      'Venta'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(vcTitle[vnIndex], style: GoogleFonts.openSans(fontSize: 20, color: Colors.white),),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
      ),
      bottomNavigationBar: CustomLineIndicatorBottomNavbar(
      selectedColor: Colors.white,
      unSelectedColor: Colors.grey,
      backgroundColor: Colors.lightGreen,
      currentIndex: vnIndex,
      unselectedIconSize: 15,
      selectedIconSize: 20,
      onTap: (index) {
        setState(() {
          vnIndex = index;
        });
      },
      enableLineIndicator: true,
      lineIndicatorWidth: 2,
      indicatorType: IndicatorType.Bottom,
      customBottomBarItems: [
        CustomBottomBarItems(
          label: 'Home',
          icon: Icons.home,
        ),
        CustomBottomBarItems(
          label: 'Account',
          icon: Icons.account_box_outlined,
        ),
        CustomBottomBarItems(
            label: 'Leaves', icon: Icons.calendar_today_outlined),
        CustomBottomBarItems(
          label: 'Loyalty',
          icon: Icons.card_giftcard_rounded,
        ),
        CustomBottomBarItems(
          label: 'Requests',
          icon: Icons.list,
        ),
      ],
    ),
      body: pages[vnIndex],
    );
  }
}
