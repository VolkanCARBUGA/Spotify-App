import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final double size;
  final double width;
  final double height;
  final TextEditingController controller;
  final bool isPassword;
  final IconButton? icon;

  const CustomTextField({super.key,required this.text,this.size=20,this.width=400, required this.height,required this.controller,this.isPassword=false,this.icon});

  @override
  Widget build(BuildContext context) {
    
    return  SizedBox(
      width: width,
     
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            
            obscureText: isPassword,
            controller: controller,
            decoration: InputDecoration(
             
              suffixIcon: icon,
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.all(Radius.circular(10)),
                 borderSide: BorderSide(color: Colors.black, width: 3)
                
               ),
                    label: Text(
                      text,
                    ),
            ),
             validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '$text boş olamaz';
                }
                return null;
              },
          ),
           SizedBox(
            height: size,
          ),
        ],
      ),
    );
  }
}