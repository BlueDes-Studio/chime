import 'package:flutter/material.dart';

class SubjectEntryComponent extends StatelessWidget {
  final int index;
  final void Function() removeEntry;

  const SubjectEntryComponent({
    super.key,
    required this.index,
    required this.removeEntry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "class$index:",
            style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
            ),
          ),
          Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.1,
                color: Colors.grey,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(
                  Icons.calendar_month,
                  color: Colors.grey,
                  size: 16,
                ),
                const Text(
                  "Day",
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: "Poppins",
                    fontSize: 14,
                  ),
                ),
                Container(
                  width: 5,
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                  size: 16,
                )
              ],
            ),
          ),
          Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.1,
                color: Colors.grey,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(
                  Icons.timer,
                  color: Colors.grey,
                  size: 16,
                ),
                const Text(
                  "Time",
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: "Poppins",
                    fontSize: 14,
                  ),
                ),
                Container(
                  width: 5,
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                  size: 16,
                )
              ],
            ),
          ),
          IconButton(
            onPressed: removeEntry,
            icon: const Icon(
              Icons.delete,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
