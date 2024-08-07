import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rive/rive.dart';
import 'package:valorant_api/api/dart_api.dart';

class BundlesPage extends StatefulWidget {
  static String routeName = '/BundlesPage';

  const BundlesPage({super.key});

  @override
  State<BundlesPage> createState() => _BundlesPageState();
}

class _BundlesPageState extends State<BundlesPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: HexColor('e9404f'),
      // App Bar
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
          ),
        ),
        title: const Text(
          'Bundles',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: HexColor('e9404f'),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: FutureBuilder(
          future: fetchBundles(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var bundleseData = snapshot.data!.data;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: bundleseData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 300,
                  ),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        // Bundles Picure
                        SizedBox(
                          child: bundleseData[index].verticalPromoImage == null
                              ? SizedBox()
                              : Image.network(
                                  fit: BoxFit.cover,
                                  bundleseData[index]
                                      .verticalPromoImage
                                      .toString(),
                                ),
                        ),

                        // Bundles Name
                        Positioned(
                          bottom: 0,
                          child: Container(
                            alignment: Alignment.center,
                            width: 212,
                            height: 30,
                            color: Colors.white,
                            child: Text(bundleseData[index].displayName),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }
            return const Center(
              child: RiveAnimation.asset('assets/animation/wait.riv'),
            );
          },
        ),
      ),
    );
  }
}
