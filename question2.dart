// start making all fields as private
class UserModel {
  String _name;
  int _age;
  String _email;

  UserModel(this._name, this._age, this._email);

  // we can use getters to get each field value
  String get name => _name;
  int get age => _age;
  String get email => _email;

  // we can use setter for age to make sure that any inputted age will be a valid age
  set age(int value) {
    if (value < 0) throw Exception("Age cannot be negative");
    if (value > 100) throw Exception("This is over man's natural age");
    _age = value;
  }

  void updateUser(String name, int age, String email) {
    this._name = name;
    this.age = age; // the first age is the setter not the private field
    this._email = email;
  }
}

// make a separate class that responsible for one service to apply single responsibility principle
class FirestoreService {
  void saveUser(UserModel user) {
    print('Saving ${user.name}, ${user.age}, ${user.email} to Firestore');
  }
}
