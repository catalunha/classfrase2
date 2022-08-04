import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppStepOrder extends StatelessWidget {
  final dateFormat = DateFormat('dd/MM HH:mm');

  AppStepOrder({
    Key? key,
    required this.orderId,
    required this.field,
    required this.iconData,
    required this.start,
    required this.end,
    required this.controller,
  });

  final dynamic controller;
  final String orderId;
  final String? field;
  final IconData iconData;
  final DateTime? start;
  final DateTime? end;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 150,
          // color: Colors.grey,
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: field != null && end == null
                ? () {
                    controller.updateDate(
                        orderId, 'start$field', start != null);
                  }
                : null,
            child: start != null
                ? Text(dateFormat.format(start!))
                : const Icon(Icons.timer_off_outlined),
          ),
        ),
        Icon(iconData,
            color: start == null
                ? Colors.red
                : end == null
                    ? Colors.blue
                    : Colors.green),
        Container(
          width: 150,
          // color: Colors.grey,
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: field != null && start != null
                ? () {
                    controller.updateDate(orderId, 'end$field', end != null);
                  }
                : null,
            child: end != null
                ? Text(dateFormat.format(end!))
                : const Icon(Icons.timer_off_outlined),
          ),
        ),
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: [
  //       Row(
  //         children: [
  //           IconButton(
  //             onPressed: field != null
  //                 ? () {
  //                     controller.updateDate(orderId, 'start$field', false);
  //                   }
  //                 : null,
  //             icon: Icon(iconData,
  //                 color: start == null
  //                     ? Colors.red
  //                     : end == null
  //                         ? Colors.blue
  //                         : Colors.green),
  //           ),
  //           const SizedBox(width: 5),
  //           InkWell(
  //             onLongPress: () {
  //               controller.updateDate(orderId, 'start$field', true);
  //             },
  //             child: Text(start != null ? dateFormat.format(start!) : ""),
  //           ),
  //         ],
  //       ),
  //       Row(
  //         children: [
  //           IconButton(
  //             onPressed: field != null
  //                 ? () {
  //                     controller.updateDate(orderId, 'end$field', false);
  //                   }
  //                 : null,
  //             icon: Icon(iconData,
  //                 color: end == null
  //                     ? Colors.red
  //                     : end == null
  //                         ? Colors.blue
  //                         : Colors.green),
  //           ),
  //           const SizedBox(width: 5),
  //           InkWell(
  //             onLongPress: () {
  //               controller.updateDate(orderId, 'end$field', true);
  //             },
  //             child: end != null
  //                 ? Text(dateFormat.format(end!))
  //                 : Container(
  //                     width: 100,
  //                     height: 20,
  //                     color: Colors.grey,
  //                   ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
}
