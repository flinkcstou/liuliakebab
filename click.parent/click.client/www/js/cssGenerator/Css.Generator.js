widthK = window.innerWidth / 720;
heightK = window.innerHeight / 1232;
if (device.platform == 'iOS') {
  heightK = (window.innerHeight - 20) / 1232;
  heightOfMobile = window.innerHeight - 20;
}
else {
  heightK = window.innerHeight / 1232;
  heightOfMobile = window.innerHeight;
}

var css = {
  sfuiDisplay: "@font-face " +
  "{" +
  "font-family: 'SFUIDisplay-Light';" +
  "src: url('resources/font/SFUIDisplay/SFUIDisplay-Light.otf');" +
  "format: ('opentype');" +
  "font-weight: normal;" +
  "font-style: normal;" +
  "}",

  orator: "@font-face " +
  "{" +
  "font-family: 'Orator';" +
  "src: url(resources/font/Orator/OratorStd.otf);" +
  "format: ('opentype');" +
  "font-weight: normal;" +
  "font-style: normal;" +
  "}",

  html: "html" +
  "{ " +
  "-webkit-user-select: none; " +
  "-webkit-touch-callout: none; " +
  "-webkit-user-drag: none; " +
  "-webkit-tap-highlight-color:rgba(0,0,0,0);" +
  "text-decoration:none;" +
  "color:inherit;" +
  " font-size:" + 32 * widthK + "px;" +
  "}",
  htmlId: "#htmlId " +
  "{" +
  "width: 100%;" +
  "height: 100%;" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
    //"background-image: url(resources/draft/mainform.png);" +
    //"opacity: 0.6;" +
  "background-image: -moz-linear-gradient(rgb(1,124,227) 0%, rgb(21,181,243) 60%, rgb(21,181,243) 100%);" +
  "background-image: -webkit-linear-gradient(rgb(1,124,227) 0%, rgb(21,181,243) 60%, rgb(21,181,243) 100%);" +
  "background-image: -ms-linear-gradient(rgb(1,124,227) 0%, rgb(21,181,243) 60%, rgb(21,181,243) 100%);" +
  "font-family: SFUIDisplay-Light;" +
  "margin: 0;" +
  "overflow: hidden;" +
  "bottom: 0;" +
  "}",
  body: "body{" +
  "margin: 0;" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + heightOfMobile + "px;" +
  "margin: 0;" +
  "overflow: hidden;" +
  "bottom: 0;" +
  "}",
  input: "input " +
  "{" +
  "font-family: Neuron;" +
  "font-size:" + 24 * widthK + "px;" +
  "}",

  //VIEW REGISTRATION DEVICE

  viewRegistrationDevice: ".view-registration-device " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 100%;" +
  "overflow: hidden;" +
  "background-image: url('resources/icons/background/transparent.png');" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "}",
  registrationDeviceFlexContainer: ".registration-device-flex-container " +
  "{" +
  "position: absolute;" +
  "top: 0;" +
  "bottom:" + 645 * widthK + "px;" +
  "width: 100%;" +
  "display: flex;" +
  "}",
  registrationDeviceUnchanbgableContainer: ".registration-device-unchangable-container " +
  "{" +
  "width: 100%;" +
  "position: absolute;" +
  "height:" + 320 * widthK + "px;" +
    //"top:" + 155 * heightK + "px;" +
  "bottom:" + 17 + "%;" +
  "}",
  registrationDevicePhoneField: ".registration-device-phone-field " +
  "{" +
  "position: absolute;" +
  "left:" + 80 * widthK + "px;" +
  "width:" + 560 * widthK + "px;" +
  "height:" + 107 * widthK + "px;" +
  "border-bottom:" + 6 * widthK + "px solid rgba(163, 222, 238, 0.95);" +
  "bottom:" + 210 * widthK + "px;" +
  "color: white;" +
  "}",
  registrationDeviceTextField: ".registration-device-text-field " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "}",
  registrationDevicePhoneInput: ".registration-device-phone-input " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "top:" + 30 * widthK + "px;" +
  "font-size:" + 64 * widthK + "px;" +
  "}",
  registrationDeviceRemember: ".registration-device-remember " +
  "{" +
  "position: absolute;" +
  "top:" + 110 * widthK + "px;" +
  "width: 100%;" +
  "height:" + 100 * widthK + "px;" +
  "}",
  registrationDeviceRememberLabel: ".registration-device-remember-label " +
  "{" +
  "position: absolute;" +
  "color: #4bd5ff;" +
  "top:" + 32 * widthK + "px;" +
  "width:" + 340 * widthK + "px;" +
  "margin: 0;" +
  "font-size:" + 32 * widthK + "px;" +
  "}",
  registrationRememberIcon: ".registration-device-remember-icon " +
  "{" +
  "position: absolute;" +
  "background-image: url(resources/icons/authorization/remember.png);" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "width:" + 52 * widthK + "px;" +
  "height:" + 72 * widthK + "px;" +
  "left:" + 490 * widthK + "px;" +
  "top:" + 30 * widthK + "px;" +
  "opacity: 0.3;" +
  "}",


  buttonEnter: ".button-enter " +
  "{" +
  "position: relative;" +
  "width:" + 440 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "background-color: #01cfff;" +
  "margin-right: auto;" +
  "border-radius:" + 80 * widthK + "px;" +
  "margin-left: auto;" +
  "}",

  buttonEnterLabel: ".button-enter-label " +
  "{" +
  "position: relative;" +
  "top: " + 20 * widthK + "px;" +
  "width:" + 120 * widthK + "px;" +
  "height:" + 40 * widthK + "px;" +
  "font-size:" + 44 * widthK + "px;" +
  "margin: auto;" +
  "color: white;" +
  "}",
  registrationButtonEnter: ".registration-button-enter " +
  "{" +
  "top:" + 230 * widthK + "px;" +
  "}",

  keyboardField: ".keyboard-field " +
  "{" +
  "position: absolute;" +
  "width:" + 500 * widthK + "px;" +
  "height:" + 500 * widthK + "px;" +
  "left:" + 110 * widthK + "px" +
  "}",

  registrationKeyboardField: ".registration-keyboard-field " +
  "{" +
  "position: absolute;" +
  "bottom:" + 150 * widthK + "px;" +
  "left:" + 110 * widthK + "px;" +
  "}",
  registrationButtonsContainer: ".registration-buttons-container " +
  "{" +
  "position: absolute;" +
  "width:" + 560 * widthK + "px;" +
  "bottom:" + -10 * widthK + "px;" +
  "left:" + 84 * widthK + "px;" +
  "}",
  registrationContainerOffline: ".registration-container-offline " +
  "{" +
  "position: absolute;" +
  "width:" + 300 * widthK + "px;" +
  "height:" + 140 * widthK + "px;" +
  "bottom: 0;" +
  "left: 0;" +
  "}",
  registrationButtonOffline: ".registration-button-offline " +
  "{" +
  "position: absolute;" +
  "font-size:" + 34 * widthK + "px;" +
  "background-size: contain;" +
  "color: white;" +
  "border-bottom:" + 2 * widthK + "px solid white;" +
  "bottom:" + 40 * widthK + "px;" +
  "text-align: center;" +
  "margin-left: 0;" +
  "margin-bottom:" + 14 * widthK + "px;" +
  "}",
  registrationContainerDemoVersion: ".registration-container-demo-version " +
  "{" +
  "position: absolute;" +
  "width:" + 300 * widthK + "px;" +
  "height:" + 140 * widthK + "px;" +
  "bottom: 0;" +
  "right: 0;" +
  "}",
  RegistrationButtonDemoVersion: ".registration-button-demo-version " +
  "{" +
  "position: absolute;" +
  "font-size:" + 34 * widthK + "px;" +
  "background-size: contain;" +
  "color: #b7f1ff;" +
  "border-bottom:" + 2 * widthK + "px solid #b7f1ff;" +
  "bottom:" + 40 * widthK + "px;" +
  "margin-left:" + 80 * widthK + "px;" +
  "margin-bottom:" + 14 * widthK + "px;" +
  "text-align: center;" +
  "}",
  registrationButtonHelp: ".registration-button-help " +
  "{" +
  "position: relative;" +
  "font-size:" + 34 * widthK + "px;" +
  "top:" + -30 * widthK + "px;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "width:" + 125 * widthK + "px;" +
  "background-size: contain;" +
  "color: #b7f1ff;" +
  "border-bottom:" + 2 * widthK + "px solid #b7f1ff;" +
  "}",
  registrationButtonRegistration: ".registration-button-registration " +
  "{" +
  "position: absolute;" +
  "top:" + 30 * widthK + "px;" +
  "right:" + 120 * widthK + "px;" +
  "font-size:" + 34 * widthK + "px;" +
  "background-size: contain;" +
  "color: white;" +
  "border-bottom:" + 2 * widthK + "px solid white;" +
  "}",
  registrationTextField: ".registration-text-field " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "top:" + -20 * widthK + "px;" +
  "left: 0;" +
  "text-align: center;" +
  "color: #4bd5ff;" +
  "font-size:" + 30 * widthK + "px;" +
  "margin: 0;" +
  "}",

  //KEYBOARD COMPONENT

  keyboardContainer: ".keyboard-container " +
  "{" +
  "position: absolute;" +
  "width:" + 500 * widthK + "px;" +
  "height:" + 400 * widthK + "px;" +
  "}",
  keyboardFieldOne: ".keyboard-field-one " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 120 * widthK + "px;" +
  "top: 0;" +
  "}",
  keyboardFieldTwo: ".keyboard-field-two " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 120 * widthK + "px;" +
  "top:" + 120 * widthK + "px;" +
  "}",
  keyboardFieldThree: ".keyboard-field-three " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 120 * widthK + "px;" +
  "top:" + 240 * widthK + "px;" +
  "}",
  keyboardFieldFour: ".keyboard-field-four " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 120 * widthK + "px;" +
  "top:" + 360 * widthK + "px;" +
  "}",
  keyboardFieldFive: ".keyboard-buttons " +
  "{" +
  "position: absolute;" +
  "width: " + 140 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "top:" + 16 * widthK + "px;" +
  "color: white;" +
  "font-size:" + 70 * widthK + "px;" +
  "text-align: center;" +
  "}",
  keyboardButtons: ".keyboard-buttons " +
  "{" +
  "position: absolute;" +
  "width:" + 140 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "top:" + 16 * widthK + "px;" +
  "color: white;" +
  "font-size:" + 70 * widthK + "px;" +
  "text-align: center;" +
  "}",
  keyboardButtonsLabel: ".keyboard-buttons-label " +
  "{" +
  "position: absolute;" +
  "left:" + 54 * widthK + "px;" +
  "top:" + 16 * widthK + "px;" +
  "margin: 0;" +
  "}",
  keyboardButtonsActive: ".keyboard-buttons:active " +
  "{" +
  "background: radial-gradient(rgba(255, 255, 255, 0.23), rgba(255, 255, 255, 0.04), transparent);" +
  "border-radius:" + 80 * widthK + "px;" +
  "}",
  keyboardButtonOne: ".keyboard-button-one {left: 0;}",
  keyboardButtonTwo: ".keyboard-button-two {left:" + 180 * widthK + "px;}",
  keyboardButtonThree: ".keyboard-button-three {right: 0;}",
  keyboardButtonFour: ".keyboard-button-four {left: 0;}",
  keyboardButtonFive: ".keyboard-button-five {left:" + 180 * widthK + "px;}",
  keyboardButtonSix: ".keyboard-button-six {right: 0;}",
  keyboardButtonSeven: ".keyboard-button-seven {left: 0;}",
  keyboardButtonEight: ".keyboard-button-eight {left:" + 180 * widthK + "px;}",
  keyboardButtonNine: ".keyboard-button-nine {right: 0;}",
  keyboardSpace: ".keyboard-space {left: 0;}",
  keyboardButtonZero: ".keyboard-button-zero {left:" + 180 * widthK + "px;}",
  keyboardButtonenter: ".keyboard-button-enter {position: absolute;}",

  keyboardButtonX: ".keyboard-button-x " +
  "{" +
  "background-size:" + 76 * widthK + "px;" +
  "background-image: url('resources/icons/keyboard/backspace.png');" +
  "background-repeat: no-repeat;" +
  "background-position-x:" + 20 * widthK + "px;" +
  "background-position-y: center;" +
  "right: 0;" +
  "top:" + 25 * widthK + "px;" +
  "}",

  //VIEW SMS

  viewSms: ".view-sms " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 100%;" +
  "overflow: hidden;" +
  "background-image: url('resources/icons/background/transparent.png');" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "}",

  smsFlexContainer: ".sms-flex-container" +
  "{" +
  "position: absolute;" +
  "top: 0;" +
  "bottom:" + 565 * widthK + "px;" +
  "width: 100%;" +
  "}",

  smsUnchangableContainer: ".sms-unchangable-container" +
  "{" +
  "width: 100%;" +
  "position: absolute;" +
  "height:" + 275 * widthK + "px;" +
  "bottom:" + 20 + "%" +
  "}",

  smsTextField: ".sms-text-field " +
  "{" +
  "position: relative;" +
  "text-align: center;" +
  "color: #b7f1ff;" +
  "top:" + 90 * widthK + "px;" +
  "font-size:" + 30 * widthK + "px;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "}",

  smsPhoneField: ".sms-phone-field " +
  "{" +
  "position: absolute;" +
  "top:" + 15 * widthK + "px;" +
  "left:" + 85 * widthK + "px;" +
  "width:" + 560 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "border-bottom:" + 6 * widthK + "px solid rgba(163, 222, 238, 0.95);" +
  "color: white;" +
  "}",

  smsTextFieldOne: ".sms-text-field-one " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "top:" + -20 * widthK + "px;" +
  "left: 0;" +
  "text-align: center;" +
  "color: #4bd5ff;" +
  "font-size:" + 30 * widthK + "px;" +
  "margin: 0;" +
  "}",

  smsPhoneInput: ".sms-phone-input " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "top:" + 30 * widthK + "px;" +
  "font-size:" + 64 * widthK + "px;" +
  "}",

  smsTimer: ".sms-timer " +
  "{" +
  "position: absolute;" +
  "width:" + 160 * widthK + "px;" +
  "height:" + 80 * widthK + "px;" +
  "margin: 0;" +
  "top:" + 40 * widthK + "px;" +
  "right:" + -40 * widthK + "px;" +
  "bottom: 0;" +
  "}",

  smsResendIcon: ".sms-resend-icon " +
  "{" +
  "position: absolute;" +
  "background-image: url(resources/icons/ViewSms/resend.png);" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "width:" + 80 * widthK + "px;" +
  "height:" + 44 * widthK + "px;" +
  "margin: 0;" +
  "left:" + 70 * widthK + "px;" +
  "top:" + -4 * widthK + "px;" +
  "}",

  //VIEW AUTHORIZATION

  viewAuthorization: ".view-authorization " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 100%;" +
  "overflow: hidden;" +
  "background-image: url('resources/icons/background/transparent.png');" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "}",

  authorizationFlexContainer: ".authorization-flex-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "top: 0;" +
  "bottom:" + 610 * widthK + "px;" +
  "}",

  authorizationUnchangableContainer: ".authorization-unchangable-container " +
  "{" +
  "position: absolute;" +
  "height:" + 110 * widthK + "px;" +
  "bottom: 50%;" +
  "width: 100%;" +
  "}",

  authorizationPinContainer: ".authorization-pin-container " +
  "{" +
  "position: relative;" +
  "width:" + 320 * widthK + "px;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "height:" + 100 * widthK + "px;" +
  "}",

  authorizationPinField: ".authorization-pin-field " +
  "{" +
  "position: relative;" +
  "height:" + 40 * widthK + "px;" +
  "width:" + 320 * widthK + "px;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "margin-top:" + 20 * widthK + "px;" +
  "}",

  authorizationPinCircle: ".authorization-pin-circles " +
  "{" +
  "position: absolute;" +
  "width:" + 34 * widthK + "px;" +
  "height:" + 34 * widthK + "px;" +
  "border-radius:" + 40 * widthK + "px;" +
  "border:" + 4.5 * widthK + "px solid #01cfff;" +
  "}",

  authorizationPinTwo: ".authorization-pin-two " +
  "{" +
  "left:" + 70 * widthK + "px;" +
  "}",

  authorizationPinThree: ".authorization-pin-three " +
  "{" +
  "left:" + 140 * widthK + "px;" +
  "}",

  authorizationPinFour: ".authorization-pin-four " +
  "{" +
  "left:" + 210 * widthK + "px;" +
  "}",

  authorizationPinFive: ".authorization-pin-five " +
  "{" +
  "left:" + 280 * widthK + "px;" +
  "}",

  authorizationKeyboardField: ".authorization-keyboard-field " +
  "{" +
  "bottom:" + 107 * widthK + "px;" +
  "}",

  authorizationButtonEnter: ".authorization-button-enter " +
  "{" +
  "top:" + 240 * widthK + "px;" +
  "}",

  authorizationButtonsContainer: ".authorization-buttons-container " +
  "{" +
  "position: absolute;" +
  "width:" + 490 * widthK + "px;" +
  "left:" + 120 * widthK + "px;" +
  "bottom:" + 700 * widthK + "px;" +
  "height:" + 45 * widthK + "px;" +
  "}",

  authorizationButtonForgetPin: ".authorization-button-forget-pin " +
  "{" +
  "position: absolute;" +
  "font-size:" + 34 * widthK + "px;" +
  "left: 0;" +
  "background-size: contain;" +
  "color: #05eeff;" +
  "border-bottom:" + 2 * widthK + "px solid #05eeff;" +
  "}",

  authorizationButtonRegistration: ".authorization-button-registration " +
  "{" +
  "position: absolute;" +
  "font-size:" + 34 * widthK + "px;" +
  "background-size: contain;" +
  "color: white;" +
  "right: 0;" +
  "border-bottom:" + 2 * widthK + "px solid white;" +
  "}",

  authorizationButtonOffline: ".authorization-button-offline " +
  "{" +
  "position: absolute;" +
  "font-size:" + 34 * widthK + "px;" +
  "width:" + 240 * widthK + "px;" +
  "background-size: contain;" +
  "color: white;" +
  "border-bottom:" + 2 * widthK + "px solid white;" +
  "text-align: center;" +
  "bottom:" + 40 * widthK + "px;" +
  "left:" + 240 * widthK + "px;" +
  "}",

  authorizationEnterPinLabel: ".authorization-enter-pin-label " +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "background-size: contain;" +
  "width:" + 275 * widthK + "px;" +
  "color: white;" +
  "font-size:" + 32 * widthK + "px;" +
  "}",

  //VIEW MAIN PAGE

  viewMainPage: ".view-main-page " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 100%;" +
  "overflow: hidden;" +
  "}",

  //TOOLBAR COMPONENT

  toolbar: ".toolbar " +
  "{" +
  "position: absolute;" +
  "top:" + 20 * widthK + "px;" +
  "right:" + 26 * widthK + "px;" +
  "left:" + 26 * widthK + "px;" +
  "height:" + 70 * widthK + "px;" +
  "background: transparent;" +
  "border-bottom:" + 2 * widthK + "px solid #a3deee;" +
  "}",

  toolbarCircleContainer: ".toolbar-circle-container " +
  "{" +
  "position: absolute;" +
  "width:" + 105 * widthK + "px;" +
  "height:" + 105 * widthK + "px;" +
  "left:" + 272 * widthK + "px;" +
  "bottom:" + -40 * widthK + "px;" +
  "border-radius:" + 100 * widthK + "px;" +
  "background-color: white;" +
  "border:" + 8 * widthK + "px solid #007AE2;" +
  "background-image: url(resources/icons/bank-operations/circleReport.png);" +
  "background-repeat: no-repeat;" +
  "background-size: 90%;" +
  "background-position: center;" +
  "-webkit-box-shadow: 0px 10px 5px -7px rgba(0,0,0,0.45);" +
  "-moz-box-shadow: 0px 10px 5px -7px rgba(0,0,0,0.45);" +
  "box-shadow: 0px 10px 5px -7px rgba(0,0,0,0.45);" +
  "}",

  menuButton: ".menu-button " +
  "{" +
  "position: absolute;" +
  "left:" + 4 * widthK + "px;" +
  "background: transparent;" +
  "width: 100%;" +
  "height: 100%;" +
  "background-position: center;" +
  "}",

  menuIcon: ".menu-icon " +
  "{" +
  "position: absolute;" +
  "background: transparent;" +
  "background-image: url(resources/icons/toolbar/menus.png);" +
  "width:" + 100 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "background-size: 35%;" +
  "top:" + -28 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "left:" + -16 * widthK + "px;" +
  "}",

  bellButton: ".bell-button " +
  "{" +
  "position: absolute;" +
  "right:" + 4 * widthK + "px;" +
  "background: transparent;" +
  "width: 100%;" +
  "height: 100%;" +
  "background-position: center;" +
  "}",

  bellIcon: ".bell-icon " +
  "{" +
  "position: absolute;" +
  "background: transparent;" +
  "background-image: url(resources/icons/toolbar/bells.png);" +
  "width:" + 40 * widthK + "px;" +
  "height:" + 46 * widthK + "px;" +
  "background-size: 100%;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "opacity: 0.5;" +
  "right:" + 20 * widthK + "px;" +
  "top:" + -2 * widthK + "px;" +
  "}",

  //BANK OPERATION COMPONENT

  bankOperations: ".bank-operations " +
  "{" +
  "position: absolute;" +
  "bottom:" + 429 * heightK + "px;" +
  "top:" + 545 * widthK + "px;" +
  "width: 100%;" +
  "}",

  bankOperationButton: ".bank-operation-button " +
  "{" +
  "position: absolute;" +
  "background: transparent;" +
  "height:" + 120 * widthK + "px;" +
  "width:" + 140 * widthK + "px;" +
  "bottom: 20%;" +
  "}",

  bankOperationButtonPay: ".bank-operation-button-pay " +
  "{" +
  "left:" + 50 * widthK + "px;" +
  "}",

  bankOperationButtonTransfer: ".bank-operation-button-transfer " +
  "{" +
  "left:" + 280 * widthK + "px;" +
  "}",

  bankOperationButtonAutoPay: ".bank-operation-button-autopay " +
  "{" +
  "left:" + 511 * widthK + "px;" +
  "}",

  topOperationsButtons: ".top-operations-buttons " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 60%;" +
    //"bottom:" + 85 * heightK + "px;" +
  "top: 15%;" +
  "}",

  bankOperationIcon: ".bank-operation-icon " +
  "{" +
  "position: absolute;" +
  "top: 10%;" +
  "width: 100%;" +
  "height: 100%;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "}",

  bankOperationButtonMyCardContainer: ".bank-operation-button-my-cards-container " +
  "{" +
  "position: absolute;" +
  "top:" + 30 + "%;" +
  "left:" + 30 + "%;" +
  "}",

  bankOperationButtonMyCard: ".bank-operation-button-my-cards " +
  "{" +
  "position: absolute;" +
  "left:" + 27 * widthK + "px;" +
  "right:" + 27 * widthK + "px;" +
  "border-bottom:" + 2 * widthK + "px solid #a3deee;" +
  "text-align: center;" +
  "top:" + 440 * widthK + "px;" +
  "height:" + 100 * heightK + "px;" +
  "}",

  bankOperationButtonMyCardsIcon: ".bank-operation-button-my-cards-icon " +
  "{" +
  "position: absolute;" +
  "width:" + 71 * widthK + "px;" +
  "height:" + 70 * widthK + "px;" +
  "left:" + 20 * widthK + "px;" +
  "top:" + -3 * widthK + "px;" +
  "background-size: 70%;" +
  "background-repeat: no-repeat;" +
  "background-image: url(resources/icons/bank-operations/allcards.png);" +
  "}",

  bankOperationButtonMyCardsLabel: ".bank-operation-button-my-cards-label " +
  "{" +
  "width:" + 186 * widthK + "px;" +
  "left:" + 71 * widthK + "px;" +
  "top:" + 1 * widthK + "px;" +
  "position: absolute;" +
  "font-size:" + 28 * widthK + "px;" +
  "color: #ffffff;" +
  "}",

  bankOperationLabel: ".bank-operation-label " +
  "{" +
  "position: absolute;" +
  "bottom:" + -25 * widthK + "px;" +
  "color: #ffffff;" +
  "text-align: center;" +
  "font-size:" + 29 * widthK + "px;" +
  "}",

  bankOperationLabelPay: ".bank-operation-label-pay " +
  "{" +
  "left:" + 77 * widthK + "px;" +
  "}",

  bankOperationLabelTransfer: ".bank-operation-label-transfer " +
  "{" +
  "left:" + 277 * widthK + "px;" +
  "}",

  bankOperationLabelAutoPay: ".bank-operation-label-autopay " +
  "{" +
  "left:" + 496 * widthK + "px;" +
  "}",

  operationPayIcon: ".operation-pay-icon " +
  "{" +
  "background-image: url(resources/icons/bank-operations/payment.png);" +
  "background-size: 49%;" +
  "left:" + 8 * widthK + "px;" +
  "}",

  operationTransferIcon: ".operation-transfer-icon " +
  "{" +
  "background-image: url(resources/icons/bank-operations/transfers.png);" +
  "background-size: 69%;" +
  "}",

  operationAutopayIcon: ".operation-autopay-icon " +
  "{" +
  "background-image: url(resources/icons/bank-operations/autopays.png);" +
  "background-size: 53%;" +
  "}",

  //CAROUSEL COMPONENT

  cardCarousel: ".card-carousel " +
  "{" +
  "position: absolute;" +
  "height:" + 290 * widthK + "px;" +
  "width: 100%;" +
  "display: inline-block;" +
  "top:" + 140 * widthK + "px;" +
  "background: transparent;" +
  "}",

  cards: ".cards " +
  "{" +
  "position: relative;" +
  "-webkit-animation: mymove 5s infinite;" +
  "animation: mymove 5s infinite;" +
  "}",

  card: ".card " +
  "{" +
  "-webkit-appearance: none;" +
  "height:" + 289 * widthK + "px;" +
  "width:" + 510 * widthK + "px;" +
  "position: absolute;" +
  "top:" + 7 * widthK + "px;" +
  "-webkit-border-radius:" + 14 * widthK + "px;" +
  "-moz-border-radius:" + 14 * widthK + "px;" +
  "border-radius:" + 14 * widthK + "px;" +
  "background-size: cover;" +
  "color: white;" +
  "-webkit-box-shadow: 0px 50px 50px -50px rgba(0,0,0,1);" +
  "-moz-box-shadow: 0px 50px 50px -50px rgba(0,0,0,1);" +
  "box-shadow: 0px 50px 50px -50px rgba(0,0,0,1);" +
  "}",

  cardBankName: ".card-bank-name " +
  "{" +
  "position: absolute;" +
  "top:" + 12 * widthK + "px;" +
  "right:" + 25 * widthK + "px;" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "font-size:" + 36 * widthK + "px;" +
  "height:" + 32 * widthK + "px;" +
  "width:" + 118 * widthK + "px;" +
  "background-position: top right;" +
  "}",

  cardBankNameUrl: ".card-bank-name-url " +
  "{" +
  "position: absolute;" +
  "width:" + 240 * widthK + "px;" +
  "height:" + 90 * widthK + "px;" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "background-position: left top;" +
  "left:" + 30 * widthK + "px;" +
  "top:" + 20 * widthK + "px" +
  "}",

  cardSalaryTitle: ".card-salary-title " +
  "{" +
  "position: absolute;" +
  "top:" + 134 * widthK + "px;" +
  "left:" + 25 * widthK + "px;" +
  "color: #595759;" +
  "background-size: contain;" +
  "font-size:" + 23 * widthK + "px;" +
  "height: 10%;" +
  "}",

  cardBalansCurrencyContainer: ".card-balance-currency-container " +
  "{" +
  "position: absolute;" +
  "width:" + 400 * widthK + "px;" +
  "top:" + 163 * widthK + "px;" +
  "display: inline-block;" +
  "margin: 0;" +
  "}",

  cardBalance: ".card-balance " +
  "{" +
  "position: relative;" +
  "left:" + 25 * widthK + "px;" +
  "color: #585658;" +
  "font-size:" + 44 * widthK + "px;" +
  "margin: 0;" +
  "margin-top:" + -2 * widthK + "px;" +
  "float: left;" +
  "padding: 0;" +
  "}",

  cardCurrency: ".card-currency " +
  "{" +
  "position: relative;" +
  "margin-left:" + 35 * widthK + "px;" +
  "color: #595759;" +
  "top:" + -6 * widthK + "px;" +
  "font-size:" + 24 * widthK + "px;" +
  "background-size: contain;" +
  "float: left;" +
  "width:" + 60 * widthK + "px;" +
  "}",

  cardNumber: ".card-number " +
  "{" +
  "position: absolute;" +
  "top:" + 242 * widthK + "px;" +
  "width:" + 384 * widthK + "px;" +
  "height:" + 40 * widthK + "px;" +
  "font-size:" + 32 * widthK + "px;" +
  "text-shadow: white -1px -1px 0.4px, black 0.0px 1px 0.2px, white -1px -1px 0.4px, black 0.0px 1px 0.4px;" +
  "-webkit-text-shadow: white -1px -1px 0.4px, black 0.0px 1px 0.2px, white -1px -1px 0.4px, black 0.0px 1px 0.4px;font-family: Orator;" +
  "color: transparent;" +
  "left:" + 20 * widthK + "px;" +
  "}",

  cardNumberPartOne: ".card-number-part-one " +
  "{" +
  "position: absolute;" +
  "left: 0px;" +
  "font-weight: bold;" +
  "}",

  cardNumberPartTwo: ".card-number-part-two " +
  "{" +
  "position: absolute;" +
  "left:" + 304 * widthK + "px;" +
  "font-weight: bold;" +
  "}",

  numberStars: ".number-stars " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left:" + 90 * widthK + "px;" +
  "top:" + 2 * widthK + "px;" +
  "letter-spacing:" + -10 * widthK + "px;" +
  "font-size:" + 52 * widthK + "px;" +
  "}",

  //SERVICE CAROUSEL COMPONENT

  serviceCarousel: ".service-carousel " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "top:" + 805 * heightK + "px;" +
  "bottom:" + 90 * widthK + "px;" +
  "background: transparent;" +
  "}",

  serviceComponent: ".service-component " +
  "{" +
  "position: absolute;" +
  "width:" + 620 * widthK + "px;" +
    //"height:" + 338 * heightK + "px;" +
  "top:" + -1 * heightK + "px;" +
  "bottom:" + 5 * widthK + "px;" +
  "background-color: #fefefe;" +
  "}",

  serviceContainer: ".service-container " +
  "{" +
  "position: absolute;" +
  "height: 55%;" +
  "width: 100%;" +
  "bottom: 15%;" +
  "left:" + 25 * widthK + "px;" +
  "}",

  serviceButtons: ".service-buttons " +
  "{" +
  "position: absolute;" +
  "width:" + 125 * widthK + "px;" +
  "height:" + 125 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "border-radius:" + 100 * widthK + "px;" +
  "border:" + 1 * widthK + "px solid #f1f1f1;" +
  "}",

  beelineButton: ".beeline-button " +
  "{" +
  "background-image: url(resources/icons/services/beelineS.png);" +
  "background-size: 60%;" +
  "left:" + 152 * widthK + "px;" +
  "}",

  ucellButton: ".ucell-button " +
  "{" +
  "left:" + 15 * widthK + "px;" +
  "top:" + 0 * widthK + "px;" +
  "background-image: url(resources/icons/services/ucellS.png);" +
  "background-size: 80%;" +
  "}",

  umsButton: ".ums-button " +
  "{" +
  "left:" + 288 * widthK + "px;" +
  "background-position: center;" +
  "background-image: url(resources/icons/services/umsS.png);" +
  "background-size: 60%;" +
  "}",

  myPhoneButton: ".my-phone-button " +
  "{" +
  "left:" + 425 * widthK + "px;" +
  "top: 0;" +
  "background-position-x:" + 35 * widthK + "px;" +
  "background-image: url(resources/icons/services/myphone.png);" +
  "background-size: 60%;" +
  "}",

  serviceLabels: ".service-labels " +
  "{" +
  "position: absolute;" +
  "bottom:" + -80 * widthK + "px;" +
  "font-size:" + 25 * widthK + "px;" +
  "color: grey;" +
  "}",

  serviceLabelsUcell: ".service-labels-ucell " +
  "{" +
  "left:" + 40 * widthK + "px;" +
  "}",

  serviceLabelBeeline: ".service-labels-beeline " +
  "{" +
  "bottom:" + -80 * widthK + "px;" +
  "left:" + 24 * widthK + "px;" +
  "}",

  serviceLabelsUms: ".service-labels-ums " +
  "{" +
  "left:" + 33 * widthK + "px;" +
  "bottom:" + -80 * widthK + "px;" +
  "}",

  serviceLabelMyPhone: ".service-labels-my-phone " +
  "{" +
  "left: 0px;" +
  "width:" + 166 * widthK + "px;" +
  "bottom:" + -80 * widthK + "px;" +
  "}",

  serviceTitle: ".service-title " +
  "{" +
  "position: relative;" +
  "top:" + 38 * heightK + "px;" +
  "width:" + 244 * widthK + "px;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "background: transparent;" +
  "background-size: contain;" +
  "color: #585858;" +
  "font-size:" + 24 * widthK + "px;" +
  "}",

  sideMenu: ".side-menu " +
  "{" +
  "position: fixed;" +
  "height: 100%;" +
  "width:" + 500 * widthK + "px;" +
  "overflow: hidden;" +
  "transform: translate3d(-100%, 0, 0);" +
  "-webkit-transform: translate3d(-100%, 0, 0);" +
  "-ms-transform: translate3d(-100%, 0, 0);" +
  "background-color: #0485e5;" +
  "transition: 0.5s;" +
  "-webkit-transition: 0.5s;" +
  "z-index: 999999;" +
  "top: 0;" +
  "}",

  sideMenuBackPage: ".side-menu-back-page " +
  "{" +
  "position: fixed;" +
  "height: 100%;" +
  "width: 100%;" +
  "overflow: hidden;" +
  "transform: translate3d(0, 0, 0);" +
  "-webkit-transform: translate3d(0, 0, 0);" +
  "-ms-transform: translate3d(0, 0, 0);" +
  "background-color: rgba(0, 0, 0, 0.6);" +
  "transition: 0.5s;" +
  "-webkit-transition: 0.5s;" +
  "opacity: 0;" +
  "}",

  //TITLE COMPONENT

  pageTitle: ".page-title " +
  "{" +
  "position: absolute;" +
  "top:" + -12 * widthK + "px;" +
  "right:" + 28 * widthK + "px;" +
  "left:" + 25 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "background: transparent;" +
  "border-bottom:" + 6 * widthK + "px solid rgb(149, 230, 253);" +
  "}",

  nameTitle: ".name-title " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size:" + 32 * widthK + "px;" +
  "left:" + 82 * widthK + "px;" +
  "top:" + 42 * widthK + "px;" +
  "margin: 0;" +
  "color: #fffaf9;" +
  "}",

  backButton: ".back-button " +
  "{" +
  "position: absolute;" +
  "width:" + 120 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "background-image: url(resources/icons/back/back.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 19%;" +
  "background-position-y: center;" +
  "background-position-x:" + 20 * widthK + "px;" +
  "background-size: 19%;" +
  "left: 0;" +
  "top:" + 10 * widthK + "px;" +
  "}",

  settingsButton: ".settings-button " +
  "{" +
  "position: absolute;" +
  "width:" + 68 * widthK + "px;" +
  "height:" + 68 * widthK + "px;" +
  "right:" + 6 * widthK + "px;" +
  "background-image: url(resources/icons/ViewMyCards/cardsettings.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 69%;" +
  "background-position-y: center;" +
  "background-position-x:" + 20 * widthK + "px;" +
  "background-size: 69%;" +
  "top:" + 29 * widthK + "px;" +
  "}",

  searchButton: ".search-button " +
  "{" +
  "position: absolute;" +
  "width:" + 83 * widthK + "px;" +
  "height:" + 68 * widthK + "px;" +
  "right:" + -15 * widthK + "px;" +
  "background-image: url(resources/icons/toolbar/search.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 55%;" +
  "background-position-y: center;" +
  "background-position-x:" + 20 * widthK + "px;" +
  "background-size: 45%;" +
  "top:" + 25 * widthK + "px;" +
  "}",

  //FOOTER COMPONENT

  footer: ".footer " +
  "{" +
  "position: absolute;" +
  "bottom:" + 190 * widthK + "px;" +
  "left: 0;" +
  "right: 0;" +
  "height:" + 105 * widthK + "px;" +
  "width: 100%;" +
  "border-top:" + 2 * widthK + "px solid rgb(37, 160, 227);" +
  "color: rgb(197, 233, 239);" +
  "background-color: #22a0e0;" +
  "}",

  footerIconTick: ".footer-icon-tick " +
  "{" +
  "position: absolute;" +
  "left:" + 185 * widthK + "px;" +
  "background-size: contain;" +
  "background-image: url(resources/icons/footer/contacts.png);" +
  "background-repeat: no-repeat;" +
  "width:" + 33 * widthK + "px;" +
  "height:" + 18 * widthK + "px;" +
  "top:" + 40 * widthK + "px;" +
  "transition: 0.8s;" +
  "}",

  footerContactsContainer: ".footer-contacts-container " +
  "{" +
  "position: fixed;" +
  "bottom: 0;" +
  "left: 0;" +
  "right: 0;" +
  "transition: 0.3s;" +
  "-webkit-transition: 0.3s;" +
  "height:" + 312 * widthK + "px;" +
  "width: 100%;" +
  "transform: translate3d(0, " + 200 * widthK + "px, 0);" +
  "-webkit-transform: translate3d(0," + 200 * widthK + "px, 0);" +
  "-ms-transform: translate3d(0," + 200 * widthK + "px, 0);" +
  "}",

  footerContactLabel: ".footer-contacts-label " +
  "{" +
  "position: absolute;" +
  "font-size:" + 27 * widthK + "px;" +
  "margin-top:" + 33 * widthK + "px;" +
  "color: white;" +
  "left:" + -1 * widthK + "px;" +
  "}",

  footerContacts: ".footer-contacts " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 240 * widthK + "px;" +
  "bottom:" + -40 * widthK + "px;" +
  "background-color: #25a0e3;" +
  "}",

  footerFavouriteContactsContainer: ".footer-favourite-contacts-container " +
  "{" +
  "position: relative;" +
  "width:" + 670 * widthK + "px;" +
  "height:" + 160 * widthK + "px;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "top: 0;" +
  "left:" + 20 * widthK + "px;" +
  "}",

  footerFavouriteContactsCircles: ".footer-favourite-contacts-circles " +
  "{" +
  "position: absolute;" +
  "width:" + 100 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "border-radius:" + 100 * widthK + "px;" +
  "border: none;" +
  "background-color: #7ae4ff;" +
  "top: 0;" +
  "background-repeat: no-repeat;" +
  "background-size: contain;" +
  "background-position: center;" +
  "left:" + 10 * widthK + "px;" +
  "}",

  footerContacsBlocks: ".footer-contacts-blocks " +
  "{" +
  "position: absolute;" +
  "height:" + 160 * widthK + "px;" +
  "width:" + 120 * widthK + "px;" +
  "text-align: center;" +
  "}",

  footerContactsBlockOne: ".footer-contacts-block-one " +
  "{" +
  "left:" + -30 * widthK + "px;" +
  "}",

  footerContactsBlockTwo: ".footer-contacts-block-two " +
  "{" +
  "left:" + 110 * widthK + "px;" +
  "}",

  footerContactsBlockThree: ".footer-contacts-block-three " +
  "{" +
  "left:" + 250 * widthK + "px;" +
  "}",

  footerContacsBlockFour: ".footer-contacts-block-four " +
  "{" +
  "left:" + 390 * widthK + "px;" +
  "}",

  footerContactsBlockFive: ".footer-contacts-block-five " +
  "{" +
  "left:" + 530 * widthK + "px;" +
  "}",

  footerFavouriteContactsLabel: ".footer-favourite-contacts-label " +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "font-size:" + 24 * widthK + "px;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "margin-top: 0;" +
  "margin-bottom: 0;" +
  "top:" + 108 * widthK + "px;" +
  "color: white;" +
  "font-weight: normal;" +
  "}",

  footerContactsLabelIconContainer: ".footer-contacts-label-icon-container " +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "width:" + 214 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "}",

  //VIEW MY CARDS

  viewMyCards: ".view-my-cards " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 100%;" +
  "overflow: hidden;" +
  "}",

  myCardsCarousel: ".my-cards-carousel " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "top:" + -22 * widthK + "px;" +
  "}",

  myCardsButtonContainer: ".my-cards-button-container " +
  "{" +
  "position: absolute;" +
  "top:" + 417 * widthK + "px;" +
  "left:" + -30 * widthK + "px;" +
  "right: 0;" +
  "overflow: hidden;" +
  "height:" + 300 * widthK + "px;" +
  "background: transparent;" +
  "}",

  myCardsButtonField: ".my-cards-button-field " +
  "{" +
  "position: absolute;" +
  "width:" + 800 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "}",

  myCardsButtonFieldTransfer: ".my-cards-button-field-transfer " +
  "{" +
  "top: 0;" +
  "}",

  myCardsFieldPayment: ".my-cards-button-field-payment " +
  "{" +
  "top:" + 100 * widthK + "px;" +
  "}",

  myCardsFieldReport: ".my-cards-button-field-report " +
  "{" +
  "top:" + 200 * widthK + "px;" +
  "}",

  myCardsButtonIcon: ".my-cards-button-icon " +
  "{" +
  "position: absolute;" +
  "width:" + 146 * widthK + "px;" +
  "height:" + 101 * widthK + "px;" +
  "background: transparent;" +
  "background-repeat: no-repeat;" +
  "opacity: 0.7;" +
  "left:" + 24 * widthK + "px;" +
  "}",

  myCardsButtonIconTransfer: ".my-cards-button-icon-transfer " +
  "{" +
  "background-image: url(resources/icons/ViewMyCards/cardtransfer.png);" +
  "background-size: 35%;" +
  "background-position: center;" +
  "}",

  myCardsButtonIconPayment: ".my-cards-button-icon-payment " +
  "{" +
  "background-image: url(resources/icons/ViewMyCards/cardpaymens.png);" +
  "background-size: 25%;" +
  "background-position: center;" +
  "}",

  myCardsButtonIconReport: ".my-cards-button-icon-report " +
  "{" +
  "background-image: url(resources/icons/ViewMyCards/cardreport.png);" +
  "background-size: 35%;" +
  "background-position: center;" +
  "}",

  myCardsButtonIconBlock: ".my-cards-button-icon-block" +
  "{" +
  "background-image: url(resources/icons/ViewMyCards/cardblock.png);" +
  "background-size: 30%;" +
  "background-position: center;" +
  "top:" + 4 * widthK + "px;" +
  "left:" + -2 * widthK + "px;" +
  "}",

  myCardsButtonLabel: ".my-cards-button-label " +
  "{" +
  "position: absolute;" +
  "height: 70%;" +
  "width: 80%;" +
  "left: 20%;" +
  "font-size:" + 30 * widthK + "px;" +
  "color: white;" +
  "top:" + 30 * widthK + "px;" +
  "border-bottom:" + 2 * widthK + "px solid #95e6fd;" +
  "}",

  myCardsButtonBlockCard: ".my-cards-button-block-card " +
  "{" +
  "position: absolute;" +
  "height:" + 110 * widthK + "px;" +
  "width: 100%;" +
  "background-color: #eb604d;" +
  "top:" + 726 * widthK + "px;" +
  "}",

  myCardsButtonBlockCardLabel: ".my-cards-button-block-card-label " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "left:" + 128 * widthK + "px;" +
  "font-size:" + 30 * widthK + "px;" +
  "color: white;" +
  "top:" + 33 * widthK + "px;" +
  "}",

  myCardsLastOperationContainer: ".my-cards-last-operations-container " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "top:" + 80 * widthK + "px;" +
  "background-color: white;" +
  "}",

  myCardsLastOperations: ".my-cards-last-operations " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "top:" + 835 * widthK + "px;" +
  "overflow: auto;" +
  "background-color: #ffffff;" +
  "bottom: 0;" +
  "}",

  myCardsLastOperationsContainerLabel: ".my-cards-last-operations-container-label " +
  "{" +
  "position: absolute;" +
  "top: 0;" +
  "height:" + 80 * widthK + "px;" +
  "width: 100%;" +
  "background-color: #f7f7f7;" +
  "background-size: contain;" +
  "font-size:" + 24 * widthK + "px;" +
  "color: #8a8a8a;" +
  "}",

  myCardsLastOperationLabel: ".my-cards-last-operations-label " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left:" + 43 * widthK + "px;" +
  "top:" + 23 * widthK + "px;" +
  "}",

  myCardsLastOperationInfo: ".my-cards-last-operations-info " +
  "{" +
  "position: absolute;" +
  "top:" + 80 * widthK + "px;" +
  "width: 100%;" +
  "height:" + 160 * widthK + "px;" +
  "border-bottom:" + 2 * widthK + "px solid #dedfe0;" +
  "overflow: hidden;" +
  "}",

  myCardsOperationAmounts: ".my-cards-operation-amount " +
  "{" +
  "position: relative;" +
  "color: #EB604D;" +
  "background-size: contain;" +
  "font-size:" + 48 * widthK + "px;" +
  "height:" + 60 * widthK + "px;" +
  "top:" + 8 * widthK + "px;" +
  "left:" + 60 * widthK + "px;" +
  "float: left;" +

  "}",

  myCardsOperationCurrency: ".my-cards-operation-currency " +
  "{" +
  "position: relative;" +
  "color: #919191;" +
  "top:" + 26 * widthK + "px;" +
  "background-size: contain;" +
  "float: left;" +
  "left:" + 70 * widthK + "px;" +
  "font-size:" + 25 * widthK + "px;" +
  "}",

  myCardsOperationDate: ".my-cards-operation-date " +
  "{" +
  "position: absolute;" +
  "color: #919191;" +
  "bottom:" + 30 * widthK + "px;" +
  "left:" + 57 * widthK + "px;" +
  "font-size:" + 25 * widthK + "px;" +
  "}",

  myCardsFirmName: "    .my-cards-firm-name" +
  "{" +
  "position: absolute;" +
  "left:" + 58 * widthK + "px;" +
  "top:" + 60 * widthK + "px;" +
  "font-size:" + 34 * widthK + "px;" +
  "color: #232323;" +
  "}",

  //VIEW INFO

  viewInfo: ".view-info " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 100%;" +
  "overflow-x: hidden;" +
  "background-color: #ffffff;" +
  "}",

  viewInfoTitleContainer: ".view-info-title-container " +
  "{" +
  "position: absolute;" +
  "right:" + 30 * widthK + "px;" +
  "left:" + 30 * widthK + "px;" +
  "height:" + 89 * widthK + "px;" +
  "border-bottom:" + 1 * widthK + "px solid #f4f4f4;" +
  "}",

  viewInfoBackButton: ".view-info-back-button " +
  "{position: absolute;" +
  "left:" + 10 * widthK + "px;" +
  "width:" + 100 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "top:" + 5 * widthK + "px;" +
  "border-radius:" + 90 * widthK + "px;" +
  "border:" + 1 * widthK + "px solid #e5e5e5;" +
  "background-image: url(resources/icons/ViewInfo/backtomain.png);" +
  "background-repeat: no-repeat;" +
  "background-size: 48%;" +
  "background-position: center;" +
  "background-color: #ffffff;" +
  "}",

  viewInfoBalanceContainer: ".view-info-balance-container " +
  "{" +
  "position: absolute;" +
  "right:" + 30 * widthK + "px;" +
  "left:" + 30 * widthK + "px;" +
  "height:" + 190 * widthK + "px;" +
  "top:" + 89 * widthK + "px;" +
  "border-bottom:" + 1 * widthK + "px solid #f4f4f4;" +
  "}",

  viewInfoMyFinanceContainer: ".view-info-my-finance-container " +
  "{" +
  "position: absolute;" +
  "right:" + 30 * widthK + "px;" +
  "left:" + 30 * widthK + "px;" +
  "height:" + 125 * widthK + "px;" +
  "top:" + 280 * widthK + "px;" +
  "border-bottom:" + 1 * widthK + "px solid #f4f4f4;" +
  "}",

  viewInfoReportsContainer: ".view-info-reports-container " +
  "{" +
  "position: absolute;" +
  "right:" + 30 * widthK + "px;" +
  "left:" + 30 * widthK + "px;" +
  "height:" + 125 * widthK + "px;" +
  "top:" + 408 * widthK + "px;" +
  "border-bottom:" + 1 * widthK + "px solid #f4f4f4;" +
  "}",

  viewInfoBagIcon: ".view-info-bag-icon " +
  "{" +
  "position: absolute;" +
  "width: 18%;" +
  "height: 70%;" +
  "left: 0%;" +
  "top: 15%;" +
  "background-image: url(resources/icons/ViewInfo/mybalance.png);" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: 60%;" +
  "}",

  viewInfoReloadIcon: ".view-info-reload-icon " +
  "{" +
  "position: absolute;" +
  "width: 10%;" +
  "height: 30%;" +
  "right: 2%;" +
  "top: 23%;" +
  "background-image: url(resources/icons/ViewInfo/reload.png);" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: 73%;" +
  "}",

  viewInfoMyFinanceIcon: ".view-info-my-finance-icon " +
  "{" +
  "position: absolute;" +
  "width: 20%;" +
  "height: 70%;" +
  "left: -1%;" +
  "top: 12%;" +
  "background-image: url(resources/icons/ViewInfo/myfinance.png);" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: 67%;" +
  "}",

  viewInfoOpenIcon: ".view-info-open-icon " +
  "{" +
  "position: absolute;" +
  "width: 20%;" +
  "height: 80%;" +
  "right: -5%;" +
  "top: 12%;" +
  "background-image: url(resources/icons/ViewInfo/open.png);" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: 9%;" +
  "}",

  viewInfoReportIcon: ".view-info-reports-icon " +
  "{" +
  "position: absolute;" +
  "width: 20%;" +
  "height: 70%;" +
  "left: -1%;" +
  "top: 15%;" +
  "background-image: url(resources/icons/ViewInfo/myreports.png);" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: 67%;" +
  "}",

  viewInfoMyFinanceTitle: ".view-info-my-finance-title " +
  "{" +
  "position: absolute;" +
  "width: 36%;" +
  "height: 70%;" +
  "left: 18%;" +
  "top: 10%;" +
  "text-align: center;" +
  "font-size:" + 29 * widthK + "px;" +
  "color: #8b8b8b;" +
  "}",

  viewInfoReportTitle: ".view-info-reports-title " +
  "{" +
  "position: absolute;" +
  "width: 36%;" +
  "height: 70%;" +
  "left: 12%;" +
  "top: 10%;" +
  "text-align: center;" +
  "font-size:" + 29 * widthK + "px;" +
  "color: #8b8b8b;" +
  "}",

  viewInfoOperationContainer: ".view-info-operations-container " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 250 * widthK + "px;" +
  "top:" + 600 * widthK + "px;" +
  "overflow: auto;" +
  "}",

  viewInfoOperationTitle: ".view-info-operations-title " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 68 * widthK + "px;" +
  "top:" + 535 * widthK + "px;" +
  "}",

  viewInfoOperationsLabel: ".view-info-operations-label " +
  "{" +
  "font-size:" + 24 * widthK + "px;" +
  "position: absolute;" +
  "top: 26%;" +
  "left: 7%;" +
  "color: #8b8b8b;" +
  "}",

  viewOperationInfoContainer: ".view-info-operation-info-container " +
  "{" +
  "position: absolute;" +
  "height: 100%;" +
  "width: 300%;" +
  "left: 103%;" +
  "}",

  viewInfoBalanceLabel: ".view-info-balance-label " +
  "{" +
  "position: absolute;" +
  "left: 25%;" +
  "top: 10%;" +
  "font-size:" + 25 * widthK + "px;" +
  "color: #c2c2c2;" +
  "}",

  viewInfoCardBalance: ".view-card-balance " +
  "{" +
  "position: relative;" +
  "left:" + 34 * widthK + "px;" +
  "color: #515151;" +
  "font-size:" + 52 * widthK + "px;" +
  "margin: 0;" +
  "margin-top:" + -2 * widthK + "px;" +
  "float: left;" +
  "padding: 0;" +
  "}",

  payNameTitle: ".pay-name-title " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size:" + 34 * widthK + "px; " +
  "left:" + 86 * widthK + "px; " +
  "top:" + 40 * widthK + "px; " +
  "margin: 0;  " +
  "color: #fffaf9;" +
  "}",

  payCategoryContainer: ".pay-category-container" +
  "{" +
  "position: absolute;" +
    //"height:" + 1150 * widthK + "px; " +
  "width:" + 720 * widthK + "px; " +
  "top:" + 86 * widthK + "px; " +
  "bottom:0; " +
  "background-color: white; " +
  "overflow-y: auto; " +
  "overflow-x: hidden; " +
  "}",

  payServiceBlockContainer: ".pay-service-block-containter" +
  "{" +
  "position: relative;" +
  "min-height:" + 92 * widthK + "px; " +
  "width: 100%;" +
  "margin-top: 1%;" +
  "border-bottom-style: solid;" +
  "border-bottom-color: gainsboro;" +
  "background-color: transparent;" +
  "}",

  payServicesBlock: ".pay-services-block" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "top: 60%;" +
  "margin-bottom: 4%;" +
  "padding-top: 2%;" +
  "overflow: hidden;" +
  "}",

  payServiceIcon: ".pay-service-icon" +
  "{" +
  "position: relative;" +
  "width: 75%;" +
  "height: " + 150 * widthK + "px; " +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "border-radius: 50%;" +
  "border: " + 1 * widthK + "px solid gray;" +
  "background-size: 80%;" +
  "}",

  payServiceNameField: ".pay-service-name-field" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "font-size:" + 24 * widthK + "px; " +
  "color: gray;" +
  "text-align: center;" +
  "margin-right: auto;" +
  "top: 100%;" +

  "}",

  payCategoryIcon: ".pay-category-icon" +
  "{" +
  "position: relative;" +
  "width: 13%;" +
  "height:" + 95 * widthK + "px; " +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "float: left;" +
  "left: 3%;" +
  "background-size: 50%;" +
  "}",

  payCategoryNameField: ".pay-category-name-field" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "top: " + 31 * widthK + "px; " +
  "left: 6%;" +
  "text-align: left;" +
  "font-size:" + 29 * widthK + "px; " +
  "color: gray;" +
  "}",

  payServiceContainer: ".pay-service-containter" +
  "{" +
  "position: relative;" +
  "width: 28%;" +
  "margin-left: 3%;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: 60%;" +
  "margin-bottom: 10%;" +
  "float: left;" +
  "}",

  viewPay: ".view-pay" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 100%;" +
  "overflow-y: hidden;" +
  "overflow-x: hidden;" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "background-image: url('resources/icons/background/transparent.png');" +
  "}",

  payIconTick: ".pay-icon-tick " +
  "{" +
  "position: relative;" +
  "left:" + 653 * widthK + "px;" +
  "background-size: contain;" +
  "background-image: url(resources/icons/ViewPay/catopen.png);" +
  "background-repeat: no-repeat;" +
  "width:" + 19 * widthK + "px;" +
  "height:" + 18 * widthK + "px;" +
  "top:" + 2 * widthK + "px;" +
  "}",


  servicePageTitle: ".servicepage-title" +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size: " + 38 * widthK + "px; " +
  "left: 13%;" +
  "top: 36%;" +
  "margin: 0;" +
  "color: #fffaf9;" +
  "}",

  servicePageCategoryField: ".servicepage-category-field" +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size: " + 29 * widthK + "px; " +
  "left: 13%;" +
  "top: 89%;" +
  "margin: 0;" +
  "color: lavender;" +
  "}",

  servicePageServiceIcon: ".servicepage-service-icon" +
  "{" +
  "top: 36%;" +
  "position: relative;" +
  "width: 13%;" +
  "height: 91%;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "border-radius: 50%;" +
  "border: " + 1 * widthK + "px solid gray;" +
  "float: right;" +
  "right: 4%;" +
  "background-size: 150%;" +
  "}",

  servicePageBodyContainer: ".servicepage-body-container" +
  "{" +
  "position: absolute;" +
  "height: " + 1150 * widthK + "px; " +
  "width: " + 720 * widthK + "px; " +
  "top: " + 150 * widthK + "px; " +
  "background-color: white;" +
  "overflow-x: hidden;" +
  "overflow-y: scroll;" +
  "}",

  servicePagePhoneField: ".servicepage-phone-field" +
  "{" +
  "position: relative;" +
  "left: 10%;" +
  "width: 79%;" +
  "height: 9%;" +
  "border-bottom:  " + 5 * widthK + "px solid #01cfff;" +
  "color: white;" +
    //"top: 3%;" +
  "margin-top: 5%" +
  "}",

  servicePageAmountField: ".servicepage-amount-field" +
  "{position: absolute;" +
  "left: 10%;" +
  "width: 79%;" +
  "height: 9%;" +
  "border-bottom:  " + 5 * widthK + "px solid lightgray;" +
  "color: white;" +
    //"top: 16%;" +
  "margin-top: 8%" +
  "}",

  servicePageTextField: ".servicepage-text-field" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 24 * widthK + "px; " +
  "top: -16%;" +
  "}",

  servicePagePhoneInput: ".servicepage-phone-input" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "top: 59%;" +
  "font-size: " + 28 * widthK + "px; " +
  "color: #515151;" +
  "}",

  servicePagePhoneIcon: ".servicepage-phone-icon" +
  "{" +
  "position: relative;" +
  "float: right;" +
  "background-image: url('resources/icons/ViewService/book.png');" +
  "width: 8%;" +
  "height: 50%;" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "background-position: center;" +
  "top: 36%;" +
  "}",

  servicePageAmountIcon: ".servicepage-amount-icon" +
  "{" +
  "position: relative;" +
  "float: right;" +
  "background-image: url('resources/icons/ViewService/calc.png');" +
  "width: 7%;" +
  "height: 40%;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: 100%;" +
  "top: 40%;" +
  "}",

  servicePageButtonEnter: ".servicepage-button-enter" +
  "{" +
    //"top: 31%;" +
  "position: relative;" +
  "width: 63%;" +
  "height: 8%;" +
  "margin-right: auto;" +
  "border-radius: " + 80 * widthK + "px; " +
  "margin-left: auto;" +
  "background-color: rgb(1, 124, 227);" +
  "margin-top: 30%;" +
  "}",

  servicePageButtonBack: ".servicepage-button-back" +
  "{" +
  "top: 14%;" +
  "position: absolute;" +
  "width: 17%;" +
  "height: 88%;" +
  "background-image: url('resources/icons/back/back.png');" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 20%;" +
  "background-position-y: center;" +
  "background-position-x: 22%;" +
  "background-size: 20%;" +
  "left: 0;" +
  "}",

  pincardButtonEnter: " .pincard-button-enter" +
  "{" +
  "bottom: 27%;" +
  "position: absolute;" +
  "width: 60%;" +
  "height: 19%;" +
  "border-radius:" + 80 * widthK + "px; " +
  "margin-left: 20%;" +
  "background-color: rgb(1, 124, 227);" +
  "}",

  pincardPayfromContainer: ".pincard-payfrom-container" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "background-color: transparent;" +
  "width: 100%;" +
  "height: 6%;" +
  "border-bottom:  " + 1 * widthK + "px solid lightgray;" +
  "}",

  pincardPayfromField: ".pincard-payfrom-field" +
  "{" +
  "position: absolute;" +
  "font-size: " + 28 * widthK + "px; " +
  "color: gray;" +
  "margin: 2%;" +
  "margin-left: 6%;" +
  "}",

  pincardAllcardsContainer: ".pincard-allcards-container" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: 46%;" +
  "top: 6%;" +
  "background-color: transparent;" +
    //"border-bottom:  " + 1 * widthK + "px solid lightgray;" +
  "overflow: scroll;" +
  "}",

  pincardCardContainer: ".pincard-card-container" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: " + 175 * widthK + "px; " +
  "background-color: transparent;" +
  "border-bottom:  " + 1 * widthK + "px solid lightgray;" +
  "}",

  pincardCardLogoContainer: ".pincard-card-logo-container" +
  "{" +
  "width: 41%;" +
  "height: 100%;" +
  "background-color: transparent;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: 50%;" +
  "float: left;" +
  "position: absolute;" +
  "}",

  pincardButtonEnterLabel: ".pincard-button-enter-label" +
  "{" +
  "position: relative;" +
  "top: 20%;" +
  "width: 30%;" +
  "font-size: " + 44 * widthK + "px; " +
  "margin: auto;" +
  "color: white;" +
  "right: 10%;" +
  "}",

  pincardCardInfoContainer: ".pincard-card-info-container" +
  "{" +
  "position: absolute;" +
  "width: 41%;" +
  "height: 100%;" +
  "left: 45%;" +
  "background-color: transparent;" +
  "}",

  pincardCardInfoTextOne: ".pincard-card-info-text-one" +
  "{" +
  "position: absolute;" +
  "font-size: " + 24 * widthK + "px; " +
  "color: gray;" +
  "top: 4%;" +
  "}",

  pincardCardInfoTextTwo: ".pincard-card-info-text-two" +
  "{" +
  "position: absolute;" +
  "font-size: " + 36 * widthK + "px; " +
  "font-weight: bold;" +
  "color: rgba(80, 185, 8, 0.77);" +
  "top: 17%;" +
  "}",

  pincardCardInfoTextThree: ".pincard-card-info-text-three" +
  "{" +
  "position: absolute;" +
  "font-size: " + 24 * widthK + "px; " +
  "color: gray;" +
  "top: 51%;" +
  "}",

  pincardCardCheckmark: ".pincard-card-checkmark" +
  "{" +
  "position: absolute;" +
  "width: 18%;" +
  "height: 100%;" +
  "left: 81%;" +
  "background-color: transparent;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: 35%;" +
  "}",

  pincardHelpText: ".pincard-help-text" +
  "{" +
  "bottom: 55%;" +
  "position: absolute;" +
  "margin-left: 35%;" +
  "color: rgb(1, 124, 227);" +
  "font-size: " + 30 * widthK + "px; " +
  "text-align: center;" +
  "text-decoration: underline;" +
  "}",

  pincardBottomContainer: ".pincard-bottom-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 42%;" +
  "top: 52%;" +
  "background-color: transparent;" +
  "border-bottom:  " + 1 * widthK + "px solid lightgray;" +
  "overflow: scroll;" +
  "}",

  payconfirmDataContainer: ".payconfirm-data-container" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: 51%;" +
  "background-color: transparent;" +
  "border-bottom:  " + 1 * widthK + "px solid lightgray;" +
  "overflow: scroll;" +
  "}",

  payconfirmPhoneField: ".payconfirm-phone-field" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 23%;" +
  "border-bottom:  " + 1 * widthK + "px solid lightgray;" +
  "color: white;" +
  "}",

  payconfirm: ".payconfirm-field" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: 24%;" +
  "border-bottom:  " + 1 * widthK + "px solid lightgray;" +
  "color: white;" +
  "top: 23%;" +
  "}",

  payconfirmCardField: ".payconfirm-card-field" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: 29%;" +
  "border-bottom:  " + 1 * widthK + "px solid lightgray;" +
  "color: white;" +
  "top: 23%;" +
  "}",

  payconfirmBottomContainer: ".payconfirm-bottom-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 50%;" +
  "top: 52%;" +
  "background-color: transparent;" +
  "border-bottom:  " + 1 * widthK + "px solid lightgray;" +
  "overflow: scroll;" +
  "}",

  payconfirmTextField: ".payconfirm-text-field" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: darkgray;" +
  "font-size: " + 25 * widthK + "px; " +
  "margin-left: 10%;" +
  "top: 20%;" +
  "}",

  payconfirmPhoneInput: ".payconfirm-phone-input" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "margin-left: 10%;" +
  "top: 41%;" +
  "font-size: " + 38 * widthK + "px; " +
  "color: gray;" +
  "}",

  payconfirmCardInfoContainer: ".payconfirm-card-info-container" +
  "{" +
  "position: absolute;" +
  "width: 60%;" +
  "height: 78%;" +
  "background-color: transparent;" +
  "margin-left: 4%;" +
  "}",

  payconfirmDetailText: ".payconfirm-detail-text" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "color: darkgray;" +
  "font-size: " + 25 * widthK + "px; " +
  "margin-left: 10%;" +
  "top: 75%;" +
  "}",

  payconfirmCardLogoContainer: ".payconfirm-card-logo-container" +
  "{" +
  "position: absolute;" +
  "width: 40%;" +
  "height: 100%;" +
  "left: 60%;" +
  "background-color: transparent;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: 55%;" +
  "float: left;" +
  "}",

  payconfirmActionContainer: ".payconfirm-action-containter" +
  "{" +
  "position: relative;" +
  "float: left;" +
  "width: 50%;" +
  "height: 40%;" +
  "background-color: transparent;" +
  "}",

  payconfirmActionIcon: ".payconfirm-action-icon" +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "height: 46%;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "left: 25%;" +
  "top: 11%;" +
  "background-size: 50%;" +
  "}",

  payconfirmActionText: ".payconfirm-action-text" +
  "{" +
  "top: 22%;" +
  "position: relative;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "color: rgb(1, 124, 227);" +
  "font-size: " + 30 * widthK + "px; " +
  "text-align: center;" +
  "text-decoration: underline;" +
  "width: 50%;" +
  "}",

  payconfirmButtonEnter: ".payconfirm-button-enter" +
  "{" +
  "bottom: 31%;" +
  "position: absolute;" +
  "width: 60%;" +
  "height: 16%;" +
  "border-radius: " + 80 * widthK + "px; " +
  "margin-left: 20%;" +
  "background-color: rgb(1, 124, 227);" +
  "}",

  payconfirmButtonEnterLabel: ".payconfirm-button-enter-label" +
  "{" +
  "position: absolute;" +
  "top: 26%;" +
  "width: 65%;" +
  "font-size: " + 44 * widthK + "px; " +
  "margin: auto;" +
  "color: white;" +
  "right: 10%;" +
  "}",

  inputTypeNumberText: "input[type=number], input[type=text]" +
  "{" +
  "border: none;" +
  "position: relative;" +
  "top: 36%;" +
  "width: 88%;" +
  "height: 42%;" +
  "font-size: " + 35 * widthK + "px; " +
  "font-family: Calibri;" +
  "}",

  componentSearch: ".component-search " +
  "{" +
  "position: fixed;" +
  "opacity: 0.9;" +
  "height: 100%;" +
  "width: 100%;" +
  "background-color: #353340;" +
  "display: none;" +
  "}",

  searchContainer: ".search-container" +
  "{" +
  "position: absolute;" +
  "width:" + 580 * widthK + "px;" +
  "height:" + 650 * widthK + "px;" +
  "left:" + 70 * widthK + "px;" +
  "top: 0px;" +
  "}",

  searchTitleContainer: ".search-title-container " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 13%;" +
  "}",

  searchSearchIcon: ".search-search-icon " +
  "{" +
  "position: relative;" +
  "width: 13%;" +
  "height: 100%;" +
  "background-repeat: no-repeat;" +
  "float: left;" +
  "background-image: url(resources/icons/toolbar/search.png);" +
  "background-position: center;" +
  "background-size: 45%;" +
  "}",

  searchTitleName: ".search-title-name " +
  "{" +
  "position: relative;" +
  "float: left;" +
  "margin: 0;" +
  "margin-top: 3%;" +
  "color: white;" +
  "}",

  searchCancelIcon: ".search-cancel-icon " +
  "{" +
  "position: absolute;" +
  "right: 0;" +
  "width: 15%;" +
  "height: 100%;" +
  "background-repeat: no-repeat;" +
  "background-image: url(resources/icons/toolbar/search.png);" +
  "background-position: center;" +
  "background-size: 45%;" +
  "}",

  searchInput: ".search-input " +
  "{" +
  "position: absolute;" +
  "font-family: Neuron;" +
  "font-size:" + 24 * widthK + "px;" +
  "background: none;" +
  "border: none;" +
  "border-bottom:" + 3 * widthK + "px solid #a3deee;" +
  "width: 80%;" +
  "height: 10%;" +
  "top: 20%;" +
  "left: 10%;" +
  "}"

}


var style = document.createElement('style');
style.type = 'text/css';
var allCss = '';
var styleSheet = style.stylesheet;
for (key in css) {
  allCss += css[key];
}

style.appendChild(document.createTextNode(allCss));
document.getElementsByTagName("head")[0].appendChild(style);
firstMount.firstStep ();

