import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:sundaymart/src/presentation/pages/search/search_riverpod.dart';

import '../../../core/constants/app_assets.dart';
import '../../../riverpod/gh.dart';
import '../main/shop/cart/checkout/oneSystem/Controller/basct_shop_contrroller.dart';
import '../main/shop/details/banner_details/banner_details_page.dart';

class SearchScanBarCodeScreen extends ConsumerStatefulWidget {
  @override
  _SearchScanBarCodeScreenState createState() =>
      _SearchScanBarCodeScreenState();
}

class _SearchScanBarCodeScreenState extends ConsumerState<SearchScanBarCodeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _scannedBarcode = '';
  final GlobalKey<dynamic> _qrKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Consumer(builder: (context, ref, child) {
        final getSearchScanarFromApi = ref.watch(SearchBarCodeApiProvider);
        final appModel = ref.watch(appModelProvider);

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onChanged: (text) {
                  // Handle regular text input changes if needed
                  print(text);
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () async {
                      // Show QR scanner
                      final barcode = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QRViewExample(qrKey: _qrKey),
                        ),
                      );

                      if (barcode != null) {
                        setState(() {
                          _scannedBarcode = barcode;
                          _searchController.text = barcode;
                        });

                        String trimmedBarcode = barcode.trim();
                        // Call the search function with the scanned barcode
                        getSearchScanarFromApi.getSearchBarCode(search: trimmedBarcode);

                        print(barcode.runtimeType);
                      }
                    },
                    icon: const Icon(Icons.camera_alt),
                  ),
                  hintText: 'ابحث...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: getSearchScanarFromApi.searchBarCodeList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _getCrossAxisCount(context),
                  childAspectRatio: _getAspectRatio(context),
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (context, index) {
                  final item = getSearchScanarFromApi.searchBarCodeList[index];

                  return Card(
                    color: Colors.white,
                    child: Container(
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BannerDetailsPage(
                                productId: item["ProductID"],
                                CategoryId: item["CategoryId"],
                                name: (appModel.activeLanguage.languageCode == 'ar')
                                    ? item['ProductArName']
                                    : item['ProductEnName'],
                                image: item['ProductcImage'],
                                specification: item['Specification'],
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 130,
                                          child: Image.network(
                                            '${item['ProductcImage']}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  4.verticalSpace,
                                  (item["DiscountPercent"] == 0)
                                      ? Row(
                                    children: [
                                      Text(
                                        ' ${item["PriceAfterDiscount"]} ',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Monadi',
                                        ),
                                      ),
                                      Text(
                                        (appModel.activeLanguage.languageCode == 'ar')
                                            ? 'د.ك'
                                            : 'K.D',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Monadi',
                                        ),
                                      ),
                                    ],
                                  )
                                      : Row(
                                    children: [
                                      Text(
                                        '${(item["PriceAfterDiscount"]).toStringAsFixed(3)}',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Monadi',
                                        ),
                                      ),
                                      Text(
                                        (appModel.activeLanguage.languageCode == 'ar')
                                            ? 'د.ك'
                                            : 'K.D',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Monadi',
                                        ),
                                      ),
                                      10.horizontalSpace,
                                      Text(
                                        ' ${item["Price"]}',
                                        style: TextStyle(
                                          decoration: TextDecoration.lineThrough,
                                          color: Colors.red,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Monadi',
                                        ),
                                      ),
                                      Text(
                                        'د.ك',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w300,
                                          decoration: TextDecoration.lineThrough,
                                          color: Colors.red,
                                          fontFamily: 'Monadi',
                                        ),
                                      ),
                                    ],
                                  ),
                                  2.verticalSpace,
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      (appModel.activeLanguage.languageCode == 'ar')
                                          ? '${item["ProductArName"]}'
                                          : '${item["ProductEnName"]}',
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Monadi',
                                      ),
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
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 1200) {
      return 4;
    } else if (screenWidth >= 800) {
      return 3;
    } else {
      return 2;
    }
  }

  double _getAspectRatio(BuildContext context) {
    final crossAxisCount = _getCrossAxisCount(context);
    if (crossAxisCount == 4) {
      return 0.75; // Wider aspect ratio for large screens
    } else {
      return 0.8; // Regular aspect ratio for medium and small screens
    }
  }
}

class QRViewExample extends StatelessWidget {
  final GlobalKey<dynamic> qrKey;

  const QRViewExample({required this.qrKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: QRView(
        key: qrKey,
        onQRViewCreated: (controller) {
          controller.scannedDataStream.listen((scanData) {
            Navigator.pop(context, scanData.code); // Return scanned QR code
          });
        },
      ),
    );
  }
}
