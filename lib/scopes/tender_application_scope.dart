import 'package:scoped_model/scoped_model.dart';

class ApplicationScope extends Model {
  Map _postRequestHeaders = {
    'Accept' : 'application/json'
  };

  Map get getHeaders {
    return _postRequestHeaders;
  }

  void postApplicationData (postValues) {
    print(postValues);
    return null;

  }
}