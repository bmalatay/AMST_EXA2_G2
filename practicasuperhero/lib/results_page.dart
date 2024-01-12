import 'package:flutter/material.dart';
import 'hero_profile_page.dart';
import 'superhero_api.dart';

class ResultsPage extends StatelessWidget {
  final String searchQuery;
  final SuperheroApi superheroApi = SuperheroApi();

  ResultsPage(this.searchQuery);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Resultados'),
        ),
        body: FutureBuilder(
        future: superheroApi.searchHeroes(searchQuery),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
    return Center(child: Text('Error: ${snapshot.error}'));
    } else {
    List<dynamic>? heroes = snapshot.data as List<dynamic>?;

    return Container(
    decoration: BoxDecoration(
    gradient: LinearGradient(
    colors: [Colors.blue, Colors.purple],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    ),
    ),
    child: ListView.builder(
    itemCount: heroes?.length,
    itemBuilder: (context, index) {
    return Card(
    color: Colors.grey[300], // Fondo gris claro
    child: ListTile(
    title: Text(
    heroes?[index]['name'],
    style: TextStyle(color: Colors.blue), // Letras azules
    ),
    onTap: () {
    int heroId = int.parse(heroes![index]['id'].toString());
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => HeroProfilePage(heroId as String),
    ),
    );
    },
    ),
    );
    },
    ),
    );
    }
onTap: () {
int heroId = int.parse(heroes![index]['id'].toString());
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => HeroProfilePage(heroId),