import 'package:mavel_comics/models/abstract_model.dart';

///
///
///
class ComicModel extends AbstractModel<int> {
  String title;

  ///
  ///
  ///
  ComicModel();

  ///
  ///
  ///
  ComicModel.fromJson(Map<String, dynamic> map)
      : title = map['title'],
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
    if (title != null) {
      map['title'] = title;
    }
    return map;
  }

  ///
  ///
  ///
  @override
  String get searchTerm => title;

  ///
  ///
  ///
  @override
  String toString() => title;
}
