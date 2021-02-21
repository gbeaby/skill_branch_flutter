import '../string_utils.dart';

enum LoginType {
  email,
  phone,
}

class User with UserUtils {
  String email;
  String phone;

  String _lastName;
  String _firstName;

  LoginType _type;

  List<User> friends = [];

  User._({String firstName, String lastName, String phone, String email})
      : _firstName = firstName,
        _lastName = lastName,
        this.phone = phone,
        this.email = email {
    print('User is created!');

    _type = email != null ? LoginType.email : LoginType.phone;
  }

  factory User({String name, String phone, String email}) {
    if (name.isEmpty) throw Exception("User name is empty!");
    //if (phone.isEmpty) throw Exception("User phone is empty!");
    //if (email.isEmpty) throw Exception("User email is empty!");

    return User._(
      firstName: _getFirstName(name),
      lastName: _getLastName(name),
      phone: phone == null ? '' : checkPhone(phone),
      email: email == null ? '' : checkEmail(email),
    );
  }

  static String _getLastName(String userName) => userName.split(" ")[1];

  static String _getFirstName(String userName) => userName.split(" ")[0];

  static String checkPhone(String phone) {
    String pattern = r"^(?:[+0])?[0-9]{11}";

    phone = phone.replaceAll(RegExp("[^+\\d]"), "");

    if (phone == null || phone.isEmpty) {
      throw Exception("Enter don't empty phone number!!!");
    } else if (!RegExp(pattern).hasMatch(phone)) {
      throw Exception(
          "Enter a valid phone number starting with a + and containing 11 digits");
    }
    return phone;
  }

  static String checkEmail(String email) {
    String pattern =
        r"^[-a-z0-9!#$%&'*+/=?^_`{|}~]+(?:\.[-a-z0-9!#$%&'*+/=?^_`{|}~]+)*@(?:[a-z0-9]([-a-z0-9]{0,61}[a-z0-9])?\.)*(?:aero|arpa|asia|biz|cat|com|coop|edu|gov|info|int|jobs|mil|mobi|museum|name|net|org|pro|tel|travel|[a-z][a-z])$";
    if (email == null || email.isEmpty) {
      throw Exception("Enter don't empty email!!!");
    }
    if (!RegExp(pattern).hasMatch(email)) {
      throw Exception("Wrong email");
    }
    return email;
  }

  String get login {
    if (_type == LoginType.phone) return phone;
    return email;
  }

  String get name {
    return "".capitalize(_firstName) + ' ' + "".capitalize(_lastName);
  }

  @override
  bool operator ==(Object object) {
    if (object == null) {
      return false;
    }

    if (object is User) {
      return _firstName == object._firstName &&
          _lastName == object._lastName &&
          (phone == object.phone || email == object.email);
    }
  }

  void addFriend(Iterable<User> newFriend) {
    friends.addAll(newFriend);
  }

  void removeFriend(User user) {
    friends.remove(user);
  }

  String get userInfo => '''
    name: $name
    email: $email
    phone: $phone
    firstName: $_firstName
    lastName: $_lastName
    friends: ${friends.toList()}
  ''';

  @override
  String toString() {
    return '''
    name: $name
    email: $email
    phone: $phone
    friends: ${friends.toList()}
  ''';
  }
}

mixin UserUtils {
  String capitalize(String s) {
    return s[0].toUpperCase() + s[1].substring(1);
  }
}
