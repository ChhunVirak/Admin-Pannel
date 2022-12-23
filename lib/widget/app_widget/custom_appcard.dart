import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:z1web_adminpanel/setting/color/app_color.dart';

class AppCard extends StatelessWidget {
  final GestureTapCallback? ontap;
  final VoidCallback? onPressed;
  final Color? color;
  final String? image;
  final String? desc;
  final String? name;
  final bool showDelete;
  final double? proccess;
  const AppCard({
    Key? key,
    this.ontap,
    this.color,
    this.image,
    this.name,
    this.proccess,
    this.desc,
    this.showDelete = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: '${name!}\n$desc',
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      preferBelow: true,
      waitDuration: const Duration(milliseconds: 1000),
      child: Stack(
        children: [
          InkWell(
            onTap: ontap ?? () {},
            child: Container(
              width: 250,
              margin: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: color ?? Colors.transparent,
                // border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(-4, -4),
                    spreadRadius: 0,
                    blurRadius: 6,
                    color: Colors.white,
                  ),
                  BoxShadow(
                    blurStyle: BlurStyle.inner,
                    offset: Offset(4, 4),
                    spreadRadius: 0,
                    blurRadius: 6,
                    color: Colors.black,
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    color: AppColor.primarySwatch,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5),
                          ),
                          const SizedBox(height: 5),
                          Text(desc ?? 'This is App for Invester.',
                              style: Theme.of(context).textTheme.subtitle1),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const CircularProgressIndicator(
                          value: 1,
                          color: Colors.black12,
                        ),
                        proccess != null
                            ? CircularProgressIndicator(
                                value: proccess! / 100,
                                color: AppColor.primarySwatch,
                              )
                            : const SizedBox(),
                        Text(
                          proccess != null ? '$proccess%' : '0%',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: AppColor.primarySwatch,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          showDelete
              ? Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                      onPressed: onPressed,
                      icon: SvgPicture.asset('asset/svg/navigation/trash.svg')),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
