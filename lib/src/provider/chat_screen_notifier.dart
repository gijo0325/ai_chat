import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_chat/src/provider/chat_screen_state.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

final aiChatProvider =
    StateNotifierProvider<ChatScreenNotifier, ChatScreenViewState>(
  (ref) => ChatScreenNotifier(),
);

class ChatScreenNotifier extends StateNotifier<ChatScreenViewState> {
  ChatScreenNotifier() : super(ChatScreenViewState()) {
    init();
  }

  late final GenerativeModel model;
  late final ChatSession chat;

  init() {
    model = GenerativeModel(
      model: 'gemini-2.0-flash-exp',
      apiKey: state.apiKey,
    );
    chat = model.startChat();
  }

  Future<void> sendChatMessage(String message) async {
    state = state.copyWith(isLoading: true, loadingState: LoadinSatate.loading);

    try {
      state = state.copyWith(
        generatedContent: [
          ...state.generatedContent,
          (image: null, text: message, fromUser: true),
        ],
      );
      final response = await chat.sendMessage(
        Content.text(message),
      );
      final text = response.text;
      state = state.copyWith(
        generatedContent: [
          ...state.generatedContent,
          (image: null, text: text, fromUser: false),
        ],
      );

      if (text == null) {
        // _showError('No response from API.');
        return;
      } else {
        state =
            state.copyWith(isLoading: false, loadingState: LoadinSatate.done);
        // _scrollDown();
      }
    } catch (e) {
      // _showError(e.toString());
      state = state.copyWith(isLoading: false, loadingState: LoadinSatate.done);
    } finally {
      // _textController.clear();
      state = state.copyWith(isLoading: false, loadingState: LoadinSatate.done);
      // _textFieldFocus.requestFocus();
    }
  }

  void resetLoading() {
    state = state.copyWith(loadingState: LoadinSatate.initial);
  }
}
