class Calorieinfo {
  final double weight, height, age;
  final String female, male, gender, name;
  double calorie;

  //genderi vs vs gökçeden al, değişecek.

  Calorieinfo(this.gender, this.name, this.weight, this.height, this.age,
      this.female, this.male);

  String calculateCal() {
    if (gender == female) {
      return (665 + (9.6 * weight) + (1.8 * height) - (4.7 * age))
          .toStringAsFixed(1);
    } else {
      return (66 + (13.7 * weight) + (5 * height) - (6.8 * age))
          .toStringAsFixed(1);
    }
  }
}
