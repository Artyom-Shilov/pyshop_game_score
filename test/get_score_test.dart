import 'package:pyshop_game_score/game_dart.dart';
import 'package:test/test.dart';

void main() {
  test('fixed stamps, precise stamp in the middle', () {
    List<Stamp> games = [
      Stamp(offset: 2, score: Score(home: 0, away: 0)),
      Stamp(offset: 5, score: Score(home: 0, away: 0)),
      Stamp(offset: 6, score: Score(home: 1, away: 0)),
      Stamp(offset: 9, score: Score(home: 1, away: 1))
    ];
    expect(getScore(games, 6), equals(games[2].score));
  });

  test('fixed stamps, offset is between stamps in the middle', () {
    List<Stamp> games = [
      Stamp(offset: 2, score: Score(home: 0, away: 0)),
      Stamp(offset: 5, score: Score(home: 0, away: 0)),
      Stamp(offset: 6, score: Score(home: 1, away: 0)),
      Stamp(offset: 9, score: Score(home: 1, away: 1)),
      Stamp(offset: 14, score: Score(home: 1, away: 2)),
      Stamp(offset: 15, score: Score(home: 1, away: 2)),
      Stamp(offset: 16, score: Score(home: 1, away: 2)),
      Stamp(offset: 18, score: Score(home: 1, away: 2)),
    ];
    expect(getScore(games, 12), equals(games[3].score));
  });

  test('fixed stamps, offset of the first stamp', () {
    List<Stamp> games = [
      Stamp(offset: 14, score: Score(home: 1, away: 2)),
      Stamp(offset: 15, score: Score(home: 1, away: 2)),
      Stamp(offset: 16, score: Score(home: 1, away: 2)),
      Stamp(offset: 18, score: Score(home: 1, away: 2)),
    ];
    expect(getScore(games, 14), equals(games[0].score));
  });

  test('fixed stamps, offset of the second stamp', () {
    List<Stamp> games = [
      Stamp(offset: 14, score: Score(home: 0, away: 0)),
      Stamp(offset: 15, score: Score(home: 1, away: 0)),
      Stamp(offset: 16, score: Score(home: 1, away: 2)),
      Stamp(offset: 18, score: Score(home: 1, away: 2)),
    ];
    expect(getScore(games, 15), equals(games[1].score));
  });

  test('fixed stamps, offset is between first and second stamps', () {
    List<Stamp> games = [
      Stamp(offset: 10, score: Score(home: 0, away: 0)),
      Stamp(offset: 15, score: Score(home: 1, away: 0)),
      Stamp(offset: 16, score: Score(home: 1, away: 2)),
      Stamp(offset: 18, score: Score(home: 1, away: 2)),
    ];
    expect(getScore(games, 12), equals(games[0].score));
  });

  test('fixed stamps, offset of the last stamp', () {
    List<Stamp> games = [
      Stamp(offset: 9, score: Score(home: 1, away: 1)),
      Stamp(offset: 14, score: Score(home: 1, away: 2)),
    ];
    expect(getScore(games, 14), equals(games[1].score));
  });

  test('fixed stamps, offset of the next to last stamp', () {
    List<Stamp> games = [
      Stamp(offset: 9, score: Score(home: 0, away: 0)),
      Stamp(offset: 10, score: Score(home: 0, away: 0)),
      Stamp(offset: 15, score: Score(home: 1, away: 0)),
      Stamp(offset: 16, score: Score(home: 1, away: 2)),
    ];
    expect(getScore(games, 15), equals(games[2].score));
  });

  test('fixed stamps, offset is between last and next to last stamps', () {
    List<Stamp> games = [
      Stamp(offset: 9, score: Score(home: 0, away: 0)),
      Stamp(offset: 10, score: Score(home: 0, away: 0)),
      Stamp(offset: 12, score: Score(home: 1, away: 0)),
      Stamp(offset: 16, score: Score(home: 1, away: 2)),
      Stamp(offset: 20, score: Score(home: 1, away: 2)),
    ];
    expect(getScore(games, 18), equals(games[3].score));
  });

  test('fixed stamps, only one stamp', () {
    List<Stamp> games = [Stamp(offset: 9, score: Score(home: 0, away: 0))];
    expect(getScore(games, 9), equals(games[0].score));
  });

  test('fixed stamps, beyond max offset', () {
    List<Stamp> stamps = [
      Stamp(offset: 2, score: Score(home: 0, away: 0)),
      Stamp(offset: 5, score: Score(home: 0, away: 0)),
      Stamp(offset: 6, score: Score(home: 1, away: 0)),
    ];
    expect(getScore(stamps, 20), equals(stamps[2].score));
  });

  test('fixed stamps, zero offset', () {
    List<Stamp> stamps = [
      Stamp(offset: 2, score: Score(home: 0, away: 0)),
      Stamp(offset: 5, score: Score(home: 0, away: 0)),
      Stamp(offset: 6, score: Score(home: 1, away: 0)),
    ];
    final actualScore = getScore(stamps, 0);
    expect(actualScore.home, equals(0));
    expect(actualScore.away, equals(0));
  });

  test('fixed stamps, offset is between zero and the first stamp', () {
    List<Stamp> stamps = [
      Stamp(offset: 3, score: Score(home: 0, away: 0)),
      Stamp(offset: 5, score: Score(home: 0, away: 0)),
      Stamp(offset: 6, score: Score(home: 1, away: 0)),
    ];
    final actualScore = getScore(stamps, 1);
    expect(actualScore.home, equals(0));
    expect(actualScore.away, equals(0));
  });

  test('fixed stamps, negative offset', () {
    List<Stamp> games = [
      Stamp(offset: 2, score: Score(home: 0, away: 0)),
    ];
    expect(
        () => getScore(games, -3),
        throwsA(predicate((e) =>
            e is GetScoreException &&
            e.message == NEGATIVE_OFFSET_EXCEPTION_MESSAGE)));
  });

  test('fixed stamps, empty stamps', () {
    List<Stamp> games = [];
    expect(
        () => getScore(games, 5),
        throwsA(predicate((e) =>
            e is GetScoreException &&
            e.message == EMPRTY_STAMPS_EXCEPTION_MESSAGE)));
  });

  test('generated stamps', () {
    final games = generateGame();
    expect(getScore(games, 5000), isNotNull);
  });
}
