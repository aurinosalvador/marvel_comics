import 'package:marvel_comics/models/abstract_model.dart';

///
///
///
class DataModel {
  int count;
  int limit;
  int offset;
  List<AbstractModel> results;
  int total;

  ///
  ///
  ///
  DataModel();

  ///
  ///
  ///
  DataModel fromJson(Map<String, dynamic> map, AbstractModel model) {
    count = map['count'];
    limit = map['limit'];
    offset = map['offset'];
    results = map['results'] != null
        ? (map['results'] as List<dynamic>)
            .map((dynamic map) => model.fromJson(map))
            .toList()
        : null;
    total = map['total'];

    return this;
  }

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    if (count != null) {
      map['count'] = count;
    }
    if (limit != null) {
      map['limit'] = limit;
    }
    if (offset != null) {
      map['offset'] = offset;
    }
    if (results != null) {
      map['results'] =
          results.map((AbstractModel model) => model.toMap()).toList();
    }
    if (total != null) {
      map['total'] = total;
    }
    return map;
  }
}
