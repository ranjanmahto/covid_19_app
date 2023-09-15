import 'package:covid_app/Model/WorldStatesModel.dart';
import 'package:covid_app/View/countries_list.dart';
import 'package:covid_app/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin {

   StatesServices statesServices = StatesServices();


  late final AnimationController controller = AnimationController(
  duration: const Duration(seconds: 3),
  vsync: this)..repeat();
  @override
  void dispose()
  {
    super.dispose();
    controller.dispose();
  }
  final colorlist = <Color>[
     const Color(0xff4285F4),
     const Color(0xff1aa260),
     const Color(0xffde5246)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
              children: [
                SizedBox(height: 20,),
                FutureBuilder(future: statesServices.fetchWorldRecords(),
                builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){

                  if(!snapshot.hasData)
                  {
                     return Expanded(

                      child: SpinKitFadingCircle(
                           color: Colors.white,
                           size: 50,
                           controller: controller,
                      ));
                  }
                  else{



                    return Column(
                      children: [
                            PieChart(
                                            dataMap:  {
                                              "Total": double.parse(snapshot.data!.cases.toString()),
                                              "recoverable" : double.parse(snapshot.data!.recovered.toString()),
                                              "Deaths":double.parse(snapshot.data!.deaths.toString()),
                                            },
                                            chartRadius: MediaQuery.of(context).size.width/3.2,
                                             legendOptions: const LegendOptions(
                                              legendPosition: LegendPosition.left
                                             ),
                                             animationDuration: const Duration(milliseconds: 1200),
                                             chartType: ChartType.ring,
                                             colorList: colorlist,


                                            ),
                  SizedBox(height: 25,),

                  Column(
                    children: [
                      ReusableRow(title: 'Total', value:  snapshot.data!.cases.toString(),),
                    ReusableRow(title: 'Recovered today', value: snapshot.data!.recovered.toString(),),
                     ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString(),),
                     ReusableRow(title: 'active', value: snapshot.data!.active.toString(),),
                     ReusableRow(title: 'critical', value: snapshot.data!.critical.toString(),),
                     ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString(),),
                     ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString(),),
                    ],
                  ),

                  SizedBox(height: 50,),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CountryList(),));
                        },
                        splashColor: Colors.white,
                        child:  Container(

                            height:50,

                            decoration: BoxDecoration(

                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(child: const Text('Track Country',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                          ),
                        ),

                    ],
                  )
                      ],
                    );
                  }
                } ,
                ),



              ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title;
    final String value;
   ReusableRow({required this.title,required this.value,super.key});

  @override
  Widget build(BuildContext context) {
    

    return  Padding(
      padding:const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
              
            ],
          ),
          SizedBox(height: 10,),
          Divider(),
        ],
      ),
    );
  }
}