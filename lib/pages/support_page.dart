import 'package:agrotaxi/routers/user_init.dart';
import 'package:flutter/material.dart';
import 'package:agrotaxi/custom_widgets/message_widget.dart';
import 'package:agrotaxi/custom_widgets/send_message_input_field.dart';
import 'package:agrotaxi/models/message_model.dart';
import 'package:agrotaxi/providers/firebase_providers/message_provider.dart';
import 'package:agrotaxi/providers/firebase_providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';

class SupportPage extends StatelessWidget {
  SupportPage({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Container(
      //     padding: EdgeInsets.all(4),
      //     width: 250,
      //     height: 70,
      //     child: Image.asset("assets/images/agrotaxi_logo.png"),
      //   ),
      // ),
      body: MessagesView(),
    );
  }
}

class MessagesView extends StatefulWidget {
  MessagesView({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MessagesView> {
  MessageModel newMessage = new MessageModel();
  MessageProvider _messageProvider = new MessageProvider();
  List<MessageModel> _messages = new List<MessageModel>();
  String uid;
  final ScrollController _scrollController = new ScrollController();
  final TextEditingController _textEditingController =
      new TextEditingController();
  final FocusNode _keyboardFocusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    UserInit().isRegistered().then((uid) {
      this.uid = uid;

      UserProvider _userProvider = new UserProvider();
      _userProvider.getUserDetails(uid).then((userModel) {
        newMessage.sendBy = userModel;
        newMessage.sendBy.uid = uid;
      });

      _getMessages().then((onValue) {
        setState(() {});
      });
    });
  }

  Future<void> _getMessages() async {
    var msgs = await _messageProvider.getMessages(uid);
    _messages = msgs.reversed.toList();
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: GestureDetector(
        onTap: () {
          _keyboardFocusNode.unfocus();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(10),
                shrinkWrap: true,
                reverse: true,
                controller: _scrollController,
                dragStartBehavior: DragStartBehavior.down,
                itemCount: _messages.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_messages == null || _messages.isEmpty) {
                    return Container();
                  }
                  return MessageWidget(model: _messages[index]);
                },
              ),
            ),
            SendMessageInputField(
              textEditingController: _textEditingController,
              keyboardFocusNode: _keyboardFocusNode,
              onFieldValueChanged: (value) {
                this.newMessage.messageText = value;
              },
              onSendButtonPressed: () {
                newMessage.sendDate = Timestamp.now();
                newMessage.isReceivedMessage = false;
                _messageProvider.sendMessage(newMessage).then((onValue) {
                  _getMessages().then((value) {
                    setState(() {});
                  });
                });
                _textEditingController.clear();
                _keyboardFocusNode.unfocus();
              },
            ),
          ],
        ),
      ),
    );
  }
}
