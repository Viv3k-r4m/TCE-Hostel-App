import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ChoosePage()));

class ChoosePage extends StatefulWidget {
  const ChoosePage({super.key});

  @override
  State<ChoosePage> createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  String? selectedBlock;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TCE Hostel"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: selectedBlock == null
            ? buildBlockSelection()
            : buildFloorOptions(selectedBlock!),
      ),
    );
  }

  Widget buildBlockSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Choose a Block",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildBlockCard("Block A", Icons.apartment),
            buildBlockCard("Block E", Icons.location_city),
          ],
        ),
      ],
    );
  }

  Widget buildBlockCard(String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBlock = title;
        });
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 150,
          height: 120,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.teal),
              const SizedBox(height: 10),
              Text(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFloorOptions(String block) {
    final List<Map<String, String>> floorData = block == "Block A"
        ? [
            {"label": "Ground Floor", "icon": "1"},
            {"label": "First Floor", "icon": "2"},
          ]
        : [
            {"label": "First Floor", "icon": "2"},
            {"label": "Third Floor (A/C)", "icon": "ac"},
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  selectedBlock = null;
                });
              },
            ),
            Text(
              block,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: floorData.map((floor) {
              final String title = floor["label"]!;
              final String iconCode = floor["icon"]!;
              IconData icon = iconCode == "ac" ? Icons.ac_unit : Icons.stairs;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OccupancySelectionPage(
                        block: block,
                        floor: title,
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.orange.shade50,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon, size: 36, color: Colors.deepOrange),
                        const SizedBox(height: 12),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class OccupancySelectionPage extends StatelessWidget {
  final String block;
  final String floor;

  const OccupancySelectionPage({
    super.key,
    required this.block,
    required this.floor,
  });

  List<int> getOccupancyOptions() {
    if (block == "Block A") {
      if (floor == "Ground Floor") return [4, 3, 2];
      if (floor == "First Floor") return [4, 2];
    } else if (block == "Block E") {
      if (floor == "First Floor") return [4, 2];
      if (floor.contains("Third")) return [4];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final options = getOccupancyOptions();

    return Scaffold(
      appBar: AppBar(
        title: Text('$block - $floor'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Occupancy Type",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Column(
              children: options.map((e) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SeatMatrixPage(
                            block: block,
                            floor: floor,
                            occupancy: e,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text("$e per room"),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class SeatMatrixPage extends StatefulWidget {
  final String block;
  final String floor;
  final int occupancy;

  const SeatMatrixPage({
    super.key,
    required this.block,
    required this.floor,
    required this.occupancy,
  });

  @override
  State<SeatMatrixPage> createState() => _SeatMatrixPageState();
}

class _SeatMatrixPageState extends State<SeatMatrixPage> {
  int? selectedRoom;
  int? selectedSeatIndex;

  @override
  Widget build(BuildContext context) {
    List<int> roomNumbers = generateRoomNumbers(
      block: widget.block,
      floor: widget.floor,
      occupancy: widget.occupancy,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.block} - ${widget.floor}'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle),
            onPressed: () {
              if (selectedRoom != null && selectedSeatIndex != null) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Summary"),
                    content: Text(
                        "Block: ${widget.block}\nFloor: ${widget.floor}\nOccupancy: ${widget.occupancy} per room\nRoom: $selectedRoom\nSeat: ${selectedSeatIndex! + 1}"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      )
                    ],
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please select a seat.")),
                );
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: buildMatrix(roomNumbers, widget.occupancy),
      ),
    );
  }

  Widget buildMatrix(List<int> roomNumbers, int cols) {
    return SingleChildScrollView(
      child: Column(
        children: roomNumbers.map((roomNumber) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Text(
                    '$roomNumber →',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(width: 10),
                ...List.generate(cols, (index) {
                  bool isSelected =
                      selectedRoom == roomNumber && selectedSeatIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRoom = roomNumber;
                        selectedSeatIndex = index;
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.green.shade200
                            : Colors.blue.shade50,
                        border: Border.all(
                            color: isSelected
                                ? Colors.green
                                : Colors.blueAccent),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('${index + 1}',
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  );
                }),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  List<int> generateRoomNumbers({
    required String block,
    required String floor,
    required int occupancy,
  }) {
    if (block == "Block A") {
      if (floor == "Ground Floor") {
        if (occupancy == 4) return [...List.generate(5, (i) => i + 1), ...List.generate(8, (i) => i + 7)];
        if (occupancy == 3) return [15];
        if (occupancy == 2) return [6];
      }
      if (floor == "First Floor") {
        if (occupancy == 4) return [...List.generate(4, (i) => i + 16), ...List.generate(9, (i) => i + 22)];
        if (occupancy == 2) return [20, 21];
      }
    } else if (block == "Block E") {
      if (floor == "First Floor") {
        if (occupancy == 4) return [for (int i = 30; i <= 52; i++) i, 56, 57, 58, 59];
        if (occupancy == 2) return [53, 54, 55];
      }
      if (floor.contains("Third")) {
        if (occupancy == 4) return [for (int i = 89; i <= 115; i++) i];
      }
    }
    return [];
  }
}
