import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pediatricfacialrehab/widgets/background.dart';

import 'app_cubit/app_cubit.dart';
import 'app_cubit/app_state.dart';
import 'helper/assets_helper.dart';
import 'intro_camera/intro_camera.dart';
import 'main.dart';
import 'main_level.dart';



class secondScreen extends StatelessWidget {
  const secondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppCubit(),
        child: BlocConsumer<AppCubit, AppState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = AppCubit.get(context);
              return Background(
                child: Container(
                  height: double.infinity,
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Image.asset('assets/images/Amjad.png'),
                          Center(
                            child: Text(
                              'Pediatric Facial Rehab',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 33,
                                  color: Color.fromRGBO(244, 83, 68, 1),
                                  fontFamily: 'Roboto'),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.26,
                      ),
                      ClipPath(
                        clipper: WaveClipperOne(reverse: true),
                        child: Container(
                          height: 150,
                          color: Color.fromRGBO(244, 83, 68, 1),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Center(
                                  child: TextButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      elevation: 0,
                                      enableDrag: true,
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                      builder: (BuildContext context) {
                                        return Form(
                                          key: cubit.formKey,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            child: ClipPath(
                                              clipper:
                                                  WaveClipperOne(reverse: true),
                                              child: Container(
                                                height: 320,
                                                color: Color.fromRGBO(
                                                    244, 83, 68, 1),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 6,
                                                            ),
                                                            Text(
                                                              'Login',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 27,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'Please login to your account.',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Roboto',
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      clipBehavior: Clip
                                                          .antiAliasWithSaveLayer,
                                                      width: 300.0,
                                                      height: 50.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Center(
                                                            child:
                                                                TextFormField(
                                                          controller: AppCubit
                                                                  .get(context)
                                                              .usernameController,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return 'Please enter your username';
                                                            }
                                                            return null;
                                                          },
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      '  Username'),
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  'Roboto'),
                                                        )),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 18,
                                                    ),
                                                    Container(
                                                      clipBehavior: Clip
                                                          .antiAliasWithSaveLayer,
                                                      width: 300.0,
                                                      height: 50.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Center(
                                                            child:
                                                                TextFormField(
                                                          controller: AppCubit
                                                                  .get(context)
                                                              .passwordController,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .done,
                                                          keyboardType:
                                                              TextInputType
                                                                  .visiblePassword,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return 'Please enter your password';
                                                            }
                                                            return null;
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      '  Password'),
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  'Roboto'),
                                                        )),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 18,
                                                    ),
                                                    MaterialButton(
                                                        onPressed: () {
                                                          if (cubit.formKey
                                                              .currentState!
                                                              .validate()) {
                                                            AppCubit.get(context).login(
                                                                username: AppCubit.get(context).usernameController.text,
                                                                password: AppCubit.get(context).passwordController.text);
                                                            if (AppCubit.get(context).usernameController.text != null&&AppCubit.get(context).passwordController.text != null) {
                                                             navigateToAndFinish(widget:cameraIntro(), context: context);
                                                            }




                                                          }
                                                        },
                                                        child: Container(
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          width: 300.0,
                                                          height: 50.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                          child: Container(
                                                            color: Colors.white,
                                                            child: Center(
                                                              child: Text(
                                                                'LOGIN',
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            244,
                                                                            83,
                                                                            68,
                                                                            1),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }


}
