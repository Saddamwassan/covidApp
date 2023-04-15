import 'package:covid_tracker/Services/Utilities/states_services.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Models/world_states_model.dart';

class Worldstatescreen extends StatefulWidget {
  const Worldstatescreen({Key? key}) : super(key: key);

  @override
  State<Worldstatescreen> createState() => _WorldstatescreenState();
}

class _WorldstatescreenState extends State<Worldstatescreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 4), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorlist = <Color>[
    const Color(0xff4285f4),
    Color(0xff1aa260),
    Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .01),
            FutureBuilder(
                future: statesServices.fetchWorldStatesRecord(),
                builder: (context, AsyncSnapshot<WorldstatesModel> snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: _controller,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: const {
                            "Total": 50,
                            "Recoverd": 20,
                            "Deaths": 30
                          },
                          chartRadius: MediaQuery.of(context).size.height / 3.2,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                          animationDuration: const Duration(milliseconds: 3300),
                          chartType: ChartType.ring,
                          colorList: colorlist,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .06),
                          child: Card(
                            child: Column(children: [
                              Reuseablecode(title: "Total", value: "100"),
                              Reuseablecode(title: "Total", value: "100"),
                              Reuseablecode(title: "Total", value: "100")
                            ]),
                          ),
                        ),
                        Container(
                          height: 51,
                          decoration: BoxDecoration(
                              color: const Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(child: Text("Track Countries")),
                        )
                      ],
                    );
                  }
                }),
          ],
        ),
      )),
    );
  }
}

class Reuseablecode extends StatelessWidget {
  String title, value;
  Reuseablecode({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, bottom: 5, left: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider()
        ],
      ),
    );
  }
}
