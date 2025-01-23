import 'package:flutter/material.dart';

enum LoadinSatate {
  initial,
  loading,
  error,
  done,
}

class ChatScreenViewState {
  final bool isLoading;
  List<({Image? image, String? text, bool fromUser})> generatedContent =
      <({Image? image, String? text, bool fromUser})>[];
  final String apiKey;
  final LoadinSatate loadingState;

  ChatScreenViewState({
    this.isLoading = false,
    this.generatedContent = const <({
      Image? image,
      String? text,
      bool fromUser
    })>[],
    this.apiKey = 'AIzaSyBDF70P8EnVHT29pcWd2S7omYcjlG6t2_U',
    this.loadingState = LoadinSatate.initial,
  });

  ChatScreenViewState copyWith({
    bool? isLoading,
    List<({Image? image, String? text, bool fromUser})>? generatedContent,
    LoadinSatate? loadingState,
  }) {
    return ChatScreenViewState(
      isLoading: isLoading ?? this.isLoading,
      generatedContent: generatedContent ?? this.generatedContent,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
