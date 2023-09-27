import 'package:covid_tracker/View/world.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Detailed_Screen extends StatefulWidget {
  String name;
  String image;
  int totalCases, totaldeaths, active, critical, todayRecovered, test;
  Detailed_Screen(
      // this is called  from privous screen
      {required this.name,
      required this.totalCases,
      required this.totaldeaths,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test,
      required this.image});

  @override
  State<Detailed_Screen> createState() => _Detailed_ScreenState();
}

class _Detailed_ScreenState extends State<Detailed_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.067),
                child: Card(
                  child: Column(children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                    ),
                    Reused(
                        title: "total cases",
                        value: widget.totalCases.toString()),
                    Reused(
                        title: "total death",
                        value: widget.totaldeaths.toString()),
                    Reused(
                        title: "today recovered",
                        value: widget.todayRecovered.toString()),
                    Reused(
                        title: "critical", value: widget.critical.toString()),
                    Reused(title: "test", value: widget.test.toString()),
                    Reused(title: "active", value: widget.active.toString()),
                    Reused(
                        title: "today recovered",
                        value: widget.todayRecovered.toString()),
                  ]),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
