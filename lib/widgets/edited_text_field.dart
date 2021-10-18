import 'package:flutter/material.dart';
import 'package:rentopolis/config/configuration.dart';

class EditedTextField extends StatelessWidget {
  late String hintText;
  late Icon prefixIcon;
  late TextEditingController textEditingController;
  late TextInputType inputType;
  late var variable;
  EditedTextField(
      {required this.hintText,
      required this.prefixIcon,
      required this.textEditingController,
      required this.inputType,required this.variable});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        maxLength:
            (inputType == TextInputType.phone) ? 10 : TextField.noMaxLength,
        // onSaved: (value) {
        //   variable=value;
        // },
        keyboardType: inputType,
        style: mainFont(fontSize: 20),
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.blue,
            ),
          ),
          hintText: hintText,
          prefixIcon: prefixIcon,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: teal,
            ),
          ),
        ),
      ),
    );
  }
}
