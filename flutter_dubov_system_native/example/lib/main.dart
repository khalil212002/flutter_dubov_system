import 'package:flutter/material.dart';
import 'package:flutter_dubov_system_native/flutter_dubov_system_native.dart';

void main() {
  runApp(const DubovExampleApp());
}

/// A pure Dart class to hold the player's state between rounds,
/// simulating data you might save to a local database like SQLite or Hive.
class PlayerData {
  final int id;
  final String name;
  final int rating;
  double points = 0.0;
  List<int> opponentsPlayed = [];
  List<int> opponentRatings = [];
  List<Color> colorsPlayed = [];
  bool hasReceivedBye = false;

  PlayerData({required this.id, required this.name, required this.rating});
}

class DubovExampleApp extends StatefulWidget {
  const DubovExampleApp({super.key});

  @override
  State<DubovExampleApp> createState() => _DubovExampleAppState();
}

class _DubovExampleAppState extends State<DubovExampleApp> {
  final DubovSystemNative _ds = DubovSystemNative();

  bool _isInitialized = false;
  String _errorMessage = '';
  int _currentRound = 0;
  List<MatchPairing> _currentPairings = [];

  // This is our "Database".
  final List<PlayerData> _database = [
    PlayerData(id: 1, name: 'Khalil', rating: 2850),
    PlayerData(id: 2, name: 'Amir', rating: 2790),
    PlayerData(id: 3, name: 'Ali', rating: 2780),
    PlayerData(id: 4, name: 'Ian', rating: 2770),
  ];

  // Temporary handles for the active C++ objects
  Tournament? _cppTournament;
  List<Player> _cppPlayers = [];

  @override
  void initState() {
    super.initState();
    _initSystem();
  }

  @override
  void dispose() {
    _destroyCppObjects();
    super.dispose();
  }

  /// Deletes the C++ objects to free memory.
  /// The data survives because it's safely stored in `_database`.
  void _destroyCppObjects() {
    for (final player in _cppPlayers) {
      player.dispose();
    }
    _cppPlayers.clear();

    _cppTournament?.dispose();
    _cppTournament = null;
    print("C++ Memory Cleared.");
  }

  Future<void> _initSystem() async {
    try {
      await _ds.initialize();
      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Initialization Failed: ${e.toString()}";
      });
    }
  }

  /// This function takes our Dart `PlayerData` and manually reconstructs
  /// the C++ `Player` object, feeding it all the historical data.
  Player _recreateCppPlayer(PlayerData data) {
    // 1. Create the base player
    final p = _ds.createPlayer(data.name, data.rating, data.id, 0.0);

    // 2. Add historical points
    p.addPoints(data.points);

    // 3. Add opponent history
    for (int i = 0; i < data.opponentsPlayed.length; i++) {
      p.addOpp(data.opponentsPlayed[i]);
      p.addOppRating(data.opponentRatings[i]);
    }

    // 4. Add color history
    for (final color in data.colorsPlayed) {
      p.addColor(color);
    }

    // 5. Restore bye status
    p.setByeStatus(data.hasReceivedBye);

    return p;
  }

  /// Simulates match results to update our Dart database, then deletes the C++ objects.
  void _simulateResultsAndClearMemory() {
    // Simulate that White wins every game just for this example
    for (final match in _currentPairings) {
      if (match.isBye) {
        final p = _database.firstWhere((p) => p.id == match.white.id);
        p.points += 1.0;
        p.hasReceivedBye = true;
      } else {
        final whitePlayer = _database.firstWhere((p) => p.id == match.white.id);
        final blackPlayer = _database.firstWhere((p) => p.id == match.black.id);

        // Update Points (White wins: 1 point to White, 0 to Black)
        whitePlayer.points += 1.0;

        // Record Opponents
        whitePlayer.opponentsPlayed.add(blackPlayer.id);
        whitePlayer.opponentRatings.add(blackPlayer.rating);
        blackPlayer.opponentsPlayed.add(whitePlayer.id);
        blackPlayer.opponentRatings.add(whitePlayer.rating);

        // Record Colors
        whitePlayer.colorsPlayed.add(Color.white);
        blackPlayer.colorsPlayed.add(Color.black);
      }
    }

    // Now that our Dart database is updated, we don't need the C++ objects anymore!
    _destroyCppObjects();
  }

  void _generateNextRound() {
    try {
      // 1. If we are moving from Round 1 -> Round 2, save results and clear old memory
      if (_currentRound > 0) {
        _simulateResultsAndClearMemory();
      }

      _currentRound++;

      // 2. Create a fresh C++ Tournament
      _cppTournament = _ds.createTournament(3);

      // 3. Recreate the C++ players from our Dart database
      for (final data in _database) {
        final restoredCppPlayer = _recreateCppPlayer(data);
        _cppPlayers.add(restoredCppPlayer);
        _cppTournament!.addPlayer(restoredCppPlayer);
      }

      // 4. Generate the pairings for the new round
      if (_currentRound == 1) {
        _cppTournament!.setRound1Color(true);
      }

      final pairings = _cppTournament!.generatePairings(_currentRound);

      if (_cppTournament!.pairingErrorOccured()) {
        throw Exception(
          "A pairing error occurred during Round $_currentRound generation.",
        );
      }

      setState(() {
        _currentPairings = pairings;
        _errorMessage = '';
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Stateless Dubov Example'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
          child: _errorMessage.isNotEmpty
              ? Text(
                  'Error: $_errorMessage',
                  style: const TextStyle(color: Colors.red),
                )
              : !_isInitialized
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _currentRound == 0
                          ? 'Tournament Ready'
                          : 'Round $_currentRound Pairings',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    if (_currentPairings.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          itemCount: _currentPairings.length,
                          itemBuilder: (context, index) {
                            final match = _currentPairings[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: ListTile(
                                title: Text(
                                  match.isBye
                                      ? '${match.white.name} - BYE'
                                      : '⚪ ${match.white.name}  vs  ⚫ ${match.black.name}',
                                ),
                                subtitle: Text(
                                  'Points: ${match.white.points} vs ${match.black.points}',
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: _currentRound < 3
                            ? _generateNextRound
                            : null,
                        child: Text(
                          _currentRound == 0
                              ? 'Start Round 1'
                              : 'Simulate Results & Generate Round ${_currentRound + 1}',
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
