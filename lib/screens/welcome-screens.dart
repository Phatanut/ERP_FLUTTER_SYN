import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/pallete.dart';
import 'package:inventory_app/screens/login-screens.dart';
import 'package:inventory_app/screens/purchases/pipeline-purchases.dart';
import 'package:inventory_app/widgets/background-homes.dart';

class CustomCarouselFB2 extends StatefulWidget {
  const CustomCarouselFB2({Key? key}) : super(key: key);

  @override
  _CustomCarouselFB2State createState() => _CustomCarouselFB2State();
}

class _CustomCarouselFB2State extends State<CustomCarouselFB2> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  //signout function
  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  final formKey = GlobalKey<FormState>();

  List<Widget> cards = [
    CardFb1(
      text: "Purchasing",
      imageAsset: "assets/images/purchase-order.png",
    ),
    CardFb2(text: "CRM", imageAsset: "assets/images/crm.png"),
    CardFb3(
      text: "Inventory",
      imageAsset: "assets/images/inv.png",
    )
  ];

  final double carouselItemMargin = 16;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: .2);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      BackgroundHome(image: 'assets/images/1153.png'),
      Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            signOut();
          },
          child: Icon(Icons.logout_rounded),
          backgroundColor: Colors.lightGreenAccent.shade100,
          shape: CircleBorder(),
        ),
        body: Column(
          children: [
            Flexible(
              child: Center(
                  child: Text(
                'Categories',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.bold),
              )),
            ),
            Flexible(
                child: SizedBox(
              height: 5,
            )),
            Flexible(
              child: PageView.builder(
                  controller: _pageController,
                  itemCount: cards.length,
                  onPageChanged: (int position) {
                    setState(() {});
                  },
                  itemBuilder: (BuildContext context, int position) {
                    return imageSlider(position);
                  }),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget imageSlider(int position) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, widget) {
        return Container(
          margin: EdgeInsets.all(carouselItemMargin),
          child: Center(child: widget),
        );
      },
      child: Container(
        child: cards[position],
      ),
    );
  }
}

class CardFb1 extends StatelessWidget {
  final String text;
  final String imageAsset;

  const CardFb1({required this.text, required this.imageAsset, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
        return PipelinePurchase();
      })),
      child: Container(
        width: 200,
        height: 210,
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: Colors.green[200]?.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12.5),
          boxShadow: [
            BoxShadow(
                offset: const Offset(10, 20),
                blurRadius: 10,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.05)),
          ],
        ),
        child: Column(
          children: [
            Image.asset(imageAsset, height: 90, fit: BoxFit.cover),
            const Spacer(),
            Text(text, textAlign: TextAlign.center, style: kBodyText),
          ],
        ),
      ),
    );
  }
}

class CardFb2 extends StatelessWidget {
  final String text;
  final String imageAsset;

  const CardFb2({required this.text, required this.imageAsset, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 200,
        height: 210,
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: Colors.green[200]?.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12.5),
          boxShadow: [
            BoxShadow(
                offset: const Offset(10, 20),
                blurRadius: 10,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.05)),
          ],
        ),
        child: Column(
          children: [
            Image.asset(imageAsset, height: 90, fit: BoxFit.cover),
            const Spacer(),
            Text(text, textAlign: TextAlign.center, style: kBodyText),
          ],
        ),
      ),
    );
  }
}

class CardFb3 extends StatelessWidget {
  final String text;
  final String imageAsset;

  const CardFb3({required this.text, required this.imageAsset, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 200,
        height: 210,
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: Colors.green[200]?.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12.5),
          boxShadow: [
            BoxShadow(
                offset: const Offset(10, 20),
                blurRadius: 10,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.05)),
          ],
        ),
        child: Column(
          children: [
            Image.asset(imageAsset, height: 90, fit: BoxFit.cover),
            const Spacer(),
            Text(text, textAlign: TextAlign.center, style: kBodyText),
          ],
        ),
      ),
    );
  }
}

// ถ้าจะสร้าง Tab สำหรับ CRM เพิ่ม ให้ CardFB1 = ของ Crm , CardFb2 = ของ Purchase และ CardFb3 = ของ Inventory
