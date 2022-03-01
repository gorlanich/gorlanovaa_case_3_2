import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('http://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode==200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load...');
  }
}

Future<Post> fetchPost() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

  if (response.statusCode==200) {
    return Post.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load...');
  }
}


class Album {
  final int userId;
  final int id;
  final String title;

  Album({
    required this.userId,
    required this.id,
    required this.title,
});

  factory Album.fromJson(Map<String, dynamic> json) {
  return Album(
    userId: json['userId'],
    id: json['id'],
    title: json['title'],
  );
}
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}


class NetworkingScreen extends StatefulWidget {
  const NetworkingScreen({Key? key}) : super(key: key);

  @override
  _NetworkingScreenState createState() => _NetworkingScreenState();
}

class _NetworkingScreenState extends State<NetworkingScreen> {
  //late Future<Album> futureAlbum;
  late Future<Post> futurePost;

  @override
  void initState() {
    super.initState();
    //futureAlbum = fetchAlbum();
    futurePost = fetchPost();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP Fetching',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("HTTP Fetching "),
        ),

            body: Center(
          child: Column(children: [SizedBox(height:230,),
            Text("Text of the title is:", style: TextStyle(fontSize: 30,)),
          FutureBuilder<Post>(
          future: futurePost,
        builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.title);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
        },

      ),
            Text("Text of the body is:", style: TextStyle(fontSize: 30,)),
            FutureBuilder<Post>(
              future: futurePost,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!.body);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },

            ),
             ]),
      ),
      ),
    );
  }
}



