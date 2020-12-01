class PlaceItemRes {
  String name;
  String address;
  double lat;
  double lng;

  PlaceItemRes(this.name, this.address, this.lat, this.lng);
  static List<PlaceItemRes> fromJson(Map<String , dynamic> json){
    List<PlaceItemRes> rs = new List();

    var results = json['results'] as List;
    /*for(var item in results) {
      var p = new PlaceItemRes(
          item['name'],
          item['formated_address'],
          item['geometry']['location']['lat'],
          item['geometry']['location']['lng']
      );
      rs.add(p)
    }*/
    if (results != null){
      rs.add(new PlaceItemRes("30 Trần Não", "30 Trần Não, Q.2, HCM", 10.7973107, 106.7312727));
      rs.add(new PlaceItemRes("123 Trần Não", "123 Trần Não, Q.2, HCM", 10.7973123, 106.7312123));
      rs.add(new PlaceItemRes("100 Trần Hưng Đạo", "100 Trần Hưng Đạo, Q.1, HCM", 10.791323107, 106.73123727));
      rs.add(new PlaceItemRes("212 Trần Phú", "212 Trần Phú, Q.5, HCM", 10.1973107, 106.7122727));
    }
    return rs;
  }
}