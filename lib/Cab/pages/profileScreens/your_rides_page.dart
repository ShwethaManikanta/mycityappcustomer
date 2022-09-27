import 'package:flutter/material.dart';
import 'package:mycityapp/common/common_styles.dart';


class YourRidesPage extends StatefulWidget {
  const YourRidesPage({Key? key}) : super(key: key);

  @override
  _YourRidesPageState createState() => _YourRidesPageState();
}

class _YourRidesPageState extends State<YourRidesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Your Rides',
          style: CommonStyles.blackS16Thin(),
        ),
      ),
    );
  }
}
