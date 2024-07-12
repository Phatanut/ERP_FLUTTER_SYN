import 'package:flutter/material.dart';
import 'package:inventory_app/pallete.dart';
import 'package:inventory_app/screens/purchases/overview-purchases.dart';
import 'package:inventory_app/screens/purchases/po-purchases.dart';
import 'package:inventory_app/screens/purchases/pr-purchases.dart';
import 'package:inventory_app/screens/purchases/quotation-purchases.dart';
import 'package:inventory_app/screens/welcome-screens.dart';

class PipelinePurchase extends StatefulWidget {
  const PipelinePurchase({super.key});

  @override
  State<PipelinePurchase> createState() => _PipelinePurchaseState();
}

class _PipelinePurchaseState extends State<PipelinePurchase> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Purchasing",
            style: kBodyText,
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return CustomCarouselFB2();
              }));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: kWhite,
            ),
          ),
          bottom: TabBar(tabs: [
            Tab(
              child: Text(
                "Pipelines",
                style: kBodyText,
              ),
            ),
            Tab(
              child: Text(
                "ใบขอซื้อ",
                style: kBodyText,
              ),
            ),
            Tab(
              child: Text(
                "เปรียบเทียบใบเสนอราคา",
                style: kBodyText,
              ),
            ),
            Tab(
              child: Text(
                "ใบสั่งซื้อ",
                style: kBodyText,
              ),
            ),
          ]),
        ),
        body: TabBarView(children: [
          OverviewPurchase(),
          PrPurchase(),
          QuotationPurchase(),
          PoPurchase(),
        ]),
      ),
    );
  }
}
