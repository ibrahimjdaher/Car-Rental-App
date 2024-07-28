import 'package:flutter/material.dart';

class Rental {
  final String carTitle;
  final String rentType;
  final String rentAmount;
  final String date;
  final String time;

  Rental({
    required this.carTitle,
    required this.rentType,
    required this.rentAmount,
    required this.date,
    required this.time,
  });
}

class RentalProvider with ChangeNotifier {
  final List<Rental> _rentals = [];

  List<Rental> get rentals => _rentals;

  void addRental(Rental rental) {
    _rentals.add(rental);
    notifyListeners();
  }
}
