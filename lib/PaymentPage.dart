import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentPage extends StatefulWidget {
  final String movieTitle;
  final String selectedDate;
  final String selectedTime;

  const PaymentPage({
    Key? key,
    required this.movieTitle,
    required this.selectedDate,
    required this.selectedTime,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final Color mainColor = Color(0xFF200914);
  final Color accentColor = Color(0xFFFFB2BD);

  String name = '';
  String email = '';
  String paymentMethod = 'Cash';
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        email = user.email ?? '';
      });

      FirebaseFirestore.instance.collection('users').doc(user.uid).get().then((
        doc,
      ) {
        if (doc.exists) {
          setState(() {
            name = doc['username'] ?? 'User';
          });
        }
      });
    }
  }

  bool isCardValid(String cardNumber) {
    final visaRegex = RegExp(r'^(?:4[0-9]{12}(?:[0-9]{3})?)$');
    final masterCardRegex = RegExp(r'^(?:5[1-5][0-9]{14})$');
    return visaRegex.hasMatch(cardNumber) ||
        masterCardRegex.hasMatch(cardNumber);
  }

  void confirmBooking() async {
    if (paymentMethod == 'Card' && !isCardValid(cardNumberController.text)) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              backgroundColor: mainColor,
              title: Text(
                "Invalid Card",
                style: TextStyle(color: Colors.white),
              ),
              content: Text(
                "Please enter a valid Visa or MasterCard number.",
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton(
                  child: Text("OK", style: TextStyle(color: accentColor)),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('bookings').add({
        'username': name,
        'email': email,
        'paymentMethod': paymentMethod,
        'movie': widget.movieTitle,
        'date': widget.selectedDate.toString(),
        'time': widget.selectedTime.toString(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              backgroundColor: mainColor,
              title: Text(
                "Booking Confirmed",
                style: TextStyle(color: Colors.white),
              ),
              content: Text(
                "Movie: ${widget.movieTitle}\nDate: ${widget.selectedDate}\nTime: ${widget.selectedTime}\nPayment: $paymentMethod",
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton(
                  child: Text(
                    "Go To Home Page",
                    style: TextStyle(color: accentColor),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              backgroundColor: Colors.black,
              title: Text("Error", style: TextStyle(color: Colors.white)),
              content: Text(
                "Failed to book: $e",
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton(
                  child: Text("OK", style: TextStyle(color: accentColor)),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFC9BABA)),
        backgroundColor: Color(0xFF520C2E),
        centerTitle: true,
        title: Image(
          image: AssetImage('lib/images/logo.jpg'),
          height: 130,
          fit: BoxFit.contain,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 30, 70, 0),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment",
              style: TextStyle(color: Color(0xFFC9BABA), fontSize: 30),
            ),
            SizedBox(height: 40),
            Text("Name", style: TextStyle(color: Color(0xFFC9BABA))),
            SizedBox(height: 4),
            TextField(
              controller: TextEditingController(text: name),
              readOnly: true,
              focusNode: AlwaysDisabledFocusNode(),
              style: TextStyle(color: Color(0xFFC9BABA)),
              decoration: InputDecoration(
                filled: true,
                fillColor: mainColor,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text("Email", style: TextStyle(color: Color(0xFFC9BABA))),
            SizedBox(height: 4),
            TextField(
              controller: TextEditingController(text: email),
              readOnly: true,
              focusNode: AlwaysDisabledFocusNode(),

              style: TextStyle(color: Color(0xFFC9BABA)),
              decoration: InputDecoration(
                filled: true,
                fillColor: mainColor,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text("Payment Method", style: TextStyle(color: Color(0xFFC9BABA))),
            Row(
              children: [
                Radio<String>(
                  value: 'Cash',
                  groupValue: paymentMethod,
                  onChanged: (value) {
                    setState(() {
                      paymentMethod = value!;
                    });
                  },
                ),
                Text("Cash", style: TextStyle(color: Color(0xFFC9BABA))),
                Radio<String>(
                  value: 'Card',
                  groupValue: paymentMethod,
                  onChanged: (value) {
                    setState(() {
                      paymentMethod = value!;
                    });
                  },
                ),
                Text("Card", style: TextStyle(color: Color(0xFFC9BABA))),
              ],
            ),
            SizedBox(height: 16),
            Text("Card Number", style: TextStyle(color: Color(0xFFC9BABA))),
            TextField(
              controller: cardNumberController,
              enabled: paymentMethod == 'Card',
              style: TextStyle(color: mainColor),
              decoration: InputDecoration(
                filled: true,
                fillColor: paymentMethod == 'Card' ? accentColor : Colors.grey,
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Text("CVV", style: TextStyle(color: Color(0xFFC9BABA))),
            TextField(
              controller: cvvController,
              enabled: paymentMethod == 'Card',
              style: TextStyle(color: mainColor),
              decoration: InputDecoration(
                filled: true,
                fillColor: paymentMethod == 'Card' ? accentColor : Colors.grey,
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
            SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                onPressed: confirmBooking,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  backgroundColor: accentColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                ),
                child: Text(
                  "Confirm Payment",
                  style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
