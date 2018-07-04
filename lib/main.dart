import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/rendering.dart';

void main() {
//  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class RandomWord extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RandomWordState();
  }
}

class RandomWordState extends State<RandomWord> {
  final wordPairs = <WordPair>[];
  final _checked = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Listview"),
          leading: new IconButton(icon: new Icon(Icons.add), onPressed: null),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.list), onPressed: _changeToSavedList)
          ],
        ),
        body: new ListView.builder(itemBuilder: (context, i) {
          if (i >= wordPairs.length) {
            wordPairs.addAll(generateWordPairs().take(10));
          }
          return _bindingRow(wordPairs[i], i);
        }));
  }

  Widget _bindingRow(WordPair wordPair, i) {
    final color = i % 2 == 0 ? Colors.red : Colors.blue;
    final isChecked = _checked.contains(wordPair);
    return new ListTile(
      leading: Icon(
        isChecked ? Icons.check_box : Icons.check_box_outline_blank,
        color: color,
      ),
      title: new Text(wordPair.asUpperCase,
          style: TextStyle(fontSize: 22.0, color: color)),
      onTap: () {
        setState(() {
          if (isChecked)
            _checked.remove(wordPair);
          else
            _checked.add(wordPair);
        });
      },
    );
  }

  _changeToSavedList() {
    var route = new MaterialPageRoute(builder: (context) {
      final _listStringChecked = _checked.map((w) {
        return new ListTile(
          title: new Text(w.asUpperCase, style: TextStyle(fontSize: 20.0)),
        );
      });
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Checked"),
        ),
        body: new Center(
          child: new ListView(children: _listStringChecked.toList(),),
        ),
      );
    });
//
    Navigator.of(context).push(route);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(title: 'NGUYEN', home: new RandomWord());
  }
}
