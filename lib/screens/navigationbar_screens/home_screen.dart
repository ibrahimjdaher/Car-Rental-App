import 'package:car_rental_app/screens/navigationbar_screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/car_types.dart';
import '../../widgets/car_card.dart';
import '../all_cars_screen.dart';
import '../car_list_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<CarCard> carCards;

  const HomeScreen({super.key, required this.carCards});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 30.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // -- search bar & personal picture --
              Padding(
                padding: const EdgeInsets.only(right: 20.0, top: 30, left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22.0),
                        ),
                        child: const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: Icon(Iconsax.search_normal),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 3.0),
                                child: TextField(
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                  ),
                                  strutStyle: StrutStyle(
                                    fontFamily: 'Poppins-Medium',
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Search',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          'assets/images/me.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0, top: 15, left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Brands',
                      style: TextStyle(
                        fontFamily: 'Poppins-Bold',
                        fontSize: 25,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllCarsScreen(
                              carCards: carCards,
                            ),
                          ),
                        );
                      },
                      child: const Row(
                        children: [
                          Text(
                            'See All',
                            style: TextStyle(
                              fontFamily: 'Poppins-Medium',
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // -- list of car types --
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SizedBox(
                  height: 150, // Adjust the height as needed
                  child: ListView.builder(
                    itemCount: carType.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CarListScreen(
                                  carBrand: CarBrand.values[index],
                                  // Assuming the index matches the CarBrand enum order
                                  carCards: carCards,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 100,
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Image.asset(
                                    carType[index].carTypeImage,
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                Text(
                                  carType[index].carTypeName,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins-Bold',
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  '+${carType[index].carTypeNumber}',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Padding(
                padding: EdgeInsets.only(right: 180),
                child: Text(
                  'Popular Cars',
                  style: TextStyle(
                    fontFamily: 'Poppins-Bold',
                    fontSize: 25,
                  ),
                ),
              ),
              ListView.builder(
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                itemCount: carCards.length,
                shrinkWrap: true,
                // Ensures it takes only necessary space
                physics: const NeverScrollableScrollPhysics(),
                // Disable scrolling
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: carCards[index],
                  );
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
