enum Days {
  lundi,
  mardi,
  mercredi,
  jeudi,
  vendredi,
  samedi,
}

extension DaysExtension on Days {
  String get name {
    switch (this) {
      case Days.lundi:
        return 'Lundi';
      case Days.mardi:
        return 'Mardi';
      case Days.mercredi:
        return 'Mercredi';
      case Days.jeudi:
        return 'Jeudi';
      case Days.vendredi:
        return 'Vendredi';
      case Days.samedi:
        return 'Samedi';
    }
  }
}
