import 'package:flutter/cupertino.dart';

//Tickets Object

class Ticket {
  int id;
  String mobile;
  String fullName;
  int ticketTypeID;
  String university;
  String studentID;
  String diet;
  String additionalField;
  GlobalKey<FormState> formKey;

  Ticket(
      this.id,
      this.mobile,
      this.fullName,
      this.ticketTypeID,
      this.university,
      this.studentID,
      this.diet,
      this.additionalField,
      this.formKey);
}
