class InvitationDetailModel {
  final String id;
  final Sender sender;
  final List<Receiver> receivers;
  final Job job;

  InvitationDetailModel({
    required this.id,
    required this.sender,
    required this.receivers,
    required this.job,
  });

  factory InvitationDetailModel.fromJson(Map<String, dynamic> json) {
    return InvitationDetailModel(
      id: json['_id'],
      sender: Sender.fromJson(json['sender']),
      receivers: List<Receiver>.from(
        json['receivers'].map((r) => Receiver.fromJson(r)),
      ),
      job: Job.fromJson(json['jobId']),
    );
  }
}

class Sender {
  final String id;
  final String name;
  final String email;

  Sender({required this.id, required this.name, required this.email});

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

class Receiver {
  final ReceiverUser user;
  final String status;

  Receiver({required this.user, required this.status});

  factory Receiver.fromJson(Map<String, dynamic> json) {
    return Receiver(
      user: ReceiverUser.fromJson(json['userId']),
      status: json['status'],
    );
  }
}

class ReceiverUser {
  final String id;
  final String name;
  final String email;

  ReceiverUser({required this.id, required this.name, required this.email});

  factory ReceiverUser.fromJson(Map<String, dynamic> json) {
    return ReceiverUser(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

class Job {
  final String id;
  final String title;

  Job({required this.id, required this.title});

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['_id'],
      title: json['title'],
    );
  }
}
