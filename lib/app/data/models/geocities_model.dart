class CitiesGeoList{


  late List<CitiesGeo>? cities;
  CitiesGeoList({required this.cities});

  factory CitiesGeoList.fromJson(Map<String,dynamic> json){
    List<CitiesGeo>? cities = [];
    json["data"].forEach((item) {
      cities.add(CitiesGeo.fromJson(item));
    });
    return CitiesGeoList(cities: cities);
  }

    static List<Map<String,String>> getLists(Map<String,dynamic> json){
    List<Map<String,String>> cities = [];

    json["data"].forEach((item) {
      cities.add({"name":item["name"],"wikiDataId":item["wikiDataId"]});
    });
    return cities;
  }
}





class CitiesGeo {
  int? id;
  String? wikiDataId;
  String? type;
  String? city;
  String? name;
  String? country;
  String? countryCode;
  String? region;
  String? regionCode;
  double? latitude;
  double? longitude;
  int? population;

  CitiesGeo(
      {this.id,
        this.wikiDataId,
        this.type,
        this.city,
        this.name,
        this.country,
        this.countryCode,
        this.region,
        this.regionCode,
        this.latitude,
        this.longitude,
        this.population});

  CitiesGeo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wikiDataId = json['wikiDataId'];
    type = json['type'];
    city = json['city'];
    name = json['name'];
    country = json['country'];
    countryCode = json['countryCode'];
    region = json['region'];
    regionCode = json['regionCode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    population = json['population'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['wikiDataId'] = this.wikiDataId;
    data['type'] = this.type;
    data['city'] = this.city;
    data['name'] = this.name;
    data['country'] = this.country;
    data['countryCode'] = this.countryCode;
    data['region'] = this.region;
    data['regionCode'] = this.regionCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['population'] = this.population;
    return data;
  }
}
