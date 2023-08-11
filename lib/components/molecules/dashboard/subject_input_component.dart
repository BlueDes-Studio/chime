import 'package:flutter/material.dart';

class SubjectInputComponent extends StatelessWidget {
  final String hintText;
  const SubjectInputComponent({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9 * 0.9,
            height: 40,
            child: TextFormField(
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(
                hintText: hintText,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 15,
                ),
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontFamily: "Poppins",
                  fontSize: 16,
                ),
              ),
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
