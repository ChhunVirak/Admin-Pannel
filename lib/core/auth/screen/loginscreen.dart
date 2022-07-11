import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:z1web_adminpanel/core/auth/controller/login_controller.dart';
import 'package:z1web_adminpanel/setting/color/app_color.dart';
import 'package:z1web_adminpanel/util/helper/custom_button.dart';
import 'package:z1web_adminpanel/util/helper/custom_textformfield.dart';

import '../../../router/router.gr.dart';

class LoginScreen extends StatefulWidget {
  final String? message;
  const LoginScreen({Key? key, this.message}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put(LoginController());

  ///overlay
  OverlayState? overlayState;
  OverlayEntry? overlayEntry;

  ///
  void showOverlay(BuildContext context1, GlobalKey<dynamic> getkey,
      int getIndex, Function onCancel) async {
    ///
    var newKey = getkey;
    overlayState = Overlay.of(context1);

    ///
    // var width = newKey.currentContext.widget;
    var positionval = newKey.currentContext!.findRenderObject() as RenderBox;

    ///
    final listOverlayWidget = <Widget>[
      Container(
        height: 50,
        width: kIsWeb ? 370 : 240,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      const SizedBox(
        width: kIsWeb ? 370 : 240,
        child: CustomButton(
          text: 'Login',
        ),
      )
    ];

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              overlayEntry!.remove();
              onCancel();
            },
            child: Container(
              color: Colors.black.withOpacity(0.4),
              child: Stack(
                children: [
                  Positioned(
                    top: positionval.localToGlobal(Offset.zero).dy + 10,
                    left: positionval.localToGlobal(Offset.zero).dx - 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: listOverlayWidget[getIndex],
                      // SizedBox(
                      //     width: newKey.currentContext!.size!.width,
                      //     child: const CustomTextFormField()),
                    ),
                  ),

                  ///Tooltips
                  Positioned(
                    // top: 50, left: 50,
                    top: positionval.localToGlobal(Offset.zero).dy - 70,
                    left: positionval.localToGlobal(Offset.zero).dx - 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: const Text('This is test'),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 15),
                          height: 10,
                          width: 20,
                          child: CustomPaint(
                            painter: MyPainter(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
    overlayState!.insert(overlayEntry!);
  }

  var key1 = GlobalKey();
  var key2 = GlobalKey();
  var key3 = GlobalKey();

  ///
  void autoPlay(BuildContext getcontext) {
    Future.delayed(const Duration(seconds: 1), () {
      showOverlay(getcontext, key1, 0, () {});
      Timer.periodic(const Duration(seconds: 1), (timer) {
        debugPrint(' a ${timer.tick}');
        if (timer.tick == 4) {
          overlayEntry!.remove();
          showOverlay(getcontext, key2, 0, () {
            timer.cancel();
          });
        } else if (timer.tick == 8) {
          overlayEntry!.remove();
          showOverlay(getcontext, key3, 1, () {
            timer.cancel();
          });
        } else if (timer.tick == 12) {
          overlayEntry!.remove();
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Obx(
        () => Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Admin Panel',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.primarySwatch,
                        fontSize: 30),
                  ),
                  widget.message != null
                      ? Text(widget.message!)
                      : const SizedBox(),
                  const SizedBox(height: 30),
                  Container(
                    width: kIsWeb ? 440 : 300,
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 0.5,
                            blurRadius: 6)
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ///
                        CustomTextFormField(
                          key: key1,
                          onChanged: (v) {
                            loginController.username(v);
                          },
                          label: 'Username',
                          onFieldSubmitted: (v) {
                            // loginController.getId();
                            loginController.checkUser(onsuccess: (v) {
                              Future.delayed(
                                const Duration(seconds: 1),
                                () {
                                  loginController.isLoadingLogin(false);
                                  context.navigateTo(const HomeScreen());
                                },
                              );
                              debugPrint('GO');
                            }, onWrong: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: AppColor.primarySwatch,
                                  content: const Text(
                                      'Invalid Username or Password! Please try again.'),
                                  action: SnackBarAction(
                                    label: 'Try Again!',
                                    onPressed: () {
                                      loginController.checkUser(onsuccess: (v) {
                                        Future.delayed(
                                          const Duration(seconds: 1),
                                          () {
                                            loginController
                                                .isLoadingLogin(false);
                                            context
                                                .navigateTo(const HomeScreen());
                                          },
                                        );
                                        debugPrint('GO');
                                      });
                                    },
                                  ),
                                ),
                              );
                              FocusScope.of(context).requestFocus();
                            });
                          },
                        ),

                        ///
                        CustomTextFormField(
                          key: key2,
                          onChanged: (v) {
                            loginController.password(v);
                          },
                          obscureText: true,
                          label: 'Password',
                          onFieldSubmitted: (v) {
                            // loginController.getId();
                            loginController.checkUser(onsuccess: (v) {
                              Future.delayed(
                                const Duration(seconds: 1),
                                () {
                                  loginController.isLoadingLogin(false);
                                  context.navigateTo(const HomeScreen());
                                },
                              );
                              debugPrint('GO');
                            }, onWrong: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: AppColor.primarySwatch,
                                  content: const Text(
                                      'Invalid Username or Password! Please try again.'),
                                  action: SnackBarAction(
                                    label: 'Try Again!',
                                    onPressed: () {
                                      loginController.checkUser(onsuccess: (v) {
                                        Future.delayed(
                                          const Duration(seconds: 1),
                                          () {
                                            loginController
                                                .isLoadingLogin(false);
                                            context
                                                .navigateTo(const HomeScreen());
                                          },
                                        );
                                        debugPrint('GO');
                                      });
                                    },
                                  ),
                                ),
                              );
                            });
                          },
                        ),

                        ///
                        CustomButton(
                          key: key3,
                          text: 'Login',
                          onTap: () {
                            // loginController.getId();
                            loginController.checkUser(onsuccess: (v) {
                              Future.delayed(
                                const Duration(seconds: 1),
                                () {
                                  loginController.isLoadingLogin(false);
                                  context.navigateTo(const HomeScreen());
                                },
                              );
                              debugPrint('GO');
                            }, onWrong: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: AppColor.primarySwatch,
                                  content: const Text(
                                      'Invalid Username or Password! Please try again.'),
                                  action: SnackBarAction(
                                    label: 'Try Again!',
                                    onPressed: () {
                                      loginController.checkUser(onsuccess: (v) {
                                        Future.delayed(
                                          const Duration(seconds: 1),
                                          () {
                                            loginController
                                                .isLoadingLogin(false);
                                            context
                                                .navigateTo(const HomeScreen());
                                          },
                                        );
                                        debugPrint('GO');
                                      });
                                    },
                                  ),
                                ),
                              );
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: IconButton(
                onPressed: () {
                  autoPlay(context);
                  // showOverlay(context, key1, () {});
                },
                icon: SvgPicture.asset('asset/svg/navigation/exclamation.svg'),
              ),
            ),
            loginController.isLoadingLogin.value
                ? Container(
                    color: Colors.black.withOpacity(0.2),
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                          color: AppColor.primaryColor, shape: BoxShape.circle),
                      child: const CircularProgressIndicator(
                        color: AppColor.primarySwatch,
                        strokeWidth: 10,
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(MyPainter oldDelegate) => false;
}
