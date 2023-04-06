import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/login_service.dart';
import '../models/habit_model.dart';
import '../services/overview_service.dart';

class OverviewController extends GetxController {
  static OverviewController get to => Get.find<OverviewController>();
  final szInputUserName = ''.obs;
  final szNotionPageId = ''.obs;
  final szHabitId = ''.obs;
  final szHabitUser = ''.obs;
  final szType = ''.obs;
  final szTimeLengthMinute = ''.obs;
  final szDate = ''.obs;
  final isLoading = false.obs;
  //final itemHabitModel = HabitModel().obs;
  var lHabitList = <HabitModel>[];
  final inputDateController = TextEditingController();

  @override
  void onInit() {
    _getHabitUser();
    _getHabitList();
    super.onInit();
  }

  void _getHabitUser() {
    //get Mokup User
    szInputUserName.value = LoginService().loadUserName();
    update();
  }

  Future<void> refreshListData() async {
    await _getHabitList();
    update();
  }

  Future<void> _getHabitList() async {
    isLoading.value = false;
    if (lHabitList.isNotEmpty) {
      lHabitList.clear();
    }
    //get List from Http Service
    lHabitList = await OverviewService().habitList;

    if (lHabitList.isNotEmpty) {
      lHabitList = lHabitList
          .where((e) =>
              e.szHabitUser == szInputUserName.value && e.mnHideHabit != 1)
          .toList();
      lHabitList.sort((a, b) => b.szHabitId!.compareTo(a.szHabitId!));
    }
    isLoading.value = true;
    update();
  }

  Future<void> updateHabitData() async {
    if (szTimeLengthMinute.value != '' &&
        szType.value != '' &&
        szDate.value != '') {
      HabitModel habitItem = HabitModel(
        szNotionPageId: szNotionPageId.value,
        szHabitId: szHabitId.value,
        szHabitUser: szHabitUser.value,
        szDateOfHabit: szDate.value,
        szTimeLengthMinute: szTimeLengthMinute.value,
        szType: szType.value,
        mnHideHabit: 0,
      );
      if (await OverviewService().updateHabitData(habitItem)) {
        isLoading.value = false;
        await _getHabitList();
        Get.snackbar(
          'Information',
          'Update successfully!',
          backgroundColor: Colors.grey.shade700,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.grey.shade300,
        );
        isLoading.value = true;
      } else {
        Get.snackbar(
          'Error',
          'Api Service not response!',
          backgroundColor: Colors.grey.shade700,
          snackPosition: SnackPosition.TOP,
          borderRadius: 20,
          colorText: Colors.grey.shade300,
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'All Fields required!',
        backgroundColor: Colors.grey.shade700,
        snackPosition: SnackPosition.TOP,
        borderRadius: 20,
        colorText: Colors.grey.shade300,
      );
    }
    update();
  }

  void saveHabitData() async {
    final newHabit = HabitModel(
      szDateOfHabit: szDate.value,
      szHabitUser: szInputUserName.value,
      szTimeLengthMinute: szTimeLengthMinute.value,
      szType: szType.value,
      szHabitId: DateTime.now().microsecondsSinceEpoch.toString(),
      mnHideHabit: 0,
    );
    if (newHabit.szDateOfHabit != '' &&
        newHabit.szHabitUser != '' &&
        newHabit.szTimeLengthMinute != '') {
      if (await OverviewService().saveHabitData(newHabit)) {
        isLoading.value = false;
        await _getHabitList();
        Get.snackbar(
          'Information',
          'Save successfully!',
          backgroundColor: Colors.grey.shade700,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.grey.shade300,
        );
        isLoading.value = true;
      } else {
        Get.snackbar(
          'Error',
          'Api Service not response!',
          backgroundColor: Colors.grey.shade700,
          snackPosition: SnackPosition.TOP,
          borderRadius: 20,
          colorText: Colors.grey.shade300,
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'All Fields required!',
        backgroundColor: Colors.grey.shade700,
        snackPosition: SnackPosition.TOP,
        borderRadius: 20,
        colorText: Colors.grey.shade300,
      );
    }
    update();
  }

  void deletHabitItem(String szHabitPageId) async {
    if (await OverviewService().deletHabitItem(szHabitPageId)) {
      isLoading.value = false;
      await _getHabitList();
      isLoading.value = true;
      Get.snackbar(
        'Info',
        'Item is deleted!',
        backgroundColor: Colors.grey.shade700,
        snackPosition: SnackPosition.TOP,
        borderRadius: 20,
        colorText: Colors.grey.shade300,
      );
    } else {
      Get.snackbar(
        'Error',
        'Item is not deleted no connection to API Service!',
        backgroundColor: Colors.grey.shade700,
        snackPosition: SnackPosition.TOP,
        borderRadius: 20,
        colorText: Colors.grey.shade300,
      );
    }
    update();
  }

  Future<void> selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      String dateText = pickedDate.toIso8601String().substring(0, 10);
      szDate.value = dateText;
      inputDateController.text = szDate.value;
    } else {
      szDate.value == '';
    }
    update();
  }
}
