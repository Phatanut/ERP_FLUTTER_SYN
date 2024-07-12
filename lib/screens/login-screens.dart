import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_app/models/profiles.dart';
import 'package:inventory_app/pallete.dart';
import 'package:inventory_app/screens/welcome-screens.dart';
import 'package:inventory_app/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'assets/images/1132.png'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Flexible(
                child: Center(
                    child: Text(
                  'Synatic Inventory',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.bold),
                )),
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.green[200]?.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(
                                  FontAwesomeIcons.envelope,
                                  size: 28,
                                  color: kWhite,
                                ),
                              ),
                              hintText: 'Email',
                              hintStyle: kBodyText,
                            ),
                            style: kBodyText,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? emails) {
                              profile.emails = emails;
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
                        decoration: BoxDecoration(
                          color: Colors.green[200]?.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(
                                  FontAwesomeIcons.lock,
                                  size: 28,
                                  color: kWhite,
                                ),
                              ),
                              hintText: "Password",
                              hintStyle: kBodyText,
                            ),
                            obscureText: true,
                            style: kBodyText,
                            keyboardType: TextInputType.name,
                            onSaved: (String? passwords) {
                              profile.passwords = passwords;
                            },
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, 'ForgotPassword'),
                      child: Text(
                        "Forget Password ?",
                        style: kBodyText,
                      ),
                    ),
                    SizedBox(
                      height: 60,
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
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: profile.emails!,
                                      password: profile.passwords!)
                                  .then((value) {
                                formKey.currentState?.reset();
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return CustomCarouselFB2();
                                }));
                              });
                            } on FirebaseAuthException catch (e) {
                              Fluttertoast.showToast(
                                  msg: e.message!,
                                  gravity: ToastGravity.CENTER);
                            }
                          }
                        },
                        backgroundColor: Colors.cyan[200]?.withOpacity(0.5),
                        child: Text(
                          "Login",
                          style: kBodyText,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'CreateNewAccount'),
                child: Container(
                  child: Text(
                    "Create New Account",
                    style: kBodyText,
                  ),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(width: 1, color: kWhite))),
                ),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        )
      ],
    );
  }
}
