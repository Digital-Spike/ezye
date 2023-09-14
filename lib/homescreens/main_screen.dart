import 'package:ezys/homescreens/home_screen.dart';
import 'package:ezys/profilescreens/profile_screen.dart';
import 'package:ezys/paymentScreens/coupan_screen.dart';
import 'package:ezys/paymentScreens/wallet_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class MainScreen extends StatefulWidget {
  final Widget mainChild;
  final PreferredSizeWidget? mainAppBar;
  const MainScreen({required this.mainChild, this.mainAppBar, super.key});

  static const String id = 'main-screen';


  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final double indicatorWidth = 40.0; // Adjust the width as needed
  final double indicatorHeight = 4.0; // Adjust the height as needed
  final Color indicatorColor = Color(0xffb22024);
  static int? _bottomNavIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: const Color(0xfff1f1f2),
    extendBodyBehindAppBar: true,
    
      appBar: widget.mainAppBar,
      body: SafeArea(child: widget.mainChild),

     
      bottomNavigationBar: Stack(

        children: [
              BottomNavigationBar(
              elevation: 1,
              
           selectedItemColor: Colors.black,
           
              currentIndex: _bottomNavIndex ?? 0,
              onTap: (index) =>
                switchScreen(index),
               
              landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
              
              type: BottomNavigationBarType.fixed,
              items:  <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/icons/Home.svg',height: 28,width: 28,),
                    activeIcon: SvgPicture.asset('assets/icons/Home Fill (1).svg',height: 28,width: 28,),
                    label: 'Home',
                    ),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/icons/Coupon.svg',height: 28,width: 28,),
                    activeIcon: SvgPicture.asset('assets/icons/Coupon Fill.svg',height: 28,width: 28,),
                    label: 'Coupons',
                   ),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/icons/Wallet.svg',height: 25,width: 25,),
                    activeIcon: SvgPicture.asset('assets/icons/Wallet Fill.svg',height: 25,width: 25,),
                    label: 'Wallet',
                    ),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/icons/Profile Fill.svg',height: 28,width: 28,),
                    activeIcon: SvgPicture.asset('assets/icons/Profile.svg',height: 28,width: 28,),
                    label: 'Profile',
                   ),
              ]),
             Positioned(
            top: 0, // Adjust the top position as needed
            left: (MediaQuery.of(context).size.width / 4) *
                (_bottomNavIndex ?? 0) +
                (MediaQuery.of(context).size.width / 8) -
                (indicatorWidth / 2), // Calculate the position based on the selected index
            child: Container(
              width: indicatorWidth,
              height: indicatorHeight,
              
              decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5)),color: indicatorColor,),
            ),
          ),
            ],
      ),
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
            builder: (context) => const CoupanPage(),
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