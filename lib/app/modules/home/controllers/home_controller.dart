import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_todoapp/app/modules/home/providers/task_provider.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  var lstTask = List<dynamic>.empty(growable: true).obs;
  var page = 1;
  var isDataProcessing = false.obs;

  //For Pagination
  ScrollController scrollController = ScrollController();
  var isMoreDataAvailable = true.obs;

  @override
  void onInit() {
    super.onInit();
    getTask(page);

    //For pagination
    paginateTask();
  }

  //Fetch Data
  void getTask(var page) {
    try {
      isDataProcessing(true);
      TaskProvider().getTask(page).then((resp) {
        isDataProcessing(false);
        lstTask.addAll(resp);
      }, onError: (err) {
        isDataProcessing(false);

        Get.snackbar("Error", err.toString(),
            colorText: Colors.black,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM);
      });
    } catch (exception) {
      isDataProcessing(false);

      Get.snackbar("Exception", exception.toString(),
          colorText: Colors.black,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  //Get more data
  void getMoreTask(var page) {
    try {
      TaskProvider().getTask(page).then((resp) {
        if (resp.length > 0) {
          isMoreDataAvailable(true);
        } else {
          isMoreDataAvailable(false);
          Get.snackbar("Message", "No more items",
              colorText: Colors.black,backgroundColor: Colors.lightBlueAccent);
        }
        lstTask.addAll(resp);
      }, onError: (err) {
        isMoreDataAvailable(false);
        Get.snackbar("Error", err.toString(), colorText: Colors.red);
      });
    } catch (exception) {
      isMoreDataAvailable(false);
      Get.snackbar("Exception", exception.toString(), colorText: Colors.red);
    }
  }

  //For pagination
  void paginateTask() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print('reached end');
        page++;
        getMoreTask(page);
      }
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController.dispose();
  }

}
