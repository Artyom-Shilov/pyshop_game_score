import 'dart:math';

const TIMESTAMPS_COUNT = 10;
const PROBABILITY_SCORE_CHANGED = 0.0001;
const PROBABILITY_HOME_SCORE = 0.45;
const OFFSET_MAX_STEP = 3;
const EMPRTY_STAMPS_EXCEPTION_MESSAGE = 'empty stamps';
const NEGATIVE_OFFSET_EXCEPTION_MESSAGE = 'negative offset';

class Score {
  final int home;
  final int away;

  Score({
    required this.home,
    required this.away
  });
}

class Stamp {
  final int offset;
  final Score score;

  Stamp({
    required this.offset,
    required this.score
  });
}

final Stamp emptyScoreStamp = Stamp(
  offset: 0,
  score: Score(
    home: 0,
    away: 0,
  ),
);

List<Stamp> generateGame() {
  final stamps = List<Stamp>
      .generate(TIMESTAMPS_COUNT, (score) => emptyScoreStamp);

  var currentStamp = stamps[0];

  for (var i = 0; i < TIMESTAMPS_COUNT; i++) {
    currentStamp = generateStamp(currentStamp);
    stamps[i] = currentStamp;
  }

  return stamps;
}

Stamp generateStamp(Stamp prev) {
  final scoreChanged = Random().nextDouble() > 1 - PROBABILITY_SCORE_CHANGED;
  final homeScoreChange =
  scoreChanged && Random().nextDouble() < PROBABILITY_HOME_SCORE
      ? 1
      : 0;

  final awayScoreChange = scoreChanged && !(homeScoreChange > 0) ? 1 : 0;
  final offsetChange = (Random().nextDouble() * OFFSET_MAX_STEP).floor() + 1;

  return Stamp(
    offset: prev.offset + offsetChange,
    score: Score(
        home: prev.score.home + homeScoreChange,
        away: prev.score.away + awayScoreChange
    ),
  );
}

Score getScore(List<Stamp> gameStamps, int offset) {
  gameStamps.isEmpty
      ? throw GetScoreException(EMPRTY_STAMPS_EXCEPTION_MESSAGE)
      : null;
  offset < 0
      ? throw GetScoreException(NEGATIVE_OFFSET_EXCEPTION_MESSAGE)
      : null;

  if (offset >= 0 && offset < gameStamps[0].offset) {
    return Score(home: 0, away: 0);
  }
  if (offset > gameStamps.last.offset) {
    return gameStamps.last.score;
  }

  int start = 0;
  int end = gameStamps.length - 1;
  int stampIndex = -1;

  while (end - start > 1) {
    int middle = start  + ((end - start) / 2).floor();
    if (gameStamps[middle].offset == offset) {
      stampIndex = middle;
      break;
    }
    gameStamps[middle].offset < offset ? start = middle : end = middle;
  }

  if (stampIndex == -1) {
    return offset == gameStamps[end].offset
        ? gameStamps[end].score
        : gameStamps[start].score;
  }
  
  return gameStamps[stampIndex].score;
}

class GetScoreException implements Exception {

  GetScoreException(this.message);

  final String message;
}