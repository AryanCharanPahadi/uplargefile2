import 'dart:convert';
import 'package:app17000ft/base_client/app_exception.dart';
import 'package:app17000ft/base_client/base_client.dart';
import 'package:app17000ft/helper/database_helper.dart';
import 'package:app17000ft/tourDetails/tour_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://mis.17000ft.org/apis/fast_apis/';
List<TourDetails> _tourList = [];
List<TourDetails> get tourList => _tourList;

  //fetch tour ids
   Future <List<TourDetails>> fetchTourIds(String? office) async {
    print('fetchTour ids is called for $office');
    _tourList = [];
   
    var request = {'office': office ?? ''};
   
    var response = await BaseClient()
        .post(baseUrl,'tourIds.php', request)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
      //  DialogHelper.showErroDialog(description: apiError["reason"]);
      } else {
        //handleError(error);
      }
    });

     _tourList = tourDetailsFromJson(response);
     // print('this is response ${response.body}');
    
    if(_tourList.isNotEmpty) {
      SqfliteDatabaseHelper().delete('tour_details');
      for(int i = 0; i < _tourList.length; i++) {
      await  LocalDbController().addData(tourDetails: _tourList[i]);
      }

    }
   

    return _tourList;
  }
}
