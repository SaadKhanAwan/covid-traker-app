import 'package:covid_tracker/View/country_detail.dart';
import 'package:covid_tracker/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class countries_list extends StatefulWidget {
  const countries_list({Key? key}) : super(key: key);

  @override
  State<countries_list> createState() => _countries_listState();
}

class _countries_listState extends State<countries_list> {
  // this is Sherch bar Textfield to sherch for specific country
  TextEditingController shearch_contoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // StateServices are initilizse here
    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: shearch_contoller,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  hintText: "Search With Countries",
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0))),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: stateServices.CountriesListApi(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      // this is for shimmer effect
                      return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  height: 10,
                                  width: 90,
                                  color: Colors.white,
                                ),
                                title: Container(
                                  height: 10,
                                  width: 90,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 90,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ));
                    });
              } else {
                // this is if no data enter i text field
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]["country"];
                      if (shearch_contoller.text.isEmpty) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Detailed_Screen(
                                              image: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                              name: snapshot.data![index]
                                                  ['country'],
                                              totalCases: snapshot.data![index]
                                                  ['cases'],
                                              todayRecovered:
                                                  snapshot.data![index]
                                                      ['todayRecovered'],
                                              totaldeaths: snapshot.data![index]
                                                  ['deaths'],
                                              active: snapshot.data![index]
                                                  ['active'],
                                              test: snapshot.data![index]
                                                  ['tests'],
                                              critical: snapshot.data![index]
                                                  ['critical'],
                                            )));
                              },
                              child: ListTile(
                                // this is to fetch images
                                leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag'])),
                                // this is to fetch countries
                                title: Text(snapshot.data![index]["country"]),
                                // this is to fetch cases
                                subtitle: Text(
                                    snapshot.data![index]["cases"].toString()),
                              ),
                            )
                          ],
                        );
                        // this is if a country is sherch in textfield
                      } else if (name
                          .toLowerCase()
                          .contains(shearch_contoller.text.toLowerCase())) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Detailed_Screen(
                                              image: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                              name: snapshot.data![index]
                                                  ['country'],
                                              totalCases: snapshot.data![index]
                                                  ['cases'],
                                              todayRecovered:
                                                  snapshot.data![index]
                                                      ['todayRecovered'],
                                              totaldeaths: snapshot.data![index]
                                                  ['deaths'],
                                              active: snapshot.data![index]
                                                  ['active'],
                                              test: snapshot.data![index]
                                                  ['tests'],
                                              critical: snapshot.data![index]
                                                  ['critical'],
                                            )));
                              },
                              child: ListTile(
                                leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag'])),
                                title: Text(snapshot.data![index]["country"]),
                                subtitle: Text(
                                    snapshot.data![index]["cases"].toString()),
                              ),
                            )
                          ],
                        );
                      } else {
                        Container();
                      }
                      return null;
                    });
              }
            },
          ))
        ],
      )),
    );
  }
}
