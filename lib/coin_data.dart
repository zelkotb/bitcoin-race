import 'package:bitcoin_ticker/network.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
const baseUrl = "https://rest.coinapi.io/v1/exchangerate/";
const apikey = "5AF9AE2A-3CBB-4427-A0DC-AAD577053FF8";
class CoinData {

  NetworkHelper helper = NetworkHelper();
  Future<double> convert(String assetIdBase, String assetIdQuote) async{
    String url = "$baseUrl$assetIdBase/$assetIdQuote?apikey=$apikey";
    var data = await helper.sendGetRequest(url);
    return data['rate'];
  }
}
