import 'package:client/core/theme/app_palette.dart';
import 'package:client/features/auth/view/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' as fpdart;
import '../../repositories/auth_remote_repository.dart';
import '../widgets/auth_gradient_button.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isSecure = true;


  void showBottomSheet(String email, String password) {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        height: 200,
        width: double.infinity,
        color: Colors.transparent,
        child: Card(
          color: Pallete.gradient1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text("Email: $email"),
              Text("Password: $password"),
            ],
          ),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var authRemoteRepository = AuthRemoteRepository();
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding:  EdgeInsets.all(size.width * 0.05),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(
                "Login Page",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              CustomTextField(
                text: "Email",
                width: size.width * 0.9,
                height: size.height * 0.06,
                controller: emailController,
              ),
              CustomTextField(
                text: "Password",
                width: size.width * 0.9,
                height: size.height * 0.06,
                controller: passwordController,
                isPassword: isSecure,
                icon: IconButton(
                    onPressed: () {
                      setState(() {
                        isSecure = !isSecure;
                      });
                    },
                    icon: Icon(isSecure ? Icons.visibility_off : Icons.visibility)),
              ),
              AuthGradientButton(
                text: "Login",
                width: size.width * 0.9,
                height: size.height * 0.06,
                onPressed: () async{
                  if (formKey.currentState!.validate()) {
             final result = await  authRemoteRepository.login(
                     email: emailController.text,
                     password: passwordController.text
                   );
                   final val=switch (result) {
                     fpdart.Left(value:final l)=> l,
                     fpdart.Right(value:final r)=> r.toString()
                   };
                   showBottomSheet(emailController.text, passwordController.text);
                   debugPrint(val.toString());
                  }
                },
                color: Pallete.gradient1,
                textColor: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => const SignupPage(),
                        ));
                      },
                      child: const Text("Signup"))
                ],
              )
            ]),
          ),
        ));
  }
}
