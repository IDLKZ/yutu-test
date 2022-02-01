class Banlists {
  List<Banlists>? banlists;

  Banlists({this.banlists});

  Banlists.fromJson(Map<String, dynamic> json) {
    if (json['banlists'] != null) {
      banlists = <Banlists>[];
      json['banlists'].forEach((v) {
        banlists?.add(Banlists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (banlists != null) {
      data['banlists'] = banlists?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ban {
  String? initiator;
  String? banned;

  Ban({this.initiator, this.banned});

  Ban.fromJson(Map<String, dynamic> json) {
    initiator = json['initiator'];
    banned = json['banned'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['initiator'] = initiator;
    data['banned'] = banned;
    return data;
  }
}
