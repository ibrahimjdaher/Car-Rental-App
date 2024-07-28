import 'package:flutter/material.dart';
import 'package:car_rental_app/widgets/car_card.dart'; // Ensure the path is correct

class AllCarsScreen extends StatelessWidget {
  final List<CarCard> carCards;

  const AllCarsScreen({super.key, required this.carCards});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Cars',
          style: TextStyle(fontFamily: 'Poppins-Medium'),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_rounded,size: 20,),
        ),
      ),
      body: ListView.builder(
        itemCount: carCards.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: carCards[index],
          );
        },
      ),
    );
  }
}
