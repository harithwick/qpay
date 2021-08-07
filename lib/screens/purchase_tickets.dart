import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qpay/models/ticket_object.dart';
import 'package:qpay/models/ticket_provider.dart';
import 'package:qpay/models/ticket_type_object.dart';
import 'package:qpay/screens/summary.dart';
import 'package:qpay/widgets/elevated_container.dart';
import 'package:qpay/widgets/header.dart';
import 'package:qpay/widgets/heading.dart';
import 'package:qpay/widgets/sub_heading.dart';

//Purchase tickets screen, string validation needs to be improved significantly, currently checking only if the textform field is empty or not.

class PurchaseTicket extends StatefulWidget {
  final provider;

  const PurchaseTicket({Key? key, required this.provider}) : super(key: key);

  static const String fullNameLabel = "Full Name";
  static const String mobileLabel =
      "Mobile Number (with country prefix, i.e. +61)";
  static const String mobileHint = "e.g. +77...";
  static const String universityLabel = "University";
  static const String studentIDLabel = "Student ID";
  static const String dietLabel = "Dietary Requirements (Optional)";
  static const String emailLabel = "Email Address";
  static const String emailHint = "example@gmail.com";

  @override
  _PurchaseTicketState createState() => _PurchaseTicketState();
}

class _PurchaseTicketState extends State<PurchaseTicket> {
  _renderTicketForms() {
    List<Ticket> tickets = widget.provider.getTickets();
    List<TicketType> ticketTypes = widget.provider.getTicketTypes();
    List<Widget> ticketForms = [];
    for (Ticket ticket in tickets) {
      ticketForms.add(_ticketForm(ticket, ticketTypes, widget.provider));
    }
    return Column(
      children: ticketForms,
    );
  }

  Widget _ticketForm(
      Ticket ticket, List<TicketType> ticketTypes, var provider) {
    return ElevatedContainer(
      color: Colors.white,
      widget: Form(
        key: ticket.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Heading(label: "TICKET #${ticket.id}"),
            SizedBox(height: 32.0),
            SubHeading(label: "Personal Info", icon: Icons.person),
            SizedBox(height: 16.0),
            _renderTextField(PurchaseTicket.fullNameLabel, "Full Name", ticket),
            SizedBox(height: 16.0),
            _renderTextField(PurchaseTicket.mobileLabel, "e.g. +77...", ticket),
            SizedBox(height: 32.0),
            SubHeading(label: "Ticket Details", icon: Icons.airplane_ticket),
            SizedBox(height: 16.0),
            _renderTicketTypes(ticketTypes, ticket),
            SizedBox(height: 16.0),
            _renderAdditionalFields(ticketTypes, ticket),
            SizedBox(height: 16.0),
            _renderTextField(
                PurchaseTicket.universityLabel, "Enter University", ticket),
            SizedBox(height: 16.0),
            _renderTextField(
                PurchaseTicket.studentIDLabel, "Enter Student", ticket),
            SizedBox(height: 16.0),
            _renderTextField(
                PurchaseTicket.dietLabel, "Enter Dietary Requirements", ticket),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget _renderTextField(
      String _labelText, String _hintText, Ticket selectedTicket) {
    return TextFormField(
      initialValue: "",
      decoration: InputDecoration(
        hintText: _hintText,
        labelText: _labelText,
      ),
      onChanged: (String? value) {
        switch (_labelText) {
          case PurchaseTicket.fullNameLabel:
            selectedTicket.fullName = value!;
            widget.provider.updateTicket(selectedTicket);
            break;
          case PurchaseTicket.mobileLabel:
            selectedTicket.mobile = value!;
            widget.provider.updateTicket(selectedTicket);
            break;
          case PurchaseTicket.universityLabel:
            selectedTicket.university = value!;
            widget.provider.updateTicket(selectedTicket);
            break;
          case PurchaseTicket.studentIDLabel:
            selectedTicket.studentID = value!;
            widget.provider.updateTicket(selectedTicket);
            break;
          case PurchaseTicket.dietLabel:
            selectedTicket.diet = value!;
            widget.provider.updateTicket(selectedTicket);
            break;
          default:
            selectedTicket.additionalField = value!;
            widget.provider.updateTicket(selectedTicket);
            break;
        }
      },
      validator: (String? value) {
        switch (_labelText) {
          case PurchaseTicket.fullNameLabel:
            if (value!.isEmpty) {
              return 'Field cannot be empty';
            }
            break;
          case PurchaseTicket.mobileLabel:
            if (value!.isEmpty) {
              return 'Field cannot be empty';
            }
            break;
          case PurchaseTicket.universityLabel:
            if (value!.isEmpty) {
              return 'Field cannot be empty';
            }
            break;
          case PurchaseTicket.studentIDLabel:
            if (value!.isEmpty) {
              return 'Field cannot be empty';
            }
            break;
          case PurchaseTicket.dietLabel:
            if (value!.isEmpty) {
              return 'Field cannot be empty';
            }
            break;
          default:
            break;
        }
      },
    );
  }

  _renderTicketTypes(List<TicketType> ticketTypes, Ticket selectedTicket) {
    return DropdownButton(
        value: selectedTicket.ticketTypeID,
        onChanged: (int? newTypeID) {
          selectedTicket.ticketTypeID = newTypeID!;
          widget.provider.updateTicket(selectedTicket);
        },
        items: ticketTypes.map<DropdownMenuItem<int>>((TicketType ticketType) {
          return DropdownMenuItem<int>(
            child: Text("${ticketType.name} (\$${ticketType.price})"),
            value: ticketType.id,
          );
        }).toList());
  }

  Widget _renderAdditionalFields(
      List<TicketType> ticketTypes, Ticket selectedTicket) {
    bool typeFound = false;
    late TicketType ticketType;

    for (TicketType type in ticketTypes) {
      if (type.id == selectedTicket.ticketTypeID &&
          type.additionalField != "") {
        ticketType = type;
        typeFound = true;
        break;
      }
    }

    if (typeFound) {
      return _renderTextField(ticketType.additionalField,
          ticketType.additionalField, selectedTicket);
    }
    return Container();
  }

  _renderPayerFullNameField() {
    return TextFormField(
        decoration: InputDecoration(
          hintText: PurchaseTicket.fullNameLabel,
          labelText: PurchaseTicket.fullNameLabel,
        ),
        onChanged: (String? value) {
          widget.provider.updatePayerFullName(value!);
        },
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Field cannot be empty';
          }
        });
  }

  _renderPayerEmailField() {
    return TextFormField(
        decoration: InputDecoration(
          hintText: PurchaseTicket.emailHint,
          labelText: PurchaseTicket.emailLabel,
        ),
        onChanged: (String? value) {
          widget.provider.updatePayerEmail(value!);
        },
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Field cannot be empty';
          }
        });
  }

  _renderPayerMobileField() {
    return TextFormField(
        decoration: InputDecoration(
          hintText: PurchaseTicket.mobileLabel,
          labelText: PurchaseTicket.mobileHint,
        ),
        onChanged: (String? value) {
          widget.provider.updatePayerMobile(value!);
        },
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Field cannot be empty';
          }
        });
  }

  Widget _renderPayerDetails(context) {
    return ElevatedContainer(
      color: Colors.white,
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Heading(label: "PAYER DETAILS"),
          SizedBox(height: 32.0),
          SubHeading(label: "Personal Info", icon: Icons.person),
          SizedBox(height: 16.0),
          _renderPayerFullNameField(),
          SizedBox(height: 16.0),
          _renderPayerEmailField(),
          SizedBox(height: 16.0),
          _renderPayerMobileField(),
          SizedBox(height: 32.0),
          ElevatedButton(
            child: Text("Secure Tickets"),
            onPressed: () {
              if (widget.provider.invalidFormsExists()) {
                print("invalid forms");
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Summary(
                              provider: widget.provider,
                            )));
              }
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Consumer<TicketInfo>(
        builder: (context, ticketInfo, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              _renderTicketForms(),
              _renderPayerDetails(context)
            ],
          );
        },
      )),
    );
  }
}
