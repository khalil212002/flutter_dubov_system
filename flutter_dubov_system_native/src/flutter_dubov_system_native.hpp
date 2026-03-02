#if _WIN32
#define FFI_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT
#endif

#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

    typedef void* PlayerHandle;
    typedef void* TournamentHandle;

    typedef enum {
        COLOR_HANDLE_WHITE = 0,
        COLOR_HANDLE_BLACK = 1,
        COLOR_HANDLE_NO_COLOR = 2
    } ColorHandle;

    typedef enum {
        COLOR_PREF_NO_PREFERENCE = 0,
        COLOR_PREF_MILD = 1,
        COLOR_PREF_ALTERNATION = 2,
        COLOR_PREF_ABSOLUTE = 3
    } ColorPreferenceHandle;

    typedef struct {
        PlayerHandle white;
        PlayerHandle black;
        bool is_bye;
    } MatchHandle;

    typedef struct {
        int* ptr;
        int count;
    } IntArray;

    typedef struct {
        PlayerHandle* ptr;
        int count;
    } PlayerArray;

    typedef struct {
        MatchHandle* ptr;
        int count;
    } MatchArray;

    FFI_PLUGIN_EXPORT void freeIntArray(IntArray array);
    FFI_PLUGIN_EXPORT void freePlayerArray(PlayerArray array);
    FFI_PLUGIN_EXPORT void freeMatchArray(MatchArray array);

    // Player related functions
    FFI_PLUGIN_EXPORT PlayerHandle create_player(const char* name, int rating, int id, double points); 
    FFI_PLUGIN_EXPORT PlayerHandle create_player_default();
    FFI_PLUGIN_EXPORT void destroy_player(PlayerHandle player);
    FFI_PLUGIN_EXPORT char* getName(PlayerHandle player);
    FFI_PLUGIN_EXPORT int getRating(PlayerHandle player);
    FFI_PLUGIN_EXPORT int getID(PlayerHandle player);
    FFI_PLUGIN_EXPORT int getNumColors(PlayerHandle player);
    FFI_PLUGIN_EXPORT int getOppCount(PlayerHandle player);
    FFI_PLUGIN_EXPORT int getNumUpfloat(PlayerHandle player);
    FFI_PLUGIN_EXPORT double getPoints(PlayerHandle player);
    FFI_PLUGIN_EXPORT bool canPlayOpp(PlayerHandle player, PlayerHandle opp);
    FFI_PLUGIN_EXPORT double getARO(PlayerHandle player);
    FFI_PLUGIN_EXPORT void addOpp(PlayerHandle player, int id);
    FFI_PLUGIN_EXPORT void addColor(PlayerHandle player, ColorHandle c);
    FFI_PLUGIN_EXPORT ColorHandle getDueColor(PlayerHandle player);
    FFI_PLUGIN_EXPORT ColorPreferenceHandle getPreferenceStrength(PlayerHandle player);
    FFI_PLUGIN_EXPORT void incrementUpfloat(PlayerHandle player);
    FFI_PLUGIN_EXPORT bool canUpfloat(PlayerHandle player, int cr);
    FFI_PLUGIN_EXPORT int getNumUpfloatedIfMaxUpfloater(PlayerHandle player, int total_rounds);
    FFI_PLUGIN_EXPORT IntArray getOppPlayed(PlayerHandle player);
    FFI_PLUGIN_EXPORT void addOppRating(PlayerHandle player, int r);
    FFI_PLUGIN_EXPORT bool upfloatedPreviously(PlayerHandle player);
    FFI_PLUGIN_EXPORT void setUpfloatPrevStatus(PlayerHandle player, bool s);
    FFI_PLUGIN_EXPORT void addPoints(PlayerHandle player, const double pt);
    FFI_PLUGIN_EXPORT bool hasReceievedBye(PlayerHandle player);
    FFI_PLUGIN_EXPORT void setByeStatus(PlayerHandle player, bool s);
    FFI_PLUGIN_EXPORT void addPairingRestriction(PlayerHandle player, int opp_id);
    FFI_PLUGIN_EXPORT bool shouldAlternate(PlayerHandle player, const PlayerHandle opp);
    FFI_PLUGIN_EXPORT bool isColorHistEqual(PlayerHandle player, const PlayerHandle opp);
    FFI_PLUGIN_EXPORT ColorHandle getFirstColorPlayed(PlayerHandle player);
    FFI_PLUGIN_EXPORT int getMaxUpfloatTimes(int total_rounds); 

    // Tournament related functions 
    FFI_PLUGIN_EXPORT TournamentHandle create_tournament(int total_rounds);
    FFI_PLUGIN_EXPORT void destroy_tournament(TournamentHandle tournament);
    FFI_PLUGIN_EXPORT void addPlayer(TournamentHandle tournament, PlayerHandle player);
    FFI_PLUGIN_EXPORT void setRound1Color(TournamentHandle tournament, bool make_white);
    FFI_PLUGIN_EXPORT PlayerArray getPlayers(TournamentHandle tournament);
    FFI_PLUGIN_EXPORT bool pairingErrorOccured(TournamentHandle tournament);
    FFI_PLUGIN_EXPORT int getPlayerCount(TournamentHandle tournament);
    FFI_PLUGIN_EXPORT MatchArray generatePairings(TournamentHandle tournament, int r);
    FFI_PLUGIN_EXPORT MatchArray generatePairingsBaku(TournamentHandle tournament, int r, bool baku_acceleration); 

#ifdef __cplusplus
}
#endif