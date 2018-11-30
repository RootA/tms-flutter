import 'package:scoped_model/scoped_model.dart';

class Urls extends Model {
  String _mainUrl = "http://localhost:5000/api/v1";

  String get MainUrl {
    return _mainUrl;
  }
}