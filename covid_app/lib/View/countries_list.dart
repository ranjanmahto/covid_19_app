import 'package:covid_app/View/showdetail.dart';
import 'package:flutter/material.dart';
import 'package:covid_app/services/states_services.dart';
import 'package:shimmer/shimmer.dart';

class CountryList extends StatefulWidget {
  const CountryList({super.key});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  TextEditingController searchbar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Countries List',
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchbar,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  hintText: "Search by country name ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(59),
                  )),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: StatesServices().fetchCountryRecords(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.white,
                                child: ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 10,
                                      width: 90,
                                      color: Colors.white,
                                    ),
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    width: 90,
                                    color: Colors.white,
                                  ),
                                )),
                          );
                        });
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]["country"];

                          if (searchbar.text.isEmpty) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ShowDetail(
                                              totalcases: snapshot.data![index]
                                                  ["cases"],
                                              deaths: snapshot.data![index]
                                                  ["deaths"],
                                              image: snapshot.data![index]
                                                  ["countryInfo"]['flag'],
                                              name: snapshot.data![index]
                                                  ["country"],
                                              totalrecovered: snapshot
                                                  .data![index]["recovered"],
                                              active: snapshot.data![index]
                                                  ["active"],
                                              critical: snapshot.data![index]
                                                  ["critical"],
                                              todayrecovered:
                                                  snapshot.data![index]
                                                      ["todayRecovered"]),
                                        ));
                                  },
                                  child: ListTile(
                                    leading: Image(
                                      image: NetworkImage(snapshot.data![index]
                                          ["countryInfo"]['flag']),
                                      height: 50,
                                      width: 50,
                                    ),
                                    title:
                                        Text(snapshot.data![index]["country"]),
                                    subtitle: Text(snapshot.data![index]
                                            ["cases"]
                                        .toString()),
                                  ),
                                )
                              ],
                            );
                          } else if (name
                              .toLowerCase()
                              .contains(searchbar.text)) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                     Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ShowDetail(
                                              totalcases: snapshot.data![index]
                                                  ["cases"],
                                              deaths: snapshot.data![index]
                                                  ["deaths"],
                                              image: snapshot.data![index]
                                                  ["countryInfo"]['flag'],
                                              name: snapshot.data![index]
                                                  ["country"],
                                              totalrecovered: snapshot
                                                  .data![index]["recovered"],
                                              active: snapshot.data![index]
                                                  ["active"],
                                              critical: snapshot.data![index]
                                                  ["critical"],
                                              todayrecovered:
                                                  snapshot.data![index]
                                                      ["todayRecovered"]),
                                        ));
                                  },
                                  child: ListTile(
                                    leading: Image(
                                      image: NetworkImage(snapshot.data![index]
                                          ["countryInfo"]['flag']),
                                      height: 50,
                                      width: 50,
                                    ),
                                    title: Text(snapshot.data![index]["country"]),
                                    subtitle: Text(snapshot.data![index]["cases"]
                                        .toString()),
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Container();
                          }
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}
