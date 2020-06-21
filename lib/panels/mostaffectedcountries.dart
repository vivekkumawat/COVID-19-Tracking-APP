import 'package:flutter/material.dart';

class MostAffectedCountriesPanel extends StatelessWidget {
  final List countryData;
  const MostAffectedCountriesPanel({Key key, this.countryData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Row(
                children: <Widget>[
                  Image.network(
                    countryData[index]['countryInfo']['flag'],
                    height: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(countryData[index]['country'],
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Deaths: ' + countryData[index]['deaths'].toString(),
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w600),
                  )
                ],
              ));
        },
        itemCount: 5,
      ),
    );
  }
}
