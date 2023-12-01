import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:garage_parrot/themes/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: Header(widget: widget, currentWidth: currentWidth),
      body: Column(
        children: [
          const Text('boby'),
          ElevatedButton(
              onPressed: () {}, child: const Icon(Icons.ac_unit_rounded))
        ],
      ),
    );
  }
}

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({
    super.key,
    required this.widget,
    required this.currentWidth,
  });

  final HomePage widget;
  final double currentWidth;
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(120);


  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return Image.asset(
            'logo_garage_parrot.png',
            height: 50,
            width: 50,
          );
        },
      ),
      title: Text(
        widget.title,
        style: Theme.of(
          context,
        ).textTheme.titleLarge,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            '/icons/power-off-solid.svg',
            colorFilter: const ColorFilter.mode(secondary, BlendMode.srcIn),
          ),
        )
      ],
      bottom: PreferredSize(
        preferredSize: preferredSize,
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  currentWidth > 500
                      ? Row(
                          children: [
                            SvgPicture.asset(
                              'icons/house-solid.svg',
                              height: 30,
                              width: 30,
                              colorFilter: const ColorFilter.mode(
                                  secondary, BlendMode.srcIn),
                            ),
                            Text(
                              'Accueil',
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        )
                      : Column(
                          children: [
                            SvgPicture.asset(
                              'icons/house-solid.svg',
                              height: 30,
                              width: 30,
                              colorFilter: const ColorFilter.mode(
                                  secondary, BlendMode.srcIn),
                            ),
                            Text(
                              'Accueil',
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        ),
                  currentWidth > 500
                      ? Row(
                    children: [
                      SvgPicture.asset(
                        'icons/wrench-solid.svg',
                        height: 30,
                        width: 30,
                        colorFilter: const ColorFilter.mode(
                            secondary, BlendMode.srcIn),
                      ),
                      Text(
                        'Atelier',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  )
                      : Column(
                    children: [
                      SvgPicture.asset(
                        'icons/wrench-solid.svg',
                        height: 30,
                        width: 30,
                        colorFilter: const ColorFilter.mode(
                            secondary, BlendMode.srcIn),
                      ),
                      Text(
                        'Atelier',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  currentWidth > 500
                      ? Row(
                    children: [
                      SvgPicture.asset(
                        'icons/car-on-solid.svg',
                        height: 30,
                        width: 30,
                        colorFilter: const ColorFilter.mode(
                            secondary, BlendMode.srcIn),
                      ),
                      Text(
                        'Galerie',
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  )
                      : Column(
                    children: [
                      SvgPicture.asset(
                        'icons/car-on-solid.svg',
                        height: 30,
                        width: 30,
                        colorFilter: const ColorFilter.mode(
                            secondary, BlendMode.srcIn),
                      ),
                      Text(
                        'Galerie',
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
