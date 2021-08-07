import 'package:flutter/material.dart';
import 'package:qpay/models/ticket_object.dart';
import 'package:qpay/widgets/elevated_container.dart';
import 'package:qpay/widgets/heading.dart';
import 'package:qpay/widgets/sub_heading.dart';

//Summary page of the project which is broken down into 3 sections, header, payer details and ticket list

class Summary extends StatelessWidget {
  final provider;

  Summary({required this.provider});

  Widget _header() {
    return ElevatedContainer(
      color: Color(0xffEB3070),
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "TICKET SECURED",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(height: 32),
          Text(
            "Total: \$" + provider.getTotal().toStringAsFixed(2),
            style: TextStyle(fontSize: 18, color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget _confirmPayerDetails() {
    return ElevatedContainer(
      color: Colors.white,
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Heading(label: "CONFIRM PAYER DETAILS"),
          SizedBox(height: 32.0),
          SubHeading(label: "Personal Info", icon: Icons.person),
          SizedBox(height: 16.0),
          Text("Bill will be sent to below QPay Mobile Number:"),
          SizedBox(height: 16),
          Text("Full Name: " + provider.payerFullName),
          SizedBox(height: 16),
          Text("Email Address: " + provider.payerEmail),
          SizedBox(height: 16),
          Text("Mobile Number: " + provider.payerMobile),
          SizedBox(height: 32),
          ElevatedButton(
            child: Text("Proceed to Payment"),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget _ticketList() {
    List<Ticket> ticketList = provider.getTicketsList;
    List<Widget> returnWidgets = [];
    int i = 0;
    for (Ticket ticket in ticketList) {
      i++;
      returnWidgets.add(ElevatedContainer(
        color: Colors.white,
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Heading(label: "TICKET #$i"),
            SizedBox(height: 32.0),
            SubHeading(label: "Personal Info", icon: Icons.person),
            SizedBox(height: 16),
            Text("Full Name: " + ticket.fullName),
            SizedBox(height: 16),
            Text("Mobile Number: " + ticket.mobile),
            SizedBox(height: 16),
            SubHeading(label: "Ticket Details", icon: Icons.airplane_ticket),
            SizedBox(height: 16),
            Text("Ticket Type: " + ticket.ticketTypeID.toString()),
            SizedBox(height: 16),
            Text("University: " + ticket.university),
            SizedBox(height: 16),
            Text("Dietary Requirements: " + ticket.diet),
          ],
        ),
      ));
    }
    return Column(
      children: returnWidgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_header(), _ticketList(), _confirmPayerDetails()],
        ),
      ),
    );
  }
}
