import 'package:car_rental_app/screens/checkout_screen.dart';
import 'package:car_rental_app/screens/navigationbar_screens/home_screen.dart';
import 'package:car_rental_app/screens/navigationbar_screens/profile_screen.dart';
import 'package:car_rental_app/screens/navigationbar_screens/ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../common/car_types.dart';
import '../widgets/car_card.dart';

late final CheckoutScreen checkoutScreen;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(
      carCards: [
        CarCard(
          carTitle: 'Porsche 911',
          carDetails1: 'Manual',
          carDetails2: '4 seats',
          carDetails3: 'Petrol',
          carImage: 'assets/images/car_images/Porsche.png',
          carBrand: CarBrand.porsche,
        ),
        CarCard(
          carTitle: 'BMW X7',
          carDetails1: 'Automatic',
          carDetails2: '7 seats',
          carDetails3: 'Petrol',
          carImage: 'assets/images/car_images/BMW X7.png',
          carBrand: CarBrand.bmw,
        ),
        CarCard(
          carTitle: 'C-Class Sedan',
          carDetails1: 'Automatic',
          carDetails2: '5 seats',
          carDetails3: 'Petrol',
          carImage: 'assets/images/car_images/c-class sedan.png',
          carBrand: CarBrand.mercedes,
        ),
        CarCard(
          carTitle: 'Land Cruiser',
          carDetails1: 'Automatic',
          carDetails2: '8 seats',
          carDetails3: 'Diesel',
          carImage: 'assets/images/car_images/Toyota Land Cruiser.png',
          carBrand: CarBrand.toyota,
        ),
        CarCard(
          carTitle: 'S 500 Sedan',
          carDetails1: 'Automatic',
          carDetails2: '5 seats',
          carDetails3: 'Diesel',
          carImage: 'assets/images/car_images/s500sedan.png',
          carBrand: CarBrand.mercedes,
        ),
        CarCard(
          carTitle: 'GLA 250 SUV',
          carDetails1: 'Automatic',
          carDetails2: '7 seats',
          carDetails3: 'Diesel',
          carImage: 'assets/images/car_images/GLA250SUV.png',
          carBrand: CarBrand.mercedes,
        ),
        CarCard(
          carTitle: 'BMW M3',
          carDetails1: 'Automatic',
          carDetails2: '5 seats',
          carDetails3: 'Petrol',
          carImage: 'assets/images/car_images/BMW M3.png',
          carBrand: CarBrand.bmw,
        ),
      ],
    ),
    const TicketScreen(),
    const ProfileScreen(showBackButton: false),

    // Add more screens here as needed
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      extendBody: true,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Colors.grey[200],
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: IconButton(
                onPressed: () => _onItemTapped(0),
                icon: Icon(
                  Iconsax.home,
                  size: 30,
                  color:
                      _selectedIndex == 0 ? Colors.blueAccent : Colors.black26,
                ),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () => _onItemTapped(1),
                icon: Icon(
                  Iconsax.ticket_2,
                  size: 30,
                  color:
                      _selectedIndex == 1 ? Colors.blueAccent : Colors.black26,
                ),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () => _onItemTapped(2),
                icon: Icon(
                  Iconsax.user,
                  size: 30,
                  color:
                      _selectedIndex == 2 ? Colors.blueAccent : Colors.black26,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
