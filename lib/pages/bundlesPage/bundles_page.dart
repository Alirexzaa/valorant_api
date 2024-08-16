import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:valorant_api/api/dart_api.dart';
import 'package:valorant_api/pages/constants.dart';

class BundlesPage extends StatefulWidget {
  static String routeName = '/BundlesPage';

  const BundlesPage({super.key});

  @override
  State<BundlesPage> createState() => _BundlesPageState();
}

class _BundlesPageState extends State<BundlesPage> {
  @override
  Widget build(BuildContext context) {
    // Get size of display in use
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Constants.primaryColor,
      // App Bar
      appBar: AppBar(
        leading: IconButton(
          color: Constants.secondPrimaryColor,
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
        backgroundColor: Constants.primaryColor,
      ),
      // Body
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: FutureBuilder(
          future: fetchBundles(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var bundlesData = snapshot.data!.data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: bundlesData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 300,
                  ),
                  itemBuilder: (context, index) {
                    return InkResponse(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/BundlesDetailPage',
                          arguments: {
                            'displayName': bundlesData[index].displayName,
                            'description': bundlesData[index].description,
                            'verticalPromoImage':
                                bundlesData[index].verticalPromoImage,
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Constants.secondPrimaryColor),
                        ),
                        child: Stack(
                          children: [
                            // Bundles Picure
                            SizedBox(
                              child:
                                  bundlesData[index].verticalPromoImage == null
                                      ? const SizedBox()
                                      : Image.network(
                                          fit: BoxFit.cover,
                                          bundlesData[index]
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
                                color: Constants.secondPrimaryColor,
                                child: Text(
                                  bundlesData[index].displayName,
                                  style: TextStyle(
                                    color: Constants.primaryColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            // Loading Animation
            return Center(
              child: RiveAnimation.asset(Constants.loadingRiveAnimation),
            );
          },
        ),
      ),
    );
  }
}
