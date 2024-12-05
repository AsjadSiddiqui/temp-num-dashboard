enum PhoneNumberStatus {
  active,
  inactive,
}

class PhoneNumber {
  final int id;
  final String number;
  final int messages;

  // Status can be changed later
  PhoneNumberStatus status;

  PhoneNumber({
    required this.id,
    required this.number,
    required this.status,
    required this.messages,
  });

  factory PhoneNumber.fromJson(Map<String, dynamic> json) {
    return PhoneNumber(
      id: json['id'],
      number: json['number'],
      status: json['status'] == 'active' ? PhoneNumberStatus.active : PhoneNumberStatus.inactive,
      messages: json['messages'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'number': number,
        'status': status.name,
        'messages': messages,
      };

  @override
  String toString() {
    return 'PhoneNumber{id: $id, number: $number, status: $status, messages: $messages}';
  }
}
