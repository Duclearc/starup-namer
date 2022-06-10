import 'package:flutter/material.dart';

import 'package:startup_namer/button_icon_round.dart';
import 'package:english_words/english_words.dart';
import 'package:startup_namer/selected_names.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);
  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _initialPlaceholderText = 'Press the blue button to start';
  String _suggestedName = '';
  final _selectedNames = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              _suggestedName.isEmpty ? _initialPlaceholderText : _suggestedName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 38),
            ),
            FloatingActionButton(
              onPressed: () => setState(
                () {
                  _suggestedName = WordPair.random().asPascalCase;
                },
              ),
              child: const Icon(Icons.replay),
            ),
            SelectedNames(selectedNames: _selectedNames),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ButtonIconRound(
              state: _suggestedName.isEmpty,
              color: Colors.red,
              icon: Icons.remove,
              onPressed: () => setState(() {
                _selectedNames.removeWhere((element) =>
                    element == _suggestedName.replaceAll(RegExp(' ✅'), ''));
                _suggestedName = _suggestedName.replaceAll(RegExp(' ✅'), '');
              }),
            ),
            ButtonIconRound(
              state: _suggestedName.isEmpty,
              color: Colors.green,
              icon: Icons.check,
              onPressed: () => setState(() {
                _selectedNames.add(_suggestedName);
                _suggestedName = '$_suggestedName ✅';
              }),
            ),
          ],
        ),
      ),
    );
  }
}
