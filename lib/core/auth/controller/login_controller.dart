import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:z1web_adminpanel/module/dashboard/model/app_model.dart';
import 'package:z1web_adminpanel/util/function/local_storage.dart';

class LoginController extends GetxController {
  final username = ''.obs;
  final password = ''.obs;

  final isLoadingLogin = false.obs;

  checkUser({ValueChanged<String>? onsuccess, Function? onWrong}) {
    isLoadingLogin(true);
    try {
      FirebaseFirestore.instance
          .collection('user')
          .where('password', isEqualTo: password.value)
          .get()
          .then(
        (value) {
          if (value.docs.isNotEmpty) {
            if (onsuccess != null &&
                value.docs[0]['username'].toString().toLowerCase() ==
                    username.value.toLowerCase()) {
              LocalStorage.storeData(
                  key: 'TOKEN', value: value.docs[0]['token']);
              onsuccess(
                value.docs[0]['username'],
              );
            }
            debugPrint('value ${value.docs}');
          } else {
            if (onWrong != null) {
              onWrong();
            }
            isLoadingLogin(false);

            // Fluttertoast.showToast(
            //     msg: 'Invalid Username or Passaword' 'Please try again.');
            debugPrint('No item found');
          }
        },
      ); //https://dribbble.com/shots?color=261F5B
    } catch (e) {
      debugPrint('Error $e');
    }
  }

  final listApp = <AppModel>[].obs;
  Future<void> getApplist() async {
    listApp.clear();
    await FirebaseFirestore.instance
        .collection('allapplist')
        .doc("PzFIM1vAROeDI5RBHzIB")
        .collection('applist')
        .get()
        .then((value) {
      value.docs.map(
        (e) {
          debugPrint("------------->hello");
          var item = AppModel.fromJson(e.data());
          listApp.add(item);
        },
      ).toList();
    }).onError((error, stackTrace) {
      debugPrint("ERROR -------> ${error.toString()}");
    });
  }

  deleteItem(String itemId) {
    FirebaseFirestore.instance
        .collection('allapplist')
        .doc("PzFIM1vAROeDI5RBHzIB")
        .collection('applist')
        .doc(itemId)
        .delete()
        .then((value) {
      getApplist();
      debugPrint('deleted $itemId');
    }).onError((error, stackTrace) {
      debugPrint("#####_-------> ${error.toString()}");
    });
  }

  final appname = ''.obs;
  final appurl = ''.obs;
  final description = ''.obs;
  final slider = 0.0.obs;
  final image =
      'https://themesfinity.com/wp-content/uploads/2018/02/default-placeholder.png'
          .obs;

  ///Clear
  clearInputField() {
    appname('');
    appurl('');
    description('');
    slider(0.0);
  }

  ///
  bool isEmpty() {
    if (appname.value == '' && appurl.value == '' && appname.value == '') {
      return true;
    } else {
      return false;
    }
  }

  Future addapp() async {
    AppModel itemadd = AppModel(
        appname: appname.value,
        applink: appurl.value,
        description: description.value,
        proccess: slider.value * 100,
        icon: image.value);
    debugPrint('name ${itemadd.appname}');
    await FirebaseFirestore.instance
        .collection('allapplist')
        .doc('PzFIM1vAROeDI5RBHzIB')
        .collection('applist')
        .add(itemadd.toJson())
        .then((value) {
      storeID(value.id).then((value) {
        // clearInputField();
        getApplist();
      });
    });
  }

  Future storeID(String id) async {
    FirebaseFirestore.instance
        .collection('allapplist')
        .doc('PzFIM1vAROeDI5RBHzIB')
        .collection('applist')
        .doc(id)
        .update({'id': id});
  }

  String generateMd5() {
    String input = 'hello';

    return md5.convert(utf8.encode(input)).toString();
  }
}
