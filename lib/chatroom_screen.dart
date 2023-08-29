import 'package:chat_room/model/message_model.dart';

import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final List<Message> messagesList = [
    Message(
        date: DateTime.now().subtract(const Duration(minutes: 1)),
        isSentByMe: true,
        text: "Thanks for contacting us"),
    Message(
        date: DateTime.now().subtract(const Duration(minutes: 1)),
        isSentByMe: true,
        text: "How may I help you")
  ];
  final TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 61, 95),
        elevation: 0,
        title: const Text("Support",
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(
          child: GroupedListView<Message, DateTime>(
            reverse: false,
            order: GroupedListOrder.ASC,
            useStickyGroupSeparators: true,
            floatingHeader: true,
            padding: const EdgeInsets.all(8),
            elements: messagesList,
            groupBy: (message) => DateTime(
                message.date.year, message.date.month, message.date.day),
            groupHeaderBuilder: (Message message) => SizedBox(
              height: 40,
              child: Center(
                child: Card(
                    child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          DateFormat.yMMMd().format(message.date),
                        ))),
              ),
            ),
            itemBuilder: (context, Message message) => Align(
                alignment: message.isSentByMe
                    ? Alignment.centerLeft
                    : Alignment.centerLeft,
                child: message.isSentByMe
                    ? buildMessageField(
                        message,
                        const Color.fromARGB(255, 217, 214, 214),
                        const Color.fromARGB(255, 21, 61, 95),
                        "Support",
                        BubbleNip.leftTop)
                    : Align(
                        alignment: message.isSentByMe
                            ? Alignment.centerRight
                            : Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            buildMessageField(
                                message,
                                const Color.fromARGB(255, 21, 61, 95),
                                const Color.fromRGBO(238, 238, 238, 1),
                                "Ktech",
                                BubbleNip.rightTop),
                            const CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/profileImg.jpg"),
                            ),
                          ],
                        ),
                      )),
          ),
        ),
        sendMessageField(),
        const SizedBox(height: 40),
      ]),
    );
  }

  Container sendMessageField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.grey[200],
      child: Row(
        children: [
          const Row(
            children: [
              Icon(
                Icons.image,
                color: Color.fromARGB(255, 21, 61, 95),
              ),
              Icon(FontAwesomeIcons.ellipsisVertical,
                  color: Color.fromARGB(255, 21, 61, 95)),
              Icon(Icons.camera_alt, color: Color.fromARGB(255, 21, 61, 95)),
            ],
          ),
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  border: InputBorder.none,
                  hintText: 'Type to start chat'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 21, 61, 95)),
              child: Center(
                child: IconButton(
                  icon:
                      const Icon(Icons.arrow_forward_ios_sharp, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      messagesList.add(Message(
                          date: DateTime.now(),
                          text: messageController.text,
                          isSentByMe: false));
                      messageController.clear();
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Bubble buildMessageField(Message message, Color textColor, Color bgColor,
      String title, dynamic nip) {
    return Bubble(
      //style: styleMe,

      nip: nip,
      radius: const Radius.circular(10),
      margin: const BubbleEdges.symmetric(horizontal: 10, vertical: 4),

      color: bgColor,
      child: Padding(
          padding: const EdgeInsets.all(12),
          child: Expanded(
              child: Container(
            decoration: const BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20, color: textColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(message.text,
                    maxLines: 5, style: TextStyle(color: textColor)),
              ],
            ),
          ))),
    );
  }
}
