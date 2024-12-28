import 'package:chatapp/Service/chat/chat_service.dart';
import 'package:chatapp/components/chat_bubble.dart';
import 'package:chatapp/components/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatPage extends StatefulWidget {
  final String recieverUserEmail;
  final String recieverUserId;
  const ChatPage({super.key, required this.recieverUserEmail, required this.recieverUserId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController=TextEditingController();
  final ChatService _chatService=ChatService();
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  void sendMessage()async{
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(widget.recieverUserId, _messageController.text);
      _messageController.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.recieverUserEmail),),
      body: Column(
        children: [
          Expanded(child: _builMessageList()),
          _buildMessageInput()
        ],
      ),
    );
  }
  Widget _builMessageList(){
    return StreamBuilder(stream: _chatService.getMessage(widget.recieverUserId,
        _firebaseAuth.currentUser!.uid), builder: (context,snapshot){
      if(snapshot.hasError){
        return Text("Error"+snapshot.hasError.toString());
      }if(snapshot.connectionState==ConnectionState.waiting){
        return Text("Loading");
      }
      return ListView(
        children: snapshot.data!.docs.map((document)=>_buildMessageItem(DocumentSnapshot,document)).toList(),
      );
    });
  }
  Widget _buildMessageItem(DocumentSnapshot,document){
    Map<String,dynamic>data=document.data()as Map<String,dynamic>;
    var alignment=(data['senderId']==_firebaseAuth.currentUser!.uid)?Alignment.centerRight:Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Column(
        children: [
          Text(data['senderEmail'],style: TextStyle(fontSize: 15),),
          ChatBubble(message: data['message'])
        ],
      ),
    );
  }Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: textfield(
              Controller: _messageController, // Corrected property name
              hintText: "Enter message",
              obscuretext: false, // Fixed casing
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.arrow_upward,
              size: 30,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

}