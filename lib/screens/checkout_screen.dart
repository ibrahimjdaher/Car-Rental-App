import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_rental_app/common/colors.dart';
import 'package:car_rental_app/widgets/rental_provider.dart';
import 'package:car_rental_app/screens/home.dart';

class CheckoutScreen extends StatefulWidget {
  final String carTitle;
  final String dailyRent;
  final String hourlyRent;
  final bool isDailySelected;

  const CheckoutScreen({
    super.key,
    required this.carTitle,
    required this.dailyRent,
    required this.hourlyRent,
    required this.isDailySelected,
  });

  @override
  CheckoutScreenState createState() => CheckoutScreenState();
}

class CheckoutScreenState extends State<CheckoutScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _processPayment() {
    if (_formKey.currentState!.validate() &&
        selectedDate != null &&
        selectedTime != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop(); // Dismiss the circular progress dialog

        final rental = Rental(
          carTitle: widget.carTitle,
          rentType: widget.isDailySelected ? 'Daily' : 'Hourly',
          rentAmount: widget.isDailySelected ? widget.dailyRent : widget.hourlyRent,
          date: selectedDate!.toLocal().toString().split(' ')[0],
          time: selectedTime!.format(context),
        );

        Provider.of<RentalProvider>(context, listen: false).addRental(rental);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Payment successful'),
          ),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
              (Route<dynamic> route) => false, // Remove all routes from the stack
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all fields and select date and time.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
            size: 22,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'Poppins-Medium',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Car: ${widget.carTitle}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins-Bold',
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.isDailySelected
                      ? 'Daily Rent: ${widget.dailyRent}'
                      : 'Hourly Rent: ${widget.hourlyRent}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins-Medium',
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  shape: const OutlineInputBorder(),
                  title: Text(
                    selectedDate == null
                        ? 'Select Date'
                        : 'Date: ${selectedDate!.toLocal().toString().split(' ')[0]}',
                  ),
                  trailing: const Icon(Icons.calendar_month),
                  onTap: () => _selectDate(context),
                ),
                const SizedBox(height: 20),
                ListTile(
                  shape: const OutlineInputBorder(),
                  title: Text(
                    selectedTime == null
                        ? 'Select Time'
                        : 'Time: ${selectedTime!.format(context)}',
                  ),
                  trailing: const Icon(Icons.access_time),
                  onTap: () => _selectTime(context),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _cardNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Card Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your card number';
                    } else if (value.length != 16) {
                      return 'Card number must be 16 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _expiryDateController,
                  decoration: const InputDecoration(
                    labelText: 'Expiry Date (MM/YY)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the expiry date';
                    } else if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
                      return 'Expiry date must be in MM/YY format';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _cvvController,
                  decoration: const InputDecoration(
                    labelText: 'CVV',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the CVV';
                    } else if (value.length != 3) {
                      return 'CVV must be 3 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: MaterialButton(
                    color: TColor.primaryColor,
                    onPressed: _processPayment,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Pay Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins-Medium',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
