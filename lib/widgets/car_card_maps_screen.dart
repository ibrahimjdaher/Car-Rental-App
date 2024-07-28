import 'package:car_rental_app/common/car_types.dart';
import 'package:car_rental_app/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import '../common/colors.dart';

class CarCardMapsScreen extends StatelessWidget {
  final String carTitle;
  final String dailyRent;
  final String hourlyRent;
  final String carImage;
  final CarBrand carBrand;
  final bool isDailySelected; // New parameter

  const CarCardMapsScreen({
    super.key,
    required this.carTitle,
    this.dailyRent = '\$400',
    this.hourlyRent = '\$80',
    required this.carImage,
    required this.carBrand,
    required this.isDailySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 5,
          ),
          child: Container(
            width: double.infinity,
            height: 250, // Increased height to accommodate car brand
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    carTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins-Medium',
                    ),
                  ),
                  Text(
                    carBrand.toString().split('.').last, // Display car brand
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontFamily: 'Poppins-Regular',
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$dailyRent / Day',
                        style: TextStyle(
                          fontSize: isDailySelected ? 20 : 15,
                          color: isDailySelected ? Colors.blue : Colors.black38,
                          // Highlight if selected
                          fontFamily: isDailySelected
                              ? 'Poppins-Medium'
                              : 'Poppins-Regular',
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          right: 200,
                        ),
                        child: Divider(),
                      ),
                      Text(
                        '$hourlyRent / Hour',
                        style: TextStyle(
                          fontSize: isDailySelected ? 15 : 20,
                          color: isDailySelected ? Colors.black38 : Colors.blue,
                          // Highlight if selected
                          fontFamily: isDailySelected
                              ? 'Poppins-Regular'
                              : 'Poppins-Medium',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Center(
                    child: MaterialButton(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      color: TColor.primaryColor,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutScreen(
                              carTitle: carTitle,
                              dailyRent: dailyRent,
                              hourlyRent: hourlyRent,
                              isDailySelected: isDailySelected,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Rent Now',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Poppins-Regular',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 200,
          top: 0,
          bottom: 90,
          right: 0,
          child: Image.asset(
            carImage,
            width: 150,
            height: 150,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
