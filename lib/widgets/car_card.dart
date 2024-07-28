import 'package:car_rental_app/common/car_types.dart';
import 'package:flutter/material.dart';
import '../common/colors.dart';
import '../screens/car_details_screen.dart';

class CarCard extends StatelessWidget {
  final String carTitle;
  final String carDetails1;
  final String carDetails2;
  final String carDetails3;
  final String carImage;
  final CarBrand carBrand;

  const CarCard({
    super.key,
    required this.carTitle,
    required this.carDetails1,
    required this.carDetails2,
    required this.carDetails3,
    required this.carImage,
    required this.carBrand,
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
                        carDetails1,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black26,
                          fontFamily: 'Poppins-Regular',
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          right: 200,
                        ),
                        child: Divider(),
                      ),
                      Text(
                        carDetails2,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black26,
                          fontFamily: 'Poppins-Regular',
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 200),
                        child: Divider(),
                      ),
                      Text(
                        carDetails3,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black26,
                          fontFamily: 'Poppins-Regular',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        color: TColor.primaryColor,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {

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
                      MaterialButton(
                        color: Colors.white,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: TColor.primaryColor,
                            strokeAlign: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return CarDetailsScreen(
                                carTitle: carTitle,
                                carDetails1: carDetails1,
                                carDetails2: carDetails2,
                                carDetails3: carDetails3,
                                carImage: carImage,
                                carBrand: carBrand,
                              );
                            }),
                          );
                        },
                        child: Text(
                          'Details',
                          style: TextStyle(
                            fontSize: 18,
                            color: TColor.primaryColor,
                            fontFamily: 'Poppins-Regular',
                          ),
                        ),
                      ),
                    ],
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
