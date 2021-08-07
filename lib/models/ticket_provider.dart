import 'package:flutter/material.dart';
import 'package:qpay/models/ticket_object.dart';
import 'package:qpay/models/ticket_type_object.dart';

//All data needed for provider state management system

class TicketInfo extends ChangeNotifier {
  String _payerFullName = "";
  String _payerEmail = "";
  String _payerMobile = "";
  bool loading = false;
  List<Ticket> _tickets = [];
  int _numTickets = 1;
  double _totalCost = 0;
  List<TicketType> _ticketTypes = [
    TicketType(1, "General Admission", 6.31, ""),
    TicketType(2, "IEEE.ORG Member", 0.00,
        "What is your IEEE.ORG Member number? NOTE: This ID Begins with a 9 and we will verify it after your purchase.")
  ];

  String get payerFullName => _payerFullName;
  String get payerEmail => _payerEmail;
  String get payerMobile => _payerMobile;
  List<Ticket> get getTicketsList => _tickets;
  double get getTotalCost => _totalCost;
  int get getNumTickets => _numTickets;
  Ticket get firstTicket => _tickets[0];
  List<Ticket> getTickets() => _tickets;
  List<TicketType> getTicketTypes() => _ticketTypes;

  void updateTicket(Ticket newTicket) {
    for (int i = 0; i < _tickets.length; i++) {
      if (_tickets[i].id == newTicket.id) {
        _tickets[i] = newTicket;
        break;
      }
    }
    notifyListeners();
  }

  void setNumTickets(int numTickets) {
    _numTickets = numTickets;
    notifyListeners();
  }

  double getTotal() {
    double total = 0;
    for (int i = 0; i < _tickets.length; i++) {
      if (_tickets[i].ticketTypeID == 1) {
        total += 6.31;
      }
    }
    return total;
  }

  void updatePayerFullName(String payerFullName) {
    _payerFullName = payerFullName;
    notifyListeners();
  }

  void updatePayerEmail(String payerEmail) {
    _payerEmail = payerEmail;
    notifyListeners();
  }

  void updatePayerMobile(String payerMobile) {
    _payerMobile = payerMobile;
    notifyListeners();
  }

  bool invalidFormsExists() {
    bool notValid = false;
    bool goodTicket = false;
    for (Ticket ticket in _tickets) {
      goodTicket = ticket.formKey.currentState!.validate();
      if (goodTicket == false) {
        notValid = true;
      }
    }
    return notValid;
  }

  void initTickets() {
    _tickets = [];
    for (int i = 0; i < _numTickets; i++) {
      final key = GlobalKey<FormState>();
      _tickets.add(
          Ticket(i + 1, "", "", _ticketTypes.first.id, "", "", "", "", key));
    }
    notifyListeners();
  }
}
