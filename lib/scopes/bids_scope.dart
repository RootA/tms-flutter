import 'package:scoped_model/scoped_model.dart';
import 'main_scope.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BidsScope extends Model {

  List<dynamic> _bidsList = [];

  List<dynamic> get mybidListings {
    return List.from(_bidsList);
  }

  void fetchBidListings (MainScope model)  async {
    http.Response response = await http.get(model.MainUrl+'/bids');
    _bidsList = json.decode(response.body);
    notifyListeners();
  }

  void fetchMybidsListings (MainScope model, public_id)  async {
    http.Response response = await http.get(model.MainUrl+'/my/bids/${public_id}');
    _bidsList = json.decode(response.body);
    notifyListeners();
  }
}