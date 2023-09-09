import 'package:ezys/homescreens/home_screen.dart';
import 'package:ezys/homescreens/profile_screen.dart';
import 'package:ezys/homescreens/voucher_screen.dart';
import 'package:ezys/homescreens/wallet_screen.dart';

import 'package:flutter/material.dart';


class MainScreen extends StatefulWidget {
  final Widget mainChild;
  final PreferredSizeWidget? mainAppBar;
  const MainScreen({required this.mainChild, this.mainAppBar, super.key});

  static const String id = 'main-screen';


  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static int? _bottomNavIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: const Color(0xfff1f1f2),
    extendBodyBehindAppBar: true,
    
      appBar: widget.mainAppBar,
      body: SafeArea(child: widget.mainChild),

     
      bottomNavigationBar: BottomNavigationBar(
          elevation: 1,
          // backgroundColor: Color(0xffF5E6C2),
         selectedItemColor: Colors.black,
         
          currentIndex: _bottomNavIndex ?? 0,
          onTap: (index) =>
            switchScreen(index),
           
          landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
          
          type: BottomNavigationBarType.fixed,
          items:  <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/home.png',height: 23,width: 23,),
                activeIcon: Image.asset('assets/icons/homefilled.png',height: 23,width: 23,),
                label: 'Home',
                ),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/voucher.png',height: 23,width: 23,),
                activeIcon: Image.asset('assets/icons/voucherfilled.png',height: 23,width: 23,),
                label: 'Vouchers',
               ),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/wallet.png',height: 23,width: 23,),
                activeIcon: Image.asset('assets/icons/walletfilled.png',height: 23,width: 23,),
                label: 'Wallet',
                ),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/user.png',height: 23,width: 23,),
                activeIcon: Image.asset('assets/icons/userfill.png',height: 23,width: 23,),
                label: 'Profile',
               ),
          ]),
    );
  }

  switchScreen(int index) {
    _bottomNavIndex = index;
    switch (_bottomNavIndex) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VoucherPage(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WalletPage(),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfilePage(),
          ),
        );
        break;
    }
  }
}