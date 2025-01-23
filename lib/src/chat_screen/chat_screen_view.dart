import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_chat/src/message_screen/message_screen.dart';
import 'package:g_chat/src/provider/chat_screen_notifier.dart';
import 'package:g_chat/src/provider/chat_screen_state.dart';

class ChatScreenView extends ConsumerStatefulWidget {
  static const routeName = '/chat';

  const ChatScreenView({
    super.key,
  });

  @override
  ChatScreenViewState createState() => ChatScreenViewState();
}

class ChatScreenViewState extends ConsumerState<ChatScreenView> {
  String routeName = '/chat';
  final ScrollController scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();
  final FocusNode textFieldFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  void scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.easeOutCirc,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final state = ref.watch(aiChatProvider);
    final notifier = ref.watch(aiChatProvider.notifier);

    final textFieldDecoration = InputDecoration(
      hintText: 'Write a message...',
      hintStyle: TextStyle(
        color: const Color(0xffffffff),
        fontSize: screenWidth * 0.04, // Dynamic font size
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(
          color: Color.fromARGB(58, 255, 255, 255),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(
          color: Color.fromARGB(58, 255, 255, 255),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(
          color: Color.fromARGB(58, 255, 255, 255),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.03, // Increased vertical padding
        horizontal: screenWidth * 0.05, // Horizontal padding
      ),
      suffixIcon: GestureDetector(
        onTap: () => {
          notifier.sendChatMessage(textController.text),
          textController.clear(),
          textFieldFocus.requestFocus(),
          scrollDown(),
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/sent_button.png',
            height: 36,
            width: 36,
          ),
        ),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.loadingState != LoadinSatate.initial) {
        if (state.loadingState == LoadinSatate.done) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(
              milliseconds: 750,
            ),
            curve: Curves.easeOutCirc,
          );
        }
        notifier.resetLoading();
      }
    });

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.black,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: screenHeight * 0.02), // Dynamic spacing
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          screenWidth * 0.05, // Responsive horizontal padding
                      vertical:
                          screenHeight * 0.01, // Responsive vertical padding
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        SizedBox(width: screenWidth * 0.2), // Dynamic spacing
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Ai Chat',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.05, // Dynamic font size
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Spacer(), // Pushes everything else to the left
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: state.apiKey.isNotEmpty
                  ? ListView.builder(
                      controller: scrollController,
                      itemBuilder: (context, idx) {
                        final content = state.generatedContent[idx];
                        return MessageWidget(
                          text: content.text,
                          image: content.image,
                          isFromUser: content.fromUser,
                          isLoading: state.isLoading &&
                              idx == state.generatedContent.length - 1,
                        );
                      },
                      itemCount: state.generatedContent.length,
                    )
                  : ListView(
                      children: const [
                        Text(
                          'No API key found. Please provide an API Key using '
                          "'--dart-define' to set the 'API_KEY' declaration.",
                        ),
                      ],
                    ),
            ),
            TextFormField(
              controller: textController,
              focusNode: textFieldFocus,
              decoration: textFieldDecoration,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.04, // Dynamic font size
              ),
            ),
          ],
        ),
      ),
    );
  }
}
