#ifdef __EMSCRIPTEN__
#include <emscripten/bind.h>
#include <vector>
#include "Tournament.hpp"
#include "Player.hpp"

using namespace emscripten;

void wrap_addPlayer(CPPDubovSystem::Tournament& t, const CPPDubovSystem::Player& p) {
    t.addPlayer(p);
}

std::vector<CPPDubovSystem::Match> wrap_generatePairings(CPPDubovSystem::Tournament& t, int round) {
    return t.generatePairings(round);
}

std::vector<CPPDubovSystem::Match> wrap_generatePairingsBaku(CPPDubovSystem::Tournament& t, int round, bool baku) {
    return t.generatePairings(round, baku);
}

EMSCRIPTEN_BINDINGS(dubov_system) {
    enum_<CPPDubovSystem::Color>("Color")
        .value("WHITE", CPPDubovSystem::Color::WHITE)
        .value("BLACK", CPPDubovSystem::Color::BLACK)
        .value("NO_COLOR", CPPDubovSystem::Color::NO_COLOR);

    enum_<CPPDubovSystem::ColorPreference>("ColorPreference")
        .value("ABSOLUTE", CPPDubovSystem::ColorPreference::ABSOLUTE)
        .value("MILD", CPPDubovSystem::ColorPreference::MILD)
        .value("ALTERNATION", CPPDubovSystem::ColorPreference::ALTERNATION)
        .value("NO_PREFERENCE", CPPDubovSystem::ColorPreference::NO_PREFERENCE);

    class_<CPPDubovSystem::Player>("Player")
        .constructor<std::string, int, int, double>()
        .constructor<>()
        .function("getName", &CPPDubovSystem::Player::getName)
        .function("getRating", &CPPDubovSystem::Player::getRating)
        .function("getID", &CPPDubovSystem::Player::getID)
        .function("getPoints", &CPPDubovSystem::Player::getPoints)
        .function("getDueColor", &CPPDubovSystem::Player::getDueColor)
        .function("getPreferenceStrength", &CPPDubovSystem::Player::getPreferenceStrength)
        .function("getARO", &CPPDubovSystem::Player::getARO)
        .function("getOppCount", &CPPDubovSystem::Player::getOppCount)
        .function("hasReceievedBye", &CPPDubovSystem::Player::hasReceievedBye)
        .function("upfloatedPreviously", &CPPDubovSystem::Player::upfloatedPreviously)
        .function("getFirstColorPlayed", &CPPDubovSystem::Player::getFirstColorPlayed)
        .function("addOpp", &CPPDubovSystem::Player::addOpp)
        .function("addColor", &CPPDubovSystem::Player::addColor)
        .function("addOppRating", &CPPDubovSystem::Player::addOppRating)
        .function("incrementUpfloat", &CPPDubovSystem::Player::incrementUpfloat)
        .function("setUpfloatPrevStatus", &CPPDubovSystem::Player::setUpfloatPrevStatus)
        .function("addPoints", &CPPDubovSystem::Player::addPoints)
        .function("addPairingRestriction", &CPPDubovSystem::Player::addPairingRestriction)
        .function("setByeStatus", &CPPDubovSystem::Player::setByeStatus)
        .function("canPlayOpp", &CPPDubovSystem::Player::canPlayOpp)
        .function("canUpfloat", &CPPDubovSystem::Player::canUpfloat)
        .function("getNumUpfloatedIfMaxUpfloater", &CPPDubovSystem::Player::getNumUpfloatedIfMaxUpfloater)
        .function("shouldAlternate", &CPPDubovSystem::Player::shouldAlternate)
        .function("isColorHistEqual", &CPPDubovSystem::Player::isColorHistEqual)
        .class_function("getMaxUpfloatTimes", &CPPDubovSystem::Player::getMaxUpfloatTimes);

    class_<CPPDubovSystem::Match>("Match")
        .property("white", &CPPDubovSystem::Match::white)
        .property("black", &CPPDubovSystem::Match::black)
        .property("is_bye", &CPPDubovSystem::Match::is_bye);

    register_vector<CPPDubovSystem::Match>("VectorMatch");

    class_<CPPDubovSystem::Tournament>("Tournament")
        .constructor<int>()
        .function("addPlayer", &wrap_addPlayer)
        .function("setRound1Color", &CPPDubovSystem::Tournament::setRound1Color)
        .function("generatePairings", &wrap_generatePairings)
        .function("generatePairingsBaku", &wrap_generatePairingsBaku)
        .function("pairingErrorOccured", &CPPDubovSystem::Tournament::pairingErrorOccured);
}
#endif