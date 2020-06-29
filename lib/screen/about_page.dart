import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Apps',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Developer',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                  'Hanif Khoirul Fathansyah seorang Mobile and Backend Developer.',
                  style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 20,
              ),
              Text(
                'Tujuan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                  'Aplikasi ini dibuat untuk menampilkan berbagai macam makanan di dunia disertai dengan cara pembuatan nya.\n'
                  'Sehingga user dapat mengikuti cara pembuatan nya jika ingin membuat makanannya sendiri',
                  style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 20,
              ),
              Text(
                'Tools',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                  'Aplikasi ini dibuat dengan Flutter Framework menggunakan Intellij IDE',
                  style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
