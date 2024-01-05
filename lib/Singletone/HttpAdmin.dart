import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HttpAdmin{


  HttpAdmin();


  Future<double> pedirTemperaturasEn(double latitud, double longitud) async{
    var url = Uri.https('api.open-meteo.com', '/v1/forecast',
        { 'latitude': latitud.toString(),
          'longitude': longitud.toString(),
          'hourly': 'temperature_2m',
        });

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      DateTime now = DateTime.now();
      int hora = now.hour;

      var jsonHourly = jsonResponse['hourly'];
      var jsonTemperaturas=jsonHourly['temperature_2m'];
      var jsonTemperatura0=jsonTemperaturas[hora];

      return jsonTemperatura0;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return 0;
    }

  }



}