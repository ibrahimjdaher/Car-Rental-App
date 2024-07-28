enum CarBrand { bmw, mercedes, porsche, toyota, ford, hyundai }

class CarType {
  String carTypeName;
  String carTypeImage;
  String carTypeNumber;
  CarBrand carBrand;

  CarType({
    required this.carTypeImage,
    required this.carTypeName,
    required this.carTypeNumber,
    required this.carBrand,
  });

  factory CarType.fromJson(Map<String, dynamic> json) {
    return CarType(
      carTypeImage: json['carTypeImage'],
      carTypeName: json['carTypeName'],
      carTypeNumber: json['carTypeNumber'],
      carBrand: CarBrand.values
          .firstWhere((e) => e.toString() == 'CarBrand.' + json['carBrand']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carTypeNumber': carTypeNumber,
      'carTypeName': carTypeName,
      'carTypeImage': carTypeImage,
      'carBrand': carBrand.toString().split('.').last,
    };
  }
}

var carType = [
  CarType(
    carTypeImage: 'assets/images/car_logo/bmw.png',
    carTypeName: 'BMW',
    carTypeNumber: '10',
    carBrand: CarBrand.bmw,
  ),
  CarType(
    carTypeImage: 'assets/images/car_logo/mercedes.png',
    carTypeName: 'Mercedes',
    carTypeNumber: '8',
    carBrand: CarBrand.mercedes,
  ),
  CarType(
    carTypeImage: 'assets/images/car_logo/porsche.png',
    carTypeName: 'Porsche',
    carTypeNumber: '5',
    carBrand: CarBrand.porsche,
  ),
  CarType(
    carTypeImage: 'assets/images/car_logo/toyota.png',
    carTypeName: 'Toyota',
    carTypeNumber: '18',
    carBrand: CarBrand.toyota,
  ),
  CarType(
    carTypeImage: 'assets/images/car_logo/ford.png',
    carTypeName: 'Ford',
    carTypeNumber: '23',
    carBrand: CarBrand.ford,
  ),
  CarType(
    carTypeImage: 'assets/images/car_logo/hyundai.png',
    carTypeName: 'Hyundai',
    carTypeNumber: '20',
    carBrand: CarBrand.hyundai,
  ),
];
