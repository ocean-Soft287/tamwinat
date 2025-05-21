      import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('عملية لم تنجح',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Monadi',
                fontSize: 16,
              )),
          20.verticalSpace,
          Image.asset(width: 60, 'assets/images/all/paymentField.jpg'),
          20.verticalSpace,
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  const Text('لقد تم رفض العمليه ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Monadi',
                      )),
                  5.verticalSpace,
                  const Text('ليست ناجحه',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontFamily: 'Monadi',
                      )),
                ],
              ),
            ),
          )
        ],
      ),
      bottomSheet: InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Container(
            color: Colors.orange,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                      child: Text(
                    'العودة الى تنفيذ الطلب',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Monadi',
                        color: Colors.white),
                  )),
                ),
              ],
            ),
          )),
    );
  }
}

class PaymentSuccessPage extends StatelessWidget {
  final Widget colum1;

  const PaymentSuccessPage({required this.colum1});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: colum1);
  }
}

class PaymentSuccessButOrderFailedScreen extends StatelessWidget {
  final VoidCallback sendOrderAgain;

  const PaymentSuccessButOrderFailedScreen(
      {Key? key, required this.sendOrderAgain})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'تم الدفع بنجاح',
            style: TextStyle(
              color: Colors.green,
              fontFamily: 'Monadi',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          20.verticalSpace,
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'لكن حدث خطأ أثناء إرسال الطلب!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Monadi',
                    ),
                  ),
                  5.verticalSpace,
                  const Text(
                    'يرجى المحاولة مرة أخرى',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontFamily: 'Monadi',
                    ),
                  ),
                  20.verticalSpace,
                  InkWell(
                    onTap: sendOrderAgain,
                    child: Container(
                      height: 40.h,
                      margin: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          'إعادة المحاولة',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Monadi',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
