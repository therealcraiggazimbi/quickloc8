class Message {
  String message;
  String subject;
  String display;

  Message(
      {required this.message, required this.subject, required this.display});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'],
      subject: json['subject'],
      display: json['display'],
    );
  }
}
