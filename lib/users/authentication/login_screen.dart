import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loca_app/users/authentication/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loca_app/users/fragments/dashboard_of_fragments.dart';
import 'package:loca_app/users/model/user.dart';
import 'package:loca_app/api_connection/api_connection.dart';
import 'package:loca_app/users/userPreferences/user_preferences.dart';


class LoginScreen extends StatefulWidget
{


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  loginUserNow() async
  {
    try
    {
      var res = await http.post(
        Uri.parse(API.login),
        body: {
          "user_email": emailController.text.trim(),
          "user_password": passwordController.text.trim(),
        },
      );

      if(res.statusCode == 200)
      {
        var resBodyOfLogin = jsonDecode(res.body);
        if(resBodyOfLogin['success'] == true)
        {
          Fluttertoast.showToast(msg: "Bạn đã Đăng nhập thành công.");

          User userInfo = User.fromJson(resBodyOfLogin["userData"]);

          //save userInfo to local Storage using Shared Preferences
          await RememberUserPrefs.saveRememberUser(userInfo);

          Future.delayed(Duration(milliseconds: 2000), ()
          {
            Get.to(DashboardOfFragments());
          });
        }
        else
        {
          Fluttertoast.showToast(msg: "Không chính xác.\nVui lòng nhập đúng email hoặc mật khẩu và thử lại.");
        }
      }
    }
    catch(errorMsg)
    {
      print("Lỗi :: " + errorMsg.toString());
    }
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

                    //login screen header
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 325,
                      child: Image.asset(
                        "images/login.jpg"
                      ),
                    ),

                    //login screen sign-in form
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

                              //email-pass-login btn
                              Form(
                                key: formKey,
                                child: Column(
                                  children: [

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
                                              loginUserNow();
                                            }
                                        },
                                        borderRadius: BorderRadius.circular(30),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 28,
                                            ),
                                          child: Text(
                                            "Đăng nhập",
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

                              SizedBox(height: 16,),

                              //don't have an account btn
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Nếu chưa có tài khoản?"
                                  ),
                                  TextButton(
                                    onPressed: ()
                                    {
                                      Get.to(SignUpScreen());
                                    },
                                    child: const Text(
                                      "Đăng ký",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 16,),

                              const Text(
                                "Hoặc",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),

                              SizedBox(height: 16,),

                              //are u an admin - btn
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                      "Bạn có phải Admin?"
                                  ),
                                  TextButton(
                                    onPressed: ()
                                    {

                                    },
                                    child: const Text(
                                      "Ấn vào đây",
                                      style: TextStyle(
                                        color: Colors.lightBlueAccent,
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
