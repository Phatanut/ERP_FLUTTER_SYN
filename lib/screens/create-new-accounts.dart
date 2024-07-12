import 'dart:typed_data';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_app/models/profiles.dart';
import 'package:inventory_app/pallete.dart';
import 'package:inventory_app/screens/screens.dart';
import 'package:inventory_app/widgets/widgets.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({super.key});

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  Uint8List? selectedImageInBytes; // Variable to hold the selected image file
  String _imageFile = '';

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder? commonBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Colors.green[200]!.withOpacity(0.5)),
    );
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'assets/images/1167.png'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: _imageFile.isNotEmpty || _imageFile != ''
                              ? CircleAvatar(
                                  radius: size.width * 0.03,
                                  foregroundImage:
                                      MemoryImage(selectedImageInBytes!),
                                )
                              : CircleAvatar(
                                  radius: size.width * 0.03,
                                  backgroundColor:
                                      Colors.grey[400]?.withOpacity(0.4),
                                  child: Icon(FontAwesomeIcons.user,
                                      color: kWhite, size: size.width * 0.03),
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.02,
                      left: size.width * 0.44,
                      child: Container(
                        height: size.height * 0.06,
                        width: size.width * 0.05,
                        decoration: BoxDecoration(
                            color: kBlue,
                            shape: BoxShape.circle,
                            border: Border.all(color: kWhite, width: 2)),
                        child: IconButton(
                          onPressed: () {
                            pickImage();
                          },
                          icon: const Icon(FontAwesomeIcons.camera),
                          color: kWhite,
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.02,
                      left: size.width * 0.51,
                      child: Container(
                        height: size.height * 0.06,
                        width: size.width * 0.05,
                        decoration: BoxDecoration(
                            color: kBlue,
                            shape: BoxShape.circle,
                            border: Border.all(color: kWhite, width: 2)),
                        child: IconButton(
                          onPressed: () async {
                            await uploadImage(selectedImageInBytes!);
                          },
                          icon: const Icon(FontAwesomeIcons.upload),
                          color: kWhite,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Container(
                          height: size.height * 0.08,
                          width: size.width * 0.3,
                          child: Center(
                            child: TextFormField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.green[200]!.withOpacity(0.5),
                                border: commonBorder,
                                enabledBorder: commonBorder,
                                errorBorder: commonBorder,
                                focusedBorder: commonBorder,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Icon(
                                    FontAwesomeIcons.envelope,
                                    size: 28,
                                    color: kWhite,
                                  ),
                                ),
                                hintText: 'Email-Register',
                                hintStyle: kBodyText,
                              ),
                              style: kBodyText,
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (String? emails) {
                                profile.emails = emails;
                              },
                              validator: (val) {
                                if (val!.isEmpty) return 'Enter valid email';
                                return null; // change your condition
                              },
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: size.height * 0.08,
                          width: size.width * 0.3,
                          child: Center(
                              child: TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.green[200]!.withOpacity(0.5),
                              border: commonBorder,
                              enabledBorder: commonBorder,
                              errorBorder: commonBorder,
                              focusedBorder: commonBorder,
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(
                                  FontAwesomeIcons.lock,
                                  size: 28,
                                  color: kWhite,
                                ),
                              ),
                              hintText: "Password-Register",
                              hintStyle: kBodyText,
                            ),
                            obscureText: true,
                            style: kBodyText,
                            keyboardType: TextInputType.name,
                            onSaved: (String? passwords) {
                              profile.passwords = passwords;
                            },
                            validator: (val) {
                              if (val!.isEmpty) return 'Enter valid password';
                              return null; // change your condition
                            },
                            textInputAction: TextInputAction.next,
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: size.height * 0.08,
                          width: size.width * 0.3,
                          child: Center(
                              child: TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.green[200]!.withOpacity(0.5),
                              border: commonBorder,
                              enabledBorder: commonBorder,
                              errorBorder: commonBorder,
                              focusedBorder: commonBorder,
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(
                                  FontAwesomeIcons.user,
                                  size: 28,
                                  color: kWhite,
                                ),
                              ),
                              hintText: "First-Name",
                              hintStyle: kBodyText,
                            ),
                            style: kBodyText,
                            keyboardType: TextInputType.name,
                            onSaved: (String? fnames) {
                              profile.fnames = fnames;
                            },
                            validator: (val) {
                              if (val!.isEmpty) return 'Enter valid First-Name';
                              return null; // change your condition
                            },
                            textInputAction: TextInputAction.next,
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: size.height * 0.08,
                          width: size.width * 0.3,
                          child: Center(
                              child: TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.green[200]!.withOpacity(0.5),
                              border: commonBorder,
                              enabledBorder: commonBorder,
                              errorBorder: commonBorder,
                              focusedBorder: commonBorder,
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(
                                  FontAwesomeIcons.user,
                                  size: 28,
                                  color: kWhite,
                                ),
                              ),
                              hintText: "Last-Name",
                              hintStyle: kBodyText,
                            ),
                            style: kBodyText,
                            keyboardType: TextInputType.name,
                            onSaved: (String? snames) {
                              profile.snames = snames;
                            },
                            validator: (val) {
                              if (val!.isEmpty) return 'Enter valid Last-Name';
                              return null; // change your condition
                            },
                            textInputAction: TextInputAction.next,
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: size.height * 0.08,
                          width: size.width * 0.3,
                          child: Center(
                              child: TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.green[200]!.withOpacity(0.5),
                              border: commonBorder,
                              enabledBorder: commonBorder,
                              errorBorder: commonBorder,
                              focusedBorder: commonBorder,
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(
                                  FontAwesomeIcons.building,
                                  size: 28,
                                  color: kWhite,
                                ),
                              ),
                              hintText: "Company",
                              hintStyle: kBodyText,
                            ),
                            style: kBodyText,
                            keyboardType: TextInputType.name,
                            onSaved: (String? companies) {
                              profile.companies = companies;
                            },
                            validator: (val) {
                              if (val!.isEmpty) return 'Enter valid Company';
                              return null; // change your condition
                            },
                            textInputAction: TextInputAction.next,
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 25,
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
                            if (formKey.currentState!.validate()) {
                              formKey.currentState?.save();
                              try {
                                await _usersCollection.add({
                                  'email': profile.emails,
                                  'fname': profile.fnames,
                                  'sname': profile.snames,
                                  'company': profile.companies,
                                });
                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                  email: profile.emails!,
                                  password: profile.passwords!,
                                )
                                    .then((value) {
                                  formKey.currentState?.reset();
                                  Fluttertoast.showToast(
                                    msg: "Register Finished",
                                    gravity: ToastGravity.CENTER,
                                  );
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return LoginScreen();
                                  }));
                                });
                              } on FirebaseAuthException catch (e) {
                                print(e.code);
                                String? message;
                                if (e.code == 'email-already-in-use') {
                                  message = "This Email Is Already Registered";
                                } else if (e.code == "weak-password") {
                                  message =
                                      "Password Should More Than 6 Letters";
                                } else {
                                  message = e.message;
                                }
                                Fluttertoast.showToast(
                                  msg: message!,
                                  gravity: ToastGravity.CENTER,
                                );
                              }
                            }
                          },
                          backgroundColor: Colors.cyan[200]?.withOpacity(0.5),
                          child: Text(
                            "Register",
                            style: kBodyText,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?", style: kBodyText),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/');
                            },
                            child: Text("  Login",
                                style: kBodyText.copyWith(
                                    color: kBlue, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Method to pick image in flutter web
  Future<void> pickImage() async {
    try {
      // Pick image using file_picker package
      FilePickerResult? fileResult = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      // If user picks an image, save selected image to variable
      if (fileResult != null) {
        setState(() {
          _imageFile = fileResult.files.first.name;
          selectedImageInBytes = fileResult.files.first.bytes;
        });
      }
    } catch (e) {
      // If an error occured, show SnackBar with error message
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error:$e")));
    }
  }

  // Method to upload selected image in flutter web
  // This method will get selected image in Bytes
  Future<String> uploadImage(Uint8List selectedImageInBytes) async {
    try {
      // This is referance where image uploaded in firebase storage bucket
      Reference ref = FirebaseStorage.instance.ref().child('Images');

      // metadata to save image extension
      final metadata = SettableMetadata(contentType: 'image/jpeg');

      // UploadTask to finally upload image
      UploadTask uploadTask = ref.putData(selectedImageInBytes, metadata);

      // After successfully upload show SnackBar
      await uploadTask.whenComplete(() => ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Image Uploaded"))));
      return await ref.getDownloadURL();
    } catch (e) {
      // If an error occured while uploading, show SnackBar with error message
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return '';
  }
}
