import 'tenders_scope.dart';
import 'url_scope.dart';
import 'tender_application_scope.dart';
import 'package:scoped_model/scoped_model.dart';
import 'bids_scope.dart';

class MainScope extends Model with TendersScope, Urls, ApplicationScope, BidsScope {

}
