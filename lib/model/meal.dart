class Meal {
  final String mealTime, name, imagePath, kiloCaloriesBurnt, timeTaken;

  Meal({
    this.mealTime,
    this.name,
    this.imagePath,
    this.kiloCaloriesBurnt,
    this.timeTaken,
  });
}

final meals = [
  Meal(
      mealTime: 'BREAKFAST',
      name: 'Granola',
      kiloCaloriesBurnt: '271',
      timeTaken: '10',
      imagePath: 'assets/fruit_granola.jpeg'),
  Meal(
      mealTime: 'DINNER',
      name: 'Pesto Pasta',
      kiloCaloriesBurnt: '612',
      timeTaken: '15',
      imagePath: 'assets/pesto_pasta.jpeg'),
  Meal(
      mealTime: 'SNACK',
      name: 'Keto Snack',
      kiloCaloriesBurnt: '414',
      timeTaken: '16',
      imagePath: 'assets/keto_snack.jpeg'),
];
