import 'package:ezye/home_screens/categories_screen.dart';
import 'package:ezye/home_screens/home_screen.dart';
import 'package:ezye/paymentScreens/wallet_screen.dart';
import 'package:ezye/profilescreens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String id = 'main-screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
   CateGories(),
    WalletPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex > 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return false; // Prevent app from closing
        }
        return true; // Allow app to close
      },
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 10,
          currentIndex: _selectedIndex,
          backgroundColor: Colors.white,
          onTap: _onItemTapped,
          selectedItemColor: Colors.black,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          unselectedItemColor: Color(0xff7C7D85),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/merchant1.svg',
                height: 32,
                width: 32,
              ),
              activeIcon: SvgPicture.asset(
                'assets/svg/merchant.svg',
                height: 32,
                width: 32,
              ),
              label: 'STORE',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/category1.svg',
                height: 32,
                width: 32,
              ),
              activeIcon: SvgPicture.asset(
                'assets/svg/category.svg',
                height: 32,
                width: 32,
              ),
              label: 'CATEGORIES',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/cart1.svg',
                height: 32,
                width: 32,
              ),
              activeIcon: SvgPicture.asset(
                'assets/svg/cart.svg',
                height: 32,
                width: 32,
              ),
              label: 'CART',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/account1.svg',
                height: 32,
                width: 32,
              ),
              activeIcon: SvgPicture.asset(
                'assets/svg/account.svg',
                height: 32,
                width: 32,
              ),
              label: 'MY ACCOUNT',
            ),
          ],
        ),
      ),
    );
  }
}
