import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/constants.dart';
import '../../core/utils/utils.dart';
import 'components.dart';

class DatePickerModal extends StatefulWidget {
  final Function(DateTime) onDateSaved;

  const DatePickerModal({Key? key, required this.onDateSaved})
      : super(key: key);

  @override
  State<DatePickerModal> createState() => _DatePickerModalState();
}

class _DatePickerModalState extends State<DatePickerModal> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          24.verticalSpace,
          SizedBox(
            height: 300.r,
            child: CupertinoTheme(
              data: CupertinoThemeData(
                brightness: LocalStorage.instance.getAppThemeMode()
                    ? Brightness.dark
                    : Brightness.light,
              ),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                minimumDate: DateTime.now(),
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime value) {
                  date = value;
                },
              ),
            ),
          ),
          16.verticalSpace,
          MainConfirmButton(
            title: AppHelpers.getTranslation(TrKeys.save),
            onTap: () {
              widget.onDateSaved(date);
               Navigator.pop(context);
            },
          ),
          24.verticalSpace,
        ],
      ),
    );
  }
}
