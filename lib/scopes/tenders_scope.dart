import 'package:scoped_model/scoped_model.dart';
import 'main_scope.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TendersScope extends Model {

  List<dynamic> _tendersList = [];

  List<dynamic> get tenderListings {
    return List.from(_tendersList);
  }

  List<dynamic> _mytendersList = [];

  List<dynamic> get mytenderListings {
    return List.from(_mytendersList);
  }

  Future<void>  fetchTenderListings (MainScope model)  async {
    http.Response response = await http.get(model.MainUrl+'/tenders');
    _tendersList = json.decode(response.body);
    notifyListeners();
  }

  Future<void>  fetchMyTenderListings (MainScope model, public_id)  async {
    http.Response response = await http.get(model.MainUrl+'/my/tenders/${public_id}');
    _mytendersList = json.decode(response.body);
    notifyListeners();
  }
}