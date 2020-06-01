import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String assetIdBase = "BTC";
  String assetIdQuote = "AUD";
  String rate = "?";
  CoinData coinData = CoinData();
  List<String> prices = [];
  bool loading = false;

  @override
  initState() {
    super.initState();
    getPrices();
  }

  Widget getPriceCard(String rate, String assetIdQuote, String assetIdBase) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $assetIdBase = $rate $assetIdQuote',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  List<Widget> getPriceCards(List<String> prices) {
    List<Widget> cards = List();
    if (prices.length == 0) {
      prices.add("?");
      prices.add("?");
      prices.add("?");
    }
    for (int i = 0; i < cryptoList.length; i++) {
      cards.add(this.getPriceCard(prices[i], assetIdQuote, cryptoList[i]));
    }
    return cards;
  }

  void getPrices() async {
    var rateDouble;
    setState(() {
      this.loading = true;
    });
    List<String> prices = List();
    for (int i = 0; i < cryptoList.length; i++) {
      rateDouble = await coinData.convert(cryptoList[i], assetIdQuote);
      prices.add(rateDouble.toStringAsFixed(3));
    }
    setState(() {
      this.prices = prices;
      this.loading = false;
    });
  }

  Widget getWidget(bool loading) {
    if (loading) {
      return Padding(
        padding: EdgeInsets.fromLTRB(30, 170, 30, 0),
        child: CircularProgressIndicator(
          backgroundColor: Colors.lightBlueAccent,
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: Column(
          children: getPriceCards(prices),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          getWidget(loading),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              value: assetIdQuote,
              onChanged: (value) {
                setState(() {
                  assetIdQuote = value;
                });
                getPrices();
              },
              items:
                  currenciesList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
