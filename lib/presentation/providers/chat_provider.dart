

import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

//El changenotifier puee notificar cuanod hay cambios.
class ChatProvider extends ChangeNotifier {

  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();
  final ScrollController chatScrollController = ScrollController();

  List <Message> messageList = [
    Message(text: 'Hola amor!', fromWho: FromWho.me),
    Message(text: 'Ya regresaste del trabajo?', fromWho: FromWho.me),
  ];

  Future<void> sendMessage(String text) async {

    if(text.isEmpty) return; // Si el texto está vacío, no hacemos nada
    
    final newMessage = Message(
      text: text,
      fromWho: FromWho.me,
    );
    messageList.add(newMessage);

    if(text.endsWith('?')){
      await herReply();
    }

    notifyListeners(); // Notifica a los widgets que escuchan este provider
    moveScrollToBottom(); // Mueve el scroll al final de la lista

  }

  Future<void> herReply() async{
    final  herMessage = await getYesNoAnswer.getAnswer();
    messageList.add(herMessage);
    notifyListeners(); // Notifica a los widgets que escuchan este provider
    moveScrollToBottom(); // Mueve el scroll al final de la lista
  }

  Future<void> moveScrollToBottom() async{

    //esperamos unas milesimas de segundo para que el widget se reconstruya
    await Future.delayed(const Duration(milliseconds: 100));

    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

}