enum SignUpEvents {
  pressRequestCodeAgain('press_request_code_again'),

  pressBackButtonSignUp('press_back_button_sign_up');

  final String value;

  const SignUpEvents(this.value);
}