import 'package:client/core/theme/app_palette.dart';
import 'package:client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client/features/auth/view/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' as fpdart;


import '../../repositories/auth_remote_repository.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Kontrolörleri sınıf seviyesinde tanımlayın
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final authRemoteRepository = AuthRemoteRepository();

  bool isSecure = true; // isSecure değişkenini sınıf seviyesinde tanımlayın

  @override
  void dispose() {
    // TextEditingController nesnelerini serbest bırakın
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    // formKey.currentState!.validate();
    super.dispose();
  }

  void showBottomSheet(String name, String email, String password) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        isDismissible: true,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Card(
                color: Pallete.gradient1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Başarıyla Kaydedildi Hoşgeldiniz $name"),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Signup Page',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              CustomTextField(
                controller: nameController,
                width: size.width * 0.9,
                height: size.height * 0.06,
                text: "Name",
              ),
              CustomTextField(
                controller: emailController,
                width: size.width * 0.9,
                height: size.height * 0.06,
                text: "Email",
              ),
              CustomTextField(
                isPassword: isSecure,
                icon: IconButton(
                  onPressed: () {
                    setState(() {
                      isSecure = !isSecure;
                    });
                  },
                  icon:
                      Icon(isSecure ? Icons.visibility_off : Icons.visibility),
                ),
                controller: passwordController,
                width: size.width * 0.9,
                height: size.height * 0.06,
                text: "Password",
              ),
              AuthGradientButton(
                text: 'Sign Up',
                color: Pallete.subtitleText,
                textColor: Colors.white,
                onPressed: () async {
                  // Form girişlerini kontrol et
                  String name = nameController.text;
                  String email = emailController.text;
                  String password = passwordController.text;
                  final response = await authRemoteRepository.signup(
                      name: name, email: email, password: password);
                  final val=switch (response) {
                  fpdart.Left(value:final l) => l,
                  fpdart.Right(value:final r) => r.toString()
                  };

                  showBottomSheet(name, email, password);

                  debugPrint(val.toString());
                },
                width: size.width * 0.9,
                height: size.height * 0.06,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Text('Login'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
