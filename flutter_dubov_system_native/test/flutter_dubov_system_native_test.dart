import 'package:flutter_dubov_system_native/flutter_dubov_system_native.dart';
import 'package:test/test.dart';

void main() {
  late DubovSystemNative dubovSystem;

  setUpAll(() {
    dubovSystem = DubovSystemNative();
  });

  group('Player Core Functions', () {
    late Player player;

    setUp(() {
      player = dubovSystem.createPlayer('Magnus', 2850, 1, 0.0);
    });

    tearDown(() {
      player.dispose();
    });

    test('Initial properties are correct', () {
      expect(player.name, 'Magnus');
      expect(player.rating, 2850);
      expect(player.id, 1);
      expect(player.points, 0.0);
      expect(player.numColors, 0);
      expect(player.numUpfloat, 0);
      expect(player.oppCount, 0);
      expect(player.hasReceivedBye, isFalse);
      expect(player.upfloatedPreviously, isFalse);
    });

    test('Points and Byes update correctly', () {
      player.addPoints(1.5);
      expect(player.points, 1.5);

      player.setByeStatus(true);
      expect(player.hasReceivedBye, isTrue);
    });

    test('Color history and preferences update correctly', () {
      player.addColor(Color.white);
      expect(player.numColors, 1);
      expect(player.firstColorPlayed, Color.white);

      player.addColor(Color.black);
      expect(player.numColors, 2);

      expect(player.dueColor, isNotNull);
      expect(player.preferenceStrength, isNotNull);
    });

    test('Opponent tracking updates correctly', () {
      player.addOpp(42);
      player.addOpp(99);

      expect(player.oppCount, 2);

      final opps = player.oppPlayed;
      expect(opps.length, 2);
      expect(opps, containsAll([42, 99]));
    });

    test('Rating calculation ARO updates correctly', () {
      player.addOppRating(2000);
      player.addOpp(1);
      player.addOppRating(2200);
      player.addOpp(2);
      expect(player.ARO, 2100.0);
    });

    test('Upfloat tracking works', () {
      player.incrementUpfloat();
      expect(player.numUpfloat, 1);

      player.setUpfloatPrevStatus(true);
      expect(player.upfloatedPreviously, isTrue);

      expect(player.getNumUpfloatedIfMaxUpfloater(9), greaterThanOrEqualTo(0));
    });
  });

  group('Player Interactions', () {
    late Player p1;
    late Player p2;

    setUp(() {
      p1 = dubovSystem.createPlayer('Player 1', 2000, 1, 1.0);
      p2 = dubovSystem.createPlayer('Player 2', 2000, 2, 1.0);
    });

    tearDown(() {
      p1.dispose();
      p2.dispose();
    });

    test('canPlayOpp is accurate', () {
      expect(p1.canPlayOpp(p2), isTrue);

      p1.addOpp(p2.id);
      p2.addOpp(p1.id);
      expect(p1.canPlayOpp(p2), isFalse);
    });

    test('addPairingRestriction prevents play', () {
      p1.addPairingRestriction(p2.id);
      expect(p1.canPlayOpp(p2), isFalse);
    });

    test('Color comparisons work', () {
      p1.addColor(Color.white);
      p2.addColor(Color.white);

      expect(p1.isColorHistEqual(p2), isTrue);
      expect(p1.shouldAlternate(p2), isNotNull);
    });
  });

  group('Tournament Functions', () {
    late Tournament tournament;
    late Player p1;
    late Player p2;
    late Player p3;
    late Player p4;

    setUp(() {
      tournament = dubovSystem.createTournament(3);
      p1 = dubovSystem.createPlayer('P1', 2500, 1, 0.0);
      p2 = dubovSystem.createPlayer('P2', 2400, 2, 0.0);
      p3 = dubovSystem.createPlayer('P3', 2300, 3, 0.0);
      p4 = dubovSystem.createPlayer('P4', 2200, 4, 0.0);
    });

    tearDown(() {
      p1.dispose();
      p2.dispose();
      p3.dispose();
      p4.dispose();
      tournament.dispose();
    });

    test('Adding players and counting works', () {
      tournament.addPlayer(p1);
      tournament.addPlayer(p2);

      expect(tournament.playerCount, 2);

      final players = tournament.players;
      expect(players.length, 2);
      expect(players.first.name, 'P1');
    });

    test('Generating pairings works and handles memory safely', () {
      tournament.addPlayer(p1);
      tournament.addPlayer(p2);
      tournament.addPlayer(p3);
      tournament.addPlayer(p4);

      tournament.setRound1Color(true);

      final pairings = tournament.generatePairings(1);

      expect(tournament.pairingErrorOccured(), isFalse);
      expect(pairings.length, 2);

      if (pairings.isNotEmpty) {
        final match = pairings.first;
        expect(match.white, isNotNull);
        expect(match.black, isNotNull);
        expect(match.isBye, isFalse);
      }
    });
  });
}
