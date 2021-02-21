import 'models/user.dart';

class UserHolder {
  Map<String, User> users = {};

  void registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw Exception('User is added!!!');
    }
  }

  User getUserByLogin(String login) {
    //if (login.isEmpty) {
    //  throw Exception('login is empty');
    //}
    return users[login];
  }

  User registerUserByEmail(String fullName, String email) {
    if (email.isEmpty) {
      throw Exception('Empty email');
    }
    if (users.containsKey(email)) {
      throw Exception('A user with this email already exists');
    }

    User user = User(name: fullName, email: email);
    users[user.login] = user;
    return user;
  }

  User registerUserByPhone(String fullName, String phone) {
    if (phone.isEmpty) {
      throw Exception('phone is empty');
    }
    String checkPhone = User.checkPhone(phone);
    if (users.containsKey(checkPhone)) {
      throw Exception('A user with this phone already exists');
    }

    User user = User(name: fullName, phone: checkPhone);
    users[user.login] = user;
    return user;
  }

  void setFriends(String login, List<User> friends) {
    if (users.containsKey(login)) {
      users[login].addFriend(friends);
    }
  }

  User findUserInFriends(String fullName, User user) {
    User localUser = users[fullName];
    for (User f in localUser.friends) {
      if (f == user) {
        return user;
      }
    }
    throw Exception('${user.login} is not a friend of the login');
  }

  List<User> importUsers(List<String> list) {
    List<User> users = [];
    for (String i in list) {
      List<String> data = i.split(';');
      User user = User(
          name: data[0].trim(), email: data[1].trim(), phone: data[2].trim());
      users.add(user);
    }
    return users;
  }
}
