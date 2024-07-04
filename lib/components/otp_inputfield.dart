import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class OtpInputField extends StatelessWidget {
  final controller;
  const OtpInputField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        width: 40,
        child: TextFormField(
            maxLines: 1,
            maxLength: 1,
            controller: controller,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) {
              if (value.length == 1) FocusScope.of(context).nextFocus();
            },
            style: TextStyle(),
            cursorColor: Colors.black,
            decoration: InputDecoration(
                counterText: "",
                fillColor: Colors.grey.shade100,
                filled: true,
                isDense: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.black)))),
      ),
    );
  }
}