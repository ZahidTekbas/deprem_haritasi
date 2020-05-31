class DepremData {
  String date;
  String time;
  double lat;
  double lng;
  String depth;
  String magnitude;
  String location;

  DepremData(
      {this.date,
      this.time,
      this.lat,
      this.lng,
      this.depth,
      this.magnitude,
      this.location});

  factory DepremData.fromJson(dynamic json, int index) {
    print('index: $index date: ${json[index]['tarih']}');
    return DepremData(
        date: json[index]['tarih'],
        time: json[index]['saat'],
        lat: double.parse(json[index]['enlem']),
        lng: double.parse(json[index]['boylam']),
        depth: json[index]['derinlik'],
        magnitude: json[index]['buyukluk'],
        location: json[index]['yer']);
  }

  getLat() {
    return lat;
  }
  getLng(){
    return lng;
  }
}
