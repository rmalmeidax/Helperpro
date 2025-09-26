import 'package:flutter/material.dart';

class FrmPesquisaAbaListaWidget extends StatefulWidget {
  const FrmPesquisaAbaListaWidget({super.key});

  @override
  State<FrmPesquisaAbaListaWidget> createState() =>
      _FrmPesquisaAbaListaWidgetState();
}

class _FrmPesquisaAbaListaWidgetState
    extends State<FrmPesquisaAbaListaWidget> {
  // Simulação de dados principais
  final List<Map<String, dynamic>> _items = [
    {"name": "James", "service": "Banheiro", "daily": 250.0, "rating": 3},
    {"name": "Frank Will", "service": "Banheiro", "daily": 250.0, "rating": 4},
    {"name": "Will", "service": "Piso", "daily": 250.0, "rating": 2},
    {"name": "Ross", "service": "Blakplosh", "daily": 700.0, "rating": 5},
  ];

  // Simulação de últimos trabalhos
  final Map<String, List<Map<String, String>>> _lastJobs = {
    "James": [
      {"start": "12/05/23", "done": "24/05/23"},
      {"start": "01/05/23", "done": "10/05/23"},
    ],
    "Frank Will": [
      {"start": "01/05/23", "done": "09/05/23"},
      {"start": "15/04/23", "done": "20/04/23"},
    ],
    "Will": [
      {"start": "02/05/23", "done": "07/05/23"},
    ],
    "Ross": [
      {"start": "20/04/23", "done": "30/04/23"},
      {"start": "01/03/23", "done": "10/03/23"},
    ],
  };

  void _showLastJobs(String name) {
    final jobs = _lastJobs[name] ?? [];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.teal[100],
          title: Text("Últimos Trabalhos de $name"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                final job = jobs[index];
                return Card(
                  color: Colors.teal[300],
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    title: Text("Start: ${job['start']}"),
                    subtitle: Text("Done: ${job['done']}"),
                  ),
                );
              },
            ),
          ),
          actions: [
            ElevatedButton(
              style:
              ElevatedButton.styleFrom(backgroundColor: Colors.teal[600]),
              onPressed: () => Navigator.pop(context),
              child: const Text("Okay"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[300],
      appBar: AppBar(
        title: const Text("Luiz Fernando Tile"),
        backgroundColor: Colors.teal[700],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Últimos Trabalhos",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Card(
                    color: Colors.black87,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: const Icon(Icons.work, color: Colors.white),
                      title: Text(
                        item['name'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Row(
                        children: [
                          Text(item['service'],
                              style: const TextStyle(color: Colors.white70)),
                          const SizedBox(width: 10),
                          Row(
                            children: List.generate(
                              5,
                                  (starIndex) => Icon(
                                starIndex < item['rating']
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.yellow[600],
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Diária: \$${item['daily']}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12)),
                          IconButton(
                            icon: const Icon(Icons.add, color: Colors.white),
                            onPressed: () => _showLastJobs(item['name']),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
