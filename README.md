# QPay

In the main file a provider is being setup. Provider helps with simplifing state management. I initially opted to go with just set state but soon realised the state management was getting too complex specially with the dynamic nature of the forms. Inside the models folder, the ticket_provider.dart file sets up the data and functions needed for the state of the app.

The app has 3 screens, homepage, purchase tickets and summary page. The Home page has a selection of the number of tickets, based on the selection the form on the PurchaseTickets screen is dynamically updated. On enther to the PurchaseTickets page the 15min timer is started. The data entered in the form is being passed in to the Ticket and TicketType objects with the help of provider. A simple  textfield validation check is in place to see if theres any data in any of the textfields. This can be improved significantly to clean up and ensure the right data is being fed in. 

Once the user clicks the Secure Tickets button on the PurchaseTickets screen, the user input data is passed on to the Summary page to be displayed.

