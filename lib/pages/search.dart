import 'package:covid19_tracker/datasource.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  final List countryList;

  Search(this.countryList);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        primaryColor: primaryBlack,
        brightness: DynamicTheme.of(context).brightness);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionsList = query.isEmpty
        ? countryList
        : countryList
            .where((element) =>
                element['country'].toString().toLowerCase().startsWith(query))
            .toList();
    return ListView.builder(
        itemCount: suggestionsList.length,
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              height: 130,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 150,
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          suggestionsList[index]['country'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Image.network(
                            suggestionsList[index]['countryInfo']['flag'],
                            height: 50,
                            width: 60)
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            'CONFIRMED: ' +
                                suggestionsList[index]['cases'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                        Text(
                            'ACTIVE: ' +
                                suggestionsList[index]['active'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                        Text(
                            'RECOVERED: ' +
                                suggestionsList[index]['recovered'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green)),
                        Text(
                            'DEATHS: ' +
                                suggestionsList[index]['deaths'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.grey[100]
                                    : Colors.grey[800])),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          );
        });
  }
}
