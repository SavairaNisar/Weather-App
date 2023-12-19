class Weather {
  final String cityName;
  final double tempreature;
  final String mainCondition;

  Weather({ required this.cityName,
    required this.tempreature,
    required this.mainCondition,
  });

  factory Weather.fromJson(Map<String, dynamic>json){
    return Weather(cityName: json['name'],
        tempreature: json['main']['temp'].toDouble(),
        mainCondition: json['weather'][0]['main']);
  }

}
