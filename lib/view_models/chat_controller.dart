import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/ai_doctor_model.dart';

class ChatController extends GetxController {
  var messages = <ChatMessage>[].obs;
  var isLoading = false.obs;
  final String apiKey = dotenv.env['GEMINI_API_KEY']!;
  final firestore = FirebaseFirestore.instance;

  String? currentChatId;




  final RxList<String> currentMessages = <String>[].obs;
  final RxList<Map<String, dynamic>> chatHistory = <Map<String, dynamic>>[].obs;

  final RxList<String> storedMessages = <String>[].obs;  // You can change this to Map if needed


  VoidCallback? scrollCallback; // ✅ For scroll trigger after bot reply





  // Start a new chat and save previous chat to Firebase
  Future<void> startNewChat() async {

    isLoading.value = true;

    if (chatHistory.isEmpty) {
      isLoading.value = false;
      return; // ✅ Don't create a chat if no message exists
    }

    final chatId = firestore.collection('chat_history').doc().id;
    currentChatId = chatId;

    final chat = {
      'messages': List.from(currentMessages),
      'firstMessage': currentMessages.isNotEmpty ? currentMessages.first : '',
      'timestamp': DateTime.now().toIso8601String(),
    };

    final chatRef = firestore.collection('chat_history').doc(chatId);
    await chatRef.set(chat);

    if (currentMessages.isNotEmpty) {
      await chatRef.collection('messages').add({
        'sender': 'user',
        'message': currentMessages.first,
        'timestamp': DateTime.now(),
      });
    }

    await fetchChats();
    chatHistory.insert(0, {...chat, 'chatId': chatId});
    currentMessages.clear();

    // ✅ Add this line
    listenToMessages(chatId);

    isLoading.value = false; // Stop loading once complete


  }



  void loadChat(int index) {
    final chat = chatHistory[index];
    final chatId = chat['chatId'];

    currentChatId = chatId;

    firestore
        .collection('chat_history')
        .doc(chatId)
        .collection('messages')
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        currentMessages.value = snapshot.docs.map((doc) => doc['message'].toString()).toList();
      }
    });

    listenToMessages(chatId); // Start listening to this chat's messages
  }


  // Fetch chats from Firebase
  Future<void> fetchChats() async {
    try {
      final snapshot = await firestore
          .collection('chat_history')
          .orderBy('timestamp', descending: true)
          .limit(10)  // Limit to most recent 10 chats
          .get();

      // Update chatHistory with chatId and other details
      chatHistory.value = snapshot.docs.map((doc) {
        final chatData = doc.data();
        final chatId = doc.id; // Fetch the unique chat ID
        return {...chatData, 'chatId': chatId}; // Include chatId in the data
      }).toList();
    } catch (e) {
      print("Error fetching chats: $e");
      // Optionally show a message to the user
    }
  }


  void clearMessages() {

    isLoading.value = true;

    messages.clear();        // clears Firebase-based live chat
    currentMessages.clear(); // clears local messages for history saving
    storedMessages.clear();  // Also clear stored messages


    isLoading.value = false; // Stop loading once complete

  }

  @override
  void onInit() {
    super.onInit();
    initChat();
  }

  Future<void> initChat() async {
    await fetchChats();

    if (chatHistory.isNotEmpty) {
      final latestChat = chatHistory.first;
      final chatId = latestChat['chatId'];
      currentChatId = chatId;

      // Load its messages
      firestore
          .collection('chat_history')
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp')
          .get()
          .then((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          currentMessages.value = snapshot.docs.map((doc) => doc['message'].toString()).toList();
          storedMessages.addAll(currentMessages); // Add to stored messages for access

        }

      });

      listenToMessages(chatId);
    }
  }





  StreamSubscription? messageSubscription;

  void listenToMessages(String chatId) {
    messageSubscription?.cancel(); // cancel previous listener

    messageSubscription = firestore
        .collection('chat_history')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .listen((snapshot) {
      messages.value = snapshot.docs.map((doc) => ChatMessage.fromMap(doc.data())).toList();

      storedMessages
        ..clear()
        ..addAll(messages.map((msg) => msg.message).toList());

      scrollCallback?.call();
    });
  }

  @override
  void onClose() {
    messageSubscription?.cancel();
    super.onClose();
  }

  void sendMessage2(String message) {
    currentMessages.add(message);
    storedMessages.add(message); // Store the message in storedMessages
  }





  Future<void> sendMessage(String msg) async {
    final now = DateTime.now();

    // If no chat exists → create one
    if (currentChatId == null) {
      // Create chatHistory doc
      final chatDoc = firestore.collection('chat_history').doc();
      currentChatId = chatDoc.id;

      // Create the initial chat document with first message
      await chatDoc.set({
        'timestamp': now.toIso8601String(),
        'firstMessage': msg,
      });



      // Create messages subcollection & add first message
      await chatDoc.collection('messages').add({
        'sender': 'user',
        'message': msg,
        'timestamp': now,
      });




      isLoading.value = true;
      // Wait for bot response
      final botResponse = await fetchBotReply(msg);
      isLoading.value = false;

      // Add bot response after receiving the reply
      await firestore
          .collection('chat_history')
          .doc(currentChatId)
          .collection('messages')
          .add({
        'sender': 'bot',
        'message': botResponse,
        'timestamp': DateTime.now(),
      });

      // Optionally fetch updated chat list after bot's response
      await fetchChats();
      listenToMessages(currentChatId!); // Pass the current chat ID

    } else {
      // Chat already exists → just add user message
      await firestore
          .collection('chat_history')
          .doc(currentChatId)
          .collection('messages')
          .add({
        'sender': 'user',
        'message': msg,
        'timestamp': now,
      });

      // Wait for bot response
      isLoading.value = true;
      final botResponse = await fetchBotReply(msg);
      isLoading.value = false;

      // Add bot response after receiving the reply
      await firestore
          .collection('chat_history')
          .doc(currentChatId)
          .collection('messages')
          .add({
        'sender': 'bot',
        'message': botResponse,
        'timestamp': DateTime.now(),
      });
    }
  }


  Future<String> fetchBotReply(String prompt) async {
    final url = Uri.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "contents": [
          {
            "role": "user",
            "parts": [
              {"text": prompt}
            ]
          }
        ]
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      try {
        var content = data['candidates'][0]['content']['parts'][0]['text'];
        return content ?? "No response.";
      } catch (e) {
        return "Error parsing response: $e";
      }
    } else {
      return "Error: ${data['error']['message'] ?? "Unknown error"}";
    }
  }


  Future<void> deleteChat(String chatId) async {
    try {
      // Delete the chat from the 'chat_history' collection
      await FirebaseFirestore.instance.collection('chat_history').doc(chatId).delete();

      // Optionally, also delete messages associated with this chat (if needed)
      // await FirebaseFirestore.instance.collection('chat_history').doc(chatId).collection('messages').get().then((snapshot) {
      //   for (var doc in snapshot.docs) {
      //     doc.reference.delete();
      //   }
      // });


      // Remove the chat from local chatHistory list
      chatHistory.removeWhere((chat) => chat['chatId'] == chatId);

      // You can trigger an update or notify listeners here if needed
      update(); // Update the UI
    } catch (e) {
      print("Error deleting chat: $e");
    }
  }
}
