import 'package:covid_app/View/worldstates.dart';
import 'package:flutter/material.dart';

class ShowDetail extends StatefulWidget {

 final String image;
 final String name;
 final int totalcases,deaths,totalrecovered,active, critical, todayrecovered;
  const ShowDetail({required this.totalcases,required this.deaths,required this.image, required this.name ,required this.totalrecovered,required this.active,required this.critical,required this.todayrecovered });


  @override
  State<ShowDetail> createState() => _ShowDetailState();
}

class _ShowDetailState extends State<ShowDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.name)),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: 60,),
                      ReusableRow(title: 'cases', value: widget.totalcases.toString()),
                      ReusableRow(title: 'Recovered', value: widget.totalrecovered.toString()),
                      ReusableRow(title: 'Death', value: widget.deaths.toString()),
                      ReusableRow(title: 'Critical', value: widget.critical.toString()),
                      
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(widget.image),
                radius: 50,
              )
            ],
          )
        ],
      ),
    );
  }
}