class Task {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Task(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Task.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {

    final data = <String, dynamic>{};
    data['current_page'] = currentPage;
    /*if (data != null) {
      data['data'] = data.map((v) => v.toJson()).toList();
    }*/
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Data {
  int? taskId;
  String? taskName;
  String? taskDescription;
  int? taskPriority;
  int? activeTask;
  int? highestPriority;
  int? mediumPriority;
  int? lowestPriority;

  Data(
      {this.taskId,
      this.taskName,
      this.taskDescription,
      this.taskPriority,
      this.activeTask,
      this.highestPriority,
      this.mediumPriority,
      this.lowestPriority});

  Data.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    taskName = json['task_name'];
    taskDescription = json['task_description'];
    taskPriority = json['task_priority'];
    activeTask = json['active_task'];
    highestPriority = json['highest_priority'];
    mediumPriority = json['medium_priority'];
    lowestPriority = json['lowest_priority'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['task_id'] = taskId;
    data['task_name'] = taskName;
    data['task_description'] = taskDescription;
    data['task_priority'] = taskPriority;
    data['active_task'] = activeTask;
    data['highest_priority'] = highestPriority;
    data['medium_priority'] = mediumPriority;
    data['lowest_priority'] = lowestPriority;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
