import 'package:flutter/material.dart';
import 'package:unique_simple_bar_chart/data_models.dart';
import 'package:unique_simple_bar_chart/simple_bar_chart.dart';
import 'superhero_api.dart';

class HeroProfilePage extends StatelessWidget {
  final String heroId;
  final SuperheroApi superheroApi = SuperheroApi();

  HeroProfilePage(this.heroId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Perfil del Héroe'),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: superheroApi.getHeroDetails(int.parse(heroId) as int),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                Map<String, dynamic>? heroDetails =
                    snapshot.data as Map<String, dynamic>?;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nombre de Héroe:'),
                        Text(
                          '${heroDetails?['name']}',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text('Nombre Completo:'),
                        Text(
                          '${heroDetails?['biography']['full-name']}',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text('Imagen:'),
                        SizedBox(height: 10),
                        Image.network(
                          heroDetails?['image']['url'],
                        ),
                        SizedBox(height: 20),
                        Text('Poderes:'),
                        SimpleBarChart(
                          horizontalBarPadding: 5,
                          verticalInterval: 33,
                          listOfHorizontalBarData: [
                            HorizontalDetailsModel(
                              name: 'Inteligencia',
                              color: const Color(0xFFEB7735),
                              size: double.parse(
                                  heroDetails?['powerstats']['intelligence']),
                            ),
                            HorizontalDetailsModel(
                              name: 'Fuerza',
                              color: const Color(0xFFFBBC05),
                              size: double.parse(
                                  heroDetails?['powerstats']['strength']),
                            ),
                            HorizontalDetailsModel(
                              name: 'Velocidad',
                              color: const Color(0xFFEB7735),
                              size: double.parse(
                                  heroDetails?['powerstats']['speed']),
                            ),
                            HorizontalDetailsModel(
                              name: 'Durabilidad',
                              color: const Color(0xFFFBBC05),
                              size: double.parse(
                                  heroDetails?['powerstats']['durability']),
                            ),
                            HorizontalDetailsModel(
                              name: 'Poder',
                              color: const Color(0xFFEB7735),
                              size: double.parse(
                                  heroDetails?['powerstats']['power']),
                            ),
                            HorizontalDetailsModel(
                              name: 'Combate',
                              color: const Color(0xFFFBBC05),
                              size: double.parse(
                                  heroDetails?['powerstats']['combat']),
                            ),
                          ],
                        ),
                      ]),
                );
              }
            },
          ),
        ));
  }
}
