import 'package:flutter/material.dart';
import 'package:my_food/bloc/food_bloc.dart';
import 'package:my_food/model/detail_meals.dart';

class DetailPage extends StatefulWidget {
  String idMeal;

  DetailPage({this.idMeal});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    bloc..fetchDetailMeal(widget.idMeal);
  }

  @override
  void dispose() {
    super.dispose();
    bloc..drainDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: bloc.detailSubject,
          builder: (context, AsyncSnapshot<DetailMeal> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return buildWidget(snapshot.data.meals[0], context);
          }),
    );
  }

  buildWidget(Food food, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(food.strMealThumb),
                          fit: BoxFit.cover),
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(20))),
                ),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SafeArea(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.5)),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ),
                  left: 4,
                  top: 4,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: Text(
                      '${food.strArea} Food,\n' + food.strMeal,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 15,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('Instructions', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              food.strInstructions,
              textAlign: TextAlign.justify,
              softWrap: true,
              style: TextStyle(
                fontSize: 16
              ),
            ),
          )
        ],
      ),
    );
  }
}
