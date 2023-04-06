import 'package:flutter/material.dart';
import '../controller/home_controller.dart';
import '../constants.dart';

class MyHomePage extends StatelessWidget {
  static const namedRoute = '/home-page';
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var hCtrl = HomeController.to;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'Habit Tracker Login',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    'lib/images/logoLogin.png',
                    width: size.width - 70,
                  ),
                  const SizedBox(height: 20),
                  _myContainerTextFormField(size, context, hCtrl),
                  const SizedBox(height: 20),
                  _myElevatedIconButton(hCtrl),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _myContainerTextFormField(
      Size size, BuildContext context, HomeController hCtrl) {
    return Container(
      width: size.width - 70,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextFormField(
        style: Theme.of(context).textTheme.labelMedium,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: 'Enter your Name',
          border: InputBorder.none,
          hintStyle: kHintTextFild,
        ),
        onChanged: (String? value) {
          value != null
              ? hCtrl.szInputUserName.value = value
              : hCtrl.szInputUserName.value = 'NoName';
          //print(value);
        },
      ),
    );
  }

  ElevatedButton _myElevatedIconButton(HomeController hCtrl) {
    return ElevatedButton.icon(
      onPressed: () => hCtrl.saveUserLocal(),
      icon: Icon(Icons.person_add, color: Colors.grey.shade500),
      label: Text('Add to Habit', style: kMyElevatetButtonStyle),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade800,
        elevation: 2,
        shadowColor: Colors.grey.shade400,
      ),
    );
  }
}
