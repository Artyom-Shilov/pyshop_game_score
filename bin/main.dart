import 'package:pyshop_game_score/game_dart.dart';

main() {
/*  final game = generateGame();

  game.forEach((e) {
    print("offset - ${e.offset}; away - ${e.score.away}; home - ${e.score.home};");
  });*/

  List<Stamp> games = [
    Stamp(offset: 2, score: Score(home: 0, away: 0)),
    Stamp(offset: 5, score: Score(home: 0, away: 0)),
    Stamp(offset: 6, score: Score(home: 1, away: 0)),
    Stamp(offset: 9, score: Score(home: 1, away: 1)),
    Stamp(offset: 14, score: Score(home: 1, away: 2)),
    Stamp(offset: 15, score: Score(home: 1, away: 2)),
    Stamp(offset: 16, score: Score(home: 1, away: 2)),
    Stamp(offset: 19, score: Score(home: 1, away: 2))
  ];

  print(getScore(games, 19));

}