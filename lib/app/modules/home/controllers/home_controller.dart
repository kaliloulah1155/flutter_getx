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

  late TextEditingController titleEditingController, descriptionEditingController;
  var selectedPriority=1.obs;
  var isProcessing =false.obs;

  @override
  void onInit() {
    super.onInit();
    getTask(page);

    //For pagination
   // paginateTask();

    titleEditingController = TextEditingController();
    descriptionEditingController = TextEditingController();
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
  //Refresh List
  void refreshList() async{
    page=1;
    getTask(page);
  }

     //Save Data
    void saveTask(Map data){
       try{
         isProcessing(true);

         TaskProvider().saveTask(data).then((resp){
            if(resp=="success"){
              clearTextEditingController();
              isProcessing(false);
              Get.snackbar("Add Task","Task Added", colorText: Colors.white,backgroundColor: Colors.green,snackPosition:SnackPosition.BOTTOM);
              lstTask.clear();
               refreshList();
            }else{
              Get.snackbar("Add Task","Failed to Add Task", colorText: Colors.white,backgroundColor: Colors.red,snackPosition:SnackPosition.BOTTOM);
            }
         });

       }catch(exception){

         Get.snackbar("Exception", exception.toString(),
             colorText: Colors.black,
             backgroundColor: Colors.red,
             snackPosition: SnackPosition.BOTTOM);
       }
    }

    //Update Task
  void updateTask(Map data){
    try{
         isProcessing(true);

         TaskProvider().updateTask(data).then((resp){
           if(resp=='success'){
             clearTextEditingController();
             isProcessing(false);

             Get.snackbar("Edit Task","Task Updated", colorText: Colors.white,backgroundColor: Colors.green,snackPosition:SnackPosition.BOTTOM);
             lstTask.clear();
             refreshList();

           }else{
             Get.snackbar("Edit Task","Failed to Update Task", colorText: Colors.white,backgroundColor: Colors.red,snackPosition:SnackPosition.BOTTOM);
           }
         },onError: (err){
           isProcessing(true);
           Get.snackbar("Error", err.toString(), colorText: Colors.red);
         });

    }catch(exception){
      isProcessing(true);
      Get.snackbar("Exception", exception.toString(),
          colorText: Colors.black,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  //Update Task
  void deleteTask(Map data){
    try{
      isProcessing(true);

      TaskProvider().deleteTask(data).then((resp){
        if(resp=='success'){
          clearTextEditingController();
          isProcessing(false);

          Get.snackbar("Delete Task","Task is deleted", colorText: Colors.white,backgroundColor: Colors.green,snackPosition:SnackPosition.BOTTOM);
          lstTask.clear();
          refreshList();

        }else{
          Get.snackbar("Delete Task","Failed to delete Task", colorText: Colors.white,backgroundColor: Colors.red,snackPosition:SnackPosition.BOTTOM);
        }
      },onError: (err){
        isProcessing(true);
        Get.snackbar("Error", err.toString(), colorText: Colors.red);
      });

    }catch(exception){
      isProcessing(true);
      Get.snackbar("Exception", exception.toString(),
          colorText: Colors.black,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

    void clearTextEditingController(){
      titleEditingController.clear();
      descriptionEditingController.clear();
    }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController.dispose();
  }

}
