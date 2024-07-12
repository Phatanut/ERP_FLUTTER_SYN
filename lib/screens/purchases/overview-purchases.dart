import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/pallete.dart';
import 'package:inventory_app/screens/purchases/pipeline-purchases.dart';

class OverviewPurchase extends StatefulWidget {
  const OverviewPurchase({super.key});

  @override
  State<OverviewPurchase> createState() => _OverviewPurchaseState();
}

class _OverviewPurchaseState extends State<OverviewPurchase> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("pr_details").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: EdgeInsets.all(60.0),
              child: Container(
                width: size.width * 0.2,
                child: ListView(
                    children: snapshot.data!.docs.map((document) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Card(
                          borderOnForeground: true,
                          color: document["dropdowncompany"] == 'ซินเนติก'
                              ? Colors.lightBlueAccent[100]
                              : Colors.lightGreenAccent[100],
                          child: ListTile(
                              leading: IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Scaffold(
                                        appBar: AppBar(
                                            backgroundColor: Colors.green,
                                            leading: IconButton(
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                    context, MaterialPageRoute(
                                                        builder: (context) {
                                                  return PipelinePurchase();
                                                }));
                                              },
                                              icon: Icon(
                                                Icons.arrow_back_ios,
                                                color: kWhite,
                                              ),
                                            ),
                                            title: Center(
                                              child: Text(
                                                "รายละเอียดใบขอซื้อ",
                                                style: kBodyText,
                                              ),
                                            )),
                                        body: SingleChildScrollView(
                                          child: StreamBuilder<QuerySnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection("pr_details")
                                                  .snapshots(),
                                              builder: (context,
                                                  AsyncSnapshot<QuerySnapshot>
                                                      snapshot) {
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                                return Center(
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(100),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .stretch,
                                                          children: [
                                                            Text(
                                                              "ใบขอซื้อรายการที่  " +
                                                                  document[
                                                                      "purchase_req"],
                                                              style:
                                                                  kBodyTextBlack,
                                                            ),
                                                            SizedBox(
                                                              height: 60,
                                                            ),
                                                            Text(
                                                              "รายละเอียดรายการ  :  ",
                                                              style:
                                                                  kBodyTextBlack,
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text("บริษัท  :  " +
                                                                document[
                                                                    'dropdowncompany']),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text("แผนก  :  " +
                                                                document[
                                                                    'dropdowndep']),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text("ชื่อ-นามสกุล  :  " +
                                                                document[
                                                                    'fsname']),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text("วันที่เขียน  :  " +
                                                                document[
                                                                    'date_pr']),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text("บริษัทที่แนะนำ  :  " +
                                                                document[
                                                                    'recommend_company']),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text("E-mail  :  " +
                                                                document[
                                                                    'email_pr']),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text("เบอร์โทรศัพท์  :  " +
                                                                document[
                                                                    'phone']),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text("โปรเจค  :  " +
                                                                document[
                                                                    'project']),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text("ประเภทงาน  :  " +
                                                                document[
                                                                    'dropdownwork']),
                                                            SizedBox(
                                                              height: 60,
                                                            ),
                                                            DataTable(
                                                                border: TableBorder
                                                                    .all(),
                                                                headingRowColor: document[
                                                                            "dropdowncompany"] ==
                                                                        "ซินโนวิค"
                                                                    ? MaterialStateColor.resolveWith((states) => Colors
                                                                        .lightGreenAccent
                                                                        .shade100)
                                                                    : MaterialStateColor.resolveWith((states) => Colors
                                                                        .lightBlueAccent
                                                                        .shade100),
                                                                columns: <DataColumn>[
                                                                  DataColumn(
                                                                      label: Text(
                                                                          "ลำดับ")),
                                                                  DataColumn(
                                                                      label: Text(
                                                                          "รายการสั่งซื้อ")),
                                                                  DataColumn(
                                                                      label: Text(
                                                                          "รายละเอียด")),
                                                                  DataColumn(
                                                                      label: Text(
                                                                          "จำนวน")),
                                                                  DataColumn(
                                                                      label: Text(
                                                                          "ขนาด")),
                                                                  DataColumn(
                                                                      label: Text(
                                                                          "หน่วย")),
                                                                  DataColumn(
                                                                      label: Text(
                                                                          "ราคา")),
                                                                  DataColumn(
                                                                      label: Text(
                                                                          "ราคา/หน่วย")),
                                                                  DataColumn(
                                                                      label: Text(
                                                                          "หมายเหตุ")),
                                                                ],
                                                                rows: <DataRow>[
                                                                  DataRow(
                                                                      cells: <DataCell>[
                                                                        DataCell(
                                                                            Text(document["number1"])),
                                                                        DataCell(
                                                                            Text(document["order1"])),
                                                                        DataCell(
                                                                            Text(document["des1"])),
                                                                        DataCell(
                                                                            Text(document["amount1"])),
                                                                        DataCell(
                                                                            Text(document["scale1"])),
                                                                        DataCell(
                                                                            Text(document["unit1"])),
                                                                        DataCell(
                                                                            Text(document["price1"])),
                                                                        DataCell(
                                                                            Text("${document["price1"] == "" && document["amount1"] == "" ? "" : (num.parse(document["price1"])) / (num.parse(document["amount1"]))}")),
                                                                        DataCell(
                                                                            Text(document["additonal1"])),
                                                                      ]),
                                                                  DataRow(
                                                                      cells: <DataCell>[
                                                                        DataCell(
                                                                            Text(document["number2"])),
                                                                        DataCell(
                                                                            Text(document["order2"])),
                                                                        DataCell(
                                                                            Text(document["des2"])),
                                                                        DataCell(
                                                                            Text(document["amount2"])),
                                                                        DataCell(
                                                                            Text(document["scale2"])),
                                                                        DataCell(
                                                                            Text(document["unit2"])),
                                                                        DataCell(
                                                                            Text(document["price2"])),
                                                                        DataCell(
                                                                            Text("${document["price2"] == "" && document["amount2"] == "" ? "" : (num.parse(document["price2"])) / (num.parse(document["amount2"]))}")),
                                                                        DataCell(
                                                                            Text(document["additonal2"])),
                                                                      ]),
                                                                  DataRow(
                                                                      cells: <DataCell>[
                                                                        DataCell(
                                                                            Text(document["number3"])),
                                                                        DataCell(
                                                                            Text(document["order3"])),
                                                                        DataCell(
                                                                            Text(document["des3"])),
                                                                        DataCell(
                                                                            Text(document["amount3"])),
                                                                        DataCell(
                                                                            Text(document["scale3"])),
                                                                        DataCell(
                                                                            Text(document["unit3"])),
                                                                        DataCell(
                                                                            Text(document["price3"])),
                                                                        DataCell(
                                                                            Text("${document["price3"] == "" && document["amount3"] == "" ? "" : (num.parse(document["price3"])) / (num.parse(document["amount3"]))}")),
                                                                        DataCell(
                                                                            Text(document["additonal3"])),
                                                                      ]),
                                                                  DataRow(
                                                                      cells: <DataCell>[
                                                                        DataCell(
                                                                            Text(document["number4"])),
                                                                        DataCell(
                                                                            Text(document["order4"])),
                                                                        DataCell(
                                                                            Text(document["des4"])),
                                                                        DataCell(
                                                                            Text(document["amount4"])),
                                                                        DataCell(
                                                                            Text(document["scale4"])),
                                                                        DataCell(
                                                                            Text(document["unit4"])),
                                                                        DataCell(
                                                                            Text(document["price4"])),
                                                                        DataCell(
                                                                            Text("${document["price4"] == "" && document["amount4"] == "" ? "" : (num.parse(document["price4"])) / (num.parse(document["amount4"]))}")),
                                                                        DataCell(
                                                                            Text(document["additonal4"])),
                                                                      ]),
                                                                  DataRow(
                                                                      cells: <DataCell>[
                                                                        DataCell(
                                                                            Text(document["number5"])),
                                                                        DataCell(
                                                                            Text(document["order5"])),
                                                                        DataCell(
                                                                            Text(document["des5"])),
                                                                        DataCell(
                                                                            Text(document["amount5"])),
                                                                        DataCell(
                                                                            Text(document["scale5"])),
                                                                        DataCell(
                                                                            Text(document["unit5"])),
                                                                        DataCell(
                                                                            Text(document["price5"])),
                                                                        DataCell(
                                                                            Text("${document["price5"] == "" && document["amount5"] == "" ? "" : (num.parse(document["price5"])) / (num.parse(document["amount5"]))}")),
                                                                        DataCell(
                                                                            Text(document["additonal5"])),
                                                                      ]),
                                                                  DataRow(
                                                                      cells: <DataCell>[
                                                                        DataCell(
                                                                            Text(document["number6"])),
                                                                        DataCell(
                                                                            Text(document["order6"])),
                                                                        DataCell(
                                                                            Text(document["des6"])),
                                                                        DataCell(
                                                                            Text(document["amount6"])),
                                                                        DataCell(
                                                                            Text(document["scale6"])),
                                                                        DataCell(
                                                                            Text(document["unit6"])),
                                                                        DataCell(
                                                                            Text(document["price6"])),
                                                                        DataCell(
                                                                            Text("${document["price6"] == "" && document["amount6"] == "" ? "" : (num.parse(document["price6"])) / (num.parse(document["amount6"]))}")),
                                                                        DataCell(
                                                                            Text(document["additonal6"])),
                                                                      ]),
                                                                  DataRow(
                                                                      cells: <DataCell>[
                                                                        DataCell(
                                                                            Text(document["number7"])),
                                                                        DataCell(
                                                                            Text(document["order7"])),
                                                                        DataCell(
                                                                            Text(document["des7"])),
                                                                        DataCell(
                                                                            Text(document["amount7"])),
                                                                        DataCell(
                                                                            Text(document["scale7"])),
                                                                        DataCell(
                                                                            Text(document["unit7"])),
                                                                        DataCell(
                                                                            Text(document["price7"])),
                                                                        DataCell(
                                                                            Text("${document["price7"] == "" && document["amount7"] == "" ? "" : (num.parse(document["price7"])) / (num.parse(document["amount7"]))}")),
                                                                        DataCell(
                                                                            Text(document["additonal7"])),
                                                                      ]),
                                                                  DataRow(
                                                                      cells: <DataCell>[
                                                                        DataCell(
                                                                            Text(document["number8"])),
                                                                        DataCell(
                                                                            Text(document["order8"])),
                                                                        DataCell(
                                                                            Text(document["des8"])),
                                                                        DataCell(
                                                                            Text(document["amount8"])),
                                                                        DataCell(
                                                                            Text(document["scale8"])),
                                                                        DataCell(
                                                                            Text(document["unit8"])),
                                                                        DataCell(
                                                                            Text(document["price8"])),
                                                                        DataCell(
                                                                            Text("${document["price8"] == "" && document["amount8"] == "" ? "" : (num.parse(document["price8"])) / (num.parse(document["amount8"]))}")),
                                                                        DataCell(
                                                                            Text(document["additonal8"])),
                                                                      ]),
                                                                  DataRow(
                                                                      cells: <DataCell>[
                                                                        DataCell(
                                                                            Text(document["number9"])),
                                                                        DataCell(
                                                                            Text(document["order9"])),
                                                                        DataCell(
                                                                            Text(document["des9"])),
                                                                        DataCell(
                                                                            Text(document["amount9"])),
                                                                        DataCell(
                                                                            Text(document["scale9"])),
                                                                        DataCell(
                                                                            Text(document["unit9"])),
                                                                        DataCell(
                                                                            Text(document["price9"])),
                                                                        DataCell(
                                                                            Text("${document["price9"] == "" && document["amount9"] == "" ? "" : (num.parse(document["price9"])) / (num.parse(document["amount9"]))}")),
                                                                        DataCell(
                                                                            Text(document["additonal9"])),
                                                                      ]),
                                                                  DataRow(
                                                                      cells: <DataCell>[
                                                                        DataCell(
                                                                            Text(document["number10"])),
                                                                        DataCell(
                                                                            Text(document["order10"])),
                                                                        DataCell(
                                                                            Text(document["des10"])),
                                                                        DataCell(
                                                                            Text(document["amount10"])),
                                                                        DataCell(
                                                                            Text(document["scale10"])),
                                                                        DataCell(
                                                                            Text(document["unit10"])),
                                                                        DataCell(
                                                                            Text(document["price10"])),
                                                                        DataCell(
                                                                            Text("${document["price10"] == "" && document["amount10"] == "" ? "" : (num.parse(document["price10"])) / (num.parse(document["amount10"]))}")),
                                                                        DataCell(
                                                                            Text(document["additonal10"])),
                                                                      ]),
                                                                ]),
                                                            SizedBox(
                                                              height: 40,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text(
                                                                    "ราคารวม  :  ${(int.parse(document["price1"] == "" ? "0" : document["price1"])) + (int.parse(document["price2"] == "" ? "0" : document["price2"])) + (int.parse(document["price3"] == "" ? "0" : document["price3"])) + (int.parse(document["price4"] == "" ? "0" : document["price4"])) + (int.parse(document["price5"] == "" ? "0" : document["price5"])) + (int.parse(document["price6"] == "" ? "0" : document["price6"])) + (int.parse(document["price7"] == "" ? "0" : document["price7"])) + (int.parse(document["price8"] == "" ? "0" : document["price8"])) + (int.parse(document["price9"] == "" ? "0" : document["price9"])) + (int.parse(document["price10"] == "" ? "0" : document["price10"]))}  บาท"),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text(("หมวดหมู่สินค้า  :  " +
                                                                (document["สิ้นเปลือง"] ==
                                                                        true
                                                                    ? '[สิ้นเปลือง]  '
                                                                    : "") +
                                                                (document["อุปกรณ์-เครื่องมือ"] ==
                                                                        true
                                                                    ? '[อุปกรณ์-เครื่องมือ]  '
                                                                    : "") +
                                                                (document["วัตถุดิบเพื่อการขาย"] ==
                                                                        true
                                                                    ? '[วัตถุดิบเพื่อการขาย]  '
                                                                    : "") +
                                                                (document["วัตถุดิบเพื่อการซ่อมแซม"] ==
                                                                        true
                                                                    ? '[วัตถุดิบเพื่อการซ่อมแซม]  '
                                                                    : "") +
                                                                (document["วัตถุดิบเพื่อการผลิต"] ==
                                                                        true
                                                                    ? '[วัตถุดิบเพื่อการผลิต]'
                                                                    : "") as String)),
                                                            SizedBox(
                                                              height: 100,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  height:
                                                                      size.height *
                                                                          0.08,
                                                                  width:
                                                                      size.width *
                                                                          0.1,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                    color: Colors
                                                                            .purple[
                                                                        200],
                                                                  ),
                                                                  child:
                                                                      FloatingActionButton(
                                                                    onPressed:
                                                                        () {},
                                                                    backgroundColor:
                                                                        Colors.purpleAccent[
                                                                            200],
                                                                    child: Text(
                                                                      "Approve",
                                                                      style:
                                                                          kBodyText,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 200,
                                                                ),
                                                                Container(
                                                                  height:
                                                                      size.height *
                                                                          0.08,
                                                                  width:
                                                                      size.width *
                                                                          0.1,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                    color: Colors
                                                                            .red[
                                                                        200],
                                                                  ),
                                                                  child:
                                                                      FloatingActionButton(
                                                                    onPressed:
                                                                        () {},
                                                                    backgroundColor:
                                                                        Colors.redAccent[
                                                                            200],
                                                                    child: Text(
                                                                      "Reject",
                                                                      style:
                                                                          kBodyText,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ));
                                  }));
                                },
                                alignment: Alignment.topLeft,
                                icon: Icon(Icons.list_alt_outlined),
                                iconSize: 30,
                              ),
                              title: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Chip(
                                    label: document["dropdowncompany"] ==
                                            'ซินเนติก'
                                        ? Text("ใบขอซื้อ Synatic")
                                        : Text("ใบขอซื้อ Synovic"),
                                    backgroundColor: Colors.deepPurpleAccent,
                                    labelStyle: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(document["purchase_req"]),
                                  Text("บริษัท  :  " +
                                      document["dropdowncompany"]),
                                  Text("แผนก  :  " + document["dropdowndep"]),
                                  Text(
                                    "ประเภทงาน  :  " + document["dropdownwork"],
                                    style: TextStyle(color: Colors.red[600]),
                                  ),
                                  Text(
                                      "ชื่อ-นามสกุล  :  " + document["fsname"]),
                                  //Text("แผนก  :  " + document["department"]),
                                  Text(
                                      "วันที่เขียน  :  " + document["date_pr"]),
                                  Text(
                                      "จำนวนรายการ  :  ${int.parse((document['number1']).length.toString()) + int.parse((document['number2']).length.toString()) + int.parse((document['number3']).length.toString()) + int.parse((document['number4']).length.toString()) + int.parse((document['number5']).length.toString()) + int.parse((document['number6']).length.toString()) + int.parse((document['number7']).length.toString()) + int.parse((document['number8']).length.toString()) + int.parse((document['number9']).length.toString()) + (int.parse((document['number10']).length.toString()) == 2 ? (int.parse((document['number10']).length.toString()) - 1) : int.parse((document['number10']).length.toString()))}"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: size.height * 0.03,
                                    width: size.width * 0.05,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.amber),
                                    child: Center(
                                      child: Text("รออนุมัติ"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ))),
                    ],
                  );
                }).toList()),
              ),
            );
          }),
    );
  }
}
