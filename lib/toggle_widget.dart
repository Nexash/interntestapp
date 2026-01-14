import 'package:flutter/material.dart';

class ToggleHelper extends StatefulWidget {
  final bool iscompleted;
  final ValueChanged<bool> onToggle;
  const ToggleHelper({
    super.key,
    required this.iscompleted,
    required this.onToggle,
  });

  @override
  State<ToggleHelper> createState() => _ToggleHelperState();
}

class _ToggleHelperState extends State<ToggleHelper> {
  List<bool> isSelected = [true, false];

  @override
  void initState() {
    super.initState();
    isSelected = [!widget.iscompleted, widget.iscompleted];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ToggleButtons(
        borderRadius: BorderRadius.circular(8),
        borderColor: Colors.grey,
        selectedBorderColor: Colors.blue,
        selectedColor: Colors.white,
        fillColor: const Color.fromARGB(255, 56, 188, 142),
        isSelected: isSelected,
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width / 2 - 16,
          minHeight: 20,
        ),
        onPressed: (int index) {
          setState(() {
            // Only one selected at a time
            for (int i = 0; i < isSelected.length; i++) {
              isSelected[i] = i == index;
            }

            // Notify parent/provider about the new state
            // index 1 = Completed, index 0 = TO DO
            widget.onToggle(index == 1);
          });
        },

        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text("TO DO"),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text("Completed"),
            ),
          ),
        ],
      ),
    );
  }
}
