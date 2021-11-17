import 'package:get/get.dart';

import '../task_model.dart';

class TaskProvider extends GetConnect {
  //Fetch Data
  Future<List<dynamic>> getTask(var page) async {
    try {
      //final response = await get("http://127.0.0.1:8000/api/getTask?page=$page");
      final response=await get("http://10.0.2.2:8000/api/getTask?page=$page"); //use 10.0.2.2 for localhost and emulator
      if (response.status.hasError) {
        return Future.error(response.statusText);
      } else {
        return response.body['data'];
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  Future<String> saveTask(Map data) async{
    try{
       final response=await post("http://10.0.2.2:8000/api/saveTask",data);
       if (response.status.hasError) {
         return Future.error(response.statusText);
       } else {
         return response.body['result'];
       }
    }catch(exception){
      return Future.error(exception.toString());
    }
  }


}
