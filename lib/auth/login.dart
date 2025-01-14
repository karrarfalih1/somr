import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:somer/materal/botom.dart';
import 'package:somer/materal/intext.dart';
import 'package:somer/materal/logo.dart';
import 'package:somer/materal/titlesignin.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _mystate();
}

class _mystate extends State<Login> {
  bool isLoding = false;
  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> keyform = GlobalKey();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerpasword = TextEditingController();
  TextEditingController controllerfersname = TextEditingController();
  TextEditingController controllerlastname = TextEditingController();
  TextEditingController controllerpasword2 = TextEditingController();

  Future<bool> isEmailAlreadyInUse(String email) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return result.docs.isNotEmpty;
  }

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                const SizedBox(
                  height: 90,
                ),
                Column(
                  //    mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isLoding == true
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Logo(),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "  Login",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    const TEXT(
                      testt: 'Email',
                    ),
                    clatext(
                        hinttext: "Enter your Email",
                        mycontroller: controllerEmail,
                        validator: (val) {
                          if (val == "") {
                            return "Email should not be empty";
                          } else if (!val!.contains("@gmail.com")) {
                            return "Email should be a valid Gmail address";
                          }
                          return null; // إذا كان البريد الإلكتروني صحيح، لا ترجع أي خطأ.
                        }),
                    // Text("  Login",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                    const SizedBox(
                      height: 20,
                    ),
                    const TEXT(
                      testt: 'Pasword',
                    ),
                    clatext(
                      typetext: true,
                      hinttext: "Enter your pasword",
                      mycontroller: controllerpasword,
                      validator: (val) {
                        if (val == "") {
                          return "cant pe empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      width: 1000,
                      child: const SizedBox(
                        height: 10,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
     botomc(
  onpressed: () async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoding = true;
      });

      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: controllerEmail.text,
          password: controllerpasword.text,
        );

        // Reload the user to get the updated emailVerified status
         await FirebaseAuth.instance.currentUser!.reload();
         var user = FirebaseAuth.instance.currentUser;
        if (user!.emailVerified) {
          // Navigate to the next page if email is verified
          Navigator.of(context).pushNamedAndRemoveUntil("pageone", (route) => false);
        } else {
          // Show dialog to ask the user to verify their email
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("تاكد من بريدك الالكتروني ثم سجل الدخول "),
                actions: [
                  MaterialButton(
                    child: const Text("ok"),
                    onPressed: () async {
                      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
                      Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
                    },
                  )
                ],
              );
            },
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }

      setState(() {
        isLoding = false;
      });
    }
  },
  textbotum: 'Login',
),

                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not regestor yet ? "),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed("signup");
                      },
                      child: const Text(
                        "Creat new Acunte",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 90,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
