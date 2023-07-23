class WebtoonDetailModel {
  final String title, genre, about, age;

  WebtoonDetailModel.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        about = json["about"],
        age = json["age"],
        genre = json["genre"];
}
