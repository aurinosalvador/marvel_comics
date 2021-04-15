import 'package:mavel_comics/models/abstract_model.dart';

///
///
///
class ComicModel extends AbstractModel<int> {
  String description;
  String thumbnail;
  String title;

  ///
  ///
  ///
  ComicModel();

  ///
  ///
  ///
  ComicModel.fromJson(Map<String, dynamic> map)
      : description = map['description'],
        thumbnail = map['thumbnail']['path'],
        title = map['title'],
        super.fromJson(map);

  ///
  ///
  ///
  @override
  ComicModel fromJson(Map<String, dynamic> map) => ComicModel.fromJson(map);

  ///
  ///
  ///
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    if (description != null) {
      map['description'] = description;
    }
    if (thumbnail != null) {
      map['thumbnail']['path'] = thumbnail;
    }
    if (title != null) {
      map['title'] = title;
    }
    return map;
  }

  ///
  ///
  ///
  @override
  String toString() => title;
}
