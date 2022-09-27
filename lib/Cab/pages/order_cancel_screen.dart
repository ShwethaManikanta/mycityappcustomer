import 'package:flutter/material.dart';
import 'package:mycityapp/common/common_styles.dart';

class OrderCancelScreen extends StatefulWidget {
  const OrderCancelScreen({Key? key}) : super(key: key);

  @override
  State<OrderCancelScreen> createState() => _OrderCancelScreenState();
}

class _OrderCancelScreenState extends State<OrderCancelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () async {
                  await Navigator.of(context).pushNamedAndRemoveUntil(
                      '/MainHomePage', (Route<dynamic> route) => false);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 50),
                    child: Text(" Ok ", style: CommonStyles.black57S17()),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildAppBar() {
    return AppBar(
      backgroundColor: Colors.amber,
      title: Text(
        'Order Cancel',
        style: CommonStyles.whiteText16BoldW500(),
      ),
      centerTitle: true,
      leading: const SizedBox(),
    );
  }
}
