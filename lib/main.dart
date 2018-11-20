import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcomes to Flutter',
      home: RandomWords(),
      theme: new ThemeData(primaryColor: Colors.redAccent),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  void _pushSaved() {
    Navigator.of(context)
        .push(new MaterialPageRoute<void>(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _saved.map((String pair) {
        return new ListTile(
            title: new Text(
          pair.toString(),
          style: _biggerFont,
        ));
      });
      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();
      return new Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
        ),
        body: new ListView(children: divided),
      );
    }));
  }

  final List<String> _suggestions = <String>[];

  final Set<String> _saved = Set<String>();

  final _biggerFont = const TextStyle(fontSize: 18);

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: EdgeInsets.all(16),

      //itemCount: 10,

      itemBuilder: (context, i) {
        //if (i == 1) {
          //_suggestions.addAll(nouns.take(10));
        //}
        if (i.isOdd) return Divider();

        final index = i ~/ 2;

        if (index >= _suggestions.length) {
             _suggestions.addAll(nouns.take(5));

        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(String pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
        title: Text(pair.toString(), style: _biggerFont),
        trailing: new Icon(
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.redAccent : null),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: _buildSuggestions(),
      appBar: AppBar(
        title: Text('The Great list'),
        actions: <Widget>[
          new IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0, // this will be set when a new tab is tapped
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.compare_arrows),
            title: new Text('Home'),
          ), BottomNavigationBarItem(
            icon: new Icon(Icons.compare_arrows),
            title: new Text('Home2'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            title: new Text('Messages'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            title: new Text('Messages'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            title: new Text('Messages'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.create),
            title: new Text('Create new'),
            backgroundColor: Colors.brown,
          ),
        ],
      ),
    );
   
  }
   Future<void> _onItemTapped(int index) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('clicked button ' + index.toString())
          );
        }
      );
    }
}
