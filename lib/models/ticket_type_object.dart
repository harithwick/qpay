//Ticket Type Class to account for the two types of tickets, IEEE and General Admission

class TicketType {
  final int id;
  final String name;
  final double price;
  final String additionalField;

  TicketType(this.id, this.name, this.price, this.additionalField);
}
