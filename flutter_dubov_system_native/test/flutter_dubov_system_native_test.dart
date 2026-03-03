import 'package:flutter_dubov_system_native/flutter_dubov_system_native.dart';
import 'package:test/test.dart';
import 'package:flutter_dubov_system_platform_interface/flutter_dubov_system_platform_interface.dart';

void main() {
  // We will use this instance to create everything
  late DubovSystemNative dubovSystem;

  setUpAll(() {
    dubovSystem = DubovSystemNative();
  });

  group('NativePlayer Tests via DubovSystemNative', () {
    late Player player1;
    late Player player2;

    setUp(() {
      // Create players using the plugin interface
      player1 = dubovSystem.createPlayer('Magnus', 2850, 1, 0.0);
      player2 = dubovSystem.createPlayer('Hikaru', 2780, 2, 0.0);
    });

    tearDown(() {
      // Prevent memory leaks by disposing handles
      player1.dispose();
      player2.dispose();
    });

    test('Player creation and getters return expected values', () {
      expect(player1.id, 1);
      expect(player1.rating, 2850);
      expect(player1.points, 0.0);
      expect(player1.oppCount, 0);
      expect(player1.hasReceivedBye, false);
      expect(player1.upfloatedPreviously, false);

      // Verify the string conversion works properly without crashing
      expect(player1.name, 'Magnus');
    });

    test('addPoints modifies points properly', () {
      player1.addPoints(1.5);
      expect(player1.points, 1.5);
    });

    test('addColor updates color history and preferences', () {
      player1.addColor(Color.white);

      expect(player1.firstColorPlayed, Color.white);
      expect(player1.dueColor, isA<Color>());
      expect(player1.preferenceStrength, isA<ColorPreference>());
    });

    test('addOpp and addOppRating update ARO and count', () {
      player1.addOpp(2);
      expect(player1.oppCount, 1);

      player1.addOppRating(2780);
      expect(player1.ARO, 2780.0);
    });

    test('Bye and Upfloat statuses can be set and checked', () {
      player1.setByeStatus(true);
      expect(player1.hasReceivedBye, true);

      player1.setUpfloatPrevStatus(true);
      expect(player1.upfloatedPreviously, true);

      player1.incrementUpfloat();
      expect(player1.canUpfloat(1), isA<bool>());
      expect(player1.getNumUpfloatedIfMaxUpfloater(5), isA<int>());
    });

    test('Opponent interaction checks run without crashing', () {
      // These return booleans based on C++ logic
      expect(player1.canPlayOpp(player2), isA<bool>());
      expect(player1.isColorHistEqual(player2), isA<bool>());
      expect(player1.shouldAlternate(player2), isA<bool>());

      // Adding pairing restriction shouldn't crash
      player1.addPairingRestriction(2);
    });
  });

  group('NativeTournament Tests via DubovSystemNative', () {
    late Tournament tournament;
    late Player p1;
    late Player p2;
    late Player p3;

    setUp(() {
      // Create tournament and players using the plugin interface
      tournament = dubovSystem.createTournament(5); // 5 rounds total
      p1 = dubovSystem.createPlayer('Player 1', 1500, 1, 0.0);
      p2 = dubovSystem.createPlayer('Player 2', 1600, 2, 0.0);
      p3 = dubovSystem.createPlayer('Player 3', 1700, 3, 0.0);
    });

    tearDown(() {
      p1.dispose();
      p2.dispose();
      p3.dispose();
      tournament.dispose();
    });

    test('addPlayer and pairingErrorOccured check', () {
      tournament.addPlayer(p1);
      tournament.addPlayer(p2);

      expect(tournament.pairingErrorOccured(), isA<bool>());
    });

    test('setRound1Color executes successfully', () {
      tournament.setRound1Color(true);
    });

    test('generatePairings returns a list of MatchPairings', () {
      tournament.addPlayer(p1);
      tournament.addPlayer(p2);
      tournament.addPlayer(p3);

      final pairings = tournament.generatePairings(1);

      // Verify the list is successfully retrieved from C++ memory
      expect(pairings, isNotNull);
      expect(pairings, isA<List<MatchPairing>>());

      // If matches were generated, test the structure of the data inside
      if (pairings.isNotEmpty) {
        final match = pairings.first;
        expect(match.white, isNotNull);
        expect(match.black, isNotNull);
        expect(match.isBye, isA<bool>());
      }
    });
  });
}
