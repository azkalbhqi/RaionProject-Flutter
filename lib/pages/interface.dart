// ignore_for_file: use_key_in_widget_constructors, unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raionapp/pages/home_page.dart';
import 'package:raionapp/pages/market_page.dart';
import 'package:raionapp/pages/portofolio_page.dart';
import '../styles/styles.dart';
import './widget/buttons.dart';
import './notification_page.dart';

class Interface extends StatefulWidget {
  const Interface({super.key});

  @override
  State<Interface> createState() => _InterfaceState();
}

class _InterfaceState extends State<Interface> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CampVestor App'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const NotificationPage()));
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          HomePage(),
          MarketPage(), 
          PortofolioPage(), 
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.portrait),
            label: 'Portfolio',
          ),
          
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}