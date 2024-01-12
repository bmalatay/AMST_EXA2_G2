import 'package:flutter/material.dart';
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
      body: FutureBuilder(
        future: superheroApi.getHeroDetails(heroId as int),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Map<String, dynamic>? heroDetails = snapshot.data as Map<String, dynamic>?;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nombre de Héroe: ${heroDetails?['name']}'),
                  Text('Nombre Completo: ${heroDetails?['biography']['full-name']}'),
                  Image.network(heroDetails?['images']['lg']),
                  // Agregar gráfico de barra con las estadísticas de poder aquí
                ],
              ),
            );
          }
        },
      ),
    );
  }
}