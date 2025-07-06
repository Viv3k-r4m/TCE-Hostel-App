import 'package:flutter/material.dart';

class ChoosePage extends StatefulWidget {
  const ChoosePage({super.key});

  @override
  State<ChoosePage> createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  String? selectedBlock;
  final Map<String, String?> selectedSeats = {};

  final List<String> blocks = ['A Block', 'E Block AC', 'E Block Non AC'];

  final Set<String> groundFloorUnavailable = {'6-3', '6-4', '15-4'};
  final Set<String> firstFloorUnavailable = {'5-3', '5-4', '6-3', '6-4'};

  final Set<String> eBlockNonAcUnavailable = {
    '24-3',
    '24-4',
    '25-3',
    '25-4',
    '26-3',
    '26-4'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TCE Hostel'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Select Block',
              ),
              value: selectedBlock,
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

            if (selectedBlock != null) buildLegend(),

            const SizedBox(height: 10),

            if (selectedBlock == 'A Block')
              Expanded(
                child: ListView(
                  children: [
                    buildMatrixCard(
                      title: 'Ground Floor',
                      rows: 15,
                      cols: 4,
                      unavailableSeats: groundFloorUnavailable,
                    ),
                    const SizedBox(height: 20),
                    buildMatrixCard(
                      title: 'First Floor',
                      rows: 15,
                      cols: 4,
                      unavailableSeats: firstFloorUnavailable,
                    ),
                  ],
                ),
              )
            else if (selectedBlock == 'E Block AC')
  Expanded(
    child: SingleChildScrollView(
      child: buildMatrixCard(
        title: 'E Block AC',
        rows: 27,
        cols: 4,
        unavailableSeats: {},
      ),
    ),
  )
else if (selectedBlock == 'E Block Non AC')
  Expanded(
    child: SingleChildScrollView(
      child: buildMatrixCard(
        title: 'E Block Non AC',
        rows: 30,
        cols: 4,
        unavailableSeats: eBlockNonAcUnavailable,
      ),
    ),
  ),
          ],
        ),
      ),
    );
  }

  Widget buildLegend() {
    return Row(
      children: [
        buildLegendItem(Colors.green.shade300, 'Available'),
        const SizedBox(width: 16),
        buildLegendItem(Colors.red.shade300, 'Unavailable'),
      ],
    );
  }

  Widget buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
          margin: const EdgeInsets.only(right: 6),
        ),
        Text(label),
      ],
    );
  }

  Widget buildMatrixCard({
    required String title,
    required int rows,
    required int cols,
    required Set<String> unavailableSeats,
  }) {
    final matrixKey = selectedBlock! + '-' + title;
    return Card(
      elevation: 2,
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:
                  Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

buildSeatMatrix(
  rows: rows,
  cols: cols,
  unavailableSeats: unavailableSeats,
  selectedSeat: selectedSeats[matrixKey],
  onSeatTap: (seatKey) {
  setState(() {
    // Clear all previous selections
    selectedSeats.clear();
    
    // Save only the new selection
    selectedSeats[matrixKey] = seatKey;
  });
},
),
          ],
        ),
      ),
    );
  }
}

/// Reusable function to build a seat matrix
Widget buildSeatMatrix({
  required int rows,
  required int cols,
  required Set<String> unavailableSeats,
  required String? selectedSeat,
  required Function(String seatKey) onSeatTap,
}) {
  return Column(
    children: List.generate(rows, (row) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(cols, (col) {
          final seatKey = '${row + 1}-${col + 1}';
          final isUnavailable = unavailableSeats.contains(seatKey);
          final isSelected = selectedSeat == seatKey;

          Color seatColor;
          if (isUnavailable) {
            seatColor = Colors.red.shade300;
          } else if (isSelected) {
            seatColor = Colors.yellow.shade600;
          } else {
            seatColor = Colors.green.shade300;
          }

          return GestureDetector(
            onTap: isUnavailable
                ? null
                : () {
                    onSeatTap(seatKey);
                  },
            child: Container(
              margin: const EdgeInsets.all(6),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: seatColor,
                border: Border.all(color: Colors.black45),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  seatKey,
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
          );
        }),
      );
    }),
  );
}
