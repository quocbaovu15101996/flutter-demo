import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/pokedex/pokedex.data.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({Key? key}) : super(key: key);

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  List<GrobotItem> grobots = [];

  @override
  void initState() {
    super.initState();
    fetchGrobots();
  }

  void fetchGrobots() async {
    try {
      Response response = await Dio().get(
          'https://api.beta.radiantgalaxy.io/v1/market/grobot/selling?page=0&size=12&sortType=ASC&sortBy=PRICE&minStar=1&maxStar=9&minDurability=0&maxDurability=100&quality=1,2,3,4&gene=1,2,3,4,5&gclass=1,2,3,4,5,6');

      final items = ListGrobot.fromJson(response.data).data;
      setState(() {
        grobots = items ?? [];
      });
      log('show response $grobots');
    } catch (e) {
      log('err: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pokedex",
      home: MyPokedexWidget(grobots),
    );
  }
}

class MyPokedexWidget extends StatelessWidget {
  const MyPokedexWidget(this.grobots, {Key? key}) : super(key: key);

  final List<GrobotItem> grobots;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Center(
            child: Text('Pokedex', style: TextStyle(color: Colors.black)),
          ),
          bottom: const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontStyle: FontStyle.italic),
            tabs: <Widget>[
              Tab(
                text: "All Pokemons",
              ),
              Tab(
                text: "Favourites",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: ListPokemon(grobots),
            ),
            const Center(
              child: Text("Favourites Page"),
            ),
          ],
        ),
      ),
    );
  }
}

class ListPokemon extends StatelessWidget {
  const ListPokemon(this.grobots, {Key? key}) : super(key: key);

  final List<GrobotItem> grobots;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GridView(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 50),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      children: [
        for (var item in grobots)
          PokemonItem(item, (screenSize.width - 100) / 2)
      ],
    );
  }
}

class PokemonItem extends StatelessWidget {
  const PokemonItem(this.item, this.size, {Key? key}) : super(key: key);

  final GrobotItem item;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
            Widget>[
      Image.network(item.grobot?.gmodel?.url ?? '', width: size, height: size),
      const SizedBox(height: 4),
      Text(item.grobot?.idNft?.toString() ?? '',
          style:
              const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)),
      Text(item.grobot?.gmodel?.name?.toString() ?? '',
          style: const TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              color: Colors.black)),
    ]));
  }
}
