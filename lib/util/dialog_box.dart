import 'package:flutter/material.dart';
import 'package:todo/util/my_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  // form key
  final _formkey = GlobalKey<FormState>();
  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user data
            TextFormField(
              // validator: (value) {
              //   if (value!.isEmpty) {
              //     return "Please enter a task";
              //   }
              //   return null;
              // },
              maxLength: 25,
              cursorColor: Colors.black,
              textCapitalization: TextCapitalization.sentences,
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                hintText: "Add a new task (max. 25 characters)",
              ),
            ),

            // buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // save button
                MyButton(
                  text: "Save",
                  onPressed: onSave,
                ),
                const SizedBox(
                  width: 10,
                ),
                // cancel button
                MyButton(
                  text: "Cancel",
                  onPressed: onCancel,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
