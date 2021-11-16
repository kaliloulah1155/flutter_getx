import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Todo App'),
          centerTitle: true,
        ),
        body: Obx(() {
          if (controller.isDataProcessing.value == true) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (controller.lstTask.length > 0) {
              return Container(
                padding:
                EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Active Task : ${controller
                                .lstTask[0]['active_task']}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.green,
                                child: Text(
                                  'H',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                radius: 30,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                ' ${controller.lstTask[0]['highest_priority']}',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.red,
                                child: Text(
                                  'M',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                radius: 30,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                ' ${controller.lstTask[0]['medium_priority']}',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.purple,
                                child: Text(
                                  'L',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                radius: 30,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                ' ${controller.lstTask[0]['lowest_priority']}',
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: controller.scrollController,
                          itemCount: controller.lstTask.length,
                          itemBuilder: (BuildContext context, int index) {

                            if(index==controller.lstTask.length-1 && controller.isMoreDataAvailable.value==true){
                              return Center(child: CircularProgressIndicator());
                            }

                            return Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: controller.lstTask[index]
                                      ['task_priority'] ==
                                          1
                                          ? Colors.green
                                          : (controller.lstTask[index]
                                      ['task_priority'] ==
                                          2
                                          ? Colors.deepOrange
                                          : Colors.purple),
                                      child: Text(
                                        controller.lstTask[index]
                                        ['task_priority'] ==
                                            1
                                            ? 'H'
                                            : (controller.lstTask[index]
                                        ['task_priority'] ==
                                            2
                                            ? 'M'
                                            : 'L'),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.lstTask[index]
                                          ['task_name'],
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          controller.lstTask[index]
                                          ['task_description'],
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(children: [
                                      GestureDetector(
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.green,
                                          ),
                                          onTap: () {
                                            print('je suis la');
                                          }
                                      ),
                                      SizedBox(
                                          height: 6
                                      ),
                                      GestureDetector(
                                        child: Icon(
                                          Icons.delete,
                                          color:Colors.red
                                        ),
                                        onTap: (){

                                        },
                                      ),
                                    ],),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text(
                  'Data not found',
                  style: TextStyle(fontSize: 25),
                ),
              );
            }
          }
        }));
  }
}
