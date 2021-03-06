import 'dart:convert';
import 'package:covid19_tracker/datasource.dart';
import 'package:covid19_tracker/pages/countryPage.dart';
import 'package:covid19_tracker/panels/infopanel.dart';
import 'package:covid19_tracker/panels/mostaffectedcountries.dart';
import 'package:covid19_tracker/panels/worldwidepanel.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  Future fetchData() async {
    fetchWorldWideData();
    fetchCountryData();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[
        IconButton(
          icon: Icon(Theme.of(context).brightness == Brightness.light
              ? Icons.lightbulb_outline
              : Icons.highlight),
          onPressed: () {
            DynamicTheme.of(context).setBrightness(
                Theme.of(context).brightness == Brightness.light
                    ? Brightness.dark
                    : Brightness.light);
          },
        )
      ], centerTitle: true, title: Text("COVID-19 TRACKER")),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                height: 100,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                color: Colors.orange[100],
                child: Text(DataSource.quote,
                    style: TextStyle(
                        color: Colors.orange[800],
                        fontWeight: FontWeight.w600,
                        fontSize: 16))),
            Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Worldwide",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CountryPage()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryBlack,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text("Regional",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    )
                  ],
                )),
            worldData == null
                ? Center(child: CircularProgressIndicator())
                : WorldWidePanel(
                    worldData: worldData,
                  ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Text("Most Affected Countries",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
            ),
            SizedBox(height: 10.0),
            countryData == null
                ? Center(child: CircularProgressIndicator())
                : MostAffectedCountriesPanel(countryData: countryData),
            SizedBox(height: 10.0),
            InfoPanel(),
            SizedBox(height: 10.0),
            Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Image.network(
                    'https://disease.sh/assets/img/flags/in.png',
                    width: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("PROUDLY MADE IN INDIA",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                ])),
            SizedBox(height: 30.0),
          ],
        )),
      ),
    );
  }
}
