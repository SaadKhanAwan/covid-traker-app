import 'package:covid_tracker/View/countries_list.dart';
import 'package:covid_tracker/model/world_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import '../services/states_services.dart';

class worldstatescreen extends StatefulWidget {
  const worldstatescreen({Key? key}) : super(key: key);

  @override
  State<worldstatescreen> createState() => _worldstatescreenState();
}

class _worldstatescreenState extends State<worldstatescreen>
    with TickerProviderStateMixin {
  void dispose() {
    super.dispose();
    animation_controller.dispose();
  }

  late final animation_controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();

  final colorlist = <Color>[
    Color(0xff4285f4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              FutureBuilder(
                  future: stateServices.FetchWorldStateRecords(),
                  builder:
                      (context, AsyncSnapshot<WorldStatesmodel> snapshort) {
                    if (!snapshort.hasData) {
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50.0,
                            controller: animation_controller,
                          ));
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": double.parse(
                                  snapshort.data!.cases!.toString()),
                              "Recover": double.parse(
                                  snapshort.data!.recovered!.toString()),
                              "Death": double.parse(
                                  snapshort.data!.deaths!.toString()),
                            },
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            legendOptions: LegendOptions(
                                legendPosition: LegendPosition.left),
                            animationDuration: Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: colorlist,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.06),
                            child: Card(
                              child: Column(
                                children: [
                                  Reused(
                                      title: "total cases",
                                      value: snapshort.data!.cases!.toString()),
                                  Reused(
                                      title: "total recovered",
                                      value: snapshort.data!.recovered!
                                          .toString()),
                                  Reused(
                                      title: "total deaths",
                                      value:
                                          snapshort.data!.deaths!.toString()),
                                  Reused(
                                      title: "today cases",
                                      value: snapshort.data!.todayCases!
                                          .toString()),
                                  Reused(
                                      title: "todays death",
                                      value: snapshort.data!.todayDeaths!
                                          .toString()),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => countries_list()));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(child: Text("Track countries")),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Reused extends StatelessWidget {
  String title, value;
  Reused({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider()
        ],
      ),
    );
  }
}
