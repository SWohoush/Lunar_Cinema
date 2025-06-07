import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'PaymentPage.dart';

Color mainColor = Color(0xFF200914);

class BookingPage extends StatefulWidget {
  final String title;
  final String imageUrl;

  const BookingPage({Key? key, required this.title, required this.imageUrl})
    : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime selectedDate = DateTime.now();
  String selectedTime = '2 PM';
  int ticketCount = 1;
  Set<int> selectedSeats = {};
  final List<String> times = ['2 PM', '4 PM', '6 PM', '8 PM', '10 PM'];

  @override
  Widget build(BuildContext context) {
    int subtotal = ticketCount * 7;

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 60),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Image.network(widget.imageUrl, height: 350),
            ),
            const SizedBox(height: 10),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 35),

            // Date and Time Picker Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Date Picker
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.calendar_today, color: Color(0xFFC9BABA)),
                        SizedBox(width: 8),
                        Text(
                          "Select Date",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFC3B3B3),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                        if (picked != null) {
                          setState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                      child: Text(
                        DateFormat('yyyy - MM - dd').format(selectedDate),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                // Time Picker
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.access_time, color: Color(0xFFC9BABA)),
                        SizedBox(width: 8),
                        Text(
                          "Select Time",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    DropdownButton<String>(
                      value: selectedTime,
                      iconEnabledColor: Colors.white,
                      dropdownColor: mainColor,
                      underline: Container(height: 1, color: Colors.white),
                      style: const TextStyle(color: Colors.white),
                      items:
                          times
                              .map(
                                (time) => DropdownMenuItem(
                                  value: time,
                                  child: Text(time),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedTime = value!;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Ticket Counter
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.remove_circle,
                    color: Color(0xFFC9BABA),
                  ),
                  onPressed:
                      ticketCount > 1
                          ? () => setState(() {
                            ticketCount--;
                            selectedSeats.clear();
                          })
                          : null,
                ),
                Text(
                  '$ticketCount',
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Color(0xFFC9BABA)),
                  onPressed:
                      () => setState(() {
                        ticketCount++;
                      }),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Seat Grid
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              width: 330,
              height: 330,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                ),
                itemCount: 64,
                itemBuilder: (context, index) {
                  final seat = index + 1;
                  final isSelected = selectedSeats.contains(seat);
                  final isSelectable =
                      selectedSeats.length < ticketCount || isSelected;

                  return GestureDetector(
                    onTap:
                        isSelectable
                            ? () {
                              setState(() {
                                isSelected
                                    ? selectedSeats.remove(seat)
                                    : selectedSeats.add(seat);
                              });
                            }
                            : null,
                    child: Icon(
                      Icons.event_seat,
                      size: 18,
                      color: isSelected ? Color(0xFF520C2E) : Color(0xFF9B8181),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),
            Text(
              "Subtotal: $subtotal JDs",
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed:
                  ticketCount > 0 && selectedSeats.length == ticketCount
                      ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => PaymentPage(
                                  movieTitle: widget.title,
                                  selectedDate: DateFormat(
                                    'yyyy-MM-dd',
                                  ).format(selectedDate),
                                  selectedTime: selectedTime,
                                ),
                          ),
                        );
                      }
                      : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFC9BABA),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Confirm Booking",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF520C2E),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
