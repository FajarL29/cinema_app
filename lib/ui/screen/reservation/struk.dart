import 'package:cinema_app/ui/screen/ticket/ticket_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Struk extends StatelessWidget {
  final Map<String, String> ticketData;

  const Struk({super.key, required this.ticketData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Struk Pemesanan"),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/animasi/centang.json', width: 150, height: 150),
                  const Center(
                    child: Text(
                      "🎟 Tiket Berhasil Dipesan!",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text("🎬 Judul: ${ticketData["title"]}", style: const TextStyle(fontSize: 16)),
                  Text("🎟 Kursi: ${ticketData["seat"]}", style: const TextStyle(fontSize: 16)),
                  Text("📅 Tanggal: ${ticketData["date"]}", style: const TextStyle(fontSize: 16)),
                  Text("⏰ Waktu: ${ticketData["time"]}", style: const TextStyle(fontSize: 16)),
                  Text("💲 Harga: Rp ${ticketData["price"]}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=> TicketPage()));
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      child: const Text("Tutup"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
