import 'package:scoped_model/scoped_model.dart';
import 'main_scope.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class singleTenderScope extends Model {
  Map _singleTender = {};

  Map get singleTender {
    return Map.from(_singleTender);
  }

  Future fetchTenderDetails (MainScope model, public_id) async {
    http.Response response = await http.get(model.MainUrl+'/tenders/' + public_id);
    _singleTender = json.decode(response.body);
    notifyListeners();
  }
}

