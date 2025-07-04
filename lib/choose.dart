// choose.dart
import 'package:flutter/material.dart';

class ChoosePage extends StatefulWidget {
  const ChoosePage({super.key});

  @override
  State<ChoosePage> createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  String? selectedBlock;

  final List<String> blocks = ['A Block', 'E Block'];

  final Set<String> groundFloorUnavailable = {'6-3', '6-4', '15-4'};
  final Set<String> firstFloorUnavailable = {'5-3', '5-4', '6-3', '6-4'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TCE Hostel'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedBlock,
              hint: const Text('Select Block'),
              items: blocks
                  .map((block) => DropdownMenuItem(
                        value: block,
                        child: Text(block),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedBlock = value;
                });
              },
            ),
            const SizedBox(height: 20),

            if (selectedBlock == 'A Block')
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ground Floor', style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 10),
                      SeatMatrix(unavailableSeats: groundFloorUnavailable),
                      const SizedBox(height: 20),
                      Text('First Floor', style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 10),
                      SeatMatrix(unavailableSeats: firstFloorUnavailable),
                    ],
                  ),
                ),
              )
            else if (selectedBlock == 'E Block')
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'No matrix available for E Block',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class SeatMatrix extends StatelessWidget {
  final Set<String> unavailableSeats;

  const SeatMatrix({super.key, required this.unavailableSeats});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(15, (row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (col) {
            final seatKey = '${row + 1}-${col + 1}';
            final isUnavailable = unavailableSeats.contains(seatKey);

            return Container(
              margin: const EdgeInsets.all(4),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: isUnavailable ? Colors.red.shade300 : Colors.green.shade300,
                border: Border.all(),
              ),
              child: Center(
                child: Text(
                  seatKey,
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
