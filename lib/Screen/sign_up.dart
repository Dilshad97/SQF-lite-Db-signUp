import 'package:database/widget/gettextfield.dart';
import 'package:flutter/material.dart';
import '../Database/helper.dart';
import 'homepage.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final dbHelper = DatabaseHelper.instance;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  TextEditingController emailcotroller = TextEditingController();

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
                height: MediaQuery.of(context).size.height / 4.5,
                width: MediaQuery.of(context).size.width,
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
                controller: namecontroller,
                icon: Icons.person,
                hintName: 'Enter Name',
                inputType: TextInputType.text,
              ),
              Textfield(
                controller: emailcotroller,
                icon: Icons.mail,
                hintName: 'Enter Email',
                inputType: TextInputType.emailAddress,
              ),
              Textfield(
                controller: passwordcontroller,
                icon: Icons.lock,
                hintName: 'Password',
                inputType: TextInputType.visiblePassword,
                isObscureText: true,
              ),
              Textfield(
                controller: confirmpasswordcontroller,
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
                  onPressed: () {
                    String pass = passwordcontroller.text;
                    String confirmpass = confirmpasswordcontroller.text;
                    if (_formKey.currentState!.validate()) {
                      if (pass == confirmpass) {
                        _insert();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      } else {
                        return alertDialog(context, 'Password Mismatch');
                      }
                    }
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
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void _insert() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: namecontroller.text,
      DatabaseHelper.columnPass: passwordcontroller.text,
      DatabaseHelper.columnEmail: emailcotroller.text,
    };

    final id = await dbHelper.insert(row);
    print("Id is:   $id");
  }
}
