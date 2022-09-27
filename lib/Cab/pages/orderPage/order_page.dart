import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mycityapp/Cab/Services/apiProvider/order_history_api_provider.dart';
import 'package:mycityapp/Cab/pages/orderPage/order_page_list_view.dart';
import 'package:mycityapp/common/common_styles.dart';
import 'package:mycityapp/common/utils.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Timer? timer;

  @override
  void initState() {
    if (context.read<OrderHistoryAPIProviderCab>().orderHistoryResponse == null) {
      context.read<OrderHistoryAPIProviderCab>().getOrders().whenComplete(() {});
    }
    if (mounted) {
      timer = Timer.periodic(const Duration(seconds: 10), (timer) {
        if (mounted) {
          context.read<OrderHistoryAPIProviderCab>().getOrders();
        }
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    // waitingTime?.cancel();
    super.dispose();
  }

  // @override
  // void dispose() {
  //   timer?.cancel();  // Cancelling a timer on dispose
  //   WidgetsBinding.instance.removeObserver(this); // Removing an observer
  //   super.dispose();
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   setTimer(state != AppLifecycleState.resumed);
  // }

  // void setTimer(bool isBackground) {
  //   int delaySeconds = isBackground ? 5 : 3;

  //   // Cancelling previous timer, if there was one, and creating a new one
  //   timer?.cancel();
  //   timer = Timer.periodic(Duration(seconds: delaySeconds), (t) async {
  //     // Not sending a request, if waiting for response
  //     if (!waitingForResponse) {
  //       waitingForResponse = true;
  //       await post();
  //       waitingForResponse = false;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  buildAppBar() {
    return AppBar(
      backgroundColor: Colors.amber,
      title: Text(
        'Order History',
        style: CommonStyles.whiteText16BoldW500(),
      ),
      centerTitle: true,
      leading: const SizedBox(),
    );
  }

  buildBody() {
    return Column(
      children: [
        // buildOrderHistory(),
        buildOrderlist(),
      ],
    );
  }

  // buildOrderHistory() {
  //   return Container(
  //     alignment: Alignment.topLeft,
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
  //       child:
  //     ),
  //   );
  // }

  buildOrderlist() {
    final orderHistoryAPIProvider =
        Provider.of<OrderHistoryAPIProviderCab>(context);

    if (orderHistoryAPIProvider.ifLoading) {
      print("LOading -----------  = = = == = = == = = = ");
      return SizedBox(
        child: Utils.getCenterLoading(),
        height: 400,
        width: 300,
      );
    } else if (orderHistoryAPIProvider.error) {
      print("error -----------  = = = == = = == = = = ");

      print("-----Order History PAge--------" +
          orderHistoryAPIProvider.orderHistoryResponse.toString());

      return SizedBox(
        height: 400,
        width: 300,
        child: Utils.showErrorMessage(
            orderHistoryAPIProvider.errorMessage.toUpperCase()),
      );
    } else if (orderHistoryAPIProvider.orderHistoryResponse == null ||
        orderHistoryAPIProvider.orderHistoryResponse!.status! == "0") {
      print("Order History Status -----------  = = = == = = == = = =  0");

      return Expanded(
        child: Utils.showErrorMessage(orderHistoryAPIProvider
            .orderHistoryResponse!.message!
            .toUpperCase()),
      );
    }

    return Expanded(
      child: SizedBox(
        child: RefreshIndicator(
          onRefresh: () async {
            await context.read<OrderHistoryAPIProviderCab>().getOrders();
          },
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              primary: false,
              itemCount: orderHistoryAPIProvider
                  .orderHistoryResponse!.orderHistory!.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                // list.add(Model(
                //     orderHistoryAPIProvider.orderHistoryResponse!
                //         .orderHistory![index].tripDetails!.fromAddress!,
                //     Colors.green));
                // list.add(Model(
                //     orderHistoryAPIProvider.orderHistoryResponse!
                //         .orderHistory![index].tripDetails!.toAddress!,
                //     Colors.red));
                return OrderPageListView(index: index);
              }),
        ),
      ),
    );
  }
}
