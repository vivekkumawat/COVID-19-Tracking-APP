import 'package:covid19_tracker/datasource.dart';
import 'package:covid19_tracker/pages/faqs.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FAQPage()));
            },
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                color: primaryBlack,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "FAQs",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      Icon(Icons.arrow_forward, color: Colors.white)
                    ])),
          ),
          GestureDetector(
            onTap: () {
              launch('https://www.pmcares.gov.in/en/');
            },
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                color: primaryBlack,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "DONATE",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      Icon(Icons.arrow_forward, color: Colors.white)
                    ])),
          ),
          GestureDetector(
            onTap: () {
              launch(
                  'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/myth-busters');
            },
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                color: primaryBlack,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "MYTH BUSTERS",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      Icon(Icons.arrow_forward, color: Colors.white)
                    ])),
          )
        ],
      ),
    );
  }
}
