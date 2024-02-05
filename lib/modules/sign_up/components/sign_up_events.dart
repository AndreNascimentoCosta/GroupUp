enum SignUpEvents {
  pressRequestCodeAgain('press_request_code_again'),

  pressBackButtonSignUp('press_back_button_sign_up'), 

  pressNextButtonSignUp('press_next_button_sign_up'),

  setUserName('set_user_name');

  final String value;

  const SignUpEvents(this.value);
}