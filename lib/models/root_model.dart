import 'package:mavel_comics/models/abstract_model.dart';
import 'package:mavel_comics/models/data_model.dart';

///
///
///
class RootModel {
  String attributionHTML;
  String attributionText;
  int code;
  String copyright;
  DataModel data;
  String etag;
  String status;

  ///
  ///
  ///
  RootModel();

  ///
  ///
  ///
  RootModel fromJson(Map<String, dynamic> map, AbstractModel model) {
    attributionHTML = map['attributionHTML'];
    attributionText = map['attributionText'];
    code = map['code'];
    copyright = map['copyright'];
    data =
        map['data'] != null ? DataModel().fromJson(map['data'], model) : null;
    etag = map['etag'];
    status = map['status'];

    return this;
  }

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    if (attributionHTML != null) {
      map['attributionHTML'] = attributionHTML;
    }
    if (attributionText != null) {
      map['attributionText'] = attributionText;
    }
    if (code != null) {
      map['code'] = code;
    }
    if (copyright != null) {
      map['copyright'] = copyright;
    }
    if (data != null) {
      map['data'] = data?.toMap();
    }
    if (etag != null) {
      map['etag'] = etag;
    }
    if (status != null) {
      map['status'] = status;
    }
    return map;
  }
}
