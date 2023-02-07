import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Signup/controller/radio_controller.dart';
import 'package:flutter_auth/constants.dart';
import 'package:get/get.dart';

class SelectionList {
  String name;
  int index;

  SelectionList({required this.name, required this.index});
}

class RadioGroup extends StatelessWidget {
  RadioGroup({Key? key}) : super(key: key);

  final List<SelectionList> list = [
    SelectionList(
      index: 1,
      name: typePatient,
    ),
    SelectionList(
      index: 2,
      name: typeDoctor,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: list
          .map(
            (data) => Expanded(
              flex: 1,
              child: GetBuilder<RadioController>(builder: (radioController) {
                return RadioListTile(
                    title: Text(data.name),
                    groupValue: radioController.id.value,
                    activeColor: kPrimaryColor,
                    value: data.index,
                    onChanged: (val) {
                      radioController.updateAccountType(data.index);
                    });
              }),
            ),
          )
          .toList(),
    );
    return GetBuilder<RadioController>(builder: (radioController) {
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: RadioListTile(
              title: const Text('Patient'),
              groupValue: radioController.id.value,
              activeColor: kPrimaryColor,
              value: 1,
              onChanged: (val) {
                radioController.updateAccountType(1);
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: RadioListTile(
              title: const Text('Doctor'),
              groupValue: radioController.id.value,
              activeColor: kPrimaryColor,
              value: 2,
              onChanged: (val) {
                radioController.updateAccountType(2);
              },
            ),
          ),
        ],
      );
    });
  }
}
