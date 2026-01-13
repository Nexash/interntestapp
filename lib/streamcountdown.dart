import 'dart:async';

import 'package:flutter/material.dart';

class CountDown extends StatefulWidget {
  const CountDown({super.key});

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  TextEditingController numbercontroller = TextEditingController();
  Stream<int>? _stream;

  Stream<int> countDown(int number) async* {
    for (int i = number; i >= 0; i--) {
      await Future.delayed(Duration(seconds: 1));
      yield i;
    }
  }

  @override
  void dispose() {
    numbercontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CountDown")),
      body: Column(
        children: [
          TextField(
            controller: numbercontroller,
            decoration: InputDecoration(
              labelText: "Enter number",
              hintText: "Countdown Number",
              border: OutlineInputBorder(),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              final text = numbercontroller.text;
              if (text.isNotEmpty) {
                final number = int.tryParse(text);
                if (number != null) {
                  setState(() {
                    _stream = countDown(number);
                  });
                }
              }
            },
            child: Text("Start"),
          ),

          SizedBox(height: 20),

          _stream == null
              ? Text("")
              : StreamBuilder<int>(
                stream: _stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Failed");
                  } else {
                    return Text(
                      "CountDown: ${snapshot.data} ",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 40,
                      ),
                    );
                  }
                },
              ),
        ],
      ),
    );
  }
}
