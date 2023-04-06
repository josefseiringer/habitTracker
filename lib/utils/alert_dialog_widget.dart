import 'package:flutter/material.dart';
import '../constants.dart';
import '../controller/overview_controller.dart';

class AlertDialogWidget extends StatefulWidget {
  final String szNotionId;
  final String szUserId;
  final String szUserName;
  final String szType;
  final String szMinute;
  final String szDate;

  const AlertDialogWidget({
    super.key,
    required this.szNotionId,
    required this.szUserId,
    required this.szUserName,
    required this.szType,
    required this.szMinute,
    required this.szDate,
  });

  @override
  State<AlertDialogWidget> createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {
  final TextEditingController inputTypeController = TextEditingController();
  final TextEditingController inputMinuteController = TextEditingController();
  final TextEditingController inputDateController = TextEditingController();
  final OverviewController oCtrl = OverviewController.to;

  @override
  void initState() {
    inputDateController.text = widget.szDate;
    inputMinuteController.text = widget.szMinute;
    inputTypeController.text = widget.szType;
    super.initState();
  }

  @override
  void dispose() {
    inputTypeController.dispose();
    inputDateController.dispose();
    inputMinuteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit your Habit ${widget.szUserName}'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 70,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: TextFormField(
                controller: inputTypeController,
                style: Theme.of(context).textTheme.labelMedium,
                keyboardType: TextInputType.name,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter type',
                  border: InputBorder.none,
                  hintStyle: kHintTextFild,
                ),
              ),
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
                controller: inputMinuteController,
                style: Theme.of(context).textTheme.labelMedium,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter Time',
                  border: InputBorder.none,
                  hintStyle: kHintTextFild,
                ),
              ),
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
                controller: inputDateController,
                style: Theme.of(context).textTheme.labelMedium,
                keyboardType: TextInputType.datetime,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter Date',
                  border: InputBorder.none,
                  hintStyle: kHintTextFild,
                ),
                onTap: () async {
                  await oCtrl.selectDate(context);
                  setState(() {
                    inputDateController.text = oCtrl.szDate.value;
                  });
                },
              ),
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
            oCtrl.szNotionPageId.value = widget.szNotionId;
            oCtrl.szHabitId.value = widget.szUserId;
            oCtrl.szHabitUser.value = widget.szUserName;
            oCtrl.szType.value = inputTypeController.text;
            oCtrl.szTimeLengthMinute.value = inputMinuteController.text;
            oCtrl.szDate.value = inputDateController.text;
            oCtrl.updateHabitData();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
