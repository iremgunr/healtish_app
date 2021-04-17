class SampleUsers {
  final String email, password, name, surname, age, gender, weight;

  SampleUsers(
      {this.email,
        this.password,
        this.name,
        this.surname,
        this.age,
        this.gender,
        this.weight});
}

final sampleUser = [
  SampleUsers(
      email: 'user1@gmail.com',
      password: 'user1',
      name: 'user1',
      surname: 'user1',
      age: '20',
      gender: 'male',
      weight: '80'),
  SampleUsers(
      email: 'user2@gmail.com',
      password: 'user2',
      name: 'user2',
      surname: 'user2',
      age: '30',
      gender: 'female',
      weight: '55'),
  SampleUsers(
      email: 'user3@gmail.com',
      password: 'user3',
      name: 'user3',
      surname: 'user3',
      age: '25',
      gender: 'female',
      weight: '60'),
];
