import 'package:flutter/material.dart';
import 'package:car_rental_app/common/car_types.dart';
import 'package:car_rental_app/widgets/car_card.dart'; // Ensure the path is correct

class CarListScreen extends StatelessWidget {
  final CarBrand carBrand;
  final List<CarCard> carCards;

  const CarListScreen({
    super.key,
    required this.carBrand,
    required this.carCards,
  });

  @override
  Widget build(BuildContext context) {
    // Filter cars based on the selected brand
    final filteredCars = carCards
        .where((carCard) => carCard.carBrand == carBrand)
        .toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
          ),
        ),
        title: Text(
          style: const TextStyle(fontFamily: 'Poppins-Medium'),
          carBrand.toString().split('.').last.toUpperCase(),
        ),
      ),
      body: filteredCars.isEmpty
          ? const Center(child: Text('No cars available for this brand'))
          : ListView.builder(
        itemCount: filteredCars.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: filteredCars[index],
          );
        },
      ),
    );
  }
}
