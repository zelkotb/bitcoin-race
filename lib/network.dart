import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  Future<dynamic> sendGetRequest(String url) async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception();
      }
    } catch (e) {
      ResponseDTO dtoMock =
          ResponseDTO("2020-05-25", "BTC", "EUR", 8172.083695221455);
      return jsonEncode(dtoMock);
    }
  }
}

class ResponseDTO {
  ResponseDTO(this.time, this.assetIdBase, this.assetIdQuote, this.rate);

  String time;
  String assetIdBase;
  String assetIdQuote;
  double rate;

  ResponseDTO.fromJson(Map<String, dynamic> json)
      : time = json['time'],
        assetIdBase = json['asset_id_base'],
        assetIdQuote = json['asset_id_quote'],
        rate = json['rate'];

  Map<String,dynamic> toJson() =>
      {
        'time' : time,
        'asset_id_base' : assetIdBase,
        'asset_id_quote' : assetIdQuote,
        'rate' : rate
      };
}
