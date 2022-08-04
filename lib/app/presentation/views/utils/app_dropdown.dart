import 'package:flutter/material.dart';

class AppDropDown extends StatelessWidget {
  final String title;
  final bool enabled;
  final List<String> options;
  final String variable;
  final Function(String) faz;
  final double height;
  final double width;
  const AppDropDown({
    Key? key,
    required this.title,
    this.enabled = true,
    required this.options,
    required this.variable,
    required this.faz,
    this.height = 30,
    this.width = 170,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        enabled
            ? Container(
                height: height,
                width: width,
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(style: BorderStyle.solid, width: 0.80),
                ),
                child: Center(
                  child: DropdownButton<String>(
                    value: variable,
                    icon: const Icon(Icons.arrow_downward),
                    underline: Container(
                      height: 0,
                      color: Colors.deepPurpleAccent,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    onChanged: (String? newValue) {
                      faz(newValue!);
                    },
                    items:
                        options.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              )
            : const SizedBox(width: 50, height: 60),
      ],
    );
  }
}
