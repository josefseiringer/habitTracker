import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../constants.dart';
import '../utils/alert_dialog_widget.dart';
import '../utils/floating_popup_input_widget.dart';
import '../controller/overview_controller.dart';
import '../models/habit_model.dart';

class OverviewPage extends GetView<OverviewController> {
  static const namedRoute = '/overview-page';
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    OverviewController oCtrl = controller;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => oCtrl.refreshListData(),
          ),
        ],
        centerTitle: true,
        title: Text(
          'Your Habit List',
          style: kMybodyTextStyleMedium,
        ),
      ),
      floatingActionButton: const FloatingPopupWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: GetBuilder<OverviewController>(
            builder: (OverviewController oCtrl) {
              if (!oCtrl.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: controller.lHabitList.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      key: const ValueKey(0),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: <Widget>[
                          SlidableAction(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.black,
                            label: 'Delete',
                            icon: Icons.delete,
                            onPressed: (_) => oCtrl.deletHabitItem(
                                oCtrl.lHabitList[index].szNotionPageId!),
                          ),
                          SlidableAction(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.black,
                            label: 'Edit',
                            icon: Icons.edit,
                            onPressed: (_) => showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialogWidget(
                                  szNotionId:
                                      oCtrl.lHabitList[index].szNotionPageId!,
                                  szUserId:  oCtrl.lHabitList[index].szHabitId!,
                                  szUserName:  oCtrl.lHabitList[index].szHabitUser!,
                                  szType:  oCtrl.lHabitList[index].szType!,
                                  szMinute:  oCtrl.lHabitList[index].szTimeLengthMinute!,
                                  szDate:  oCtrl.lHabitList[index].szDateOfHabit!,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      child:
                          _myHabitItem(context, oCtrl.lHabitList[index], index),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

//List Item
  Card _myHabitItem(BuildContext context, HabitModel item, int index) {
    var maxDisplayWidth = MediaQuery.of(context).size.width;
    return Card(
      elevation: 2,
      shadowColor: Colors.grey.shade300,
      child: Container(
        width: maxDisplayWidth - 50,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Text(item.szHabitId!, style: kMybodyTextStyleSmall),
            Text(item.szDateOfHabit!, style: kMybodyTextStyleMedium),
            Text(item.szType!, style: kMybodyTextStyleSmall),
            Text('${item.szTimeLengthMinute!} Minuten',
                style: kMybodyTextStyleSmall),
          ],
        ),
      ),
    );
  }
}
