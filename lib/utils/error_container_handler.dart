abstract class ErrorContainerHandler {
  static const String MESSAGE_EKY = "message";
  static const String ADDITIONAL_MESSAGE_KEY = "additional_message";

  Map? errorContainer;

  getError() => errorContainer?[MESSAGE_EKY] ?? "";

  getAdditionalError() => errorContainer?[ADDITIONAL_MESSAGE_KEY] ?? "";
}
