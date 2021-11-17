import 'package:database/Database/dbmanager.dart';
import 'package:database/widget/gettextfield.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController emailcotroller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  final Dbmanager dbmanagerr = new Dbmanager();
  Student? student;

  // signUp() async {
  //   String fname = firstname.text;
  //   String lname = lastname.text;
  //   String email = emailcotroller.text;
  //   String passwd = password.text;
  //   String cpasswd = confirmpassword.text;
  //
  //   if (_formKey.currentState!.validate()) {
  //     if (passwd != cpasswd) {
  //       alertDialog(context, 'Password Mismatch');
  //     } else {
  //       _formKey.currentState!.save();
  //       UserModel uModel = UserModel(uid, uname, email, passwd);
  //       await dbHelper.saveData(uModel).then((userData) {
  //         alertDialog(context, "Successfully Saved");
  //
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (_) => HomePage()));
  //     }
  //   }
  // }

  // signUp() async {
  //   String fname = firstname.text;
  //   String lname = lastname.text;
  //   String email = emailcotroller.text;
  //   String passwd = password.text;
  //   String cpasswd = confirmpassword.text;
  //
  //   if (_formKey.currentState!.validate()) {
  //     if (passwd != cpasswd) {
  //       alertDialog(context, 'Password Mismatch');
  //     }
  //     else {
  //       return           Navigator.push(
  //           context, MaterialPageRoute(builder: (_) => const HomePage()));
  //
  //     }
  //     // else {
  //     //   _formKey.currentState!.save();
  //     //
  //     //   UserModel uModel = UserModel(fname, lname, email, passwd);
  //     //   await dbHelper.saveData(uModel).then((userData) {
  //     //     alertDialog(context, "Successfully Saved");
  //     //     Navigator.push(
  //     //         context, MaterialPageRoute(builder: (_) => const HomePage()));
  //     //   }).catchError((error) {
  //     //     print(error);
  //     //     alertDialog(context, "Error: Data Save Fail");
  //     //   });
  //     // }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('My Login'),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 4.5,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: const BoxDecoration(color: Colors.blue),
                    child: const Icon(
                      Icons.person,
                      size: 150,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Textfield(
                    controller: firstname,
                    icon: Icons.person,
                    hintName: 'Enter First Name',
                    inputType: TextInputType.text,
                  ),
                  Textfield(
                    controller: lastname,
                    icon: Icons.person,
                    hintName: 'Enter Last Name',
                    inputType: TextInputType.text,
                  ),
                  Textfield(
                    controller: emailcotroller,
                    icon: Icons.mail,
                    hintName: 'Enter Email',
                    inputType: TextInputType.emailAddress,
                  ),
                  Textfield(
                    controller: password,
                    icon: Icons.lock,
                    hintName: 'Password',
                    inputType: TextInputType.visiblePassword,
                    isObscureText: true,
                  ),
                  Textfield(
                    controller: confirmpassword,
                    icon: Icons.lock,
                    hintName: 'Confirm Password',
                    inputType: TextInputType.visiblePassword,
                    isObscureText: true,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          primary: Colors.deepOrangeAccent),
                      onPressed:

                          () {
                        submit(context);
                      },
                      child: const Text('Sign In')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have a account?'),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        child: const Text(
                          'Login ',
                          style: TextStyle(color: Colors.blue, fontSize: 17),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  // submit(BuildContext context) {}

   submit(BuildContext context) {
     String fname = firstname.text;
     String lname = lastname.text;
     String email = emailcotroller.text;
     String passwd = password.text;
     String cpasswd = confirmpassword.text;
     if (passwd != cpasswd) {
       alertDialog(context, 'Password Mismatch');
     }
      else if (_formKey.currentState!.validate()) {

         if (student == null) {
           Student st = Student(password: passwd,
               email: email,
               user_id: fname,
               user_name: lname);
           dbmanagerr.InsertDb(st).then((value) =>
           {
           print('Student added $value')

           }
           );

           return Navigator.push(context,
               MaterialPageRoute(builder: (context) => const HomePage()));
         }
         else{
           return null;
         }
       }
     }
   }

