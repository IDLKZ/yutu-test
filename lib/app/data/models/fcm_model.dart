class FCM {
  String? to;
  String? collapseKey;
  String? priority;
  FCMNotification? notification;

  FCM({this.to, this.collapseKey, this.priority, this.notification});

  FCM.fromJson(Map<String, dynamic> json) {
    to = json['to'];
    collapseKey = json['collapse_key'];
    priority = json['priority'];
    notification = json['notification'] != null
        ? new FCMNotification.fromJson(json['notification'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['to'] = this.to;
    data['collapse_key'] = this.collapseKey;
    data['priority'] = this.priority;
    if (this.notification != null) {
      data['notification'] = this.notification!.toJson();
    }
    return data;
  }
}

class FCMNotification {
  String? title;
  String? body;

  FCMNotification({this.title, this.body});

  FCMNotification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}