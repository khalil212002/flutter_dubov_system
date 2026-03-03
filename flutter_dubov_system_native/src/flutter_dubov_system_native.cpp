#include "flutter_dubov_system_native.h"
#include <stdbool.h>
#include <string.h> // Required for strdup
#include <stdlib.h> // Required for malloc/free
#include "CPPDubovSystem/DubovSystem/Player.hpp"
#include "CPPDubovSystem/DubovSystem/Tournament.hpp"
#include <vector>
#include <string>

using namespace CPPDubovSystem;

extern "C" {

    FFI_PLUGIN_EXPORT void freeIntArray(IntArray array) {
        if (array.ptr != nullptr) free(array.ptr);
    }

    FFI_PLUGIN_EXPORT void freePlayerArray(PlayerArray array) {
        if (array.ptr != nullptr) free(array.ptr);
    }

    FFI_PLUGIN_EXPORT void freeMatchArray(MatchArray array) {
        if (array.ptr != nullptr) free(array.ptr);
    }

    FFI_PLUGIN_EXPORT PlayerHandle create_player(const char* name, int rating, int id, double points) {
        return new Player(name, rating, id, points);
    }

    FFI_PLUGIN_EXPORT PlayerHandle create_player_default() {
        return new Player();
    }

    FFI_PLUGIN_EXPORT void destroy_player(PlayerHandle player) {
        if (player) delete static_cast<Player*>(player);
    }

    FFI_PLUGIN_EXPORT char* getName(PlayerHandle player) {
        std::string name = static_cast<Player*>(player)->getName();
#ifdef _WIN32
        return _strdup(name.c_str());
#else
        return strdup(name.c_str());
#endif
    }

    FFI_PLUGIN_EXPORT void addColor(PlayerHandle player, ColorHandle c) {
        Color color;
        switch (c) {
        case COLOR_HANDLE_WHITE: color = Color::WHITE; break;
        case COLOR_HANDLE_BLACK: color = Color::BLACK; break;
        default: color = Color::NO_COLOR; break;
        }
        static_cast<Player*>(player)->addColor(color);
    }

    FFI_PLUGIN_EXPORT double getPoints(PlayerHandle player) {
    	return static_cast<Player*>(player)->getPoints();
    }

    FFI_PLUGIN_EXPORT ColorHandle getDueColor(PlayerHandle player) {
        Color color = static_cast<Player*>(player)->getDueColor();
        switch (color) {
        case Color::WHITE: return COLOR_HANDLE_WHITE;
        case Color::BLACK: return COLOR_HANDLE_BLACK;
        default: return COLOR_HANDLE_NO_COLOR;
        }
    }

    FFI_PLUGIN_EXPORT ColorPreferenceHandle getPreferenceStrength(PlayerHandle player) {
        ColorPreference color_pref = static_cast<Player*>(player)->getPreferenceStrength();
        switch (color_pref) {
        case ColorPreference::MILD: return COLOR_PREF_MILD;
        case ColorPreference::ALTERNATION: return COLOR_PREF_ALTERNATION;
        case ColorPreference::ABSOLUTE: return COLOR_PREF_ABSOLUTE;
        default: return COLOR_PREF_NO_PREFERENCE;
        }
    }

    FFI_PLUGIN_EXPORT IntArray getOppPlayed(PlayerHandle player) {
        std::vector<int> opps = static_cast<Player*>(player)->getOppPlayed();
        IntArray arr;
        arr.count = opps.size();

        if (arr.count > 0) {
            arr.ptr = static_cast<int*>(malloc(arr.count * sizeof(int)));
            for (int i = 0; i < arr.count; ++i) {
                arr.ptr[i] = opps[i];
            }
        }
        else {
            arr.ptr = nullptr;
        }
        return arr;
    }

    FFI_PLUGIN_EXPORT int getOppCount(PlayerHandle player) {
        return static_cast<Player*>(player)->getOppCount();
    }

    FFI_PLUGIN_EXPORT double getARO(PlayerHandle player) {
        return static_cast<Player*>(player)->getARO();
    }

    FFI_PLUGIN_EXPORT bool canUpfloat(PlayerHandle player, int cr){
        return static_cast<Player*>(player)->canUpfloat(cr);
	}

    FFI_PLUGIN_EXPORT int getNumUpfloatedIfMaxUpfloater(PlayerHandle player, int total_rounds) {
        return static_cast<Player*>(player)->getNumUpfloatedIfMaxUpfloater(total_rounds);
    }

    FFI_PLUGIN_EXPORT bool upfloatedPreviously(PlayerHandle player){
        return static_cast<Player*>(player)->upfloatedPreviously();
	}

    FFI_PLUGIN_EXPORT bool hasReceievedBye(PlayerHandle player){
        return static_cast<Player*>(player)->hasReceievedBye();
	}

    FFI_PLUGIN_EXPORT bool isColorHistEqual(PlayerHandle player, const PlayerHandle opp){
        return static_cast<Player*>(player)->isColorHistEqual(*static_cast<Player*>(opp));
	}

    FFI_PLUGIN_EXPORT ColorHandle getFirstColorPlayed(PlayerHandle player)
    {
        Color color = static_cast<Player*>(player)->getFirstColorPlayed();
        switch (color) {
        case Color::WHITE: return COLOR_HANDLE_WHITE;
        case Color::BLACK: return COLOR_HANDLE_BLACK;
        default: return COLOR_HANDLE_NO_COLOR;
        }
    }

    FFI_PLUGIN_EXPORT int getMaxUpfloatTimes(int total_rounds) {
        return Player::getMaxUpfloatTimes(total_rounds);
    }

    FFI_PLUGIN_EXPORT int getID(PlayerHandle player) {
        return static_cast<Player*>(player)->getID();
    }

    FFI_PLUGIN_EXPORT int getRating(PlayerHandle player) {
        return static_cast<Player*>(player)->getRating();
    }

    FFI_PLUGIN_EXPORT void addOpp(PlayerHandle player, int id) {
        static_cast<Player*>(player)->addOpp(id);
    }

    FFI_PLUGIN_EXPORT void addOppRating(PlayerHandle player, int rating) {
        static_cast<Player*>(player)->addOppRating(rating);
    }

    FFI_PLUGIN_EXPORT void addPairingRestriction(PlayerHandle player, int oppId) {
        static_cast<Player*>(player)->addPairingRestriction(oppId);
    }

    FFI_PLUGIN_EXPORT void addPoints(PlayerHandle player, double points) {
        static_cast<Player*>(player)->addPoints(points);
    }

    FFI_PLUGIN_EXPORT void setByeStatus(PlayerHandle player, bool status) {
        static_cast<Player*>(player)->setByeStatus(status);
    }

    FFI_PLUGIN_EXPORT void setUpfloatPrevStatus(PlayerHandle player, bool status) {
        static_cast<Player*>(player)->setUpfloatPrevStatus(status);
    }

    FFI_PLUGIN_EXPORT void incrementUpfloat(PlayerHandle player) {
        static_cast<Player*>(player)->incrementUpfloat();
    }

    FFI_PLUGIN_EXPORT bool shouldAlternate(PlayerHandle player, PlayerHandle opp) {
        return static_cast<Player*>(player)->shouldAlternate(*static_cast<Player*>(opp));
    }
    
    FFI_PLUGIN_EXPORT bool canPlayOpp(PlayerHandle player, PlayerHandle opp) {
        return static_cast<Player*>(player)->canPlayOpp(*static_cast<Player*>(opp));
    }


    FFI_PLUGIN_EXPORT TournamentHandle create_tournament(int total_rounds) {
        return new Tournament(total_rounds);
    }

    FFI_PLUGIN_EXPORT void destroy_tournament(TournamentHandle tournament) {
        if (tournament) delete static_cast<Tournament*>(tournament);
    }

    FFI_PLUGIN_EXPORT void addPlayer(TournamentHandle tournament, PlayerHandle player) {
        static_cast<Tournament*>(tournament)->addPlayer(*static_cast<Player*>(player));
    }

    FFI_PLUGIN_EXPORT void setRound1Color(TournamentHandle tournament, bool make_white) {
        static_cast<Tournament*>(tournament)->setRound1Color(make_white);
    }

    FFI_PLUGIN_EXPORT PlayerArray getPlayers(TournamentHandle tournament) {
        std::vector<Player> players = static_cast<Tournament*>(tournament)->getPlayers();
        PlayerArray arr;
        arr.count = players.size();
        if (arr.count > 0) {
            arr.ptr = static_cast<PlayerHandle*>(malloc(arr.count * sizeof(PlayerHandle)));
            for (int i = 0; i < arr.count; ++i) {
                arr.ptr[i] = new Player(players[i]);
            }
        }
        else {
            arr.ptr = nullptr;
        }
        return arr;
    }

    FFI_PLUGIN_EXPORT bool pairingErrorOccured(TournamentHandle tournament)
    {
		return static_cast<Tournament*>(tournament)->pairingErrorOccured();
    }

    FFI_PLUGIN_EXPORT int getPlayerCount(TournamentHandle tournament) {
        return static_cast<Tournament*>(tournament)->getPlayerCount();
    }

    FFI_PLUGIN_EXPORT MatchArray generatePairings(TournamentHandle tournament, int r) {
        return generatePairingsBaku(tournament, r, false);
    }

    FFI_PLUGIN_EXPORT MatchArray generatePairingsBaku(TournamentHandle tournament, int r, bool baku_acceleration) {
        std::vector<Match> matches = static_cast<Tournament*>(tournament)->generatePairings(r, baku_acceleration);
        MatchArray arr;
        arr.count = matches.size();

        if (arr.count > 0) {
            arr.ptr = static_cast<MatchHandle*>(malloc(arr.count * sizeof(MatchHandle)));
            for (int i = 0; i < arr.count; ++i) {
                arr.ptr[i].white = new Player(matches[i].white);
                arr.ptr[i].black = new Player(matches[i].black);
                arr.ptr[i].is_bye = matches[i].is_bye;
            }
        }
        else {
            arr.ptr = nullptr;
        }

        return arr;
    }

    
}