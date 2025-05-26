import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:share_plus/share_plus.dart';
import '../res/colors/app_color.dart';
import '../res/media-queries/media_query.dart';
import '../res/widgets/custom_drawer.dart';
import '../res/widgets/customteextfield2.dart';
import '../view_models/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());
  final TextEditingController inputController = TextEditingController();
  final ScrollController scrollController = ScrollController(); // Add this

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextFieldFocusController searchController2 = Get.put(TextFieldFocusController());



  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.scrollCallback = scrollToBottom;
    final mediaQuery = MediaQueryHelper(context);

    return GestureDetector(

        onTap: () {
          searchController2.unfocus(); // calls focusNode.unfocus()

          FocusScope.of(context).unfocus(); // closes keyboard smoothly
        },

      child: Scaffold(
        key: _scaffoldKey,

        resizeToAvoidBottomInset: true,
        // appBar: AppBar(title: Text("DeepSeek ChatBot")),
        drawer: CustomDrawer(), // ✅ Use your custom drawer here
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: mediaQuery.paddingOnly(left: 8, top: 6,right: 2),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: InkWell(
                        onTap: (){
                          _scaffoldKey.currentState?.openDrawer(); // ✅ Open the drawer using the key

                        },

                          child: Image.asset('assets/images/menu.png', width: 20,color: Color(0xff757474),)),

                      ),
                    ),
                  ),

                Padding(
                  padding: mediaQuery.paddingOnly(right: 4, top: 6),
                  child: Text(
                    'MediLane',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff757474),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                Padding(
                  padding: mediaQuery.paddingOnly(right: 12, top: 6),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child:PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'delete') {
                              // Perform delete action

                              // controller.deleteChat(chatId);

                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'edit',
                              child: InkWell(
                                onTap: () {
                                  final controller = Get.find<ChatController>();
                                  controller.startNewChat();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon( FontAwesomeIcons.plus,color: Colors.grey,),
                                    SizedBox(width: 2,),
                                    Text("New Chat",style: TextStyle(fontSize: 14,color: Colors.grey),)
                                  ],
                                ),
                              ),                        ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon( FontAwesomeIcons.trash,color: Colors.red,),
                                  Text("Delete",style: TextStyle(fontSize: 14,color: Colors.red),)
                                ],
                              ),
                            ),
                          ],
                          child: Icon(
                            Icons.more_horiz,
                            color: Color(0xffCBCCCD),
                            size: 40,
                          ),
                        )

                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Obx(() {
                if (controller.chatHistory.isEmpty) {
                  return SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: mediaQuery.height(10)),
                          Text(
                            'MediLane',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff757474),
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(height: mediaQuery.height(6)),
                          Container(
                            height: mediaQuery.height(
                              14,
                            ), // set your desired height
                            width: mediaQuery.width(90), // set your desired width
                            child: Card(
                              color: Colors.grey[150], // light grey color
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 24.0,
                                ),
                                child: Center(
                                  child: Text(
                                    'Remembers what user said earlier in the conversation',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffA0A0A5),
                                      fontFamily: "poppins",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: mediaQuery.height(1)),

                          Container(
                            height: mediaQuery.height(
                              14,
                            ), // set your desired height
                            width: mediaQuery.width(90), // set your desired width
                            child: Card(
                              color: Colors.grey[150], // light grey color
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 24.0,
                                ),
                                child: Center(
                                  child: Text(
                                    "Allows user to provide follow-up corrections With Ai",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffA0A0A5),
                                      fontFamily: "poppins",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: mediaQuery.height(1)),

                          Container(
                            height: mediaQuery.height(
                              14,
                            ), // set your desired height
                            width: mediaQuery.width(90), // set your desired width
                            child: Card(
                              color: Colors.grey[150], // light grey color
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 24.0,
                                ),
                                child: Center(
                                  child: Text(
                                    "Limited knowledge of world and events after 2021",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffA0A0A5),
                                      fontFamily: "poppins",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                else {
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      final msg = controller.messages[index];
                      bool isUser = msg.sender == 'user';

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                          children: [
                            if (!isUser)
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.transparent, // or Colors.white, Colors.grey[200], etc.

                                backgroundImage: msg.sender == 'user'
                                    ? AssetImage('assets/images/user_profile.jpg') // Use an actual image asset for the user
                                    : null, // No image for sender (can leave empty or use a default one)
                                child: msg.sender != 'user'
                                    ? SvgPicture.asset(
                                  'assets/images/Logo.svg', // Your chatbot image for sender
                                  height: 40, // Adjust size as needed
                                )
                                    : null, // No icon for user (can leave null)
                              ),

                            SizedBox(width: 8),
                            Flexible(
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                padding: EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: isUser ? Color(0xff757474) : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Message text
                                    Expanded(
                                      child: Text(
                                        msg.message,
                                        style: TextStyle(fontSize: 12, fontFamily: "poppins"),
                                      ),
                                    ),
                                    SizedBox(width: 8),

                                    // Action icons: copy, edit (if user), and share
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Clipboard.setData(ClipboardData(text: msg.message));
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text("Copied to clipboard")),
                                            );
                                          },
                                          child: Icon(Icons.copy, size: 16, color: Colors.grey[700]),
                                        ),
                                        SizedBox(height: 6),
                                        if (isUser)
                                          InkWell(
                                            onTap: () {
                                              // Edit logic here
                                              inputController.text = msg.message;
                                            },
                                            child: Icon(Icons.edit, size: 16, color: Colors.grey[700]),
                                          ),
                                        SizedBox(height: 6),
                                        InkWell(
                                          onTap: () {
                                            SharePlus.instance.share(
                                                ShareParams(text: 'check out my website https://example.com')
                                            );                                      },
                                          child: Icon(Icons.share, size: 16, color: Colors.grey[700]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            if (isUser)
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage("assets/images/saad.jpg"), // Replace with dynamic image URL
                              ),
                          ],
                        ),
                      );
                    },
                  );
                }
              }),
            ),
            Obx(
                  () =>
              controller.isLoading.value
                  ? Padding(
                padding: EdgeInsets.all(8),
                child: Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.black,
                    size: 50,
                  ),
                ),
              )
                  : SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child:  CustomTextField2(



                        hintText: "Search",
                        controller: inputController,
                        width: mediaQuery.width(9),
                        height: mediaQuery.height(7),
                        fillColor: Colors.grey.shade100,
                        borderColor: Color(0xffDDDDE4),
                        prefixIcon: Icon(FontAwesomeIcons.search, size: 18),
                        // focusNode: searchController2.focusNode,
                        focusNode: searchController2.focusNode, // ← Use only one focus node




                      ),
                      // child: TextField(
                      //   controller: inputController,
                      //   style: TextStyle(fontSize: 16, color: Colors.black87),
                      //   decoration: InputDecoration(
                      //     contentPadding: EdgeInsets.symmetric(
                      //       vertical: 14,
                      //       horizontal: 16,
                      //     ),
                      //     hintText: "Ask something ...",
                      //     hintStyle: TextStyle(color: Colors.grey[500]),
                      //     filled: true,
                      //     fillColor: Colors.grey[100],
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //       borderSide: BorderSide.none,
                      //     ),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //       borderSide: BorderSide(color: Colors.grey.shade300),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //       borderSide: BorderSide(
                      //         color: Color(0xffDDDDE4),
                      //         width: 1.5,
                      //       ),
                      //     ),
                      //
                      //   ),
                      // ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send_outlined, color: Colors.black,),
                    onPressed: () {
                      final text = inputController.text.trim();
                      if (text.isNotEmpty) {
                        controller.sendMessage(text);
                        inputController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
