import 'package:titan/service/class/topic.dart';

Topic stringToTopic(String string) {
  switch (string) {
    case "cinema":
      return Topic.cinema;
    case "advert":
      return Topic.advert;
    case "amap":
      return Topic.amap;
    case "booking":
      return Topic.booking;
    case "event":
      return Topic.event;
    case "loan":
      return Topic.loan;
    case "raffle":
      return Topic.raffle;
    case "vote":
      return Topic.vote;
    case "ph":
      return Topic.ph;
    default:
      return Topic.cinema;
  }
}

String topicToFrenchString(Topic topic) {
  switch (topic) {
    case Topic.cinema:
      return "Cinéma";
    case Topic.advert:
      return "Annonces";
    case Topic.amap:
      return "AMAP";
    case Topic.booking:
      return "Réservation";
    case Topic.event:
      return "Evènements";
    case Topic.loan:
      return "Prêts";
    case Topic.raffle:
      return "Tombola";
    case Topic.vote:
      return "Vote";
    case Topic.ph:
      return "PH";
  }
}
