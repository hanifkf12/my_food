import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_food/about_page.dart';
import 'package:my_food/bloc/food_bloc.dart';
import 'package:my_food/detail_page.dart';
import 'package:my_food/network/api_network.dart';

import 'model/meals.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Quicksand',
          primaryColor: Color(0xff2ecc71),
          accentColor: Color(0xff1abc9c)),
      home: MyHomePage(title: 'My Food'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var index = 0;
  List<String> categories = [
    'Beef',
    'Chicken',
    'Dessert',
    'Lamb',
    'Miscellaneous',
    'Pasta',
    'Seafood',
    'Side',
    'Starter',
    'Vegetarian',
    'Breakfast'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.fetchFoods(categories[index]);
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        body: Column(
            children: <Widget>[
              Container(
                  height: size.height * 0.36,
                  decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25.0),
                          bottomRight: Radius.circular(25.0))),
                  child: SafeArea(
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(
                                    Icons.menu,
                                    size: 30,
                                  ),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                                      return AboutPage();
                                    }));
                                  }),
                              Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage('assets/me.png'),
                                      ))),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            child: Text(
                              'Good Morning,\nWelccome Hanif Khoirul',
                              style: TextStyle(
                                  fontSize: 24.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 10),
                                      blurRadius: 50,
                                      color: Colors.black12)
                                ]),
                            height: 50,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.search,
                                  size: 30,
                                  color: Colors.black87,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Search Food',
                                      hintStyle: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                    onSubmitted: (text) {
                                      print(text);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 16),
                height: 30,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: buildChipList()),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: StreamBuilder(
                      stream: bloc.subject,
                      builder: (context, AsyncSnapshot<Meals> snapshot){
                        if (snapshot.hasData) {
                          return buildList(snapshot);
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return Center(child: CircularProgressIndicator());
                  }
                  ),
                ),
              )
            ],
          ),
    );
  }

  List<Widget> buildChipList() {
    List<Widget> listChip = List();
    for (var i = 0; i <= 10; i++) {
      listChip.add(ChoiceChip(
        label: Text(
          categories[i],
          style: TextStyle(
              fontSize: 18, color: index == i ? Colors.white : Colors.black),
        ),
        selected: index == i,
        onSelected: (bool selected) {
          setState(() {
            index = i;
            bloc.fetchFoods(categories[i]);
          });
        },
        selectedColor: Theme
            .of(context)
            .accentColor,
        backgroundColor: Color(0xffbdc3c7),
      ));
      listChip.add(SizedBox(
        width: 10,
      ));
    }
    return listChip;
  }

  Widget buildList(AsyncSnapshot<Meals> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.meals.length,
        shrinkWrap: true,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              print(snapshot.data.meals[index].idMeal);
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return DetailPage(idMeal: snapshot.data.meals[index].idMeal,);
              }));
            },
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(snapshot.data.meals[index].strMealThumb),
                  fit: BoxFit.cover
                )
              ),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                        color: Colors.black.withOpacity(0.5),

                      ),
                      width: double.infinity,
                      child: Text(snapshot.data.meals[index].strMeal,style: TextStyle(color: Colors.white, fontSize: 15),),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
