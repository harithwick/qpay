import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qpay/models/ticket_provider.dart';
import 'package:qpay/widgets/elevated_container.dart';
import 'package:qpay/widgets/heading.dart';
import 'package:qpay/widgets/sub_heading.dart';
import 'purchase_tickets.dart';

//Kept the home page down just to the funtionality with minimal styling.

class HomePage extends StatelessWidget {
  static List<int> numOfTickets = [1, 2, 3, 4, 5];

  Widget _renderDropDown(context) {
    var provider = Provider.of<TicketInfo>(context);
    return DropdownButton(
        value: provider.getNumTickets,
        onChanged: (int? newVal) {
          provider.setNumTickets(newVal!);
        },
        items: numOfTickets.map<DropdownMenuItem<int>>((int value) {
          return DropdownMenuItem<int>(
            child: Text(value.toString() + " Ticket"),
            value: value,
          );
        }).toList());
  }

  Widget _secureYourTickets(context) {
    var provider = Provider.of<TicketInfo>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Heading(label: "Get Your Tickets"),
        SizedBox(height: 16),
        Text(
            "Buy tickets for your group, so that you're going together. Bonus: friends can choose to pay you back via QPay too."),
        SizedBox(height: 16),
        Text("Your Order: ${provider.getNumTickets} Ticket"),
        SizedBox(height: 16),
        _renderDropDown(context),
        SizedBox(height: 32),
        ElevatedButton(
          child: Text("Secure Tickets"),
          onPressed: () {
            provider.initTickets();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PurchaseTicket(
                          provider: provider,
                        )));
          },
        ),
        SizedBox(height: 16)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: ElevatedContainer(
            color: Colors.white,
            widget: _secureYourTickets(context),
          ),
        ),
      ),
    );
  }
}
