import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class DialogColor extends StatefulWidget {
  const DialogColor({Key? key}) : super(key: key);

  @override
  State<DialogColor> createState() => _DialogColorState();
}

class _DialogColorState extends State<DialogColor> {
  Color color = Colors.red;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ColorPicker(
                  pickerColor: color,
                  enableAlpha: true,
                  showLabel: true,
                  onColorChanged: (c) {
                    setState(() {
                      color = c;
                    });
                  }),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(color);
                  },
                  child: const Text(
                    "Select",
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          )),
    );
  }
}
