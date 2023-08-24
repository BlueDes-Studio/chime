import 'package:chime/config/colorscheme.dart';
import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class CustomizedInputComponent extends StatefulWidget {
  final String label;
  final String inputHint;

  const CustomizedInputComponent({
    super.key,
    required this.label,
    required this.inputHint,
  });

  @override
  State<CustomizedInputComponent> createState() =>
      _CustomizedInputComponentState();
}

class _CustomizedInputComponentState extends State<CustomizedInputComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            widget.label,
            style: const TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: darkGrey,
            ),
          ),
        ),
        SizedBox(
          width: 270,
          child: SimpleShadow(
            opacity: 0.2, // Default: 0.5
            offset: const Offset(1, 1), // Default: Offset(2, 2)
            sigma: 2,
            child: TextFormField(
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(
                hintText: widget.inputHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    color: chimePurple,
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
                ),
              ),
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
