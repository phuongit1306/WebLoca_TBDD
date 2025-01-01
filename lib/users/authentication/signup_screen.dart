import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loca_app/api_connection/api_connection.dart';
import 'package:loca_app/users/authentication/login_screen.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget
{


  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
{
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  validateUserEmail() async
  {
    try
    {
      var res = await http.post(
        Uri.parse(API.validateEmail),
        body: {
          'user_email': emailController.text.trim(),
        },
      );

      if(res.statusCode == 200)
        {
          var resBodyOfValidateEmail = jsonDecode(res.body);

          if(resBodyOfValidateEmail['emailFound'] == true)
            {
              Fluttertoast.showToast(msg: "Email đã có người khác sử dụng. Hãy thử email khác.");
            }
          else
            {
              //register & save new user record to database
              registerAndSaveUserRecord();
            }
        }
    }
    catch(e)
    {

    }
  }

  registerAndSaveUserRecord() async
  {

  }

  @override
  Widget build(BuildContext context)
  {
    final colorScheme = Theme.of(context).colorScheme; // Lấy colorScheme
    return Scaffold(
      /*
      appBar: AppBar(
        title: Text("Login Screen"),
        backgroundColor: colorScheme.primary, // Sử dụng màu chính từ colorScheme
      ),
       */
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, cons)
        {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: cons.maxHeight,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [

                  //signup screen header
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 355,
                    child: Image.asset(
                        "images/login3.jpg"
                    ),
                  ),

                  //signup screen sign-up form
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.all(
                          Radius.circular(60),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, -3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                        child: Column(
                          children: [

                            //name-email-pass || signup btn
                            Form(
                              key: formKey,
                              child: Column(
                                children: [

                                  //name
                                  TextFormField(
                                    controller: nameController,
                                    validator: (val) => val == "" ? "Vui lòng nhập tên" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                      hintText: "tên...",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),

                                  const SizedBox(height: 18,),

                                  //email
                                  TextFormField(
                                    controller: emailController,
                                    validator: (val) => val == "" ? "Vui lòng nhập email" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: Colors.black,
                                      ),
                                      hintText: "email...",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),

                                  const SizedBox(height: 18,),

                                  //password
                                  Obx(
                                        ()=> TextFormField(
                                      controller: passwordController,
                                      obscureText: isObsecure.value,
                                      validator: (val) => val == "" ? "Vui lòng nhập mật khẩu" : null,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.vpn_key_sharp,
                                          color: Colors.black,
                                        ),
                                        suffixIcon: Obx(
                                              ()=> GestureDetector(
                                            onTap: ()
                                            {
                                              isObsecure.value = !isObsecure.value;
                                            },
                                            child: Icon(
                                              isObsecure.value ? Icons.visibility_off : Icons.visibility,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        hintText: "mật khẩu...",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          ),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 6,
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 18,),

                                  //button
                                  Material(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(30),
                                    child: InkWell(
                                      onTap: ()
                                      {
                                        if(formKey.currentState!.validate())
                                        {
                                          //validate the email
                                          validateUserEmail();
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(30),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 28,
                                        ),
                                        child: Text(
                                          "Đăng ký",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 16,),

                            //already have account btn
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                    "Đã có tài khoản?"
                                ),
                                TextButton(
                                  onPressed: ()
                                  {
                                    Get.to(LoginScreen());
                                  },
                                  child: const Text(
                                    "Đăng nhập",
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
