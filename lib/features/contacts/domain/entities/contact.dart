import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final String name;
  final int identification;
  final String? userEmail;

  const Contact(
      {required this.name,
      required this.identification,
      required this.userEmail});

  @override
  List<Object> get props => [name, identification, userEmail ?? ""];
}
