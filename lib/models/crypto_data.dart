
class CryptoData {
  final int id;
  final String? image;
  final String name;
  final String symbol;
  final String screener;
  final String exchange;
  final int buy;
  final int neutral;
  final int sell;
  final String recommendation;
  CryptoData({
    required this.id,
    required this.screener,
    required this.image,
    required this.recommendation,
    required this.name,
    required this.symbol,
    required this.buy,
    required this.neutral,
    required this.sell,
    required this.exchange,
  });

  factory CryptoData.fromJson(Map<String, dynamic> json) {
    return CryptoData(
        id: json['id'],
        image: json['image'],
        name: json['name'],
        screener:json['screener'],
        exchange:json['exchange'],
        symbol: json['symbol'],
        buy: json['buy'],
        sell: json['sell'],
        neutral: json['neutral'],
        recommendation: json['recommendation']);
  }
}