import 'package:bloc/bloc.dart';
import 'package:cinema_app/domain/entities/ticket.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  TicketCubit() : super(TicketInitial());

  Future<void> loadTicket() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? dataTicket = pref.getStringList('ticket')??[];

    List<TicketEntity> ticket = dataTicket
        .map((ticketJson) => TicketEntity.fromJson(ticketJson))
        .toList();

    emit(TicketLoaded(ticket: ticket));
  }

  Future<void> addticket(TicketEntity ticket) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> dataTicket = pref.getStringList('ticket')??[];

    dataTicket.add(ticket.toJson());
    pref.setStringList('ticket', dataTicket);

    loadTicket();
  }
}
