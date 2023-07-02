// Model classes
class User {
  final String name;
  final String phone;
  final String number;
  final String email;

  User(
      {required this.name,
      required this.phone,
      required this.number,
      required this.email});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'number': number,
      'email': email,
    };
  }
}

class Committee {
  final double amount;
  final int duration;
  final List<User> members;

  Committee(
      {required this.amount, required this.duration, required this.members});

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'duration': duration,
      'members': members.map((member) => member.toMap()).toList(),
    };
  }
}
