import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_parrot/themes/colors.dart';

class Car extends StatelessWidget {
  const Car({
    Key? key,
    required this.image,
    required this.marque,
    required this.type,
    required this.cylinder,
    required this.power,
    required this.year,
    required this.km,
    required this.transmission,
    required this.fuel,
    required this.price,
  }) : super(key: key);

  final String marque;
  final String type;
  final double cylinder;
  final int power;
  final int year;
  final int km;
  final String transmission;
  final String fuel;
  final int price;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
          //maxWidth: 330,
          ),
      decoration: BoxDecoration(
        color: primary,
        border: Border.all(
          width: 1,
          color: secondary,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image,
              width: 200,
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(marque,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: Colors.black)),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(type,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Colors.black,
                            )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("$cylinder",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: Colors.grey)),
                    const SizedBox(
                      width: 4,
                    ),
                    Text("$power CH",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Colors.grey,
                            )),
                  ],
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                    color: secondary,
                    width: 1,
                  ))),
                  child: Column(
                    children: [
                      Text("$year",
                          style: Theme.of(context).textTheme.bodyLarge),
                      const Text("-"),
                      Text("$km km",
                          style: Theme.of(context).textTheme.bodyLarge),
                      const Text("-"),
                      Text(transmission,
                          style: Theme.of(context).textTheme.bodyLarge),
                      const Text("-"),
                      Text(fuel, style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("$price €",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Colors.black,
                            )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      label: const Text("Details"),
                      icon: SvgPicture.asset(
                        "../assets/icons/wrench-solid.svg",
                        height: 20,
                        colorFilter:
                            const ColorFilter.mode(secondary, BlendMode.srcIn),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      label: const Text("Contactez-nous"),
                      icon: SvgPicture.asset(
                        "../assets/icons/send-fill.svg",
                        height: 20,
                        colorFilter:
                            const ColorFilter.mode(secondary, BlendMode.srcIn),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
