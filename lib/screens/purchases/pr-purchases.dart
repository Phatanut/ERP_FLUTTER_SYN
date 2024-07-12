import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_app/forms/pr_formtable.dart';
import 'package:inventory_app/forms/pre_pr.dart';
import 'package:inventory_app/models/detail_pr.dart';
import 'package:inventory_app/models/table_pr.dart';
import 'package:inventory_app/pallete.dart';
import 'package:inventory_app/screens/purchases/pipeline-purchases.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrPurchase extends StatefulWidget {
  const PrPurchase({super.key});

  @override
  State<PrPurchase> createState() => _PrPurchaseState();
}

class _PrPurchaseState extends State<PrPurchase> {
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;
  String? selectedValue1;
  String? selectedValue2;
  String? selectedValue3;
  String? selectedValue4;
  TextEditingController _dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  PrDetails prdetails = PrDetails();
  TablePR1 tablePR1 = TablePR1();
  TablePR2 tablePR2 = TablePR2();
  TablePR3 tablePR3 = TablePR3();
  TablePR4 tablePR4 = TablePR4();
  TablePR5 tablePR5 = TablePR5();
  TablePR6 tablePR6 = TablePR6();
  TablePR7 tablePR7 = TablePR7();
  TablePR8 tablePR8 = TablePR8();
  TablePR9 tablePR9 = TablePR9();
  TablePR10 tablePR10 = TablePR10();
  CollectionReference _prdetailsCollection =
      FirebaseFirestore.instance.collection('pr_details');
  CollectionReference _projectsCollection =
      FirebaseFirestore.instance.collection('projects');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Image(
                      image: AssetImage('assets/images/synatic_logo.png'),
                      height: 200,
                      width: 200,
                    ),
                  ),
                ),
                Text(
                  "แบบฟอร์มใบขอซื้อ",
                  style: kBodyTextBlack,
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("company_syna_syno")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child:
                                  Text("Some error occured ${snapshot.error}"));
                        }
                        List<DropdownMenuItem> companyItems = [];
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        } else {
                          final selectProgram =
                              snapshot.data?.docs.reversed.toList();
                          if (selectProgram != null) {
                            for (var compani in selectProgram) {
                              companyItems.add(DropdownMenuItem(
                                value: compani["namecom"],
                                child: Text(compani["namecom"]),
                              ));
                            }
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              height: size.height * 0.08,
                              width: size.width * 0.4,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blueAccent.shade400,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(3)),
                              child: DropdownButton(
                                underline: const SizedBox(),
                                isExpanded: true,
                                hint: const Text(
                                  "กรุณาเลือกบริษัท",
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                                value: selectedValue1,
                                items: companyItems,
                                onChanged: (newvalue) {
                                  setState(() {
                                    selectedValue1 = newvalue;
                                  });
                                },
                              ),
                            ),
                          );
                        }
                      }),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("company_syna_syno")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child:
                                  Text("Some error occured ${snapshot.error}"));
                        }
                        List<DropdownMenuItem> depItems = [];
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        } else {
                          final selectDep =
                              snapshot.data?.docs.reversed.toList();
                          if (selectDep != null &&
                              selectedValue1 == "ซินเนติก") {
                            depItems.add(DropdownMenuItem(
                              value: "แมคคาทรอนิกส์",
                              child: Text("แมคคาทรอนิกส์"),
                            ));
                            depItems.add(DropdownMenuItem(
                              value: "ไฟฟ้า",
                              child: Text("ไฟฟ้า"),
                            ));
                            depItems.add(DropdownMenuItem(
                              value: "ธุรการ",
                              child: Text("ธุรการ"),
                            ));
                          } else if (selectDep != null &&
                              selectedValue1 == "ซินโนวิค") {
                            depItems.add(DropdownMenuItem(
                              value: "ซอฟต์แวร์",
                              child: Text("ซอฟต์แวร์"),
                            ));
                            depItems.add(DropdownMenuItem(
                              value: "ธุรการ",
                              child: Text("ธุรการ"),
                            ));
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              height: size.height * 0.08,
                              width: size.width * 0.4,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blueAccent.shade400,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(3)),
                              child: DropdownButton(
                                underline: const SizedBox(),
                                isExpanded: true,
                                hint: const Text(
                                  "กรุณาเลือกแผนก",
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                                value: selectedValue2,
                                items: depItems,
                                onChanged: (newvalue1) {
                                  setState(() {
                                    selectedValue2 = newvalue1;
                                  });
                                },
                              ),
                            ),
                          );
                        }
                      }),
                  PreprForm(
                    fieldName: "ชื่อ-นามสกุล",
                    prefixIconColor: Colors.blueAccent.shade400,
                    onSave: (String? fsnames) {
                      prdetails.fsnames = fsnames;
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.4,
                        child: TextFormField(
                          controller: _dateController,
                          decoration: InputDecoration(
                            labelText: "วันที่เขียน",
                            filled: true,
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueAccent.shade400),
                            ),
                            labelStyle:
                                const TextStyle(color: Colors.blueAccent),
                          ),
                          readOnly: true,
                          onTap: () {
                            _selectDate();
                          },
                          onSaved: (String) {
                            _dateController.text;
                          },
                        ),
                      )),
                  PreprForm(
                    fieldName: "บริษัทที่แนะนำ",
                    prefixIconColor: Colors.blueAccent.shade400,
                    onSave: (String? recommendcompanyprs) {
                      prdetails.recommendcompanypr = recommendcompanyprs;
                    },
                  ),
                  PreprForm(
                    fieldName: "เบอร์โทรศัพท์",
                    prefixIconColor: Colors.blueAccent.shade400,
                    onSave: (String? phones) {
                      prdetails.phones = phones;
                    },
                  ),
                  PreprForm(
                    fieldName: "Email",
                    prefixIconColor: Colors.blueAccent.shade400,
                    onSave: (String? emailprs) {
                      prdetails.emailprs = emailprs;
                    },
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("projects")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child:
                                  Text("Some error occured ${snapshot.error}"));
                        }
                        List<DropdownMenuItem> companyprop = [];
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        } else {
                          final selectProgram2 =
                              snapshot.data?.docs.reversed.toList();
                          if (selectProgram2 != null) {
                            for (var compani2 in selectProgram2) {
                              companyprop.add(DropdownMenuItem(
                                value: compani2["project"],
                                child: Text(compani2["project"]),
                              ));
                            }
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              height: size.height * 0.08,
                              width: size.width * 0.4,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blueAccent.shade400,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(3)),
                              child: DropdownButton(
                                underline: const SizedBox(),
                                isExpanded: true,
                                hint: const Text(
                                  "กรุณาเลือกโปรเจค (กรณีเป็นโปรเจคใหม่ ให้เลือก -> โปรเจคใหม่)",
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                                value: selectedValue4,
                                items: companyprop,
                                onChanged: (newvalue3) {
                                  setState(() {
                                    selectedValue4 = newvalue3;
                                  });
                                },
                              ),
                            ),
                          );
                        }
                      }),
                  PreprForm(
                    fieldName: "(กรณีเป็นโปรเจคใหม่) ชื่อโปรเจค",
                    prefixIconColor: Colors.blueAccent.shade400,
                    onSave: (String? compa) {
                      prdetails.compa = compa;
                    },
                  ),
                  PreprForm(
                    fieldName: "(กรณีเป็นโปรเจคใหม่) รหัสโปรเจค",
                    prefixIconColor: Colors.blueAccent.shade400,
                    onSave: (String? proj_no) {
                      prdetails.proj_no = proj_no;
                    },
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("company_syna_syno")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child:
                                  Text("Some error occured ${snapshot.error}"));
                        }
                        List<DropdownMenuItem> workItems = [];
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        } else {
                          final selectWork =
                              snapshot.data?.docs.reversed.toList();
                          if (selectWork != null) {
                            workItems.add(DropdownMenuItem(
                              value: "สำนักงาน",
                              child: Text("สำนักงาน"),
                            ));
                            workItems.add(DropdownMenuItem(
                              value: "การผลิต",
                              child: Text("การผลิต"),
                            ));
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              height: size.height * 0.08,
                              width: size.width * 0.4,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blueAccent.shade400,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(3)),
                              child: DropdownButton(
                                underline: const SizedBox(),
                                isExpanded: true,
                                hint: const Text(
                                  "ประเภทงาน",
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                                value: selectedValue3,
                                items: workItems,
                                onChanged: (newvalue2) {
                                  setState(() {
                                    selectedValue3 = newvalue2;
                                  });
                                },
                              ),
                            ),
                          );
                        }
                      }),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.lightBlueAccent.shade100),
                      border: TableBorder.all(
                        width: 1.0,
                      ),
                      columns: [
                        DataColumn(label: Text("ลำดับ")),
                        DataColumn(label: Text("รายการสั่งซื้อ")),
                        DataColumn(label: Text("รายละเอียด")),
                        DataColumn(label: Text("จำนวน")),
                        DataColumn(label: Text("ขนาด")),
                        DataColumn(label: Text("หน่วย")),
                        DataColumn(label: Text("ราคา")),
                        DataColumn(label: Text("หมายเหตุ")),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(FormPRtable(
                            onSave1: (String? n1) {
                              tablePR1.n1 = n1;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? o1) {
                              tablePR1.o1 = o1;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? d1) {
                              tablePR1.d1 = d1;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? a1) {
                              tablePR1.a1 = a1;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? scale1) {
                              tablePR1.scale1 = scale1;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? u1) {
                              tablePR1.u1 = u1;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? price1) {
                              tablePR1.price1 = price1;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? add1) {
                              tablePR1.add1 = add1;
                            },
                            fieldName1: '',
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(FormPRtable(
                            onSave1: (String? n2) {
                              tablePR2.n2 = n2;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? o2) {
                              tablePR2.o2 = o2;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? d2) {
                              tablePR2.d2 = d2;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? a2) {
                              tablePR2.a2 = a2;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? scale2) {
                              tablePR2.scale2 = scale2;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? u2) {
                              tablePR2.u2 = u2;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? price2) {
                              tablePR2.price2 = price2;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? add2) {
                              tablePR2.add2 = add2;
                            },
                            fieldName1: '',
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(FormPRtable(
                            onSave1: (String? n3) {
                              tablePR3.n3 = n3;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? o3) {
                              tablePR3.o3 = o3;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? d3) {
                              tablePR3.d3 = d3;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? a3) {
                              tablePR3.a3 = a3;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? scale3) {
                              tablePR3.scale3 = scale3;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? u3) {
                              tablePR3.u3 = u3;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? price3) {
                              tablePR3.price3 = price3;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? add3) {
                              tablePR3.add3 = add3;
                            },
                            fieldName1: '',
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(FormPRtable(
                            onSave1: (String? n4) {
                              tablePR4.n4 = n4;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? o4) {
                              tablePR4.o4 = o4;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? d4) {
                              tablePR4.d4 = d4;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? a4) {
                              tablePR4.a4 = a4;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? scale4) {
                              tablePR4.scale4 = scale4;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? u4) {
                              tablePR4.u4 = u4;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? price4) {
                              tablePR4.price4 = price4;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? add4) {
                              tablePR4.add4 = add4;
                            },
                            fieldName1: '',
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(FormPRtable(
                            onSave1: (String? n5) {
                              tablePR5.n5 = n5;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? o5) {
                              tablePR5.o5 = o5;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? d5) {
                              tablePR5.d5 = d5;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? a5) {
                              tablePR5.a5 = a5;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? scale5) {
                              tablePR5.scale5 = scale5;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? u5) {
                              tablePR5.u5 = u5;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? price5) {
                              tablePR5.price5 = price5;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? add5) {
                              tablePR5.add5 = add5;
                            },
                            fieldName1: '',
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(FormPRtable(
                            onSave1: (String? n6) {
                              tablePR6.n6 = n6;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? o6) {
                              tablePR6.o6 = o6;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? d6) {
                              tablePR6.d6 = d6;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? a6) {
                              tablePR6.a6 = a6;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? scale6) {
                              tablePR6.scale6 = scale6;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? u6) {
                              tablePR6.u6 = u6;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? price6) {
                              tablePR6.price6 = price6;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? add6) {
                              tablePR6.add6 = add6;
                            },
                            fieldName1: '',
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(FormPRtable(
                            onSave1: (String? n7) {
                              tablePR7.n7 = n7;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? o7) {
                              tablePR7.o7 = o7;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? d7) {
                              tablePR7.d7 = d7;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? a7) {
                              tablePR7.a7 = a7;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? scale7) {
                              tablePR7.scale7 = scale7;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? u7) {
                              tablePR7.u7 = u7;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? price7) {
                              tablePR7.price7 = price7;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? add7) {
                              tablePR7.add7 = add7;
                            },
                            fieldName1: '',
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(FormPRtable(
                            onSave1: (String? n8) {
                              tablePR8.n8 = n8;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? o8) {
                              tablePR8.o8 = o8;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? d8) {
                              tablePR8.d8 = d8;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? a8) {
                              tablePR8.a8 = a8;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? scale8) {
                              tablePR8.scale8 = scale8;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? u8) {
                              tablePR8.u8 = u8;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? price8) {
                              tablePR8.price8 = price8;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? add8) {
                              tablePR8.add8 = add8;
                            },
                            fieldName1: '',
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(FormPRtable(
                            onSave1: (String? n9) {
                              tablePR9.n9 = n9;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? o9) {
                              tablePR9.o9 = o9;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? d9) {
                              tablePR9.d9 = d9;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? a9) {
                              tablePR9.a9 = a9;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? scale9) {
                              tablePR9.scale9 = scale9;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? u9) {
                              tablePR9.u9 = u9;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? price9) {
                              tablePR9.price9 = price9;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? add9) {
                              tablePR9.add9 = add9;
                            },
                            fieldName1: '',
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(FormPRtable(
                            onSave1: (String? n10) {
                              tablePR10.n10 = n10;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? o10) {
                              tablePR10.o10 = o10;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? d10) {
                              tablePR10.d10 = d10;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? a10) {
                              tablePR10.a10 = a10;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? scale10) {
                              tablePR10.scale10 = scale10;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? u10) {
                              tablePR10.u10 = u10;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? price10) {
                              tablePR10.price10 = price10;
                            },
                            fieldName1: '',
                          )),
                          DataCell(FormPRtable(
                            onSave1: (String? add10) {
                              tablePR10.add10 = add10;
                            },
                            fieldName1: '',
                          )),
                        ]),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "หมวดหมู่สินค้า",
                    style: kBodyTextBlack,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        //Use Align so that our Container does not get all width as it happens in ListView
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.lightBlueAccent.shade100,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.lightBlue,
                                value: isChecked1,
                                onChanged: (val) {
                                  setState(() => isChecked1 = val!);
                                  print(isChecked1);
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: Text("สิ้นเปลือง"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Align(
                        //Use Align so that our Container does not get all width as it happens in ListView
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.lightBlueAccent.shade100,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.lightBlue,
                                value: isChecked2,
                                onChanged: (val) {
                                  setState(() => isChecked2 = val!);
                                  print(isChecked2);
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: Text("อุปกรณ์-เครื่องมือ"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Align(
                        //Use Align so that our Container does not get all width as it happens in ListView
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.lightBlueAccent.shade100,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.lightBlue,
                                value: isChecked3,
                                onChanged: (val) {
                                  setState(() => isChecked3 = val!);
                                  print(isChecked3);
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: Text("วัตถุดิบเพื่อการขาย"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Align(
                        //Use Align so that our Container does not get all width as it happens in ListView
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.lightBlueAccent.shade100,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.lightBlue,
                                value: isChecked4,
                                onChanged: (val) {
                                  setState(() => isChecked4 = val!);
                                  print(isChecked4);
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: Text("วัตถุดิบเพื่อการซ่อมแซม"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Align(
                        //Use Align so that our Container does not get all width as it happens in ListView
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.lightBlueAccent.shade100,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.lightBlue,
                                value: isChecked5,
                                onChanged: (val) {
                                  setState(() => isChecked5 = val!);
                                  print(isChecked5);
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: Text("วัตถุดิบเพื่อการผลิต"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 100),
                  Text("เปรียบเทียบร้านค้า", style: kBodyTextBlack),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //upload1
                      ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? result1 = await FilePicker.platform
                              .pickFiles(
                                  allowMultiple: false, type: FileType.any);
                          if (result1 == null) {
                            print('Error : No file selected');
                          }
                        },
                        child: Text("ไฟล์ร้านที่1"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreenAccent,
                            textStyle: kBodyText1),
                      ),
                      SizedBox(width: 40),
                      ElevatedButton(
                        onPressed: () async {},
                        child: Text("ไฟล์ร้านที่2"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreenAccent,
                            textStyle: kBodyText1),
                      ),
                      SizedBox(width: 40),
                      ElevatedButton(
                        onPressed: () async {},
                        child: Text("ไฟล์ร้านที่3"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreenAccent,
                            textStyle: kBodyText1),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              height: size.height * 0.08,
              width: size.width * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.blue[200],
              ),
              child: FloatingActionButton(
                onPressed: () async {
                  //ซินเน แบบโปรเจคใหม่
                  if (formKey.currentState!.validate() &&
                      selectedValue1 == "ซินเนติก" &&
                      selectedValue4 == "โปรเจคใหม่") {
                    formKey.currentState?.save();
                    try {
                      String invoiceNumber = await generateInvoiceNumber();
                      await _projectsCollection.add({
                        "project": "${prdetails.compa}" +
                            "  " +
                            "(${prdetails.proj_no})",
                        "proj_no": prdetails.proj_no,
                        "compa": "ซินเนติก"
                      });
                      await _prdetailsCollection.add({
                        "project": "${prdetails.compa}" +
                            "  " +
                            "(${prdetails.proj_no})",
                        "dropdowncompany": selectedValue1,
                        "dropdowndep": selectedValue2,
                        "dropdownwork": selectedValue3,
                        "fsname": prdetails.fsnames,
                        "date_pr": _dateController.text,
                        "recommend_company": prdetails.recommendcompanypr,
                        "phone": prdetails.phones,
                        "email_pr": prdetails.emailprs,
                        "number1": tablePR1.n1,
                        "order1": tablePR1.o1,
                        "des1": tablePR1.d1,
                        "amount1": tablePR1.a1,
                        "unit1": tablePR1.u1,
                        "additonal1": tablePR1.add1,
                        "number2": tablePR2.n2,
                        "order2": tablePR2.o2,
                        "des2": tablePR2.d2,
                        "amount2": tablePR2.a2,
                        "unit2": tablePR2.u2,
                        "additonal2": tablePR2.add2,
                        "number3": tablePR3.n3,
                        "order3": tablePR3.o3,
                        "des3": tablePR3.d3,
                        "amount3": tablePR3.a3,
                        "unit3": tablePR3.u3,
                        "additonal3": tablePR3.add3,
                        "number4": tablePR4.n4,
                        "order4": tablePR4.o4,
                        "des4": tablePR4.d4,
                        "amount4": tablePR4.a4,
                        "unit4": tablePR4.u4,
                        "additonal4": tablePR4.add4,
                        "number5": tablePR5.n5,
                        "order5": tablePR5.o5,
                        "des5": tablePR5.d5,
                        "amount5": tablePR5.a5,
                        "unit5": tablePR5.u5,
                        "additonal5": tablePR5.add5,
                        "number6": tablePR6.n6,
                        "order6": tablePR6.o6,
                        "des6": tablePR6.d6,
                        "amount6": tablePR6.a6,
                        "unit6": tablePR6.u6,
                        "additonal6": tablePR6.add6,
                        "number7": tablePR7.n7,
                        "order7": tablePR7.o7,
                        "des7": tablePR7.d7,
                        "amount7": tablePR7.a7,
                        "unit7": tablePR7.u7,
                        "additonal7": tablePR7.add7,
                        "number8": tablePR8.n8,
                        "order8": tablePR8.o8,
                        "des8": tablePR8.d8,
                        "amount8": tablePR8.a8,
                        "unit8": tablePR8.u8,
                        "additonal8": tablePR8.add8,
                        "number9": tablePR9.n9,
                        "order9": tablePR9.o9,
                        "des9": tablePR9.d9,
                        "amount9": tablePR9.a9,
                        "unit9": tablePR9.u9,
                        "additonal9": tablePR9.add9,
                        "number10": tablePR10.n10,
                        "order10": tablePR10.o10,
                        "des10": tablePR10.d10,
                        "amount10": tablePR10.a10,
                        "unit10": tablePR10.u10,
                        "additonal10": tablePR10.add10,
                        "scale1": tablePR1.scale1,
                        "scale2": tablePR2.scale2,
                        "scale3": tablePR3.scale3,
                        "scale4": tablePR4.scale4,
                        "scale5": tablePR5.scale5,
                        "scale6": tablePR6.scale6,
                        "scale7": tablePR7.scale7,
                        "scale8": tablePR8.scale8,
                        "scale9": tablePR9.scale9,
                        "scale10": tablePR10.scale10,
                        "สิ้นเปลือง": isChecked1,
                        "อุปกรณ์-เครื่องมือ": isChecked2,
                        "วัตถุดิบเพื่อการขาย": isChecked3,
                        "วัตถุดิบเพื่อการซ่อมแซม": isChecked4,
                        "วัตถุดิบเพื่อการผลิต": isChecked5,
                        "purchase_req": invoiceNumber,
                        "price1": tablePR1.price1,
                        "price2": tablePR2.price2,
                        "price3": tablePR3.price3,
                        "price4": tablePR4.price4,
                        "price5": tablePR5.price5,
                        "price6": tablePR6.price6,
                        "price7": tablePR7.price7,
                        "price8": tablePR8.price8,
                        "price9": tablePR9.price9,
                        "price10": tablePR10.price10,
                        "proj_no": prdetails.proj_no,
                        "compa": prdetails.compa,
                      }).then((value) {
                        formKey.currentState?.reset();
                        Fluttertoast.showToast(
                          msg: "Submitted",
                          gravity: ToastGravity.CENTER,
                        );
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return PipelinePurchase();
                        }));
                      });
                    } catch (e) {}
                  }
                  // ซินเน แบบโปรเจคที่มีอยู่แล้ว
                  if (formKey.currentState!.validate() &&
                      selectedValue1 == "ซินเนติก" &&
                      selectedValue4 != "โปรเจคใหม่") {
                    formKey.currentState?.save();
                    try {
                      String invoiceNumber = await generateInvoiceNumber();
                      await _prdetailsCollection.add({
                        "project": selectedValue4,
                        "dropdowncompany": selectedValue1,
                        "dropdowndep": selectedValue2,
                        "dropdownwork": selectedValue3,
                        "fsname": prdetails.fsnames,
                        "date_pr": _dateController.text,
                        "recommend_company": prdetails.recommendcompanypr,
                        "phone": prdetails.phones,
                        "email_pr": prdetails.emailprs,
                        "number1": tablePR1.n1,
                        "order1": tablePR1.o1,
                        "des1": tablePR1.d1,
                        "amount1": tablePR1.a1,
                        "unit1": tablePR1.u1,
                        "additonal1": tablePR1.add1,
                        "number2": tablePR2.n2,
                        "order2": tablePR2.o2,
                        "des2": tablePR2.d2,
                        "amount2": tablePR2.a2,
                        "unit2": tablePR2.u2,
                        "additonal2": tablePR2.add2,
                        "number3": tablePR3.n3,
                        "order3": tablePR3.o3,
                        "des3": tablePR3.d3,
                        "amount3": tablePR3.a3,
                        "unit3": tablePR3.u3,
                        "additonal3": tablePR3.add3,
                        "number4": tablePR4.n4,
                        "order4": tablePR4.o4,
                        "des4": tablePR4.d4,
                        "amount4": tablePR4.a4,
                        "unit4": tablePR4.u4,
                        "additonal4": tablePR4.add4,
                        "number5": tablePR5.n5,
                        "order5": tablePR5.o5,
                        "des5": tablePR5.d5,
                        "amount5": tablePR5.a5,
                        "unit5": tablePR5.u5,
                        "additonal5": tablePR5.add5,
                        "number6": tablePR6.n6,
                        "order6": tablePR6.o6,
                        "des6": tablePR6.d6,
                        "amount6": tablePR6.a6,
                        "unit6": tablePR6.u6,
                        "additonal6": tablePR6.add6,
                        "number7": tablePR7.n7,
                        "order7": tablePR7.o7,
                        "des7": tablePR7.d7,
                        "amount7": tablePR7.a7,
                        "unit7": tablePR7.u7,
                        "additonal7": tablePR7.add7,
                        "number8": tablePR8.n8,
                        "order8": tablePR8.o8,
                        "des8": tablePR8.d8,
                        "amount8": tablePR8.a8,
                        "unit8": tablePR8.u8,
                        "additonal8": tablePR8.add8,
                        "number9": tablePR9.n9,
                        "order9": tablePR9.o9,
                        "des9": tablePR9.d9,
                        "amount9": tablePR9.a9,
                        "unit9": tablePR9.u9,
                        "additonal9": tablePR9.add9,
                        "number10": tablePR10.n10,
                        "order10": tablePR10.o10,
                        "des10": tablePR10.d10,
                        "amount10": tablePR10.a10,
                        "unit10": tablePR10.u10,
                        "additonal10": tablePR10.add10,
                        "scale1": tablePR1.scale1,
                        "scale2": tablePR2.scale2,
                        "scale3": tablePR3.scale3,
                        "scale4": tablePR4.scale4,
                        "scale5": tablePR5.scale5,
                        "scale6": tablePR6.scale6,
                        "scale7": tablePR7.scale7,
                        "scale8": tablePR8.scale8,
                        "scale9": tablePR9.scale9,
                        "scale10": tablePR10.scale10,
                        "สิ้นเปลือง": isChecked1,
                        "อุปกรณ์-เครื่องมือ": isChecked2,
                        "วัตถุดิบเพื่อการขาย": isChecked3,
                        "วัตถุดิบเพื่อการซ่อมแซม": isChecked4,
                        "วัตถุดิบเพื่อการผลิต": isChecked5,
                        "purchase_req": invoiceNumber,
                        "price1": tablePR1.price1,
                        "price2": tablePR2.price2,
                        "price3": tablePR3.price3,
                        "price4": tablePR4.price4,
                        "price5": tablePR5.price5,
                        "price6": tablePR6.price6,
                        "price7": tablePR7.price7,
                        "price8": tablePR8.price8,
                        "price9": tablePR9.price9,
                        "price10": tablePR10.price10,
                        "proj_no": prdetails.proj_no,
                        "compa": prdetails.compa,
                      }).then((value) {
                        formKey.currentState?.reset();
                        Fluttertoast.showToast(
                          msg: "Submitted",
                          gravity: ToastGravity.CENTER,
                        );
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return PipelinePurchase();
                        }));
                      });
                    } catch (e) {}
                  }
                  // ซินโน แบบโปรเจคใหม่
                  if (formKey.currentState!.validate() &&
                      selectedValue1 == "ซินโนวิค" &&
                      selectedValue4 == "โปรเจคใหม่") {
                    formKey.currentState?.save();
                    try {
                      String invoiceNumber1 = await generateInvoiceNumber1();
                      await _projectsCollection.add({
                        "project": "${prdetails.compa}" +
                            "  " +
                            "(${prdetails.proj_no})",
                        "proj_no": prdetails.proj_no,
                        "compa": "ซินโนวิค"
                      });
                      await _prdetailsCollection.add({
                        "project": "${prdetails.compa}" +
                            "  " +
                            "(${prdetails.proj_no})",
                        "dropdowncompany": selectedValue1,
                        "dropdowndep": selectedValue2,
                        "dropdownwork": selectedValue3,
                        "fsname": prdetails.fsnames,
                        "date_pr": _dateController.text,
                        "recommend_company": prdetails.recommendcompanypr,
                        "phone": prdetails.phones,
                        "email_pr": prdetails.emailprs,
                        "number1": tablePR1.n1,
                        "order1": tablePR1.o1,
                        "des1": tablePR1.d1,
                        "amount1": tablePR1.a1,
                        "unit1": tablePR1.u1,
                        "additonal1": tablePR1.add1,
                        "number2": tablePR2.n2,
                        "order2": tablePR2.o2,
                        "des2": tablePR2.d2,
                        "amount2": tablePR2.a2,
                        "unit2": tablePR2.u2,
                        "additonal2": tablePR2.add2,
                        "number3": tablePR3.n3,
                        "order3": tablePR3.o3,
                        "des3": tablePR3.d3,
                        "amount3": tablePR3.a3,
                        "unit3": tablePR3.u3,
                        "additonal3": tablePR3.add3,
                        "number4": tablePR4.n4,
                        "order4": tablePR4.o4,
                        "des4": tablePR4.d4,
                        "amount4": tablePR4.a4,
                        "unit4": tablePR4.u4,
                        "additonal4": tablePR4.add4,
                        "number5": tablePR5.n5,
                        "order5": tablePR5.o5,
                        "des5": tablePR5.d5,
                        "amount5": tablePR5.a5,
                        "unit5": tablePR5.u5,
                        "additonal5": tablePR5.add5,
                        "number6": tablePR6.n6,
                        "order6": tablePR6.o6,
                        "des6": tablePR6.d6,
                        "amount6": tablePR6.a6,
                        "unit6": tablePR6.u6,
                        "additonal6": tablePR6.add6,
                        "number7": tablePR7.n7,
                        "order7": tablePR7.o7,
                        "des7": tablePR7.d7,
                        "amount7": tablePR7.a7,
                        "unit7": tablePR7.u7,
                        "additonal7": tablePR7.add7,
                        "number8": tablePR8.n8,
                        "order8": tablePR8.o8,
                        "des8": tablePR8.d8,
                        "amount8": tablePR8.a8,
                        "unit8": tablePR8.u8,
                        "additonal8": tablePR8.add8,
                        "number9": tablePR9.n9,
                        "order9": tablePR9.o9,
                        "des9": tablePR9.d9,
                        "amount9": tablePR9.a9,
                        "unit9": tablePR9.u9,
                        "additonal9": tablePR9.add9,
                        "number10": tablePR10.n10,
                        "order10": tablePR10.o10,
                        "des10": tablePR10.d10,
                        "amount10": tablePR10.a10,
                        "unit10": tablePR10.u10,
                        "additonal10": tablePR10.add10,
                        "scale1": tablePR1.scale1,
                        "scale2": tablePR2.scale2,
                        "scale3": tablePR3.scale3,
                        "scale4": tablePR4.scale4,
                        "scale5": tablePR5.scale5,
                        "scale6": tablePR6.scale6,
                        "scale7": tablePR7.scale7,
                        "scale8": tablePR8.scale8,
                        "scale9": tablePR9.scale9,
                        "scale10": tablePR10.scale10,
                        "สิ้นเปลือง": isChecked1,
                        "อุปกรณ์-เครื่องมือ": isChecked2,
                        "วัตถุดิบเพื่อการขาย": isChecked3,
                        "วัตถุดิบเพื่อการซ่อมแซม": isChecked4,
                        "วัตถุดิบเพื่อการผลิต": isChecked5,
                        "purchase_req": invoiceNumber1,
                        "price1": tablePR1.price1,
                        "price2": tablePR2.price2,
                        "price3": tablePR3.price3,
                        "price4": tablePR4.price4,
                        "price5": tablePR5.price5,
                        "price6": tablePR6.price6,
                        "price7": tablePR7.price7,
                        "price8": tablePR8.price8,
                        "price9": tablePR9.price9,
                        "price10": tablePR10.price10,
                      }).then((value) {
                        formKey.currentState?.reset();
                        Fluttertoast.showToast(
                          msg: "Submitted",
                          gravity: ToastGravity.CENTER,
                        );
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return PipelinePurchase();
                        }));
                      });
                    } catch (e) {}
                  }
                  // ซินโน แบบโปรเจคเดิม
                  if (formKey.currentState!.validate() &&
                      selectedValue1 == "ซินโนวิค" &&
                      selectedValue4 != "โปรเจคใหม่") {
                    formKey.currentState?.save();
                    try {
                      String invoiceNumber1 = await generateInvoiceNumber1();
                      await _prdetailsCollection.add({
                        "project": selectedValue4,
                        "dropdowncompany": selectedValue1,
                        "dropdowndep": selectedValue2,
                        "dropdownwork": selectedValue3,
                        "fsname": prdetails.fsnames,
                        "date_pr": _dateController.text,
                        "recommend_company": prdetails.recommendcompanypr,
                        "phone": prdetails.phones,
                        "email_pr": prdetails.emailprs,
                        "number1": tablePR1.n1,
                        "order1": tablePR1.o1,
                        "des1": tablePR1.d1,
                        "amount1": tablePR1.a1,
                        "unit1": tablePR1.u1,
                        "additonal1": tablePR1.add1,
                        "number2": tablePR2.n2,
                        "order2": tablePR2.o2,
                        "des2": tablePR2.d2,
                        "amount2": tablePR2.a2,
                        "unit2": tablePR2.u2,
                        "additonal2": tablePR2.add2,
                        "number3": tablePR3.n3,
                        "order3": tablePR3.o3,
                        "des3": tablePR3.d3,
                        "amount3": tablePR3.a3,
                        "unit3": tablePR3.u3,
                        "additonal3": tablePR3.add3,
                        "number4": tablePR4.n4,
                        "order4": tablePR4.o4,
                        "des4": tablePR4.d4,
                        "amount4": tablePR4.a4,
                        "unit4": tablePR4.u4,
                        "additonal4": tablePR4.add4,
                        "number5": tablePR5.n5,
                        "order5": tablePR5.o5,
                        "des5": tablePR5.d5,
                        "amount5": tablePR5.a5,
                        "unit5": tablePR5.u5,
                        "additonal5": tablePR5.add5,
                        "number6": tablePR6.n6,
                        "order6": tablePR6.o6,
                        "des6": tablePR6.d6,
                        "amount6": tablePR6.a6,
                        "unit6": tablePR6.u6,
                        "additonal6": tablePR6.add6,
                        "number7": tablePR7.n7,
                        "order7": tablePR7.o7,
                        "des7": tablePR7.d7,
                        "amount7": tablePR7.a7,
                        "unit7": tablePR7.u7,
                        "additonal7": tablePR7.add7,
                        "number8": tablePR8.n8,
                        "order8": tablePR8.o8,
                        "des8": tablePR8.d8,
                        "amount8": tablePR8.a8,
                        "unit8": tablePR8.u8,
                        "additonal8": tablePR8.add8,
                        "number9": tablePR9.n9,
                        "order9": tablePR9.o9,
                        "des9": tablePR9.d9,
                        "amount9": tablePR9.a9,
                        "unit9": tablePR9.u9,
                        "additonal9": tablePR9.add9,
                        "number10": tablePR10.n10,
                        "order10": tablePR10.o10,
                        "des10": tablePR10.d10,
                        "amount10": tablePR10.a10,
                        "unit10": tablePR10.u10,
                        "additonal10": tablePR10.add10,
                        "scale1": tablePR1.scale1,
                        "scale2": tablePR2.scale2,
                        "scale3": tablePR3.scale3,
                        "scale4": tablePR4.scale4,
                        "scale5": tablePR5.scale5,
                        "scale6": tablePR6.scale6,
                        "scale7": tablePR7.scale7,
                        "scale8": tablePR8.scale8,
                        "scale9": tablePR9.scale9,
                        "scale10": tablePR10.scale10,
                        "สิ้นเปลือง": isChecked1,
                        "อุปกรณ์-เครื่องมือ": isChecked2,
                        "วัตถุดิบเพื่อการขาย": isChecked3,
                        "วัตถุดิบเพื่อการซ่อมแซม": isChecked4,
                        "วัตถุดิบเพื่อการผลิต": isChecked5,
                        "purchase_req": invoiceNumber1,
                        "price1": tablePR1.price1,
                        "price2": tablePR2.price2,
                        "price3": tablePR3.price3,
                        "price4": tablePR4.price4,
                        "price5": tablePR5.price5,
                        "price6": tablePR6.price6,
                        "price7": tablePR7.price7,
                        "price8": tablePR8.price8,
                        "price9": tablePR9.price9,
                        "price10": tablePR10.price10,
                      }).then((value) {
                        formKey.currentState?.reset();
                        Fluttertoast.showToast(
                          msg: "Submitted",
                          gravity: ToastGravity.CENTER,
                        );
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return PipelinePurchase();
                        }));
                      });
                    } catch (e) {}
                  }
                },
                backgroundColor: Colors.blueAccent[200],
                child: Text(
                  "Submit Form",
                  style: kBodyText,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  Future<String> generateInvoiceNumber() async {
    final DateTime now = DateTime.now();
    final String prefix = "SYNA-";
    final String currentMonth = now.month.toString().padLeft(2, '0');

    // Use SharedPreferences for persistent storage
    final sharedPreferences = await SharedPreferences.getInstance();
    int sequenceNumber = sharedPreferences.getInt('invoiceSequence') ?? 0;

    sequenceNumber = (sequenceNumber + 1) % 1000; // Wrap around at 999

    // Update shared preferences asynchronously
    await sharedPreferences
        .setInt('invoiceSequence', sequenceNumber)
        .then((_) => null);

    // Format sequence number with leading zeros
    final String formattedSequenceNumber =
        sequenceNumber.toString().padLeft(3, '0');

    return '$prefix$currentMonth-$formattedSequenceNumber';
  }

  Future<String> generateInvoiceNumber1() async {
    final DateTime now1 = DateTime.now();
    final String prefix1 = "SYNO-";
    final String currentMonth1 = now1.month.toString().padLeft(2, '0');

    // Use SharedPreferences for persistent storage
    final sharedPreferences = await SharedPreferences.getInstance();
    int sequenceNumber1 = sharedPreferences.getInt('invoiceSequence') ?? 0;

    sequenceNumber1 = (sequenceNumber1 + 1) % 1000; // Wrap around at 999

    // Update shared preferences asynchronously
    await sharedPreferences
        .setInt('invoiceSequence', sequenceNumber1)
        .then((_) => null);

    // Format sequence number with leading zeros
    final String formattedSequenceNumber1 =
        sequenceNumber1.toString().padLeft(3, '0');

    return '$prefix1$currentMonth1-$formattedSequenceNumber1';
  }
}
