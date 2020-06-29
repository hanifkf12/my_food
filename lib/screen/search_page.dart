import 'package:flutter/material.dart';
import 'package:my_food/bloc/food_bloc.dart';
import 'package:my_food/model/meals.dart';

import 'detail_page.dart';

class SearchPage extends StatefulWidget {
  String param;

  SearchPage({this.param});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.param;
    bloc..searchFoods(widget.param);
  }

  @override
  void dispose() {
    super.dispose();
    bloc.drainSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(2, 2),
                          blurRadius: 3,
                          color: Colors.black45),
                      BoxShadow(
                          offset: Offset(0, -1),
                          blurRadius: 10,
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
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'Search Food',
                          hintStyle: TextStyle(
                              color: Colors.black87,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        onChanged: (text) {
                          bloc.drainSearch();
                          bloc.searchFoods(text);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: Container(
                child: StreamBuilder(
                    stream: bloc.searchSubject,
                    builder: (context, AsyncSnapshot<Meals> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.meals == null) {
                          return buildEmptyView(controller.text);
                        }
                        return buildList(snapshot);
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmptyView(String param) {
    return Expanded(
      child: Center(
        child: Text(
          '$param,\nNot Found',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<Meals> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.meals.length,
        shrinkWrap: true,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              print(snapshot.data.meals[index].idMeal);
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return DetailPage(
                  idMeal: snapshot.data.meals[index].idMeal,
                );
              }));
            },
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image:
                        NetworkImage(snapshot.data.meals[index].strMealThumb),
                    fit: BoxFit.cover),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(4, 6),
                      blurRadius: 6,
                      color: Colors.black45)
                ],
              ),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        color: Colors.black.withOpacity(0.5),
                      ),
                      width: double.infinity,
                      child: Text(
                        snapshot.data.meals[index].strMeal,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
