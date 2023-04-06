import 'package:flutter/material.dart';
import '../constants.dart';
import '../controller/overview_controller.dart';
import '../utils/my_text_form_field_widget.dart';

class FloatingPopupWidget extends StatelessWidget {
  const FloatingPopupWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var oCtrl = OverviewController.to;
    return FloatingActionButton(
      onPressed: () {
        oCtrl.szType.value = '';
        oCtrl.szTimeLengthMinute.value = '';
        oCtrl.szDate.value = '';
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Enter your Habit ${oCtrl.szInputUserName.value}'),
              content: SingleChildScrollView(
                child: Column(
                    children: [
                      MyTextFormWidget(
                        textInputType: TextInputType.name,
                        szHintText: 'Type here',
                        rxInputString: oCtrl.szType,
                      ),
                      const SizedBox(height: 10),
                      MyTextFormWidget(
                        textInputType: TextInputType.number,
                        szHintText: 'Time in Minute',
                        rxInputString: oCtrl.szTimeLengthMinute,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width - 70,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: TextFormField(
                            style: Theme.of(context).textTheme.labelMedium,
                            controller: oCtrl.inputDateController,
                            keyboardType: TextInputType.none,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'Tab for Date',
                              border: InputBorder.none,
                              hintStyle: kHintTextFild,
                            ),
                            onTap: () {
                              oCtrl.selectDate(context);
                            }),
                      ),
                    ],
                  ),
              ),
              actions: [
                ElevatedButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: const Text('Save'),
                  onPressed: () {
                    // Save the input here
                    oCtrl.saveHabitData();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      backgroundColor: Colors.grey.shade500,
      child: Icon(
        Icons.add,
        color: Colors.grey.shade900,
        size: 40,
      ),
    );
  }
}
