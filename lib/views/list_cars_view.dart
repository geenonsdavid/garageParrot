import 'package:flutter/material.dart';
import 'package:garage_parrot/components/car.dart';
import 'package:garage_parrot/components/car_data.dart';


class ListCarsView extends StatefulWidget {
  const ListCarsView({
    Key? key,
    required this.isScreenPhone,
    required this.isAdmin,
  }) : super(key: key);

  final bool isScreenPhone;
  final bool isAdmin;

  @override
  State<ListCarsView> createState() => _ListServicesState();
}

class _ListServicesState extends State<ListCarsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: carData.map((car) {
        final String image = car["image"];
        final String marque = car["marque"];
        final String type = car["type"];
        final double cylinder = car["cylinder"];
        final int power = car["power"];
        final int year = car["year"];
        final int km = car["km"];
        final String transmission = car["transmission"];
        final String fuel = car["fuel"];
        final int price = car["price"];
        
        
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Car(
            image: image,
            marque: marque,
            type: type,
            cylinder: cylinder,
            power: power,
            year: year,
            km: km,
            transmission: transmission,
            fuel: fuel,
            price: price,
          ),
        );
      }).toList(),
    );
  }
}
