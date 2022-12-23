import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:z1web_adminpanel/core/auth/controller/login_controller.dart';
import 'package:z1web_adminpanel/setting/color/app_color.dart';
import 'package:z1web_adminpanel/util/function/local_storage.dart';
import 'package:z1web_adminpanel/util/helper/custom_button.dart';
import 'package:z1web_adminpanel/util/helper/custom_textformfield.dart';
import '../../../config/router/router.gr.dart';
import '../../../util/helper/custom_dropdown.dart';
import '../../../widget/app_widget/custom_appcard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showInput = false;
  bool showOption = true;
  bool showDelete = false;
  double width = 200;
  final controller = Get.put(LoginController());

  checklogin() async {
    await LocalStorage.getStringValue(key: 'TOKEN').then((name) {
      if (name.isNotEmpty) {
        Future.delayed(const Duration(seconds: 1), () {
          controller.getApplist();
        });
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          context.replaceRoute(LoginScreen(message: "Please Login First"));
        });
      }
    });
  }

  bool showFilter = false;
  _handleOnPressedFilter() {
    showFilter = !showFilter;
    setState(() {});
  }

  @override
  void initState() {
    // checklogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double scrwidth = MediaQuery.of(context).size.width;
    showOption = scrwidth > 950;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: [
          Row(
            children: [
              Container(
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: const Border(
                    right: BorderSide(color: Colors.black12),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxoVYK9gVqDWkfv3blKuxWEO0t9JrH6XSjxg&usqp=CAU'),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset('asset/svg/navigation/user.svg'),
                    ),
                    const SizedBox(height: 20),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset('asset/svg/navigation/trash.svg'),
                    ),
                    const SizedBox(height: 20),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                          'asset/svg/navigation/users-alt.svg'),
                    ),
                    const Spacer(),
                    const CircleAvatar(
                      backgroundColor: AppColor.primarySwatch,
                      child: Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30)
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                  child: Column(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hello Virak',
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                Text(
                                  'Welcome Back ! $scrwidth',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ],
                            ),
                            const SizedBox(width: 50),
                            // const Spacer(),
                            SvgPicture.asset(
                              'asset/svg/navigation/search.svg',
                              height: 30,
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: CustomTextFormField(
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                            SizedBox(width: showOption ? 20 : 0),
                            showOption ? filterButton() : const SizedBox(),
                            SizedBox(width: showOption ? 20 : 0),
                            showOption ? addButton() : const SizedBox(),
                            SizedBox(width: showOption ? 20 : 0),
                            showOption ? deleteButton() : const SizedBox(),
                            SizedBox(width: !showOption ? 20 : 0),
                            !showOption ? optionButton() : const SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ),

                  ///Filter
                  showFilter
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              const Text('Try filter something'),
                              const Spacer(),
                              Expanded(
                                child: CustomDropDown(
                                  listFilter: const <String>['A-Z', 'Z-A'],
                                  onChnaged: (v) {
                                    debugPrint('value = $v');
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),

                  ///card
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Obx(
                        () => SingleChildScrollView(
                          child: Wrap(
                            runAlignment: WrapAlignment.start,
                            alignment: WrapAlignment.center,
                            runSpacing: 30,
                            spacing: 30,
                            children: controller.listApp.map(
                              (e) {
                                return AppCard(
                                  color: Colors.grey[300],
                                  showDelete: showDelete, desc: e.description,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text(
                                            'Do you want to delete ${e.appname}?'),
                                        actions: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                                color: Colors.transparent,
                                                child: const Text('Cancel')),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                              e.id != null
                                                  ? controller.deleteItem(e.id!)
                                                  : null;
                                            },
                                            child: Container(
                                                color: Colors.transparent,
                                                child: const Text('Yes')),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  ontap: () {
                                    ///
                                    List<
                                            DoughnutSeries<ChartSampleData,
                                                String>>
                                        _getElevationDoughnutSeries() {
                                      return <
                                          DoughnutSeries<ChartSampleData,
                                              String>>[
                                        DoughnutSeries<ChartSampleData, String>(
                                            dataSource: <ChartSampleData>[
                                              ChartSampleData(
                                                  x: 'A',
                                                  y: e.proccess!.toInt(),
                                                  pointColor:
                                                      const Color.fromRGBO(
                                                          0, 220, 252, 1)),
                                            ],
                                            animationDuration: 1000,
                                            xValueMapper:
                                                (ChartSampleData data, _) =>
                                                    e.proccess.toString(),
                                            yValueMapper:
                                                (ChartSampleData data, _) =>
                                                    e.proccess,
                                            pointColorMapper:
                                                (ChartSampleData data, _) =>
                                                    data.pointColor)
                                      ];
                                    }

                                    ///
                                    showDialog(
                                      barrierColor: Colors.black26,
                                      context: context,
                                      builder: (context) => Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  // height: 200,
                                                  // width: 200,
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 30,
                                                      vertical: 30),

                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      SfCircularChart(
                                                        /// It used to set the annotation on circular chart.
                                                        annotations: <
                                                            CircularChartAnnotation>[
                                                          CircularChartAnnotation(
                                                              height: '100%',
                                                              width: '100%',
                                                              widget:
                                                                  PhysicalModel(
                                                                shape: BoxShape
                                                                    .circle,
                                                                elevation: 10,
                                                                color: const Color
                                                                        .fromRGBO(
                                                                    230,
                                                                    230,
                                                                    230,
                                                                    1),
                                                                child:
                                                                    Container(),
                                                              )),
                                                          CircularChartAnnotation(
                                                              widget: const Text(
                                                                  '62%',
                                                                  style: TextStyle(
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0.5),
                                                                      fontSize:
                                                                          25)))
                                                        ],

                                                        series:
                                                            _getElevationDoughnutSeries(),
                                                      ),
                                                      PrettyQr(
                                                        size: 150,
                                                        roundEdges: true,
                                                        data: '${e.id}',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 50,
                                                  top: 50,
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Icon(Icons
                                                          .arrow_back_ios_new_rounded),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  name: '${e.appname}',
                                  image: e.icon,
                                  proccess: e.proccess,
                                  // desc: e.de,
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),

          ///
          showInput
              ? GestureDetector(
                  onTap: () {
                    showInput = false;
                    setState(() {});
                  },
                  child: AnimatedContainer(
                    // curve: Curves.line,
                    padding: const EdgeInsets.all(30),
                    duration: const Duration(milliseconds: 1000),
                    color: Colors.black.withOpacity(0.2),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {}, //prevent click
                      child: Obx(
                        () => Container(
                          // height: 500,
                          width: 800,
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextFormField(
                                  onChanged: (v) {
                                    controller.appname(v);
                                  },
                                  label: 'App Name',
                                ),
                                CustomTextFormField(
                                  onChanged: (v) {
                                    controller.appurl(v);
                                  },
                                  label: 'App Url',
                                ),
                                CustomTextFormField(
                                  onChanged: (v) {
                                    controller.description(v);
                                  },
                                  label: 'Descriptions',
                                ),
                                CustomTextFormField(
                                  onChanged: (v) {
                                    controller.image(v);
                                  },
                                  label: 'Image Url',
                                ),
                                Slider(
                                  label: "${controller.slider.value * 100}%",
                                  divisions: 10,
                                  value: controller.slider.value,
                                  onChanged: (v) {
                                    controller.slider(v);
                                  },
                                  activeColor: AppColor.primarySwatch,
                                  inactiveColor:
                                      AppColor.primarySwatch.shade100,
                                ),
                                const Text(
                                    'Note: all fields are not required you can update it later'),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomButton(
                                  isEnable:
                                      controller.appname.value.isNotEmpty &&
                                          controller.appurl.value.isNotEmpty,
                                  onTap: () {
                                    showInput = false;
                                    setState(() {});
                                    controller.addapp();
                                  },
                                  text: 'Submit',
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  Widget addButton() {
    return Tooltip(
      waitDuration: const Duration(milliseconds: 1000),
      message: 'Here you can add data.',
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 100,
        child: CustomButton(
          onTap: () {
            showInput = true;
            setState(() {});
          },
          isfill: false,
          fillColor: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text('Add'), Icon(Icons.add_rounded)],
          ),
        ),
      ),
    );
  }

  Widget deleteButton() {
    return Tooltip(
      waitDuration: const Duration(milliseconds: 1000),
      message: 'Here you can delete data.',
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 100,
        child: CustomButton(
          onTap: () {
            showDelete = !showDelete;
            setState(() {});
          },
          isfill: false,
          fillColor: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text('Delete'), Icon(Icons.delete)],
          ),
        ),
      ),
    );
  }

  Widget filterButton() {
    return Tooltip(
      waitDuration: const Duration(milliseconds: 1000),
      message: 'Here you can filter data.',
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 100,
        child: CustomButton(
          onTap: () {
            _handleOnPressedFilter();
          },
          isfill: false,
          fillColor: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Filter'),
              SvgPicture.asset(
                'asset/svg/navigation/settings-sliders.svg',
                height: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget optionButton() {
    return Tooltip(
      waitDuration: const Duration(milliseconds: 1000),
      message: 'Here you can filter data.',
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 100,
        child: CustomButton(
          onTap: () {
            _handleOnPressedFilter();
          },
          isfill: false,
          fillColor: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Option'),
              SvgPicture.asset(
                'asset/svg/navigation/settings-sliders.svg',
                height: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartSampleData {
  final String? x;
  final int? y;
  final Color? pointColor;
  ChartSampleData({this.y, this.pointColor, this.x});
}
