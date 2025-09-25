import 'package:flutter/material.dart';

class FrmPrincipalWidget extends StatelessWidget {
  const FrmPrincipalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        title: const Text("Helper", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Perfil do usuário
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage("assets/logo.jpeg"),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Andrew",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (i) {
                      return const Icon(Icons.star, color: Colors.yellowAccent, size: 20);
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Quick Service
            const Text(
              "Quick Service",
              style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
            const SizedBox(height: 10),

            GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 2.0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: const [
                _QuickServiceCard(icon: Icons.people, label: "Clientes"),
                _QuickServiceCard(icon: Icons.show_chart, label: "Atividade"),
                _QuickServiceCard(icon: Icons.attach_money, label: "Movimentacao"),
                _QuickServiceCard(icon: Icons.search, label: "Buscar"),
                _QuickServiceCard(icon: Icons.calendar_month, label: "Agenda"),
                _QuickServiceCard(icon: Icons.shopping_cart, label: "Compras"),
              ],
            ),

            const SizedBox(height: 20),

            // Transação
            const Text(
              "Transacao",
              style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
            const SizedBox(height: 10),

            Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: const Text(
                  "Luiz Fernando",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Helper", style: TextStyle(color: Colors.white70)),
                    Row(
                      children: List.generate(5, (i) {
                        return const Icon(Icons.star, color: Colors.yellowAccent, size: 16);
                      }),
                    )
                  ],
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "\$150.00",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text("Diaria", style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white ,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        ],
        currentIndex: 1,
      ),
    );
  }
}

// Widget para os cards de quick service
class _QuickServiceCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const _QuickServiceCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 8),
            Text(label,
                style: const TextStyle(color: Colors.white70, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
