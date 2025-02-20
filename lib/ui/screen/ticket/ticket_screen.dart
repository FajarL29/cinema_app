//import 'package:cinema_app/ui/screen/home/home_page.dart';
import 'package:cinema_app/ui/screen/ticket/struk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:lottie/lottie.dart';
import 'package:cinema_app/ui/constant/color_pallete.dart';
//import 'package:cinema_app/ui/screen/detail/detail_page.dart';
import 'package:cinema_app/ui/screen/ticket/cubit/ticket_cubit.dart';

class TicketScreen extends StatefulWidget {
  final Map<String, String> ticketData; // Data tiket untuk ditampilkan di pop-up
  // final Function (int index) onChangePage;

  const TicketScreen({super.key, required this.ticketData,});

  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  @override
  // void initState() {
  //   super.initState();
  //   _showSuccessDialog(widget.ticketData);
  // }

  // void _showSuccessDialog(Map<String, String> ticketData) {
  //   print("Data ticket: $ticketData");
  //   Future.delayed(Duration.zero, () {
  //     showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) {
  //         return AlertDialog(
  //           backgroundColor: Colors.white,
  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Lottie.asset('assets/animasi/centang.json', width: 150, height: 150),
  //               const SizedBox(height: 10),
  //               const Text(
  //                 "Tiket Berhasil Dipesan!",
  //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //               ),
  //               const SizedBox(height: 10),
  //               Text("🎬 Judul: ${ticketData["title"]??'Tidak tersedia'}"),
  //               Text("🎟 Kursi: ${ticketData["seat"]??'Tidak tersedia'}"),
  //               Text("📅 Tanggal: ${ticketData["date"]??'Tidak tersedia'}"),
  //               Text("⏰ Waktu: ${ticketData["time"]??'Tidak tersedia'}"),
  //               Text("💲 Harga: Rp ${ticketData["price"]??'Tidak tersedia'}"),
  //               const SizedBox(height: 15),
  //               ElevatedButton(
  //                 onPressed: () {
  //                   Navigator.pop(context); // Tutup dialog
  //                 },
  //                 style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
  //                 child: const Text("OK"),
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.colorPrimary,
      appBar: AppBar(
        title: const Text('Your Tickets', style: TextStyle(color: Colors.white)),
        backgroundColor: ColorPallete.colorPrimary,
      ),
      body: BlocBuilder<TicketCubit, TicketState>(
        builder: (context, state) {
          if (state is TicketLoaded) {
            if (state.ticket.isEmpty) {
              return const Center(
                child: Text(
                  "No tickets available",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.ticket.length,
              itemBuilder: (context, index) {
                final ticket = state.ticket[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Struk(ticketData: {
                          "title": ticket.title,
                          "seat": ticket.seat,
                          "date": ticket.date.toString(),
                          "time": ticket.title, // Pastikan ada data time di TicketEntity
                          "price": ticket.price.toString(),
                        },  ),
                        
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                          child: Image.network(
                            ticket.urlimage,
                            width: 100,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ticket.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Seat: ${ticket.seat}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  "Date: ${ticket.date.toLocal()}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  "Price: \$${ticket.price.toStringAsFixed(2)}",
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // FloatingActionButton(
                        //   onPressed: () {
                            
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(builder:(context)=> HomePage(onChangePage: (int index) { 
                        //   setState(() {
                            
                        //   }
                        //   );
                        // },
                        // ) 
                        // )
                        // );
                        //                     })
                      ],
                    ),
                  ),
                  
                );
              
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        },
      ),
    );
  }
}
