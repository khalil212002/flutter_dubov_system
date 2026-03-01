import 'package:flutter/material.dart';
import 'package:flutter_dubov_system_web/flutter_dubov_system_web.dart';

void main() {
  runApp(const DubovExampleApp());
}

class DubovExampleApp extends StatefulWidget {
  const DubovExampleApp({super.key});

  @override
  State<DubovExampleApp> createState() => _DubovExampleAppState();
}

class _DubovExampleAppState extends State<DubovExampleApp> {
  // Instance of the web implementation
  final DubovSystemWeb _ds = DubovSystemWeb();
  bool _isInitialized = false;
  List<MatchPairing> _round1Pairings = [];
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _setupAndRunTournament();
  }

  Future<void> _setupAndRunTournament() async {
    try {
      // Step 1: Initialize the Dubov System (Loads WASM and JS files)
      await _ds.initialize();
      setState(() {
        _isInitialized = true;
      });

      // Step 2: Create a Tournament (e.g., 3 total rounds)
      final tournament = _ds.createTournament(3);

      // Step 3: Create Players (Name, Rating, ID, Initial Points)
      final p1 = _ds.createPlayer('Khalil', 2850, 1, 0.0);
      final p2 = _ds.createPlayer('Amir', 2790, 2, 0.0);
      final p3 = _ds.createPlayer('Ali', 2780, 3, 0.0);
      final p4 = _ds.createPlayer('Ian', 2770, 4, 0.0);

      // Step 4: Add Players to the Tournament
      tournament.addPlayer(p1);
      tournament.addPlayer(p2);
      tournament.addPlayer(p3);
      tournament.addPlayer(p4);

      // Step 5: Generate Pairings for Round 1
      // Setting round 1 color logic (true = top seed gets White, etc.)
      tournament.setRound1Color(true);

      final pairings = tournament.generatePairings(1);

      if (tournament.pairingErrorOccured()) {
        throw Exception("A pairing error occurred during generation.");
      }

      // Update UI with the results
      setState(() {
        _round1Pairings = pairings;
      });

      // NOTE: In a real application, you should keep the player and tournament
      // objects alive across rounds to update their points and colors.
      // You should only call dispose() when the entire tournament is completely over.
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
          title: const Text('Dubov System Example'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
          child: _errorMessage.isNotEmpty
              ? Text(
                  'Error: $_errorMessage',
                  style: const TextStyle(color: Colors.red),
                )
              : !_isInitialized
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Initializing WebAssembly Module...'),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Round 1 Pairings',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (_round1Pairings.isEmpty)
                      const Text('No pairings generated.')
                    else
                      Expanded(
                        child: ListView.builder(
                          itemCount: _round1Pairings.length,
                          itemBuilder: (context, index) {
                            final match = _round1Pairings[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: Text(
                                    'Board\n${index + 1}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ),
                                title: Text(
                                  match.isBye
                                      ? '${match.white.name} - BYE'
                                      : '⚪ ${match.white.name}  vs  ⚫ ${match.black.name}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: match.isBye
                                    ? const Text('Player receives a bye')
                                    : Text(
                                        'Ratings: ${match.white.rating} vs ${match.black.rating}',
                                      ),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
