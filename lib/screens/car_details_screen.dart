import 'package:car_rental_app/widgets/car_card_maps_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../common/car_types.dart';
import 'map_screen.dart';

class CarDetailsScreen extends StatefulWidget {
  final String carTitle;
  final String carDetails1;
  final String carDetails2;
  final String carDetails3;
  final String carImage;
  final String dailyPrice;
  final String hourlyPrice;
  final String dayText;
  final String hourText;

  final CarBrand carBrand;

  const CarDetailsScreen({
    super.key,
    required this.carTitle,
    required this.carDetails1,
    required this.carDetails2,
    required this.carDetails3,
    required this.carImage,
    required this.carBrand,
    this.dailyPrice = '\$400',
    this.hourlyPrice = '\$80',
    this.dayText = ' / Day',
    this.hourText = ' / Hour',
  });

  @override
  CarDetailsScreenState createState() => CarDetailsScreenState();
}

class CarDetailsScreenState extends State<CarDetailsScreen> {
  bool isHourlySelected = false;
  bool isDailySelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.48,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white70,
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_rounded,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white70,
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Iconsax.heart,
                                size: 22,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        widget.carTitle,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: 'Poppins-Bold',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '4.9',
                            style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '(179) Reviews',
                            style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 13,
                              color: Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10,
                      ),
                      child: Image.asset(widget.carImage),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.465,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        'Specifications',
                        style: TextStyle(
                          fontFamily: 'Poppins-Medium',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 5,
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: Colors.black12,
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 3.0,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Power',
                                      style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '429 hp @ 6,100 rpm',
                                      style: TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: Colors.black12,
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 3.0,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Max Speed',
                                      style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '280 km/h',
                                      style: TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: Colors.black12,
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 3.0,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Acceleration',
                                      style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '4.9 sec 0-60 mph',
                                      style: TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        'Plan',
                        style: TextStyle(
                          fontFamily: 'Poppins-Medium',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isHourlySelected = true;
                                  isDailySelected = false;
                                });
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: 90,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: isHourlySelected
                                          ? Colors.blue.shade200
                                          : Colors.grey.shade200,
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(25.0),
                                        topLeft: Radius.circular(25.0),
                                      ),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Iconsax.clock,
                                          size: 30,
                                          color: isHourlySelected
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                        Text(
                                          widget.hourlyPrice,
                                          style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            fontSize: 15,
                                            color: isHourlySelected
                                                ? Colors.blue
                                                : Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 90,
                                    width: 180,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      border: Border.all(
                                        color: isHourlySelected
                                            ? Colors.blue
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 55.0,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'Hourly Rent',
                                            style: TextStyle(
                                              fontFamily: 'Poppins-Bold',
                                              fontSize: 16,
                                              color: isHourlySelected
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          const Text(
                                            'Best of business appointments',
                                            style: TextStyle(
                                              fontFamily: 'Poppins-Regular',
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isDailySelected = true;
                                  isHourlySelected = false;
                                });
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: 90,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: isDailySelected
                                          ? Colors.blue.shade200
                                          : Colors.grey.shade200,
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(25.0),
                                        topLeft: Radius.circular(25.0),
                                      ),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Iconsax.calendar,
                                          size: 30,
                                          color: isDailySelected
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                        Text(
                                          widget.dailyPrice,
                                          style: TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            fontSize: 15,
                                            color: isDailySelected
                                                ? Colors.blue
                                                : Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 90,
                                    width: 180,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      border: Border.all(
                                        color: isDailySelected
                                            ? Colors.blue
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 55.0,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'Daily Rent',
                                            style: TextStyle(
                                              fontFamily: 'Poppins-Bold',
                                              fontSize: 16,
                                              color: isDailySelected
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          const Text(
                                            'Best of travel',
                                            style: TextStyle(
                                              fontFamily: 'Poppins-Regular',
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        'Location',
                        style: TextStyle(
                          fontFamily: 'Poppins-Medium',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        width: double.infinity,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13.0),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Iconsax.location,
                              size: 20,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Al-Nasser Street, Gaza - Palestine',
                              style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 20.0,
                      ),
                      child: Row(
                        children: [
                          Text(
                            isDailySelected
                                ? widget.dailyPrice
                                : widget.hourlyPrice,
                            style: const TextStyle(
                              fontFamily: 'Poppins-Bold',
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            isDailySelected ? widget.dayText : widget.hourText,
                            style: const TextStyle(
                              fontFamily: 'Poppins-Medium',
                              fontSize: 23,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: isDailySelected ? 90.0 : 101.0,
                            ),
                            child: MaterialButton(
                              color: Colors.blue,
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapScreen(
                                      carCardMapsScreen: CarCardMapsScreen(
                                        carTitle: widget.carTitle,
                                        dailyRent: widget.dailyPrice,
                                        hourlyRent: widget.hourlyPrice,
                                        carImage: widget.carImage,
                                        carBrand: widget.carBrand, isDailySelected: isDailySelected,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'PickUp',
                                    style: TextStyle(
                                      fontFamily: 'Poppins-Medium',
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
