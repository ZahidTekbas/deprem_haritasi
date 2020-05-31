import 'package:deprem_haritasi/models/depremClass.dart';
import 'package:deprem_haritasi/services/get_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

List<Marker> markers;

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 1.2,
              child: FutureBuilder(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    markers = new List<Marker>();
                    return Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: FlutterMap(
                            options: MapOptions(
                                center: LatLng(39.92, 32.85), zoom: 5.0),
                            layers: [
                              TileLayerOptions(
                                  urlTemplate:
                                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                  subdomains: ['a', 'b', 'c']),
                              MarkerLayerOptions(markers: markers)
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                var info =
                                    DepremData.fromJson(snapshot.data, index);
                                markers.add(
                                  Marker(
                                    height: 15.0,
                                    width: 15.0,
                                    point: LatLng(info.getLat(), info.getLng()),
                                    builder: (context) => Container(
                                      child: GestureDetector(
                                          child: Icon(Icons.location_on),
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        '${info.location}'),
                                                    content:
                                                        Text('Buyukluk: ${info.magnitude} \n Derinlik: ${info.depth}'),
                                                    actions: <Widget>[
                                                      new FlatButton(
                                                        child:
                                                            new Text("Close"),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                });
                                          }),
                                    ),
                                  ),
                                );
                                return SizedBox(
                                  height: 0,
                                );
                              }),
                        )
                      ],
                    );
                  }
                  return Container(
                      height: 50.0, width: 100.0, child: Text('bekliyor...'));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

/* 
                            Marker(
                              width: 20.0,
                              height: 20.0,
                              point: LatLng(39.92, 32.85),
                              builder: (ctx) => Container(
                                child: GestureDetector(
                                    child: FlutterLogo(), onTap: () {}),
                              ),
                            ),

*/
