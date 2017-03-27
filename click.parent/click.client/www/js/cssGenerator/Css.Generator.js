widthK = window.innerWidth / 720;
heightK = window.innerHeight / 1232;
var heightOfMobile;
var topOfIos;

if (device.platform == 'iOS') {
  heightK = (window.innerHeight - 20) / 1232;
  heightOfMobile = window.innerHeight - 20;
  cordova.plugins.Keyboard.disableScroll(true);
  topOfIos = 20;
}
else {
  heightK = window.innerHeight / 1232;
  heightOfMobile = window.innerHeight;
  topOfIos = 0;
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
  "src: url('resources/font/Orator/OratorStd.otf');" +
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
  "font-size:" + 32 * widthK + "px;" +
  "}",
  htmlId: "#htmlId " +
  "{" +
  "width: 100%;" +
  "height: 100%;" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
    //"background-image: url(resources/draft/delete_crop.png);" +
    //"opacity: 0.6;" +
    //"background-image: -moz-linear-gradient(rgb(1,124,227) 0%, rgb(21,181,243) 50%, rgb(21,181,243) 100%);" +
    //"background-image: -webkit-linear-gradient(rgb(1,124,227) 0%, rgb(21,181,243) 50%, rgb(21,181,243) 100%);" +
    //"background-image: -ms-linear-gradient(rgb(1,124,227) 0%, rgb(21,181,243) 50%, rgb(21,181,243) 100%);" +
  "background: -moz-linear-gradient(rgb(0,168,241),rgb(73,212,255));" +
  "background: -webkit-linear-gradient(rgb(0,168,241),rgb(73,212,255));" +
  "background: -ms-linear-gradient(rgb(0,168,241),rgb(73,212,255));" +
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
  "top: 19%;" +
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
  "border-bottom:" + 2 + "px solid white;" +
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
  "border-bottom:" + 2 + "px solid #b7f1ff;" +
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
  "border-bottom:" + 2 + "px solid #b7f1ff;" +
  "}",
  registrationButtonRegistration: ".registration-button-registration " +
  "{" +
  "position: absolute;" +
  "top:" + 30 * widthK + "px;" +
  "right:" + 120 * widthK + "px;" +
  "font-size:" + 34 * widthK + "px;" +
  "background-size: contain;" +
  "color: white;" +
  "border-bottom:" + 2 + "px solid white;" +
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
  "height:" + 115 * widthK + "px;" +
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
  "width:" + 580 * widthK + "px;" +
  "left:" + 70 * widthK + "px;" +
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
  "border-bottom:" + 2 + "px solid #05eeff;" +
  "}",

  authorizationButtonRegistration: ".authorization-button-registration " +
  "{" +
  "position: absolute;" +
  "font-size:" + 34 * widthK + "px;" +
  "background-size: contain;" +
  "color: white;" +
  "right: 0;" +
  "border-bottom:" + 2 + "px solid white;" +
  "}",

  authorizationButtonOffline: ".authorization-button-offline " +
  "{" +
  "position: absolute;" +
  "font-size:" + 34 * widthK + "px;" +
  "width:" + 240 * widthK + "px;" +
  "background-size: contain;" +
  "color: white;" +
  "border-bottom:" + 2 + "px solid white;" +
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
  "border-bottom: 2px solid white;" +
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
  "border-bottom: 2px solid white;" +
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

  bankOperationButtonContainer: ".bank-operation-button-container" +
  "{" +
  "position: absolute;" +
  "width:" + 270 * widthK + "px;" +
  "height:" + 75 * widthK + "px;" +
  "top:" + -13 * widthK + "px;" +
  "background-color: transparent;" +
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
  "left:" + 73 * widthK + "px;" +
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

  invoiceCardPartOne: ".invoice-card-part-one " +
  "{" +
  "-webkit-appearance: none;" +
  "height:" + 125 * widthK + "px;" +
  "width:" + 510 * widthK + "px;" +
  "position: absolute;" +
  "top:" + 7 * widthK + "px;" +
  "background-color: white;" +
  "background-size: cover;" +
  "color: white;" +
  "-webkit-box-shadow: 0px 50px 50px -50px rgba(0,0,0,1);" +
  "-moz-box-shadow: 0px 50px 50px -50px rgba(0,0,0,1);" +
  "box-shadow: 0px 50px 50px -50px rgba(0,0,0,1);" +
  "}",

  invoiceCardPartTwo: ".invoice-card-part-two" +
  "{" +
  "-webkit-appearance: none;" +
  "height:" + 125 * widthK + "px;" +
  "width:" + 510 * widthK + "px;" +
  "position: absolute;" +
  "top:" + 150 * widthK + "px;" +
  "background-color: white;" +
  "background-size: cover;" +
  "color: white;" +
  "-webkit-box-shadow: 0px 50px 50px -50px rgba(0,0,0,1);" +
  "-moz-box-shadow: 0px 50px 50px -50px rgba(0,0,0,1);" +
  "box-shadow: 0px 50px 50px -50px rgba(0,0,0,1);" +
  "}",

  invoiceCardInfoHolder: ".invoice-card-info-holder" +
  "{" +
  "width:" + 430 * widthK + "px;" +
  "float: left;" +
  "}",

  invoiceCardTransfer: ".invoice-card-transfer" +
  "{" +
  "float: right;" +
  "background-color: #ABD15B;" +
  "background-image: url(resources/icons/bank-operations/transfers.png);" +
  "color: white;" +
  "background-repeat: no-repeat;" +
  "background-size: 65%;" +
  "background-position: center;" +
  "height: 100%;" +
  "width:" + 80 * widthK + "px;" +
  "}",

  invoiceCardFromLabel: ".invoice-card-from-label" +
  "{" +
  "color: #8f8f8f;" +
  "margin:" + 5 * widthK + "px 0 0 " + 20 * widthK + "px;" +
  "font-size:" + 27 * widthK + "px;" +
  "}",

  invoiceCardFromSenderNumber: ".invoice-card-from-sender-number" +
  "{" +
  "color: #8f8f8f;" +
  "margin: 0 0 0 " + 20 * widthK + "px;" +
  "font-size:" + 28 * widthK + "px;" +
  "}",

  invoiceCardDate: ".invoice-card-date" +
  "{" +
  "color: #b5b5b5;" +
  "margin:" + 10 * widthK + "px " + 10 * widthK + "px " + 10 * widthK + "px " + 20 * widthK + "px;" +
  "font-size:" + 25 * widthK + "px;" +
  "float: left;" +
  "word-spacing:" + 15 * widthK + "px;" +
  "}",

  invoiceCardTransferSumHolder: ".invoice-card-transfer-sum-holder" +
  "{" +
  "float: right;" +
  "color: #ABD15B;" +
  "margin:" + 5 * widthK + "px " + 20 * widthK + "px " + 10 * widthK + "px 0;" +
  "}",

  invoiceCardSumMarked: ".invoice-card-sum-marked" +
  "{" +
  "background-color: transparent;" +
  "font-size:" + 21 * widthK + "px;" +
  "color: inherit;" +
  "}",

  invoiceCardPayment: ".invoice-card-payment" +
  "{" +
  "float: right;" +
  "background-color: #FC8379;" +
  "background-image: url(resources/icons/bank-operations/payment.png);" +
  "color: white;" +
  "background-repeat: no-repeat;" +
  "background-size: 55%;" +
  "background-position: center;" +
  "height: 100%;" +
  "width:" + 80 * widthK + "px;" +
  "}",

  invoiceCardPaymentSumHolder: ".invoice-card-payment-sum-holder" +
  "{" +
  "float: right;" +
  "color: #FC8379;" +
  "margin:" + 5 * widthK + "px " + 20 * widthK + "px " + 10 * widthK + "px 0;" +
  "}",

  invoiceCardSum: ".invoice-card-sum" +
  "{" +
  "background-color: inherit;" +
  "color: inherit;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "max-width:" + 130 * widthK + "px;" +
  "white-space: nowrap;" +
  "margin: 0;" +
  "margin-right:" + 7 * widthK + "px;" +
  "float: left;" +
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

  //cardBankNameUrl: ".card-bank-name-url " +
  //"{" +
  //"position: absolute;" +
  //"width:" + 240 * widthK + "px;" +
  //"height:" + 90 * widthK + "px;" +
  //"background-size: contain;" +
  //"background-repeat: no-repeat;" +
  //"background-position: left top;" +
  //"left:" + 30 * widthK + "px;" +
  //"top:" + 20 * widthK + "px" +
  //"}",

  cardSalaryTitle: ".card-salary-title " +
  "{" +
  "position: absolute;" +
  "top:" + 134 * widthK + "px;" +
  "left:" + 25 * widthK + "px;" +
  "background-size: contain;" +
  "font-size:" + 23 * widthK + "px;" +
  "height: 10%;" +
  "width: 90%;" +
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "}",

  cardBalansCurrencyContainer: ".card-balance-currency-container " +
  "{" +
  "position: absolute;" +
  "width:" + 500 * widthK + "px;" +
  "top:" + 163 * widthK + "px;" +
  "display: inline-block;" +
  "margin: 0;" +
  "overflow: hidden;" +
  "}",

  cardBalance: ".card-balance " +
  "{" +
  "position: relative;" +
  "left:" + 25 * widthK + "px;" +
  "font-size:" + 44 * widthK + "px;" +
  "margin: 0;" +
  "margin-top:" + -2 * widthK + "px;" +
  "float: left;" +
  "padding: 0;" +
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "}",

  cardCurrency: ".card-currency " +
  "{" +
  "position: relative;" +
  "margin-left:" + 35 * widthK + "px;" +
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
  "-webkit-text-shadow: white -1px -1px 0.4px, black 0.0px 1px 0.2px, white -1px -1px 0.4px, black 0.0px 1px 0.4px;" +
  "color: transparent;" +
  "font-family: Orator;" +
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
  "word-spacing:" + -8 * widthK + "px;" +
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
  "position: relative;" +
  "width:" + 125 * widthK + "px;" +
  "height:" + 125 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "border-radius:" + 100 * widthK + "px;" +
  "border:" + 1 + "px solid #f1f1f1;" +
  "background-size: 80%;" +
  "float: left;" +
  "margin-right: 20px;" +
  "}",


  serviceEachContainer: ".service-each-container" +
  "{" +
  "position: relative;" +
  "width: " + 127 * widthK + "px;" +
  "height: " + 200 * widthK + "px;" +
    //"border: 1px solid red;" +
  "float: left;" +
  "margin-right: " + 20 * widthK + "px;" +
  "}",

  beelineButton: ".beeline-button " +
  "{" +
  "background-image: url(resources/icons/services/beelineS.png);" +
  "background-size: 60%;" +
    //"left:" + 152 * widthK + "px;" +
  "}",

  ucellButton: ".ucell-button " +
  "{" +
    //"left:" + 15 * widthK + "px;" +
  "top:" + 0 * widthK + "px;" +
  "background-image: url(resources/icons/services/ucellS.png);" +
  "background-size: 80%;" +
  "}",

  umsButton: ".ums-button " +
  "{" +
    //"left:" + 288 * widthK + "px;" +
  "background-position: center;" +
  "background-image: url(resources/icons/services/umsS.png);" +
  "background-size: 60%;" +
  "}",

  myPhoneButton: ".my-phone-button " +
  "{" +
    //"left:" + 425 * widthK + "px;" +
  "top: 0;" +
  "background-position-x:" + 35 * widthK + "px;" +
  "background-image: url(resources/icons/ViewPay/myphone.png);" +
  "background-size: 60%;" +
  "}",

  serviceLabels: ".service-labels " +
  "{" +
  "position: absolute;" +
  "bottom:0;" +
  "font-size:" + 25 * widthK + "px;" +
  "color: grey;" +
  "width: 100%;" +
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "text-align: center;" +
  "}",

  serviceLabelsUcell: ".service-labels-ucell " +
  "{" +
  "left:" + 40 * widthK + "px;" +
  "bottom:" + -80 * widthK + "px;" +
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

  sideMenuBlockForSwipe: ".side-menu-block-for-swipe " +
  "{" +
  "position: absolute;" +
  "height: 100%;" +
  "top:" + 90 * widthK + "px;" +
  "z-index: 1;" +
  "width:" + 60 * widthK + "px;" +
  "}",

  sideMenu: ".side-menu " +
  "{" +
  "position: absolute;" +
  "height: 100%;" +
  "width:" + 538 * widthK + "px;" +
  "overflow: hidden;" +
  "transform: translate3d(-100%, 0, 0);" +
  "-webkit-transform: translate3d(-100%, 0, 0);" +
  "-ms-transform: translate3d(-100%, 0, 0);" +
  "background-color: #22a0e0;" +
  "z-index: 1;" +
    //"top:" + topOfIos + "px;" +
  "}",

  sideMenuInsideButton: ".side-menu-inside-button " +
  "{" +
  "position: absolute;" +
  "height: 6%;" +
  "width: 15%;" +
  "top: 0.3%;" +
  "left: 4%;" +
  "background-image: url(resources/icons/toolbar/menus.png);" +
  "background-repeat: no-repeat;" +
  "background-size: 45%;" +
  "background-position: center;" +
  "}",

  sideMenuUserInfoContainer: ".side-menu-user-info-container " +
  "{" +
  "position: absolute;" +
  "height:" + 215 * widthK + "px;" +
  "width:" + 300 * widthK + "px;" +
  "top: 2%;" +
  "right: 0;" +
  "}",

  sideMenuUserIcon: ".side-menu-user-icon " +
  "{" +
  "position: absolute;" +
  "height:" + 99 * widthK + "px;" +
  "width:" + 95 * widthK + "px;" +
  "left: 52%;" +
  "border:" + 4 * widthK + "px solid white;" +
  "border-radius:" + 50 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "background-position: center;" +
  "}",

  sideMenuUserFirstName: ".side-menu-user-first-name " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "padding: 0;" +
  "bottom:" + 21 * widthK + "px;" +
  "right: 14%;" +
  "color: white;" +
  "}",

  sideMenuUserSecondName: ".side-menu-user-second-name " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "padding: 0;" +
  "bottom:" + 53 * widthK + "px;" +
  "right: 14%;" +
  "color: white;" +
  "}",

  sideMenuBillingsContainer: ".side-menu-billings-container " +
  "{" +
  "position: relative;" +
  "top: 32.2%;" +
  "height: 6%;" +
  "width: 77%;" +
  "left: 8%;" +
  "border-bottom: 1px solid #43aee5;" +
  "}",

  sideMenuFavoriteContainer: ".side-menu-favorite-container " +
  "{" +
  "position: relative;" +
  "top: 32.7%;" +
  "height: 6%;" +
  "width: 77%;" +
  "left: 8%;" +
  "border-bottom: 1px solid #43aee5;" +
  "}",

  sideMenuAutoPayContainer: ".side-menu-auto-pay-container " +
  "{" +
  "position: relative;" +
  "top: 32.7%;" +
  "height: 6%;" +
  "width: 77%;" +
  "left: 8%;" +
  "border-bottom: 1px solid #43aee5;" +
  "}",

  sideMenuScannerQrContainer: ".side-menu-scanner-qr-container " +
  "{" +
  "position: relative;" +
  "top: 32.7%;" +
  "height: 6%;" +
  "width: 77%;" +
  "left: 8%;" +
  "border-bottom: 1px solid #43aee5;" +
  "}",

  sideMenuSettingsContainer: ".side-menu-settings-container " +
  "{" +
  "position: relative;" +
  "top: 39.4%;" +
  "height: 7%;" +
  "width: 77%;" +
  "left: 8%;" +
  "border-bottom: 1px solid #43aee5;" +
  "}",


  sideMenuCallContainer: ".side-menu-call-container " +
  "{" +
  "position: relative;" +
  "top: 38.7%;" +
  "height: 6%;" +
  "width: 77%;" +
  "left: 8%;" +
    //"border-bottom: 1px solid #43aee5;" +
  "}",

  sideMenuContainersIcon: ".side-menu-containers-icon " +
  "{" +
  "position: absolute;" +
  "width: 9%;" +
  "height: 81%;" +
  "top: 7%;" +
  "left: 0%;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "}",

  sideMenuContainersIconSettings: ".side-menu-containers-icon-settings" +
  "{" +
  "background-image: url(resources/icons/menu/menu_settings.png);" +
  "background-size: 100%;" +
  "}",

  sideMenuContainersIconBillings: ".side-menu-containers-icon-billings" +
  "{" +
  "background-image: url(resources/icons/menu/menu_bills.png);" +
  "background-size: 100%;" +
  "}",

  sideMenuContainersIconAutopayment: ".side-menu-containers-icon-autopayment" +
  "{" +
  "background-image: url(resources/icons/menu/menu_autopayment.png);" +
  "background-size: 100%;" +
  "}",

  sideMenuContainersIconScannerQr: ".side-menu-containers-icon-scanner-qr" +
  "{" +
  "background-image: url(resources/icons/menu/menu_qr.png);" +
  "background-size: 100%;" +
  "}",

  sideMenuContainersIconCall: ".side-menu-containers-icon-call" +
  "{" +
  "background-image: url(resources/icons/menu/menu_call.png);" +
  "background-size: 100%;" +
  "top: 22%;" +
  "}",

  sideMenuContainersIconFavorite: ".side-menu-containers-icon-favorite" +
  "{" +
  "background-image: url(resources/icons/menu/menu_favorites.png);" +
  "background-size: 100%;" +
  "}",


  sideMenuContainersName: ".side-menu-containers-name " +
  "{" +
  "position: absolute;" +
  "top: 25.5%;" +
  "left: 16%;" +
  "font-size:" + 29 * widthK + "px;" +
  "color: white;" +
  "}",

  sideMenuContainersNameAutopayment: ".side-menu-containers-name-autopayment " +
  "{" +
  "}",

  sideMenuContainersNameScannerQr: ".side-menu-containers-name-scanner-qr " +
  "{" +
  "}",

  sideMenuContainersNameSettings: ".side-menu-containers-name-settings " +
  "{" +
  "}",

  sideMenuContainersNameCall: ".side-menu-containers-name-call " +
  "{" +
  "top: 33%;" +
  "}",

  sideMenuChangeMode: ".side-menu-change-mode " +
  "{" +
  "position: absolute;" +
  "top: 22%;" +
  "height: 7%;" +
  "width: 100%;" +
  "background-color: #92bf3a;" +
  "color: white;" +
  "}",

  sideMenuChangeModeText: ".side-menu-change-mode-text " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "padding: 0;" +
  "top: 29%;" +
  "left: 20.2%;" +
  "font-size:" + 29 * widthK + "px;" +
  "word-spacing:" + 2 * widthK + "px;" +
  "}",

  switchMenu: ".switch-menu" +
  "{" +
  "position: absolute;" +
  "display: block;" +
  "width:" + 37 * widthK + "px;" +
  "top: 35%;" +
  "right: 7%;" +
  "height:" + 20 * widthK + "px;" +
  "border: 1px solid white;" +
  "border-radius:" + 50 * widthK + "px;" +
  "}",

  switchMenuInput: ".switch-menu input" +
  "{" +
  "display: none;" +
  "}",

  sliderMenu: ".slider-menu" +
  "{" +
  "position: absolute;" +
  "cursor: pointer;" +
  "top: 0;" +
  "left: 0;" +
  "bottom: 0;" +
  "background-color: #ccc;" +
  "-webkit-transition: .4s;" +
  "transition: .4s;" +
  "}",

  sliderMenuBefore: ".slider-menu:before" +
  "{" +
  "position: absolute;" +
  "content: '';" +
  "height:" + 12 * widthK + "px;" +
  "width:" + 12 * widthK + "px;" +
  "left:" + 4 * widthK + "px;" +
  "bottom:" + 13 * widthK + "px;" +
  "background-color: white;" +
  "-webkit-transition: .4s;" +
  "transition: .4s;" +
  "}",

  inputCheckedSlider: "input:checked + .slider-menu" +
  "{" +
  "background-color: #2196F3;" +
  "}",

  inputFocusSlider: "input:focus + .slider-menu" +
  "{" +
  "box-shadow: 0 0 1px #2196F3;" +
  "}",

  inputCheckedSliderBefore: "input:checked + .slider-menu:before" +
  "{" +
  "-webkit-transform: translateX(" + 17 * widthK + "px);" +
  "transform: translateX(" + 17 * widthK + "px);" +
  "}",

  sliderMenuRound: ".slider-menu.round" +
  "{" +
  "border-radius:" + 34 * widthK + "px;" +
  "position: absolute;" +
  "top:" + 29 * widthK + "px;" +
  "}",

  sliderMenuRoundBefore: ".slider-menu.round:before" +
  "{" +
  "border-radius: 50%;" +
  "}",


  sideMenuChangeModeIcon: ".side-menu-change-mode-icon " +
  "{" +
  "position: absolute;" +
  "width: 12%;" +
  "height: 80%;" +
  "top: 7%;" +
  "left: 6%;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-image: url(resources/icons/menu/menu_online.png);" +
  "background-size: 56%;" +
  "}",

  sideMenuBackPage: ".side-menu-back-page " +
  "{" +
  "position: absolute;" +
  "height: 100%;" +
  "width: 100%;" +
  "overflow: hidden;" +
  "transform: translate3d(0, 0, 0);" +
  "-webkit-transform: translate3d(0, 0, 0);" +
  "-ms-transform: translate3d(0, 0, 0);" +
  "background-color: rgba(0, 0, 0, 0.6);" +
  "opacity: 0;" +
  "}",

  //TITLE COMPONENT

  pageTitle: ".page-title " +
  "{" +
  "position: absolute;" +
  "top: 0px;" +
  "right:" + 28 * widthK + "px;" +
  "left:" + 25 * widthK + "px;" +
  "height:" + 87 * widthK + "px;" +
  "background: transparent;" +
  "border-bottom: 2px solid white;" +
  "}",

  nameTitle: ".name-title " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size:" + 35 * widthK + "px;" +
  "left: 12.5%;" +
  "top: 31%;" +
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
  "background-position-y:" + 27 * widthK + "px;" +
  "background-position-x:" + 44 * widthK + "px;" +
  "background-size: 17%;" +
  "left: -3%;" +
  "top: 0;" +
  "}",

  settingsButton: ".settings-button " +
  "{" +
  "position: absolute;" +
  "width:" + 144 * widthK + "px;" +
  "height:" + 92 * widthK + "px;" +
  "right:" + -36 * widthK + "px;" +
  "background-image: url(resources/icons/ViewMyCards/cardsettings.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 31%;" +
  "background-position-y: center;" +
  "background-position-x:" + 54 * widthK + "px;" +
  "background-size: 31%;" +
  "top: 0;" +
  "}",

  searchButton: ".search-button " +
  "{" +
  "position: absolute;" +
  "width:" + 83 * widthK + "px;" +
  "height:" + 68 * widthK + "px;" +
  "right:" + -15 * widthK + "px;" +
  "background-image: url(resources/icons/search/search.png);" +
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
  "border-top:" + 2 + "px solid rgb(37, 160, 227);" +
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
  "position: absolute;" +
  "bottom: 0;" +
  "left: 0;" +
  "right: 0;" +
  "transition: 0.3s;" +
  "-webkit-transition: 0.3s;" +
  "height:" + 300 * widthK + "px;" +
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
  "color: #027ee3;" +
  "background-color: #7ae4ff;" +
  "top: 0;" +
  "background-repeat: no-repeat;" +
  "background-size: cover;" +
  "text-align: center;" +
  "line-height:" + 100 * widthK + "px;" +
  "font-size:" + 50 * widthK + "px;" +
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
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
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
  "border-bottom: 2px solid #95e6fd;" +
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
  "border-bottom:" + 2 + "px solid #dedfe0;" +
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

  //VIEW CARD EDIT

  cardEditBodyContainer: ".card-edit-body-container" +
  "{" +
  "position: absolute;" +
  "height:" + 1150 * widthK + "px; " +
  "width:" + 720 * widthK + "px; " +
  "top:" + 86 * widthK + "px; " +
  "bottom:0; " +
  "background-color: white; " +
  "overflow-y: auto; " +
  "overflow-x: hidden; " +
  "}",

  checkButton: ".check-button " +
  "{" +
  "position: absolute;" +
  "width:" + 144 * widthK + "px;" +
  "height:" + 92 * widthK + "px;" +
  "right:" + -36 * widthK + "px;" +
  "background-image: url('resources/icons/ViewService/unchecked.png');" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 31%;" +
  "background-position-y: center;" +
  "background-position-x:" + 54 * widthK + "px;" +
  "background-size: 31%;" +
  "top: 0;" +
  "}",

  cardEditField: ".card-edit-field" +
  "{position: relative;" +
  "left: 10%;" +
  "width: 79.5%;" +
  "height: 9%;" +
  "border-bottom:  " + 5 * widthK + "px solid #01cfff;" +
  "color: white;" +
  "top: 6%" +
  "}",

  cardEditTextField: ".card-edit-text-field" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 24 * widthK + "px; " +
  "bottom: 88%;" +
  "}",

  cardEditInput: ".card-edit-input" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: absolute;" +
  "top: 26%;" +
  "width: 88%;" +
  "height: 69%;" +
  "font-size:" + 49 * widthK + "px; " +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "padding: 0;" +
  "margin: 0;" +
  "}",

  cardEditMakeMainContainer: ".card-edit-makemain-container" +
  "{" +
  "position: relative;" +
  "width: 79.5%;" +
  "height: " + 70 * widthK + "px; " +
  "top:12%;" +
  "left:10%;" +
  "}",

  cardEditMakeMainText: ".card-edit-makemain-text" +
  "{" +
  "position: absolute;" +
  "font-size: " + 28 * widthK + "px; " +
  "color: #595759;" +
  "}",

  cardEditMakeMainCheck: ".card-edit-makemain-check" +
  "{" +
  "position: absolute;" +
  "background-image: url('resources/icons/ViewService/unchecked.png');" +
  "width: 7%;" +
  "height: 36%;" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "background-position: center;" +
  "top: 50%;" +
  "left: 93%;" +
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
  "border-bottom:" + 1 + "px solid #f4f4f4;" +
  "}",

  viewInfoBackButton: ".view-info-back-button " +
  "{position: absolute;" +
  "left:" + 10 * widthK + "px;" +
  "width:" + 100 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "top:" + 5 * widthK + "px;" +
  "border-radius:" + 90 * widthK + "px;" +
  "border:" + 1 + "px solid #e5e5e5;" +
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
  "border-bottom:" + 1 + "px solid #f4f4f4;" +
  "}",

  viewInfoCardBalanceCurrencyContainer: ".view-info-card-balance-currency-container " +
  "{" +
  "position: absolute;" +
  "width: 70%;" +
  "top: 38%;" +
  "left: 19%;" +
  "display: inline-block;" +
  "margin: 0;" +
  "overflow: hidden;" +
  "}",

  viewInfoCardBalance: ".view-info-card-balance " +
  "{" +
  "position: relative;" +
  "left:" + 25 * widthK + "px;" +
  "color: #585658;" +
  "font-size:" + 67 * widthK + "px;" +
  "margin: 0;" +
  "margin-top:" + -2 * widthK + "px;" +
  "float: left;" +
  "color: #91cc00;" +
  "padding: 0;" +
  "overflow: hidden;" +
  "text-overflow: ellipsis;" +
  "white-space: nowrap;" +
  "width: 78%;" +
  "}",

  viewInfoCardCurrency: ".view-info-card-currency " +
  "{" +
  "position: relative;" +
  "margin-left:" + 30 * widthK + "px;" +
  "color: #595759;" +
  "top:" + 12 * widthK + "px;" +
  "font-size:" + 26 * widthK + "px;" +
  "background-size: contain;" +
  "float: left;" +
  "color: #91cc00;" +
  "width:" + 60 * widthK + "px;" +
  "}",

  viewInfoMyFinanceContainer: ".view-info-my-finance-container " +
  "{" +
  "position: absolute;" +
  "right:" + 30 * widthK + "px;" +
  "left:" + 30 * widthK + "px;" +
  "height:" + 125 * widthK + "px;" +
  "top:" + 280 * widthK + "px;" +
  "border-bottom:" + 1 + "px solid #f4f4f4;" +
  "}",

  viewInfoReportsContainer: ".view-info-reports-container " +
  "{" +
  "position: absolute;" +
  "right:" + 30 * widthK + "px;" +
  "left:" + 30 * widthK + "px;" +
  "height:" + 125 * widthK + "px;" +
  "top:" + 408 * widthK + "px;" +
  "border-bottom:" + 1 + "px solid #f4f4f4;" +
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

  viewInfoAttentionIcon: ".view-info-attention-icon " +
  "{" +
  "position: absolute;" +
  "width: 11%;" +
  "height: 38%;" +
  "right: 1.5%;" +
  "top: 50%;" +
  "background-image: url(resources/icons/ViewInfo/attention.png);" +
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
  "overflow-x: auto;" +
  "overflow-y: hidden;" +
  "font-size:" + 23 * widthK + "px;" +
  "}",

  viewInfoOperationsIcon: ".view-info-operations-icon " +
  "{" +
  "top:" + 50 * widthK + "px;" +
  "background-size: 80%;" +
  "position: absolute;" +
  "width:" + 125 * widthK + "px;" +
  "height:" + 125 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "border-radius:" + 100 * widthK + "px;" +
    //"border:solid 1px #b7b7b7;" +
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
  "color: #8b8b8b;" +
  "}",

  viewInfoOperationInfoName: ".view-info-operation-info-name " +
  "{" +
  "position: absolute;" +
  "height: 25%;" +
  "top: -8%;" +
  "left: 8%;" +
  "margin: 0;" +
  "text-overflow: ellipsis;" +
  "white-space: nowrap;" +
  "overflow: hidden;" +
  "width: 65%;" +
  "}",

  viewInfoOperationInfoBalance: ".view-info-operation-info-balance " +
  "{" +
  "position: absolute;" +
  "top: 9%;" +
  "left: 8%;" +
  "margin: 0;" +
  "font-size:" + 45 * widthK + "px;" +
  "color: #ee4d3d;" +
  "}",

  viewInfoOperationInfoNumber: ".view-info-operation-info-number " +
  "{" +
  "position: absolute;" +
  "height: 25%;" +
  "top: 50%;" +
  "left: 8%;" +
  "margin: 0;" +
  "}",

  viewInfoOperationInfoDate: ".view-info-operation-info-date " +
  "{" +
  "position: absolute;" +
  "height: 25%;" +
  "top: 81%;" +
  "left: 9%;" +
  "margin: 0;" +
  "}",

  viewInfoBalanceLabel: ".view-info-balance-label" +
  "{" +
  "position: absolute;" +
  "left: 23%;" +
  "top: 13%;" +
  "font-size:" + 23 * widthK + "px;" +
  "color: #c2c2c2;" +
  "}",

  payNameTitle: ".pay-name-title " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size:" + 35 * widthK + "px; " +
  "left:" + 85 * widthK + "px; " +
  "top:" + 38 * widthK + "px; " +
  "margin: 0;  " +
  "color: #fffaf9;" +
  "}",

  payBackButton: ".pay-back-button " +
  "{" +
  "position: absolute;" +
  "width:" + 113 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "background-image: url(resources/icons/back/back.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 19%;" +
  "background-position-y: 62%;" +
  "background-position-x: center;" +
  "background-size: 17%;" +
  "right: 87%;" +
  "}",

  paySearchButton: ".pay-search-button " +
  "{" +
  "position: absolute;" +
  "width:" + 127 * widthK + "px;" +
  "height:" + 86 * widthK + "px;" +
  "left:85%;" +
  "background-image: url(resources/icons/search/search.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 55%;" +
  "background-position-y: center;" +
  "background-position-x:center;" +
  "background-size: 27%;" +
  "top:" + 12 * widthK + "px;" +
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
  "min-height:" + 100 * widthK + "px; " +
  "width: 100%;" +
  "margin-top: 1%;" +
  "border-bottom:" + 3 * widthK + "px solid gainsboro;" +
  "background-color: transparent;" +
  "}",

  payServiceHintContainer: ".pay-service-hint-containter" +
  "{" +
  "position: absolute;" +
  "height:" + 100 * widthK + "px; " +
  "width: 100%;" +
  "margin-top: 1%;" +
  "border-bottom:" + 3 * widthK + "px solid gainsboro;" +
  "z-index: 999999;" +
  "background-color: aliceblue;" +
  "top:" + 78 * widthK + "px; " +
  "position:fixed;" +
  "display: none;" +
  "}",

  payServicesBlock: ".pay-services-block" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "margin-bottom: 4%;" +
  "margin-top: 10%;" +
  "margin-left:" + 35 * widthK + "px;" +
  "padding: 0;" +
  "overflow: hidden;" +
  "}",

  payServiceIcon: ".pay-service-icon" +
  "{" +
  "position: relative;" +
  "width: 75%;" +
  "height: " + 150 * widthK + "px; " +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
    //"border-radius: " + 100 * widthK + "px;" +
  "border: " + 1 + "px solid white;" +
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
  "top: 104%;" +
  "width: 100%;" +
  "height: 40%;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +

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

  //viewPay: ".view-pay" +
  //"{" +
  //"position: absolute;" +
  //"width: 100%;" +
  //"height: 100%;" +
  //"overflow-y: hidden;" +
  //"background-size: contain;" +
  //"background-repeat: no-repeat;" +
  //"background-image: url('resources/icons/background/transparent.png');" +
  //"}",

  //viewServicePage: ".view-service-page" +
  //"{" +
  //"position: absolute;" +
  //"width: 100%;" +
  //"height: 100%;" +
  //"overflow: hidden;" +
  //"background-size: contain;" +
  //"background-repeat: no-repeat;" +
  //  //"background-image: url('resources/draft/servicepage.png')" +
  //"background-image: url('resources/icons/background/transparent.png');" +
  //"}",

  //viewServicePincards: ".view-service-pincards" +
  //"{" +
  //"position: absolute;" +
  //"width: 100%;" +
  //"height: 100%;" +
  //"overflow: hidden;" +
  //"background-size: contain;" +
  //"background-repeat: no-repeat;" +
  //  //"background-image: url('resources/draft/servicepincards.png');" +
  //"background-image: url('resources/icons/background/transparent.png');" +
  //"}",
  //
  //viewPayConfirm: ".view-pay-confirm" +
  //"{" +
  //"position: absolute;" +
  //"width: 100%;" +
  //"height: 100%;" +
  //"overflow: hidden;" +
  //"background-size: contain;" +
  //"background-repeat: no-repeat;" +
  //  //"background-image: url('resources/draft/payconfirm.png');" +
  //"background-image: url('resources/icons/background/transparent.png');" +
  //"}",
  //
  //viewMycardList: ".view-mycard-list" +
  //"{" +
  //"position: absolute;" +
  //"width: 100%;" +
  //"height: 100%;" +
  //"overflow: hidden;" +
  //"background-size: contain;" +
  //"background-repeat: no-repeat;" +
  //  //"background-image: url('resources/draft/mycardList.png');" +
  //"background-image: url('resources/icons/background/transparent.png');" +
  //"}",

  payIconTick: ".pay-icon-tick " +
  "{" +
  "position: relative;" +
  "left:" + 653 * widthK + "px;" +
  "background-size: contain;" +
  "background-image: url(resources/icons/ViewPay/catopen.png);" +
  "background-repeat: no-repeat;" +
  "width:" + 19 * widthK + "px;" +
  "height:" + 18 * widthK + "px;" +
  "top:" + 9 * widthK + "px;" +
  "}",

  payPageTitle: ".pay-page-title " +
  "{" +
  "position: absolute;" +
  "top:" + -12 * widthK + "px;" +
  "right:" + 28 * widthK + "px;" +
  "left:" + 25 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "background: transparent;" +
    //"border-bottom:" + 2 + "px solid rgb(149, 230, 253);" +
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
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "width: 60%;" +
  "}",

  servicePageCategoryField: ".servicepage-category-field" +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size: " + 29 * widthK + "px; " +
  "left: 13%;" +
  "top: 87%;" +
  "margin: 0;" +
  "color: lavender;" +
  "}",

  servicePageServiceIcon: ".servicepage-service-icon" +
  "{" +
  "top: 33%;" +
  "position: relative;" +
  "width: 13%;" +
  "height: 91%;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "border-radius: 50%;" +
    //"border: " + 1 + "px solid gray;" +
  "float: right;" +
  "right: 4%;" +
  "background-size: 150%;" +
  "background-color: white;" +
  "}",

  servicePageBodyContainer: ".servicepage-body-container" +
  "{" +
  "position: absolute;" +
  "height: " + 1092 * heightK + "px; " +
  "width: " + 720 * widthK + "px; " +
  "top: " + 140 * heightK + "px; " +
  "background-color: white;" +
  "overflow-x: hidden;" +
  "overflow-y: scroll;" +
  "}",

  pincardBodyContainer: ".pincard-body-container" +
  "{" +
  "position: absolute;" +
  "height: " + 1092 * heightK + "px; " +
  "width: " + 720 * widthK + "px; " +
  "top: " + 140 * heightK + "px; " +
  "background-color: white;" +
  "overflow-x: hidden;" +
  "overflow-y: scroll;" +
  "}",

  payconfirmBodyContainer: ".payconfirm-body-container" +
  "{" +
  "position: absolute;" +
  "height: " + 1092 * heightK + "px; " +
  "width: " + 720 * widthK + "px; " +
  "top: " + 140 * heightK + "px; " +
  "background-color: white;" +
  "overflow-x: hidden;" +
  "overflow-y: scroll;" +
  "border-bottom: 1px solid black;" +
  "}",

  componentFirstField: ".component-first-field" +
  "{" +
  "position: absolute;" +
  "opacity: 0.97;" +
  "height: 100%;" +
  "width: 100%;" +
  "background-color: #353340;" +
  "display: none;" +
  "}",

  servicePageFieldsDropdown: ".servicepage-fields-dropdown" +
  "{" +
  "position: relative;" +
  "width: 79.5%;" +
  "height: 9%;" +
  "left: 10%;" +
  "color: white;" +
  "border-bottom:" + 5 * widthK + "px solid lightgray;" +
  "}",

  servicePageFieldsDropdownTwo: ".servicepage-fields-dropdown-two" +
  "{" +
  "position: absolute;" +
  "width: 79.5%;" +
  "height: 8%;" +
  "left: 10%;" +
  "top: 12%;" +
  "color: white;" +
  "border-bottom:" + 5 * widthK + "px solid #95e6fd;" +
  "}",

  servicePageDropdownTextField: ".servicepage-dropdown-text-field" +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size:" + 32 * widthK + "px;" +
  "top: 40%;" +
  "margin: 0;" +
  "color: #515151;" +
  "width: 92%;" +
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "}",

  servicePageDropdownContainer: ".servicepage-dropdown-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 55%;" +
  "top: 22%;" +
  "overflow: scroll;" +
  "}",

  servicePageDropdownVariant: ".servicepage-dropdown-variant" +
  "{" +
  "position: relative;" +
  "width: 79.5%;" +
  "height:" + 125 * widthK + "px;" +
  "background-color: white;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "margin-bottom:" + 5 * widthK + "px;" +
  "}",

  servicePageFirstField: ".servicepage-first-field" +
  "{" +
  "position: relative;" +
  "left: 10%;" +
  "width: 79.5%;" +
  "height: 9%;" +
  "border-bottom:  " + 5 * widthK + "px solid #01cfff;" +
  "color: white;" +
  "top: 5.5%;" +
  "}",

  servicePagePhoneField: ".servicepage-phone-field" +
  "{" +
  "position: relative;" +
  "left: 10%;" +
  "width: 79.5%;" +
  "height: 9%;" +
  "border-bottom:" + 5 * widthK + "px solid lightgray;" +
  "color: white;" +
  "top: 4.5%" +
  "}",

  servicePagePhoneIcon: ".servicepage-phone-icon" +
  "{" +
  "position: relative;" +
  "float: right;" +
  "background-image: url('resources/icons/ViewService/book.png');" +
  "width: 13%;" +
  "height: 65%;" +
  "background-repeat: no-repeat;" +
  "background-size: 60%;" +
  "background-position: center;" +
  "top: 27%;" +
  "right: -2%;" +
  "}",

  servicePageAmountField: ".servicepage-amount-field" +
  "{position: relative;" +
  "left: 10%;" +
  "width: 79.5%;" +
  "height: 9%;" +
  "border-bottom:  " + 5 * widthK + "px solid lightgray;" +
  "color: white;" +
  "top: 10%" +
  "}",

  servicePageAmountFieldTwo: ".servicepage-amount-field-two" +
  "{position: relative;" +
  "left: 10%;" +
  "width: 79.5%;" +
  "height: 8%;" +
  "border-bottom:  " + 5 * widthK + "px solid lightgray;" +
  "color: white;" +
  "top: 11%;" +
  "}",

  servicePageAmountIcon: ".servicepage-amount-icon" +
  "{" +
  "position: relative;" +
  "float: right;" +
  "background-image: url('resources/icons/ViewService/calc.png');" +
  "width: 7%;" +
  "height: 50%;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: 100%;" +
  "top: 40%;" +
  "}",


  servicePageTextField: ".servicepage-text-field" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 24 * widthK + "px; " +
  "bottom: 88%;" +
  "}",

  servicePageNumberFirstPart: ".servicepage-number-first-part" +
  "{" +
  "float: left;" +
  "position: relative;" +
  "top: 22%;" +
  "font-size: " + 56 * widthK + "px; " +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "margin: 0;" +
  "}",

  servicePageAmountInput: ".servicepage-amount-input" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "top: 22%;" +
  "width: 88%;" +
  "font-size:" + 56 * widthK + "px; " +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "padding: 0;" +
  "margin: 0;" +
  "}",

  servicePageNumberInputPart: ".servicepage-number-input-part" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "top: 22%;" +
  "padding: 0;" +
  "margin: 0;" +
  "margin-left: 3%;" +
  "width: 57%;" +
  "font-size:" + 56 * widthK + "px; " +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "}",

  servicePageNumberInputPartTwo: ".servicepage-number-input-part-two" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: absolute;" +
  "top: 26%;" +
  "padding: 0;" +
  "margin: 0;" +
  "width: 100%;" +
  "height: 69%;" +
  "font-size:" + 56 * widthK + "px; " +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "}",

  servicePageNumberInputPartThree: ".servicepage-number-input-part-three" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: absolute;" +
  "top: 21%;" +
  "padding: 0;" +
  "margin: 0;" +
  "width: 100%;" +
  "height: 69%;" +
  "font-size:" + 56 * widthK + "px; " +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "}",


  servicePagePhoneInput: ".servicepage-phone-input" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "top: 59%;" +
  "font-size: " + 28 * widthK + "px; " +
  "color: #515151;" +
  "}",


  servicePageButtonEnter: ".servicepage-button-enter" +
  "{" +
  "position: relative;" +
  "width: " + 450 * widthK + "px; " +
  "height: " + 90 * widthK + "px; " +
  "margin-right: auto;" +
  "border-radius: " + 80 * widthK + "px; " +
  "margin-left: auto;" +
  "background-color: rgb(1, 124, 227);" +
  "top: 16%;" +
  "}",

  servicePageButtonEnterLabel: ".servicepage-button-enter-label" +
  "{" +
  "position: relative;" +
  "top:" + 15 * widthK + "px; " +
  "width: 30%;" +
  "font-size:  " + 45 * widthK + "px; " +
  "margin: auto;" +
  "color: white;" +
  "}",

  servicePageButtonBack: ".servicepage-button-back" +
  "{" +
  "top: 13%;" +
  "position: absolute;" +
  "width: 17%;" +
  "height: 140%;" +
  "background-image: url('resources/icons/back/back.png');" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 20%;" +
  "background-position-y: center;" +
  "background-position-x: center;" +
  "background-size: 20%;" +
  "left: -4%;" +
  "}",

  servicePageFormTypeTwoContainer: ".servicepage-formtype-two-container" +
  "{" +
  "position: absolute;" +
  "height: " + 1092 * heightK + "px; " +
  "width: " + 720 * widthK + "px; " +
  "top: " + 140 * heightK + "px; " +
  "background-color: white;" +
  "overflow-x: hidden;" +
  "overflow-y: scroll;" +
  "}",

  servicePagePincardsContainer: ".servicepage-pincards-container" +
  "{" +
  "position: relative;" +
  "width: 85%;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "padding-top: 4%;" +
  "padding-bottom: 4%;" +
  "border-bottom: 1px solid gray;" +
  "}",

  servicePagePincardTitle: ".servicepage-pincard-title" +
  "{" +
  "position: relative;" +
  "font-size: " + 24 * widthK + "px; " +
  "color: #595759;" +
  "width: 100%;" +
  "height: " + 25 * widthK + "px; " +
  "}",

  servicePagePincardNominalContainer: ".servicepage-pincard-nominal-container" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: " + 70 * widthK + "px; " +
  "}",

  servicePagePincardNominalValue: ".servicepage-pincard-nominal-value" +
  "{" +
  "position: absolute;" +
  "font-size: " + 28 * widthK + "px; " +
  "color: #595759;" +
  "}",

  servicePagePincardChooseArrow: ".servicepage-pincard-choose-arrow" +
  "{" +
  "position: absolute;" +
  "background-image: url('resources/icons/ViewService/right.png');" +
  "width: 3%;" +
  "height: 36%;" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "background-position: center;" +
  "top: 31%;" +
  "left: 95%;" +
  "}",

  servicePageSecondDropdownField: ".servicepage-second-dropdown-field" +
  "{" +
  "position: relative;" +
  "width: 79.5%;" +
  "height: 9%;" +
  "left: 10%;" +
  "color: white;" +
  "border-bottom:  " + 5 * widthK + "px solid lightgray;" +
  "top: 7%;" +
  "}",

  servicePageDropdownIcon: ".servicepage-dropdown-icon" +
  "{" +
  "position: absolute;" +
  "background-image: url('resources/icons/ViewService/dropdown_icon.png');" +
  "width: 7%;" +
  "height: 36%;" +
  "background-repeat: no-repeat;" +
  "background-size: 65%;" +
  "background-position: center;" +
  "top: 45%;" +
  "left: 92%;" +
  "}",


  pincardPayfromContainer: ".pincard-payfrom-container" +
  "{" +
  "position: relative;" +
  "background-color: transparent;" +
  "width: 100%;" +
  "height: 7.5%;" +
  "border-bottom: 1px solid lightgray;" +
  "}",

  pincardPayfromField: ".pincard-payfrom-field" +
  "{" +
  "position: absolute;" +
  "font-size: " + 29 * widthK + "px; " +
  "color: gray;" +
  "margin: 0;" +
  "left: 8%;" +
  "top:29%;" +
  "}",

  pincardAllcardsContainer: ".pincard-allcards-container" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height:60%;" +
  "top: 7.5%;" +
  "background-color: transparent;" +
  "overflow-x: hidden;" +
  "overflow-y: auto;" +
  "}",

  pincardCardContainer: ".pincard-card-container" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: " + 162 * widthK + "px; " +
  "background-color: transparent;" +
  "border-bottom:  " + 1 + "px solid lightgray;" +
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
  "right: 61%;" +
  "position: absolute;" +
  "}",

  pincardCardInfoContainer: ".pincard-card-info-container" +
  "{" +
  "position: absolute;" +
  "width: 41%;" +
  "height: 100%;" +
  "left: 42%;" +
  "background-color: transparent;" +
  "}",

  pincardCardInfoTextOne: ".pincard-card-info-text-one" +
  "{" +
  "position: absolute;" +
  "font-size: " + 24 * widthK + "px; " +
  "color: gray;" +
  "width: 110%;" +
  "left: -1%;" +
  "text-overflow: ellipsis;" +
  "white-space: nowrap;" +
  "overflow: hidden;" +
  "}",

  pincardCardInfoTextTwo: ".pincard-card-info-text-two" +
  "{" +
  "position: absolute;" +
  "font-size: " + 40 * widthK + "px; " +
  "font-weight: bold;" +
  "color: rgba(80, 185, 8, 0.77);" +
  "top: 10%;" +
  "width: 110%;" +
  "text-overflow: ellipsis;" +
  "white-space: nowrap;" +
  "overflow: hidden;" +
  "}",

  pincardCardInfoTextThree: ".pincard-card-info-text-three" +
  "{" +
  "position: absolute;" +
  "font-size: " + 23 * widthK + "px; " +
  "color: gray;" +
  "top: 51%;" +
  "}",

  pincardCardCheckmark: ".pincard-card-checkmark" +
  "{" +
  "position: absolute;" +
  "width: 17%;" +
  "height: 100%;" +
  "left: 81%;" +
  "top: 2%;" +
  "background-color: transparent;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: 35%;" +
  "background-image: url(resources/icons/ViewService/checked.png);" +
  "}",
  pincardCardUnCheckmark: ".pincard-card-uncheckmark" +
  "{" +
  "position: absolute;" +
  "width: 17%;" +
  "height: 100%;" +
  "left: 81%;" +
  "top: 2%;" +
  "background-color: transparent;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: 35%;" +
  "background-size: 35%;" +
  "background-image: url(resources/icons/ViewService/unchecked.png);" +
  "}",

  pincardHelpText: ".pincard-help-text" +
  "{" +
  "top: 35.7%;" +
  "position: absolute;" +
  "left: 37%;" +
  "color: rgb(1, 124, 227);" +
  "font-size: " + 29 * widthK + "px; " +
  "text-align: center;" +
  "text-decoration: underline;" +
  "}",

  pincardBottomContainer: ".pincard-bottom-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
    //"height: 46%;" +
  "top: 67%;" +
  "bottom:0;" +
  "background-color: transparent;" +
  "border-bottom:  " + 1 + "px solid lightgray;" +
  "overflow: scroll;" +
  "}",

  pincardButtonEnter: " .pincard-button-enter" +
  "{" +
  "bottom: 24%;" +
  "position: absolute;" +
  "width:" + 460 * widthK + "px; " +
  "height:" + 75 * widthK + "px; " +
  "border-radius:" + 80 * widthK + "px; " +
  "left: 18%;" +
  "background-color: rgb(1, 124, 227);" +
  "}",

  pincardButtonEnterLabel: ".pincard-button-enter-label" +
  "{" +
  "position: relative;" +
  "top: " + 10 * widthK + "px; " +
  "width: 30%;" +
  "font-size: " + 44 * widthK + "px; " +
  "margin: auto;" +
  "color: white;" +
    //"right: 10%;" +
  "}",

  payconfirmDataContainer: ".payconfirm-data-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: " + 569 * widthK + "px; " +
  "background-color: transparent;" +
    //"border-bottom:  " + 1 + "px solid lightgray;" +
  "}",

  payconfirmPhoneField: ".payconfirm-phone-field" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: 24%;" +
  "border-bottom: 1px solid lightgray;" +
  "color: white;" +
  "}",

  payconfirmTextField: ".payconfirm-text-field" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: darkgray;" +
  "font-size: " + 24 * widthK + "px; " +
  "left: 8%;" +
  "top: 25%;" +
  "}",

  payconfirmPhoneInput: ".payconfirm-phone-input" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left: 8%;" +
  "top: 47%;" +
  "font-size: " + 40 * widthK + "px; " +
  "color: gray;" +
  "}",

  payconfirmField: ".payconfirm-field" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: 22.5%;" +
  "border-bottom:  " + 1 + "px solid lightgray;" +
  "color: white;" +
    //"top: 23%;" +
  "}",

  payconfirmCardField: ".payconfirm-card-field" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: 32%;" +
  "border-bottom:1px solid lightgray;" +
  "color: white;" +
    //"top: 23%;" +
  "}",

  payconfirmCardInfoContainer: ".payconfirm-card-info-container" +
  "{" +
  "position: absolute;" +
  "width: 60%;" +
  "height: 100%;" +
  "background-color: transparent;" +
  "left: 4%;" +
  "}",

  payconfirmTextOne: ".payconfirm-text-one" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: darkgray;" +
  "font-size: " + 23 * widthK + "px; " +
  "left: 7%;" +
  "top: 17%;" +
  "}",

  payconfirmTextTwo: ".payconfirm-text-two" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left: 7%;" +
  "top: 30%;" +
  "font-size: " + 40 * widthK + "px; " +
  "color: gray;" +
  "}",

  payconfirmDetailText: ".payconfirm-detail-text" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "color: darkgray;" +
  "font-size: " + 25 * widthK + "px; " +
  "left: 7%;" +
  "top: 56%;" +
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


  payconfirmBottomContainer: ".payconfirm-bottom-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "top: 60%;" +
  "bottom: 0;" +
  "background-color: transparent;" +
  "border-bottom:  1px solid lightgray;" +
  "overflow: scroll;" +
  "}",

  payconfirmActionContainer: ".payconfirm-action-containter" +
  "{" +
  "position: relative;" +
  "float: left;" +
  "width: 50%;" +
  "height: 50%;" +
  "background-color: transparent;" +
  "}",

  payconfirmActionIconOne: ".payconfirm-action-icon-one" +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "height: 46%;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "left: 26%;" +
  "top: 14%;" +
  "background-size: 50%;" +
  "}",

  payconfirmActionIconTwo: ".payconfirm-action-icon-two" +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "height: 46%;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "left: 25%;" +
  "top: 14%;" +
  "background-size: 41%;" +
  "}",

  payconfirmActionText: ".payconfirm-action-text" +
  "{" +
  "top: 17%;" +
  "left: 4%;" +
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
  "bottom: 24%;" +
  "position: absolute;" +
  "width:" + 460 * widthK + "px; " +
  "height:" + 70 * widthK + "px; " +
  "border-radius:" + 80 * widthK + "px; " +
  "left: 18%;" +
  "background-color: rgb(1, 124, 227);" +
  "}",

  payconfirmButtonEnterLabel: ".payconfirm-button-enter-label" +
  "{" +
  "position: relative;" +
  "top: " + 9 * widthK + "px; " +
  "width: 48%;" +
  "font-size: " + 44 * widthK + "px; " +
  "margin: auto;" +
  "color: white;" +
  "}",

  //COMPONENT SEARCH

  componentSearch: ".component-search " +
  "{" +
  "position: absolute;" +
  "opacity: 0.95;" +
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
  "height: 7%;" +
  "}",

  searchSearchIcon: ".search-search-icon " +
  "{" +
  "position: relative;" +
  "width: 13%;" +
  "height: 100%;" +
  "left: 3%;" +
  "background-repeat: no-repeat;" +
  "float: left;" +
  "background-image: url(resources/icons/search/search.png);" +
  "background-position: center;" +
  "background-size: 38%;" +
  "}",

  searchTitleName: ".search-title-name " +
  "{" +
  "position: relative;" +
  "float: left;" +
  "margin: 0;" +
  "margin-top:" + 25 * widthK + "px;" +
  "left: 3%;" +
  "color: white;" +
  "}",

  searchCancelIcon: ".search-cancel-icon " +
  "{" +
  "position: absolute;" +
  "right: 0;" +
  "width: 23%;" +
  "height: 100%;" +
  "background-repeat: no-repeat;" +
  "background-image: url(resources/icons/search/close.png);" +
  "background-position-y: center;" +
  "background-position-x: 70%;" +
  "background-size: 20%;" +
  "}",

  searchInput: ".search-input " +
  "{" +
  "position: absolute;" +
  "font-family: 'SFUIDisplay-Light';" +
  "font-size:" + 32 * widthK + "px;" +
  "background: none;" +
  "border: none;" +
  "border-bottom:" + 5 * widthK + "px solid #a3deee;" +
  "width: 98%;" +
  "height: 10%;" +
  "top: 18%;" +
  "left: 1%;" +
  "outline: none;" +
  "-webkit-text-fill-color: white;" +
  "color: #e2e3e5;" +
  "}",

  searchSuggestionContainer: ".search-suggestion-container " +
  "{" +
  "position: absolute;" +
  "width: 96%;" +
  "height: 70%;" +
  "left: 2%;" +
  "top: 30%;" +
  "}",

  searchSuggestionFieldOne: ".search-suggestion-field-one " +
  "{" +
  "position: absolute;" +
  "top: 3%;" +
  "width: 103%;" +
  "left: -1%;" +
  "height: 22%;" +
  "display: none;" +
  "background-color: white;" +
  "}",

  searchSuggestionFieldTwo: ".search-suggestion-field-two " +
  "{" +
  "position: absolute;" +
  "top: 26%;" +
  "width: 103%;" +
  "left: -1%;" +
  "height: 22%;" +
  "display: none;" +
  "background-color: white;" +
  "}",

  searchSuggestionFieldThree: ".search-suggestion-field-three " +
  "{" +
  "position: absolute;" +
  "top: 49%;" +
  "width: 103%;" +
  "left: -1%;" +
  "height: 20%;" +
  "display: none;" +
  "background-color: white;" +
  "}",

  searchSuggestionFieldFour: ".search-suggestion-field-four " +
  "{" +
  "position: absolute;" +
  "top: 70%;" +
  "width: 103%;" +
  "left: -1%;" +
  "height: 20%;" +
  "display: none;" +
  "background-color: white;" +
  "}",

  searchPartOfSuggestion: ".search-part-of-suggestion" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "background-size: contain;" +
  "left: 5%;" +
  "margin-top: 5%;" +
  "color: #a1a1a2;" +
  "overflow: hidden;" +
  "width: 90%;" +
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
  "}",


  searchSelectedFieldColor: ".search-selected-field-color " +
  "{" +
  "background-color: #28a2f9;" +
  "}",

  myCardListPageTitle: ".mycardlist-page-title " +
  "{" +
  "position: absolute;" +
  "top:" + -12 * widthK + "px;" +
  "right:" + 28 * widthK + "px;" +
  "left:" + 25 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "background: transparent;" +
  "border-bottom:" + 5 * widthK + "px solid rgb(149, 230, 253);" +
  "}",

  myCardListNameTitle: ".mycardlist-name-title " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size:" + 32 * widthK + "px; " +
  "left:" + 86 * widthK + "px; " +
  "top:" + 40 * widthK + "px; " +
  "margin: 0;  " +
  "color: #fffaf9;" +
  "}",

  myCardListContainer: ".mycardlist-container" +
  "{" +
  "position: absolute;" +
  "background-color: transparent;" +
  "width: 100%;" +
  "top: 8%;" +
  "bottom: 0;" +
  "overflow:scroll;" +
  "}",

  myCardListCard: ".mycardlist-card" +
  "{" +
  "height: " + 188 * widthK + "px;" +
  "width: " + 327 * widthK + "px;" +
  "position: relative;" +
  "top: " + 13 * widthK + "px;" +
  "-webkit-border-radius:" + 10 * widthK + "px;" +
  "-moz-border-radius:" + 10 * widthK + "px;" +
  "border-radius:" + 10 * widthK + "px;" +
  "background-size: cover;" +
  "color: white;" +
  "-webkit-box-shadow: 0px 50px 50px -50px rgba(0,0,0,1);" +
  "-moz-box-shadow: 0px 50px 50px -50px rgba(0,0,0,1);" +
  "box-shadow: 0px 50px 50px -50px rgba(0,0,0,1);" +
    //"margin-left: 20px;" +
  "float: left;" +
  "margin: " + 7 * widthK + "px;" +
  "left: " + 17 * widthK + "px;" +
  "}",

  //myCardListCardBankNameUrl: ".mycardlist-card-bank-name-url" +
  //"{" +
  //"position: absolute;" +
  //"width: 30%;" +
  //"height: 16%;" +
  //"background-size: contain;" +
  //"background-repeat: no-repeat;" +
  //"background-position: left top;" +
  //"left:" + 19 * widthK + "px;" +
  //"top:" + 13 * widthK + "px" +
  //"}",

  myCardListbackButton: ".mycardlist-back-button " +
  "{" +
  "position: absolute;" +
  "width:" + 120 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "background-image: url(resources/icons/back/back.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 19%;" +
  "background-position-y:" + 27 * widthK + "px;" +
  "background-position-x:" + 44 * widthK + "px;" +
  "background-size: 17%;" +
  "left: -3%;" +
  "top: 0;" +
  "}",


  myCardListcardBankName: ".mycardlist-card-bank-name " +
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

  myCardListCardSalaryTitle: ".mycardlist-card-salary-title" +
  "{" +
  "position: absolute;" +
  "top: 41%;" +
  "left: 5%;" +
  "color: #595759;" +
  "background-size: contain;" +
  "font-size:" + 17 * widthK + "px;" +
  "height: 10%;" +

  "}",

  myCardListCardBalanceCurrencyContainer: ".mycardlist-card-balance-currency-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 21%;" +
  "top: 51%;" +
  "display: inline-block;" +
  "margin: 0;" +
  "}",

  myCardListcardBalance: ".mycardlist-card-balance " +
  "{" +
  "position: relative;" +
  "left: 5%;" +
  "color: #585658;" +
  "font-size:" + 33 * widthK + "px;" +
  "margin: 0;" +
  "float: left;" +
  "padding: 0;" +
  "}",

  myCardListcardCurrency: ".mycardlist-card-currency " +
  "{" +
  "position: relative;" +
  "left: 6%;" +
  "top: 32%;" +
  "color: #595759;" +
  "bottom: 12%;" +
  "font-size:" + 19 * widthK + "px;" +
  "background-size: contain;" +
  "float: left;" +
  "margin:0;" +
  "}",

  myCardListcardNumber: ".mycardlist-card-number " +
  "{" +
  "position: absolute;" +
  "top: 80%;" +
  "width:100%;" +
  "font-size:" + 21 * widthK + "px;" +
  "text-shadow: white -1px -1px 0.4px, black 0.0px 1px 0.2px, white -1px -1px 0.4px, black 0.0px 1px 0.4px;" +
  "-webkit-text-shadow: white -1px -1px 0.4px, black 0.0px 1px 0.2px, white -1px -1px 0.4px, black 0.0px 1px 0.4px;font-family: Orator;" +
  "color: transparent;" +
  "left:5%" +
  "}",

  myCardListcardNumberPartOne: ".mycardlist-card-number-part-one " +
  "{" +
  "position: absolute;" +
  "left: 0px;" +
  "font-weight: bold;" +
  "}",

  myCardListcardNumberPartTwo: ".mycardlist-card-number-part-two " +
  "{" +
  "position: absolute;" +
  "left:58%;" +
  "font-weight: bold;" +
  "}",

  myCardListnumberStars: ".mycardlist-number-stars " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left: 18%;" +
  "letter-spacing:" + -8 * widthK + "px;" +
  "font-size:" + 36 * widthK + "px;" +
  "}",

  //VIEW TRANSFER

  transferBodyContainer: ".transfer-body-container" +
  "{" +
  "position: absolute;" +
  "height:" + 1150 * heightK + "px;" +
  "width:" + 720 * widthK + "px;" +
  "top:" + 93 * widthK + "px;" +
  "background-color: white;" +
  "overflow: hidden;" +
  "border-bottom: 1px solid black;" +
  "}",

  transferMenusContainer: ".transfer-menus-container" +
  "{" +
  "position: absolute;" +
  "height:" + 120 * widthK + "px;" +
  "width: 100%;" +
  "top: 0;" +
  "background: transparent;" +
  "background-image: url(resources/icons/ViewTransfer/contactMenu.png);" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "background-position: center;" +
  "}",

  transferMenuContainerContact: ".transfer-menu-container-contact" +
  "{" +
  "position: absolute;" +
  "height: 100%;" +
  "width: 30%;" +
  "left: 18%;" +
  "background-color: transparent;" +
  "}",

  transferMenuContainerCard: ".transfer-menu-container-card" +
  "{" +
  "position: absolute;" +
  "height: 100%;" +
  "width: 30%;" +
  "left: 50%;" +
  "background-color: transparent;" +
  "}",

  transferMenuContactIcon: ".transfer-menu-contact-icon" +
  "{" +
  "position: relative;" +
  "height: 61%;" +
  "width: 30%;" +
  "left: 10%;" +
  "top: 20%;" +
  "background: transparent;" +
  "background-image: url('resources/icons/ViewTransfer/tocontact.png');" +
  "background-repeat: no-repeat;" +
  "background-size: 54%;" +
  "background-position: center;" +
  "}",

  transferMenuCardIcon: ".transfer-menu-card-icon" +
  "{" +
  "position: relative;" +
  "height: 61%;" +
  "width: 30%;" +
  "left: 22%;" +
  "top: 20%;" +
  "background: transparent;" +
  "background-image: url('resources/icons/ViewTransfer/tocard.png');" +
  "background-repeat: no-repeat;" +
  "background-size: 68%;" +
  "background-position: center;" +
  "opacity: 0.5;" +
  "}",

  transferMenuContactLabel: ".transfer-menu-contact-label" +
  "{" +
  "margin: 0;" +
  "left: 44%;" +
  "top: 39%;" +
  "position: absolute;" +
  "font-size:" + 23 * widthK + "px;" +
  "color: black;" +
  "}",

  transferMenuCardLabel: ".transfer-menu-card-label" +
  "{" +
  "margin: 0;" +
  "left: 57%;" +
  "top: 39%;" +
  "position: absolute;" +
  "font-size:" + 23 * widthK + "px;" +
  "color: gray;" +
  "}",

  transferContactBodyContainer: ".transfer-contact-body-container" +
  "{" +
  "position: absolute;" +
  "top: 10%;" +
  "height: 50%;" +
  "width: 100%;" +
  "background-color: transparent;" +
  "}",

  transferContactPhoneField: ".transfer-contact-phone-field" +
  "{" +
  "position: absolute;" +
  "left: 10%;" +
  "width: 79.5%;" +
  "height:" + 100 * widthK + "px;" +
  "border-bottom:" + 5 * widthK + "px solid #01cfff;" +
  "color: white;" +
  "top: 8%;" +
  "}",

  transferContactTextField: ".transfer-contact-text-field" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 24 * widthK + "px;" +
  "top: -14%;" +
  "}",

  transferContactPhoneIcon: ".transfer-contact-phone-icon" +
  "{" +
  "position: absolute;" +
  "background-image: url('resources/icons/ViewService/book.png');" +
  "width: 13%;" +
  "height: 50%;" +
  "background-repeat: no-repeat;" +
  "background-size: 60%;" +
  "background-position: center;" +
  "top: 34%;" +
  "right: -2%;" +
  "}",

  transferContactNumberFirstPart: ".transfer-contact-number-first-part" +
  "{" +
  "float: left;" +
  "position: relative;" +
  "top: 28%;" +
  "height: 68%;" +
  "font-size:" + 51 * widthK + "px;" +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "margin: 0;" +
  "}",

  transferContactNumberInputPart: ".transfer-contact-number-input-part" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "top: 28%;" +
  "padding: 0;" +
  "margin: 0;" +
  "margin-left: 3%;" +
  "width: 65%;" +
  "font-size:" + 51 * widthK + "px;" +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "}",

  transferContactFoundContainerOne: ".transfer-contact-found-container-one" +
  "{" +
  "position: absolute;" +
  "width: 79.5%;" +
  "height:" + 120 * widthK + "px;" +
  "background-color: #F0F1F4;" +
  "left: 10%;" +
  "top:" + 165 * widthK + "px;" +
  "display: none;" +
  "}",

  transferContactFoundContainerTwo: ".transfer-contact-found-container-two" +
  "{" +
  "position: absolute;" +
  "width: 79.5%;" +
  "height:" + 120 * widthK + "px;" +
  "background-color: #F0F1F4;" +
  "left: 10%;" +
  "top:" + 290 * widthK + "px;" +
  "display: none;" +
  "}",

  transferContactFoundContainerThree: ".transfer-contact-found-container-three" +
  "{" +
  "position: absolute;" +
  "width: 79.5%;" +
  "height:" + 120 * widthK + "px;" +
  "background-color: #F0F1F4;" +
  "left: 10%;" +
  "top:" + 415 * widthK + "px;" +
  "display: none;" +
  "}",

  transferContactFoundContainerFour: ".transfer-contact-found-container-four" +
  "{" +
  "position: absolute;" +
  "width: 79.5%;" +
  "height:" + 120 * widthK + "px;" +
  "background-color: #F0F1F4;" +
  "left: 10%;" +
  "top:" + 540 * widthK + "px;" +
  "display: none;" +
  "}",

  transferContactFoundContainerFive: ".transfer-contact-found-container-five" +
  "{" +
  "position: absolute;" +
  "width: 79.5%;" +
  "height:" + 120 * widthK + "px;" +
  "background-color: #F0F1F4;" +
  "left: 10%;" +
  "top:" + 665 * widthK + "px;" +
  "display: none;" +
  "}",

  transferCardNumberInputPart: ".transfer-card-number-input-part" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "top: 28%;" +
  "left: 0%;" +
  "margin: 0%;" +
  "padding: 0;" +
  "font-size:" + 51 * widthK + "px;" +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "}",


  transferContactFoundPhoto: ".transfer-contact-found-photo" +
  "{" +
  "top:" + 8 * widthK + "px;" +
  "position: absolute;" +
  "width:" + 100 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-size: cover;" +
  "background-position: center;" +
  "border-radius: 50%;" +
  "text-align: center;" +
  "line-height:" + 100 * widthK + "px;" +
  "font-size:" + 50 * widthK + "px;" +
  "background-color: #027fe3;" +
  "color: white;" +
  "left: 5%;" +
  "}",

  transferCardFoundPhoto: ".transfer-card-found-photo" +
  "{" +
  "position: absolute;" +
  "width: 20%;" +
  "height: 100%;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "left: 5%;" +
  "background-size: 100%;" +
  "}",

  transferContactFoundTextContainer: ".transfer-contact-found-text-container" +
  "{" +
  "position: absolute;" +
  "left: 25%;" +
  "color: gray;" +
  "width: 20%;" +
  "height: 100%;" +
  "display: table;" +
  "}",


  transferContactFoundTextOne: ".transfer-contact-found-text-one" +
  "{" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 24 * widthK + "px;" +
  "display: table-cell;" +
  "vertical-align: middle;" +
  "}",

  transferContactFoundTextTwo: ".transfer-contact-found-text-two" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left: 60%;" +
  "color: gray;" +
  "font-size:" + 24 * widthK + "px;" +
  "top: 40%;" +
  "}",

  transferNextButtonInnerContainer: ".transfer-next-button-inner-container" +
  "{" +
  "position: relative;" +
  "width: 63%;" +
  "height: 8%;" +
  "margin-right: auto;" +
  "border-radius: " + 80 * widthK + "px; " +
  "margin-left: auto;" +
  "background-color: rgb(1, 124, 227);" +
  "top: 25%;" +
  "}",

  transferNextButtonLabel: ".transfer-next-button-label" +
  "{" +
  "position: relative;" +
  "top: 18%;" +
  "width: 30%;" +
  "font-size:  " + 45 * widthK + "px; " +
  "margin: auto;" +
  "color: white;" +
  "}",

  transferNextButtonIcon: ".transfer-next-button-icon" +
  "{" +
  "position: relative;" +
  "background-color: lightgray;" +
  "width: 16%;" +
  "height: 36%;" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "background-position: center;" +
  "top: 31%;" +
  "left: 50%;" +
  "}",

  transferNameTitle: ".transfer-name-title " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size:" + 35 * widthK + "px;" +
  "left: 12.7%;" +
  "top: 25.5%;" +
  "margin: 0;" +
  "color: #fffaf9;" +
  "}",

  transferPageTitle: ".transfer-page-title " +
  "{" +
  "position: absolute;" +
  "top: 0;" +
  "right:" + 28 * widthK + "px;" +
  "left:" + 25 * widthK + "px;" +
  "height:" + 93 * widthK + "px;" +
  "background: transparent;" +
  "}",

  transferBackButton: ".transfer-back-button " +
  "{" +
  "position: absolute;" +
  "width:" + 120 * widthK + "px;" +
  "height:" + 91 * widthK + "px;" +
  "background-image: url(resources/icons/back/back.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 19%;" +
  "background-position-y: center;" +
  "background-position-x:" + 47 * widthK + "px;" +
  "background-size: 17%;" +
  "left:" + -25 * widthK + "px;" +
  "top: 0;" +
  "}",

  transferIButton: ".transfer-i-button " +
  "{" +
  "position: absolute;" +
  "width: 20%;" +
  "height: 100%;" +
  "right: -4%;" +
  "background-image: url(resources/icons/ViewTransfer/i.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 30%;" +
  "background-position-y: 46%;" +
  "background-position-x: 62%;" +
  "background-size: 30%;" +
  "top:0" +
  "}",

  //VIEW TRANSFER TWO

  transferTwoBodyContainer: ".transfertwo-body-container " +
  "{" +
  "position: absolute;" +
  "height:" + 1139 * heightK + "px;" +
  "width:" + 720 * widthK + "px;" +
  "top:" + 93 * widthK + "px;" +
  "background-color: white;" +
  "overflow: hidden;" +
  "}",

  transferTwoContactPhoneField: ".transfertwo-contact-phone-field" +
  "{" +
  "position: absolute;" +
  "left: 10%;" +
  "width: 79.5%;" +
  "height:" + 100 * widthK + "px;" +
  "border-bottom:" + 5 * widthK + "px solid #01cfff;" +
  "color: white;" +
  "top:" + 100 * widthK + "px;" +
  "}",

  transferTwoContactTextField: ".transfertwo-contact-text-field" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 24 * widthK + "px;" +
  "bottom: -50%;" +
  "}",

  transferTwoContactNumberInputPart: ".transfertwo-contact-number-input-part" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "top: 7%;" +
  "padding: 0;" +
  "margin: 0;" +
  "font-size:" + 75 * widthK + "px;" +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "}",

  transferTwoNextButtonInnerContainer: ".transfertwo-next-button-inner-container" +
  "{" +
  "position: relative;" +
  "width: 63%;" +
  "height: 8%;" +
  "margin-right: auto;" +
  "border-radius: " + 80 * widthK + "px; " +
  "margin-left: auto;" +
  "background-color: rgb(1, 124, 227);" +
  "top: 45%;" +
  "}",


  transferTwoNextButtonLabel: ".transfertwo-next-button-label" +
  "{" +
  "position: relative;" +
  "top: 18%;" +
  "width: 30%;" +
  "font-size:  " + 45 * widthK + "px; " +
  "margin: auto;" +
  "color: white;" +
  "}",

  transferTwoCommentContainer: ".transfertwo-comment-container" +
  "{" +
  "position: absolute;" +
  "width: 63%;" +
  "height: 16%;" +
  "top: 26%;" +
  "left: 19%;" +
  "background-size: 97%;" +
  "background-image: url(resources/icons/ViewTransfer/input.png);" +
  "background-repeat: no-repeat;" +
  "background-color: transparent;" +
  "color: #ffffff;" +
  "}",

  transferTwoCommentInput: ".transfertwo-comment-input" +
  "{" +
  "position: absolute;" +
  "width: 87%;" +
  "height: 59%;" +
  "top: 13%;" +
  "left: 6%;" +
  "font-size:" + 24 * widthK + "px;" +
  "font-family: 'SFUIDisplay-Light';" +
  "border: none;" +
  "outline: none;" +
  "margin: 0;" +
  "padding: 0;" +
  "color: gray;" +
  "}",

  transferTwoMenusContainer: ".transfertwo-menus-container " +
  "{" +
  "position: absolute;" +
  "height:" + 90 * widthK + "px;" +
  "width: 100%;" +
  "background-color: transparent;" +
  "border-bottom:1px solid #e3e3e3;" +
  "}",

  transferTwoMenuNameLabel: ".transfertwo-menu-name-label " +
  "{" +
  "margin: 0;" +
  "text-align: center;" +
  "width: 100%;" +
  "top: 41%;" +
  "position: absolute;" +
  "font-size:" + 27 * widthK + "px;" +
  "color: #515151;" +
  "}",


  //VIEW TRANSFER THREE

  transferThreeBodyContainer: ".transferthree-body-container " +
  "{" +
  "position: absolute;" +
  "height:" + 1139 * heightK + "px;" +
  "width:" + 720 * widthK + "px;" +
  "top:" + 93 * widthK + "px;" +
  "background-color: white;" +
  "overflow: hidden;" +
  "}",

  transferThreeMenusContainer: ".transferthree-menus-container " +
  "{" +
  "position: relative;" +
  "height: 7.5%;" +
  "width: 100%;" +
  "top: 0%;" +
  "background-color: transparent;" +
  "border-bottom:1px solid #e3e3e3;" +
  "}",

  transferThreeMenuNameLabel: ".transferthree-menu-name-label " +
  "{" +
  "margin: 0;" +
  "text-align: center;" +
  "width: 100%;" +
  "top: 35%;" +
  "position: absolute;" +
  "font-size:" + 27 * widthK + "px;" +
  "color: #515151;" +
  "}",

  transferThreeContactBodyContainer: ".transferthree-contact-body-container " +
  "{" +
  "position: absolute;" +
  "top: 10%;" +
  "height: 50%;" +
  "background-color: transparent;" +
  "}",

  transferThreeContactPhoneField: ".transferthree-contact-phone-field " +
  "{" +
  "position: relative;" +
  "left: 10%;" +
  "width: 79.5%;" +
  "height: 103px;" +
  "border-bottom: 5px solid #01cfff;" +
  "color: white;" +
  "top: 45px;" +
  "margin-bottom: 8%;" +
  "}",

  transferThreeNextButtonInnerContainer: ".transferthree-next-button-inner-container" +
  "{" +
  "position: relative;" +
  "width: 63%;" +
  "height: 8%;" +
  "margin-right: auto;" +
  "border-radius: " + 80 * widthK + "px; " +
  "margin-left: auto;" +
  "background-color: rgb(1, 124, 227);" +
  "top: 20%;" +
  "}",

  transferThreeNextButtonLabel: ".transferthree-next-button-label" +
  "{" +
  "position: relative;" +
  "top: 18%;" +
  "width: 30%;" +
  "font-size:  " + 45 * widthK + "px; " +
  "margin: auto;" +
  "color: white;" +
  "}",

  //VIEW TRANSFER FOUR

  transferFourBodyContainer: ".transferfour-body-container " +
  "{" +
  "position: absolute;" +
  "height:" + 1142 * heightK + "px;" +
  "width:" + 720 * widthK + "px;" +
  "top:" + 93 * widthK + "px;" +
  "background-color: white;" +
  "overflow: hidden;" +
  "}",

  transferFourDataContainer: ".transferfour-data-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: " + 569 * widthK + "px; " +
  "background-color: transparent;" +
    //"border-bottom:  " + 1 + "px solid lightgray;" +
  "}",

  transferFourPhoneField: ".transferfour-phone-field" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 24%;" +
  "border-bottom: 1px solid lightgray;" +
  "color: white;" +
  "}",

  transferFourTextField: ".transferfour-text-field" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: darkgray;" +
  "font-size: " + 24 * widthK + "px; " +
  "left: 8%;" +
  "top: 23%;" +
  "}",

  transferFourPhoneInput: ".transferfour-phone-input" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left: 8%;" +
  "top: 43%;" +
  "font-size: " + 40 * widthK + "px; " +
  "color: gray;" +
  "}",

  transferFourOwnerField: ".transferfour-owner-field" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: darkgray;" +
  "font-size: " + 24 * widthK + "px; " +
  "left: 8%;" +
  "top: 23%;" +
  "}",

  transferFourOwnerInput: ".transferfour-owner-input" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left: 8%;" +
  "top: 47%;" +
  "font-size: " + 40 * widthK + "px; " +
  "color: gray;" +
  "}",


  transferFourContainer: ".transferfour-owner-container" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: 22.5%;" +
  "border-bottom:  " + 1 + "px solid lightgray;" +
  "color: white;" +
  "top: 23%;" +
  "}",

  transferFourCategoryContainer: ".transferfour-category-container" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: 22.5%;" +
  "border-bottom:  " + 1 + "px solid lightgray;" +
  "color: white;" +
  "top: 23%;" +
  "display: none;" +
  "}",

  transferFourCardField: ".transferfour-card-field" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: 32%;" +
  "color: white;" +
  "top: 23%;" +
  "}",

  transferFourCardInfoContainer: ".transferfour-card-info-container" +
  "{" +
  "position: absolute;" +
  "width: 60%;" +
  "height: 100%;" +
  "background-color: transparent;" +
  "left: 4%;" +
  "}",

  transferFourTextOne: ".transferfour-text-one" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: darkgray;" +
  "font-size: " + 24 * widthK + "px; " +
  "left: 7%;" +
  "top: 13%;" +
  "}",

  transferFourTextTwo: ".transferfour-text-two" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left: 7%;" +
  "top: 27%;" +
  "font-size: " + 40 * widthK + "px; " +
  "color: gray;" +
  "}",

  transferFourDetailText: ".transferfour-detail-text" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "color: darkgray;" +
  "font-size: " + 25 * widthK + "px; " +
  "left: 7%;" +
  "top: 55%;" +
  "}",

  transferFourCardLogoContainer: ".transferfour-card-logo-container" +
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

  transferFourFieldSum: ".transferfour-field-sum" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: 28%;" +
  "border-bottom:  " + 1 + "px solid lightgray;" +
  "color: white;" +
  "top: 23%;" +
  "}",

  transferFourAmountField: ".transferfour-amount-field" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: darkgray;" +
  "font-size: " + 24 * widthK + "px; " +
  "left: 8%;" +
  "top: 18%;" +
  "}",

  transferFourAmountInput: ".transferfour-amount-input" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left: 8%;" +
  "top: 35%;" +
  "font-size: " + 40 * widthK + "px; " +
  "color: gray;" +
  "}",

  transferFourTaxField: ".transferfour-tax-field" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: darkgray;" +
  "font-size: " + 24 * widthK + "px; " +
  "left: 8%;" +
  "top: 63%;" +
  "}",

  transferFourBottomContainer: ".transferfour-bottom-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "top: 67%;" +
  "bottom: 8%;" +
  "background-color: transparent;" +
  "overflow: hidden;" +
  "}",

  transferFourActionContainer: ".transferfour-action-containter" +
  "{" +
  "position: absolute;" +
  "width:" + 185 * widthK + "px;" +
  "height:" + 175 * widthK + "px;" +
  "left: 38%;" +
  "top: 0;" +
  "display: none;" +
  "background-color: transparent;" +
  "}",

  transferFourActionIconOne: ".transferfour-action-icon-one" +
  "{" +
  "position: absolute;" +
  "width: 61%;" +
  "height: 46%;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "left: 18%;" +
  "top: 0;" +
  "background-size: 78%;" +
  "}",

  transferFourActionText: ".transferfour-action-text" +
  "{" +
  "top: 52%;" +
  "left: 4%;" +
  "position: absolute;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "color: rgb(1, 124, 227);" +
  "font-size: " + 30 * widthK + "px; " +
  "text-align: center;" +
  "text-decoration: underline;" +
  "width: 92%;" +
  "}",

  transferFourButtonEnter: ".transferfour-button-enter" +
  "{" +
  "bottom: 0;" +
  "position: absolute;" +
  "width: 52%;" +
  "height: 32%;" +
  "border-radius:" + 80 * widthK + "px; " +
  "left: 24%;" +
  "margin: 0;" +
  "background-color: rgb(1, 124, 227);" +
  "}",

  transferFourButtonEnterLabel: ".transferfour-button-enter-label" +
  "{" +
  "position: relative;" +
  "top: 24%;" +
    //"left: 1%;" +
  "letter-spacing:" + 3 * widthK + "px;" +
  "font-size: " + 36 * widthK + "px; " +
  "color: white;" +
  "margin: 0;" +
  "width: 60%;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "text-align: center;" +
  "}",

  //VIEW CODE CONFIRM PAGE
  codeConfirm: ".code-confirm " +
  "{" +
  "position: absolute;" +
  "opacity: 0.95;" +
  "height: 100%;" +
  "width: 100%;" +
  "background-color: #353340;" +
  "display: none;" +
  "}",

  codeConfirmContainer: ".code-confirm-container" +
  "{" +
  "position: absolute;" +
  "width:" + 580 * widthK + "px;" +
  "height:" + 650 * widthK + "px;" +
  "left:" + 70 * widthK + "px;" +
  "top: 0px;" +
  "}",

  codeConfirmTitleContainer: ".code-confirm-title-container " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 7%;" +
  "}",

  codeConfirmTitleName: ".code-confirm-title-name " +
  "{" +
  "position: relative;" +
  "float: left;" +
  "margin: 0;" +
  "margin-top:" + 25 * widthK + "px;" +
  "left: 10%;" +
  "color: white;" +
  "}",

  codeConfirmCancelIcon: ".code-confirm-cancel-icon " +
  "{" +
  "position: absolute;" +
  "right: 0;" +
  "width: 23%;" +
  "height: 100%;" +
  "background-repeat: no-repeat;" +
  "background-image: url(resources/icons/search/close.png);" +
  "background-position-y: center;" +
  "background-position-x: 70%;" +
  "background-size: 20%;" +
  "}",

  codeConfirmCodeContainer: ".code-confirm-code-container " +
  "{" +
  "position: absolute;" +
  "width:" + 450 * widthK + "px;" +
  "height:" + 450 * widthK + "px;" +
  "left:" + 135 * widthK + "px;" +
  "top:" + 150 * widthK + "px;" +
  "}",

  codeConfirmCodeText: ".code-confirm-code-text " +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "height: 25%;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "margin-bottom: 0;" +
  "margin-top: 0;" +
  "color: white;" +
  "text-align: center;" +
  "border-bottom:" + 5 * widthK + "px solid #6abfff;" +
  "font-size:" + 100 * widthK + "px;" +
  "}",

  codeConfirmMessageText: ".code-confirm-message-text " +
  "{" +
  "position: relative;" +
  "width: 85%;" +
  "text-align: center;" +
  "top: 10%;" +
  "margin:0 auto 0 auto;" +
  "font-size:" + 28 * widthK + "px;" +
  "color: white;" +
  "}",

  codeConfirmButtonEnter: ".code-confirm-button-enter" +
  "{" +
  "bottom: 24%;" +
  "position: absolute;" +
  "width: 54%;" +
  "height: 17%;" +
  "border-radius:" + 80 * widthK + "px; " +
  "left: 22%;" +
  "margin: 0;" +
  "background-color: rgb(1, 124, 227);" +
  "}",

  codeConfirmButtonEnterLabel: ".code-confirm-button-enter-label" +
  "{" +
  "position: relative;" +
  "top: 20%;" +
  "width: 100%;" +
  "font-size: " + 36 * widthK + "px; " +
  "margin: auto;" +
  "color: white;" +
  "margin: 0;" +
  "text-align: center;" +
  "}",

//  Component Contact Search

  componentContactSearch: ".component-contact-search " +
  "{" +
  "position: absolute;" +
  "opacity: 0.95;" +
  "height: 100%;" +
  "width: 100%;" +
  "background-color: #353340;" +
  "display: none;" +
  "}",

  contactSearchContainer: ".contact-search-container" +
  "{" +
  "position: absolute;" +
  "width:" + 580 * widthK + "px;" +
  "height:" + 650 * widthK + "px;" +
  "left:" + 70 * widthK + "px;" +
  "top: 0px;" +
  "}",

  contactSearchTitleContainer: ".contact-search-title-container " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 7%;" +
  "}",

  contactSearchSearchIcon: ".contact-search-search-icon " +
  "{" +
  "position: relative;" +
  "width: 13%;" +
  "height: 100%;" +
  "left: 3%;" +
  "background-repeat: no-repeat;" +
  "float: left;" +
  "background-image: url(resources/icons/search/search.png);" +
  "background-position: center;" +
  "background-size: 38%;" +
  "}",

  contactSearchTitleName: ".contact-search-title-name " +
  "{" +
  "position: relative;" +
  "float: left;" +
  "margin: 0;" +
  "margin-top:" + 25 * widthK + "px;" +
  "left: 3%;" +
  "color: white;" +
  "}",

  contactSearchCancelIcon: ".contact-search-cancel-icon " +
  "{" +
  "position: absolute;" +
  "right: 0;" +
  "width: 23%;" +
  "height: 100%;" +
  "background-repeat: no-repeat;" +
  "background-image: url(resources/icons/search/close.png);" +
  "background-position-y: center;" +
  "background-position-x: 70%;" +
  "background-size: 20%;" +
  "}",

  contactSearchPhoneField: ".contact-search-phone-field" +
  "{" +
  "position: absolute;" +
  "left: 2%;" +
  "width: 96%;" +
  "height:" + 100 * widthK + "px;" +
  "border-bottom:" + 5 * widthK + "px solid #01cfff;" +
  "color: white;" +
  "top:14%;" +
  "}",

  contactNumberFirstPart: ".contact-number-first-part" +
  "{" +
  "float: left;" +
  "position: relative;" +
  "top: 28%;" +
  "height: 68%;" +
  "font-size:" + 51 * widthK + "px;" +
  "font-family: 'SFUIDisplay-Light';" +
  "color: white;" +
  "margin: 0;" +
  "}",

  contactSearchInput: ".contact-search-input " +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "top: 28%;" +
  "padding: 0;" +
  "margin: 0;" +
  "margin-left: 3%;" +
  "width: 65%;" +
  "font-size:" + 51 * widthK + "px;" +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "-webkit-text-fill-color: white;" +
  "background: none;" +
  "}",

  contactSearchSuggestionContainer: ".contact-search-suggestion-container " +
  "{" +
  "position: absolute;" +
  "width: 96%;" +
  "height: 79%;" +
  "left: 2%;" +
  "top: 31%;" +
  "}",

  contactSearchSuggestionFieldOne: ".contact-search-suggestion-field-one " +
  "{" +
  "position: absolute;" +
  "top: 3%;" +
  "width: 103%;" +
  "left: -1%;" +
  "height: 22%;" +
  "display: none;" +
  "background-color: white;" +
  "}",

  contactSearchSuggestionFieldTwo: ".contact-search-suggestion-field-two " +
  "{" +
  "position: absolute;" +
  "top: 26%;" +
  "width: 103%;" +
  "left: -1%;" +
  "height: 22%;" +
  "display: none;" +
  "background-color: white;" +
  "}",

  contactSearchSuggestionFieldThree: ".contact-search-suggestion-field-three " +
  "{" +
  "position: absolute;" +
  "top: 49%;" +
  "width: 103%;" +
  "left: -1%;" +
  "height: 22%;" +
  "display: none;" +
  "background-color: white;" +
  "}",

  contactSearchSuggestionFieldFour: ".contact-search-suggestion-field-four " +
  "{" +
  "position: absolute;" +
  "top: 72%;" +
  "width: 103%;" +
  "left: -1%;" +
  "height: 22%;" +
  "display: none;" +
  "background-color: white;" +
  "}",

  contactSearchFoundPhoto: ".contact-search-found-photo" +
  "{" +
  "top: 8%;" +
  "position: absolute;" +
  "width: 17%;" +
  "height: 82%;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "border-radius: 50%;" +
  "border: 1px solid gray;" +
  "left: 5%;" +
  "background-size: 150%;" +
  "}",

  contactSearchFoundTextContainer: ".contact-search-found-text-container" +
  "{" +
  "position: absolute;" +
  "left: 25%;" +
  "color: gray;" +
  "width: 20%;" +
  "height: 100%;" +
  "display: table;" +
  "}",


  contactSearchFoundTextOne: ".contact-search-found-text-one" +
  "{" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 24 * widthK + "px;" +
  "display: table-cell;" +
  "vertical-align: middle;" +
  "}",

  contactSearchFoundTextTwo: ".contact-search-found-text-two" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left: 60%;" +
  "color: gray;" +
  "font-size:" + 24 * widthK + "px;" +
  "top: 40%;" +
  "}",

  //COMPONENT INPROCESSING

  componentInProcessing: ".component-in-processing " +
  "{" +
  "position: absolute;" +
  "opacity: 0.95;" +
  "height: 100%;" +
  "width: 100%;" +
  "background-color: #353340;" +
  "display: none;" +
  "}",

  InProcessingOperationSuccessMessagePartOne: ".in-processing-operation-success-message-part-one" +
  "{" +
  "position: relative;" +
  "color: white;" +
  "width: 100%;" +
  "text-align: center;" +
  "margin-left: auto;" +
  "margin-top: 0;" +
  "margin-bottom: 0;" +
  "margin-right: auto;" +
  "top:" + 601 * widthK + "px;" +
  "left:" + -10 * widthK + "px;" +
  "font-size:" + 36 * widthK + "px;" +
  "}",

  InProcessingOperationSuccessMessagePartTwo: ".in-processing-operation-success-message-part-two" +
  "{" +
  "position: relative;" +
  "color: #f7bd20;" +
  "width: 100%;" +
  "text-align: center;" +
  "margin-left: auto;" +
  "margin-top: 0;" +
  "margin-bottom: 0;" +
  "margin-right: auto;" +
  "top:" + 601 * widthK + "px;" +
  "left:" + -10 * widthK + "px;" +
  "font-size:" + 36 * widthK + "px;" +
  "}",

  InProcessingNextButtonInnerContainer: ".in-processing-next-button-inner-container" +
  "{" +
  "position: relative;" +
  "height: 6%;" +
  "left: -2%;" +
  "width: 48%;" +
  "top: 83%;" +
  "display: table;" +
  "background-color: #027fe4;" +
  "border-radius:" + 50 * widthK + "px;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "}",

  InProcessingNextButtonLabel: ".in-processing-next-button-label" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "font-size:" + 38 * widthK + "px;" +
  "color: #ffffff;" +
  "text-align: center;" +
  "display: table-cell;" +
  "vertical-align: middle;" +
  "}",

  InProcessingSuccessIcon: ".in-processing-success-icon" +
  "{" +
  "position: absolute;" +
  "top:" + 338 * widthK + "px;" +
  "width:" + 270 * widthK + "px;" +
  "height:" + 250 * widthK + "px;" +
  "left:" + 234 * widthK + "px;" +
  "background-image: url(resources/icons/ViewSuccessUnsuccess/processing.png);" +
  "background-repeat: no-repeat;" +
  "background-size: 93%;" +
  "}",

  //COMPONENT SUCCESS
  componentSuccess: ".component-success " +
  "{" +
  "position: absolute;" +
  "opacity: 0.95;" +
  "height: 100%;" +
  "width: 100%;" +
  "background-color: #353340;" +
  "display: none;" +
  "}",

  successOperationSuccessMessage: ".success-operation-success-message" +
  "{" +
  "position: relative;" +
  "color: white;" +
  "width:" + 300 * widthK + "px;" +
  "text-align: center;" +
  "margin-left: auto;" +
  "margin-top: 0;" +
  "margin-bottom: 0;" +
  "margin-right: auto;" +
  "top:" + 601 * widthK + "px;" +
  "left:" + -10 * widthK + "px;" +
  "font-size:" + 36 * widthK + "px;" +
  "}",

  successNextButtonInnerContainer: ".success-next-button-inner-container" +
  "{" +
  "position: relative;" +
  "height: 6%;" +
  "left: -2%;" +
  "width: 48%;" +
  "top: 83%;" +
  "display: table;" +
  "background-color: #027fe4;" +
  "border-radius:" + 50 * widthK + "px;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "}",

  successNextButtonLabel: ".success-next-button-label" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "font-size:" + 38 * widthK + "px;" +
  "color: #ffffff;" +
  "text-align: center;" +
  "display: table-cell;" +
  "vertical-align: middle;" +
  "}",

  successSuccessIcon: ".success-success-icon" +
  "{" +
  "position: absolute;" +
  "top:" + 338 * widthK + "px;" +
  "width:" + 270 * widthK + "px;" +
  "height:" + 250 * widthK + "px;" +
  "left:" + 234 * widthK + "px;" +
  "background-image: url(resources/icons/ViewSuccessUnsuccess/ok.png);" +
  "background-repeat: no-repeat;" +
  "background-size: 93%;" +
  "}",

  //COMPONENT DELETE
  componentDelete: ".component-delete " +
  "{" +
  "position: absolute;" +
  "opacity: 0.98;" +
  "height: 100%;" +
  "width: 101%;" +
  "display: none;" +
  "background-color: #efeff1;" +
  "}",

  deleteOperationConfirmMessage: ".delete-operation-confirm-message" +
  "{" +
  "position: relative;" +
  "color: black;" +
  "width:" + 540 * widthK + "px;" +
  "text-align: center;" +
  "margin-left: auto;" +
  "margin-top: 0;" +
  "margin-bottom: 0;" +
  "margin-right: auto;" +
  "top:" + 558 * widthK + "px;" +
  "left:" + -5 * widthK + "px;" +
  "font-size:" + 37 * widthK + "px;" +
  "}",

  deleteDeleteIcon: ".delete-delete-icon" +
  "{" +
  "position: absolute;" +
  "top:" + 246 * widthK + "px;" +
  "width:" + 270 * widthK + "px;" +
  "height:" + 250 * widthK + "px;" +
  "left:" + 234 * widthK + "px;" +
  "background-image: url(resources/icons/ComponentDelete/card_remove.png);" +
  "background-repeat: no-repeat;" +
  "background-size: 93%;" +
  "}",

  deleteButtonsContainer: ".delete-buttons-container" +
  "{" +
  "position: relative;" +
  "height: 13%;" +
  "width:100%;" +
  "top: 58%;" +
  "}",

  deleteButtonAccept: ".delete-button-accept" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "float: left;" +
  "text-align: center;" +
  "margin-left: 15%;" +
  "color: white;" +
  "background-color: #ff613e;" +
  "height:" + 62 * widthK + "px;" +
  "line-height:" + 63 * widthK + "px;" +
  "border-radius:" + 5 * widthK + "px;" +
  "font-size:" + 29 * widthK + "px;" +
  "width: 33%;" +
  "}",

  deleteButtonCancel: ".delete-button-cancel" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "float: left;" +
  "text-align: center;" +
  "margin-left: 3%;" +
  "color: #c8c8c8;" +
  "background-color: #ffffff;" +
  "height:" + 62 * widthK + "px;" +
  "line-height:" + 63 * widthK + "px;" +
  "border-radius:" + 5 * widthK + "px;" +
  "font-size:" + 29 * widthK + "px;" +
  "width: 33%;" +
  "}",


  //COMPONENT UNSUCCESS

  uncomponentUnuccess: ".component-unsuccess " +
  "{" +
  "position: absolute;" +
  "opacity: 0.95;" +
  "height: 100%;" +
  "width: 100%;" +
  "background-color: #353340;" +
  "display: none;" +
  "}",

  unsuccessOperationSuccessMessage: ".unsuccess-operation-success-message" +
  "{" +
  "position: relative;" +
  "color: white;" +
  "width:" + 380 * widthK + "px;" +
  "text-align: center;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "margin-top: 0;" +
  "margin-bottom: 0;" +
  "top:" + 575 * widthK + "px;" +
  "font-size:" + 38 * widthK + "px;" +
  "}",

  unsuccessNextButtonInnerContainer: ".unsuccess-next-button-inner-container" +
  "{" +
  "position: relative;" +
  "height: 6%;" +
  "width: 51%;" +
  "top: 76%;" +
  "display: table;" +
  "background-color: #027fe4;" +
  "border-radius:" + 50 * widthK + "px;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "}",

  unsuccessNextButtonLabel: ".unsuccess-next-button-label" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "font-size:" + 38 * widthK + "px;" +
  "color: #ffffff;" +
  "text-align: center;" +
  "display: table-cell;" +
  "vertical-align: middle;" +
  "}",

  unsuccessOperationSuccessMessagePartThree: ".unsuccess-operation-success-message-part-three" +
  "{" +
  "position: relative;" +
  "color: #ff3c5e;" +
  "width:" + 640 * widthK + "px;" +
  "font-size:" + 30 * widthK + "px;" +
  "text-align: center;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "margin-top: 0;" +
  "margin-bottom: 0;" +
  "top:" + 725 * widthK + "px;" +
  "}",

  unsuccessUnsuccessIcon: ".unsuccess-unsuccess-icon" +
  "{" +
  "position: absolute;" +
  "top:" + 307 * widthK + "px;" +
  "width:" + 270 * widthK + "px;" +
  "height:" + 250 * widthK + "px;" +
  "left:" + 243 * widthK + "px;" +
  "background-image: url(resources/icons/ViewSuccessUnsuccess/fail.png);" +
  "background-repeat: no-repeat;" +
  "background-size: 93%;" +
  "}",

  //OFFLINE MODE
  offlineCardBalance: ".offline-card-balance " +
  "{" +
  "position: relative;" +
  "left:" + 25 * widthK + "px;" +
  "height:" + 70 * widthK + "px;" +
  "color: #585658;" +
  "font-size:" + 36 * widthK + "px;" +
  "margin: 0;" +
  "margin-top:" + -2 * widthK + "px;" +
  "float: left;" +
  "padding: 0;" +
  "}",

  //VIEW REGISTRATION CLIENT

  viewRegistrationClient: ".view-registration-client " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 100%;" +
  "overflow: hidden;" +
  "background-image: url('resources/icons/background/transparent.png');" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "}",

  registrationClientCardField: ".registration-client-card-field " +
  "{" +
  "position: relative;" +
  "top:" + 0 * heightK + "px;" +
  "width:" + 600 * heightK + "px;" +
  "height:" + 320 * heightK + "px;" +
  "border:" + 4 * heightK + "px solid #2f2b3d;" +
  "background-color: #2f2b3d;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "border-radius:" + 10 * heightK + "px;" +
  "}",

  registrationClientCardNumberText: ".registration-client-card-number-text " +
  "{" +
  "left: 4%;" +
  "top: 10%;" +
  "}",

  registrationClientTextField: ".registration-client-text-field " +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "margin-bottom:" + 20 * widthK + "px;" +
  "background-size: contain;" +
  "text-align: center;" +
  "color: #4bd5ff;" +
  "font-size:" + 30 * widthK + "px;" +
  "top:" + 20 * widthK + "px;" +
  "}",

  registrationClientCardNumber: ".registration-client-card-number " +
  "{" +
  "position: absolute;" +
  "padding: 0;" +
  "color: white;" +
  "background-color: #1b1729;" +
  "border: none;" +
  "width: 86%;" +
  "height: 23%;" +
  "left: 7%;" +
  "top: 24%;" +
  "}",

  registrationClientCardNumberBox: ".registration-client-card-number-box " +
  "{" +
  "position: absolute;" +
  "width: 17%;" +
  "height: 55%;" +
  "top: 18%;" +
  "background-color: transparent;" +
  "border: none;" +
  "color: white;" +
  "font-size:" + 30 * widthK + "px;" +
  "}",

  registrationClientCardNumberBoxOne: ".registration-client-card-number-box-one " +
  "{" +
  "left: 6%;" +
  "}",

  registrationClientCardNumberBoxTwo: ".registration-client-card-number-box-two " +
  "{" +
  "left: 30%;" +
  "}",

  registrationClientCardNumberBoxThree: ".registration-client-card-number-box-three " +
  "{" +
  "right: 30%;" +
  "}",

  registrationClientCardNumberBoxFour: ".registration-client-card-number-box-four " +
  "{" +
  "right: 6%;" +
  "}",

  registrationClientCardText: ".registration-client-card-text " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "background-size: contain;" +
  "color: #757389;" +
  "font-size:" + 30 * widthK + "px;" +
  "}",

  registrationClientCardTextDate: ".registration-client-card-text-date " +
  "{" +
  "left: -12%;" +
  "width: 200%;" +
  "top: -65%;" +
  "}",

  registrationClientCardTextPin: ".registration-client-card-text-pin " +
  "{" +
  "top: -65%;" +
  "left: 0;" +
  "width: 200%;" +
  "}",

  registrationClientCardDate: ".registration-client-card-date " +
  "{" +
  "position: absolute;" +
  "padding: 0;" +
  "color: white;" +
  "background-color: #1b1729;" +
  "border: none;" +
  "width: 25%;" +
  "height: 22%;" +
  "left: 7%;" +
  "bottom: 15%;" +
  "}",

  registrationClientCardDateBox: ".registration-client-card-date-box " +
  "{" +
  "position: absolute;" +
  "width: 65%;" +
  "left: 23%;" +
  "height: 60%;" +
  "top: 26%;" +
  "background-color: transparent;" +
  "border: none;" +
  "color: white;" +
  "font-size:" + 30 * widthK + "px;" +
  "}",

  registrationClientCardPin: ".registration-client-card-pin " +
  "{" +
  "position: absolute;" +
  "padding: 0;" +
  "color: white;" +
  "background-color: #1b1729;" +
  "border: none;" +
  "width: 25%;" +
  "height: 22%;" +
  "left: 50%;" +
  "bottom: 15%;" +
  "}",

  registrationClientCardDatePinBox: ".registration-client-card-date-pin-box " +
  "{" +
  "position: absolute;" +
  "width: 65%;" +
  "left: 23%;" +
  "height: 60%;" +
  "top: 26%;" +
  "background-color: transparent;" +
  "border: none;" +
  "color: white;" +
  "font-size:" + 30 * widthK + "px;" +
  "}",

  registrationClientButtonsContainer: ".registration-client-buttons-container " +
  "{" +
  "position: absolute;" +
  "width:" + 560 * widthK + "px;" +
  "bottom:" + -10 * widthK + "px;" +
  "left:" + 84 * widthK + "px;" +
  "}",

  registrationClientButtonEnter: ".registration-client-button-enter " +
  "{" +
  "top:" + 20 * widthK + "px;" +
  "}",

  registrationClientKeyboardField: ".registration-client-keyboard-field " +
  "{" +
  "position: absolute;" +
  "bottom:" + 107 * heightK + "px;" +
  "left:" + 110 * widthK + "px;" +
  "}",

  registrationClientButtonEnterContainer: ".registration-client-button-enter-container " +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "height: 8%;" +
  "background-color: #01cfff;" +
  "margin-right: auto;" +
  "border-radius:" + 80 * widthK + "px;" +
  "margin-left: auto;" +
  "}",

  //VIEW PIN CODE

  viewPinCode: ".view-pincode " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 100%;" +
  "overflow: hidden;" +
  "background-image: url('resources/icons/background/transparent.png');" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "}",

  pinCodeFlexContainer: ".pincode-flex-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "top: 0;" +
  "bottom:" + 610 * widthK + "px;" +
  "}",

  pinCodeUnchangableContainer: ".pincode-unchangable-container " +
  "{" +
  "position: absolute;" +
  "height:" + 110 * widthK + "px;" +
  "bottom: 50%;" +
  "width: 100%;" +
  "}",

  pinCodePinContainer: ".pincode-pin-container " +
  "{" +
  "position: relative;" +
  "width:" + 320 * widthK + "px;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "height:" + 100 * widthK + "px;" +
  "}",

  pinCodePinField: ".pincode-pin-field " +
  "{" +
  "position: relative;" +
  "height:" + 40 * widthK + "px;" +
  "width:" + 320 * widthK + "px;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "margin-top:" + 20 * widthK + "px;" +
  "}",

  pinCodePinCircle: ".pincode-pin-circles " +
  "{" +
  "position: absolute;" +
  "width:" + 34 * widthK + "px;" +
  "height:" + 34 * widthK + "px;" +
  "border-radius:" + 40 * widthK + "px;" +
  "border:" + 4.5 * widthK + "px solid #01cfff;" +
  "}",

  pinCodePinTwo: ".pincode-pin-two " +
  "{" +
  "left:" + 70 * widthK + "px;" +
  "}",

  pinCodePinThree: ".pincode-pin-three " +
  "{" +
  "left:" + 140 * widthK + "px;" +
  "}",

  pinCodePinFour: ".pincode-pin-four " +
  "{" +
  "left:" + 210 * widthK + "px;" +
  "}",

  pinCodePinFive: ".pincode-pin-five " +
  "{" +
  "left:" + 280 * widthK + "px;" +
  "}",

  pinCodeKeyboardField: ".pincode-keyboard-field " +
  "{" +
  "bottom:" + 107 * widthK + "px;" +
  "}",

  pinCodeButtonEnter: ".pincode-button-enter " +
  "{" +
  "top:" + 240 * widthK + "px;" +
  "}",

  pinCodeButtonsContainer: ".pincode-buttons-container " +
  "{" +
  "position: absolute;" +
  "width:" + 490 * widthK + "px;" +
  "left:" + 120 * widthK + "px;" +
  "bottom:" + 700 * widthK + "px;" +
  "height:" + 45 * widthK + "px;" +
  "}",

  pinCodeButtonForgetPin: ".pincode-button-forget-pin " +
  "{" +
  "position: absolute;" +
  "font-size:" + 34 * widthK + "px;" +
  "left: 0;" +
  "background-size: contain;" +
  "color: #05eeff;" +
  "border-bottom:" + 2 + "px solid #05eeff;" +
  "}",

  pinCodeButtonRegistration: ".pincode-button-registration " +
  "{" +
  "position: absolute;" +
  "font-size:" + 34 * widthK + "px;" +
  "background-size: contain;" +
  "color: white;" +
  "right: 0;" +
  "border-bottom:" + 2 + "px solid white;" +
  "}",

  pinCodeButtonOffline: ".pincode-button-offline " +
  "{" +
  "position: absolute;" +
  "font-size:" + 34 * widthK + "px;" +
  "width:" + 240 * widthK + "px;" +
  "background-size: contain;" +
  "color: white;" +
  "border-bottom:" + 2 + "px solid white;" +
  "text-align: center;" +
  "bottom:" + 40 * widthK + "px;" +
  "left:" + 240 * widthK + "px;" +
  "}",

  pinCodeEnterPinLabel: ".pincode-enter-pin-label " +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "background-size: contain;" +
  "width:" + 320 * widthK + "px;" +
  "color: white;" +
  "font-size:" + 32 * widthK + "px;" +
  "}",

  pinCodeEnterPinConfirmLabel: ".pincode-enter-pin-confirm-label " +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "background-size: contain;" +
  "width:" + 350 * widthK + "px;" +
  "color: white;" +
  "font-size:" + 32 * widthK + "px;" +
  "}",

  //COMPONENT PIN RESET

  componentPinReset: ".component-pinreset" +
  "{" +
  "position: absolute;" +
  "opacity: 0.95;" +
  "height: 100%;" +
  "width: 100%;" +
  "background-color: #353340;" +
  "display: none;" +
  "}",

  componentPinResetMessage: ".component-pinreset-message" +
  "{" +
  "position: relative;" +
  "color: white;" +
  "width:" + 400 * widthK + "px;" +
  "text-align: center;" +
  "margin-left: auto;" +
  "margin-top: 0;" +
  "margin-bottom: 0;" +
  "margin-right: auto;" +
  "top:" + 410 * widthK + "px;" +
  "font-size:" + 30 * widthK + "px;" +
  "}",

  componentPinResetLine: ".component-pinreset-line" +
  "{" +
  "position: relative;" +
  "color: white;" +
  "width: 65%;" +
  "margin-top: " + 42 * widthK + "px;" +
  "margin-bottom: " + 30 * widthK + "px;" +
  "top:" + 410 * widthK + "px;" +
  "}",

  componentPinResetMessageRegistration: ".component-pinreset-message-registration" +
  "{" +
  "font-size:" + 38 * widthK + "px;" +
  "}",

  componentPinResetButtonsContainer: ".component-pinreset-buttons-container" +
  "{" +
  "position: relative;" +
  "height: 6%;" +
    //"left: -2%;" +
  "width: 100%;" +
  "top: 36%;" +
  "display: table;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "}",

  componentPinResetButton: ".component-pinreset-button" +
  "{" +
  "position: relative;" +
  "height: 85%;" +
  "width: 28%;" +
  "top: 36%;" +
  "display: table;" +
  "background-color: #027fe4;" +
  "border-radius:" + 50 * widthK + "px;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "float: left;" +
  "left:18%;" +
  "margin-right: 9%;" +
  "}",

  componentPinResetButtonLabel: ".component-pinreset-button-label" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "font-size:" + 30 * widthK + "px;" +
  "color: #ffffff;" +
  "text-align: center;" +
  "display: table-cell;" +
  "vertical-align: middle;" +
  "}",

  componentPinResetNoButton: ".component-pinreset-no-button" +
  "{" +
  "background-color: transparent;" +
  "border: 1px solid white;" +
  "}",

  componentPinResetRegistrationButton: ".component-pinreset-registration-button" +
  "{" +
  "position: relative;" +
  "height: 100%;" +
    //"left: -2%;" +
  "width: 57%;" +
  "top: 36%;" +
  "display: table;" +
  "background-color: #027fe4;" +
  "border-radius:" + 50 * widthK + "px;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "}",

  componentPinResetRegistrationButtonLabel: ".component-pinreset-registration-button-label" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "font-size:" + 34 * widthK + "px;" +
  "color: #ffffff;" +
  "text-align: center;" +
  "display: table-cell;" +
  "vertical-align: middle;" +
  "}",

  //switch: ".switch" +
  //"{" +
  //"position: absolute;" +
  //"display: block;" +
  //"width:" + 52 * widthK + "px;" +
  //"top: 30%;" +
  //"right: 5%;" +
  //"height:" + 24 * widthK + "px;" +
  //"border: 1px solid white;" +
  //"border-radius:" + 50 * widthK + "px;" +
  //"}",
  //
  //switchInput: ".switch input" +
  //"{" +
  //"display: none;" +
  //"}",
  //
  //slider: ".slider" +
  //"{" +
  //"position: absolute;" +
  //"cursor: pointer;" +
  //"top: 0;" +
  //"left: 0;" +
  //"bottom: 0;" +
  //"background-color: #ccc;" +
  //"-webkit-transition: .4s;" +
  //"transition: .4s;" +
  //"}",
  //
  //sliderBefore: ".slider:before" +
  //"{" +
  //"position: absolute;" +
  //"content: '';" +
  //"height:" + 26 * widthK + "px;" +
  //"width:" + 26 * widthK + "px;" +
  //"left: 0;" +
  //"bottom:" + 4 * widthK + "px;" +
  //"background-color: white;" +
  //"-webkit-transition: .4s;" +
  //"transition: .4s;" +
  //"}",
  //
  //inputCheckedSlider: "input:checked + .slider" +
  //"{" +
  //"background-color: #2196F3;" +
  //"}",
  //
  //inputFocusSlider: "input:focus + .slider" +
  //"{" +
  //"box-shadow: 0 0 1px #2196F3;" +
  //"}",
  //
  //inputCheckedSliderBefore: "input:checked + .slider:before" +
  //"{" +
  //"-webkit-transform: translateX(" + 26 * widthK + "px);" +
  //"transform: translateX(" + 26 * widthK + "px);" +
  //"}",
  //
  //sliderRound: ".slider.round" +
  //"{" +
  //"border-radius:" + 34 * widthK + "px;" +
  //"position: absolute;" +
  //"top:" + 29 * widthK + "px;" +
  //"}",
  //
  //sliderRoundBefore: ".slider.round:before" +
  //"{" +
  //"border-radius: 50%;" +
  //"}",

//  SETTINGS

  settingsContainer: ".settings-container" +
  "{" +
  "position: absolute;" +
    //"height:" + 1150 * widthK + "px; " +
  "width:" + 720 * widthK + "px; " +
  "top:" + 92 * widthK + "px; " +
  "bottom:0; " +
  "background-color: white; " +
  "overflow-y: auto; " +
  "overflow-x: hidden; " +
  "}",

  settingsBlockContainer: ".settings-block-containter" +
  "{" +
  "position: relative;" +
  "height:" + 92 * widthK + "px; " +
  "width: 91%;" +
  "left: 4%;" +
  "margin-top: 1%;" +
  "border-bottom:" + 1 * widthK + "px solid gainsboro;" +
  "background-color: transparent;" +
  "}",

  settingsBlockNameField: ".settings-block-name-field" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "top: " + 26 * widthK + "px; " +
  "left: 1%;" +
  "text-align: left;" +
  "font-size:" + 29 * widthK + "px; " +
  "color: gray;" +
  "}",

  settingsBlockIcon: ".settings-block-icon" +
  "{" +
  "position: relative;" +
  "width: 13%;" +
  "height:" + 95 * widthK + "px; " +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "float: left;" +
  "background-size: 50%;" +
  "}",

  settingsBlockNextIcon: ".settings-block-next-icon" +
  "{" +
  "position: absolute;" +
  "right: 0;" +
  "width: 10%;" +
  "height: 100%;" +
  "top: 0;" +
  "background-repeat: no-repeat;" +
  "background-size: 17%;" +
  "background-position: center;" +
  "background-image: url(resources/icons/ViewInfo/open.png);" +
  "}",

  settingsGeneralPageTitle: ".settings-general-page-title " +
  "{" +
    //"position: absolute;" +
    //"top:" + -12 * widthK + "px;" +
    //"right:" + 28 * widthK + "px;" +
    //"left:" + 25 * widthK + "px;" +
    //"height:" + 100 * widthK + "px;" +
    //"background: transparent;" +
  "border: none;" +
  "}",

  settingsGeneralBackButton: ".settings-general-back-button " +
  "{" +
  "position: absolute;" +
  "width:" + 120 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "background-image: url(resources/icons/back/back.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 19%;" +
  "background-position-y:" + 31 * widthK + "px; " +
  "background-position-x:" + 41 * widthK + "px; " +
  "background-size: 16%;" +
  "left: -3%;" +
  "top: 0;" +
  "}",

  settingsGeneralCheckButton: ".settings-general-check-button " +
  "{" +
  "position: absolute;" +
  "width:" + 135 * widthK + "px;" +
  "height:" + 92 * widthK + "px;" +
  "right:" + -36 * widthK + "px;" +
  "background-image: url('resources/icons/ViewSettingsGeneral/general_save.png');" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 31%;" +
  "background-position-y: center;" +
  "background-position-x:" + 54 * widthK + "px;" +
  "background-size: 31%;" +
  "top: 0;" +
  "}",

  settingsGeneralContainer: ".settings-general-container" +
  "{" +
  "top:" + 500 * widthK + "px; " +
  "}",

  settingsGeneralUserInfoContainer: ".settings-general-user-info-container" +
  "{" +
  "position: absolute;" +
  "height:" + 500 * widthK + "px;" +
  "width:100%;" +
  "background: -moz-linear-gradient(rgb(0,124,231),rgb(0,180,247));" +
  "background: -webkit-linear-gradient(rgb(0,124,231),rgb(0,180,247));" +
  "background: -ms-linear-gradient(rgb(0,124,231),rgb(0,180,247));" +
  "}",

  settingsGeneralUserIcon: ".settings-general-user-icon" +
  "{" +
  "position: absolute;" +
  "height:" + 169 * widthK + "px;" +
  "width:" + 169 * widthK + "px;" +
  "top:" + 90 * widthK + "px;" +
  "left: 37.5%;" +
    //"border:" + 4 * widthK + "px solid white;" +
  "border-radius:" + 90 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-size: cover;" +
  "background-position: center;" +
  "}",

  settingsGeneralUserUploadAvatar: ".settings-general-user-upload-avatar" +
  "{" +
  "position: absolute;" +
  "top: 16%;" +
  "left: 13%;" +
  "opacity: 0;" +
  "z-index: 999999;" +
  "font-size:" + 38 * widthK + "px;" +
  "letter-spacing:" + -21 * widthK + "px;" +
  "}",

  settingsGeneralUserFirstName: ".settings-general-user-first-name" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: absolute;" +
  "top: 25%;" +
  "left: 8%;" +
  "width: 80%;" +
  "font-size:" + 42 * widthK + "px; " +
  "font-family: 'SFUIDisplay-Light';" +
  "padding: 0;" +
  "margin: 0;" +
  "color: white;" +
  "background: transparent;" +
  "text-align: center;" +
  "}",

  settingsGeneralGenderContainer: ".settings-general-gender-container " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 25%;" +

  "}",

  settingsGeneralLanguagesContainer: ".settings-general-languages-container " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 20%;" +
  "top: 23%;" +
  "background-color: lightblue;" +
  "}",

  settingsGeneralMaleContainer: ".settings-general-male-container " +
  "{" +
  "position: absolute;" +
  "width: 20%;" +
  "height: 100%;" +
  "left: 26%;" +
  "}",

  settingsGeneralFemaleContainer: ".settings-general-female-container" +
  "{" +
  "position: absolute;" +
  "width: 20%;" +
  "height: 100%;" +
  "left: 54%;" +
  "}",

  settingsGeneralMaleIcon: ".settings-general-male-icon" +
  "{" +
  "position: relative;" +
  "width: 80%;" +
  "height: 92%;" +
  "/*top: 20%;*/" +
  "left: 11%;" +
  "background-repeat: no-repeat;" +
  "background-size: 70%;" +
  "background-position: center;" +
  "background-image: url('resources/icons/ViewSettingsGeneral/general_male_inactive.png');" +
  "}",

  settingsGeneralFemaleIcon: ".settings-general-female-icon" +
  "{" +
  "position: relative;" +
  "width: 80%;" +
  "height: 92%;" +
  "top: 0%;" +
  "left: 11%;" +
  "background-repeat: no-repeat;" +
  "background-size: 74%;" +
  "background-position: center;" +
  "background-image: url('resources/icons/ViewSettingsGeneral/general_female_inactive.png');" +
  "}",

  settingsGeneralGenderText: ".settings-general-gender-text" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "text-align: center;" +
  "padding: 0;" +
  "bottom: 12%;" +
  "color: lightgray;" +
  "font-size:" + 24 * widthK + "px;" +
  "}",

  settingsGeneralLineBetween: ".settings-general-line-between" +
  "{" +
  "position: absolute;" +
  "left: 50%;" +
  "width: 1px;" +
  "height: 55%%;" +
  "top: 40%;" +
  "background-color: lightgrey;" +
  "}",

  settingsGeneralEditIcon: ".settings-general-edit-icon" +
  "{" +
  "position: absolute;" +
  "width:" + 35 * widthK + "px;" +
  "height:" + 40 * widthK + "px;" +
  "left: 85%;" +
  "bottom:0;" +
  "background-repeat: no-repeat;" +
  "background-size: 83%;" +
  "background-position: center;" +
  "background-image: url('resources/icons/ViewSettingsGeneral/general_edit.png');" +
  "}",

  settingsGeneralUserNameContainer: ".settings-general-user-name-container" +
  "{" +
  "position: absolute;" +
  "width: 84.5%;" +
  "height: 17%;" +
  "bottom: 29%;" +
  "border-bottom:" + 5 * widthK + "px solid #05d0ff;" +
  "left: 8.5%;" +
  "}",

  settingsGeneralUserNameSave: ".settings-general-user-name-save" +
  "{" +
  "position: absolute;" +
  "width: 9%;" +
  "height: 85%;" +
  "top: 13%;" +
  "right: 0;" +
  "background-repeat: no-repeat;" +
  "background-size: 70%;" +
  "background-position: center;" +
  "background-image: url('resources/icons/ViewSettingsGeneral/general_edit.png');" +
    //"background-image: url('resources/icons/ViewSettingsGeneral/general_save.png');" +
  "}",

  settingsGeneralDownloadDeleteContainer: ".settings-general-download-delete-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 120 * widthK + "px;" +
  "bottom: 0%;" +
  "}",

  settingsGeneralDownloadContainer: ".settings-general-download-container" +
  "{" +
  "position: relative;" +
  "width: 41%;" +
  "height: 50%;" +
  "top: 13%;" +
  "margin-left: 13%;" +
  "margin-right: 0%;" +
  "float: left;" +
  "background-color: #09ceff;" +
  "}",

  settingsGeneralDownloadTitle: ".settings-general-download-title" +
  "{" +
  "position: absolute;" +
  "top: 20%;" +
  "left: 27%;" +
  "margin: 0;" +
  "color: white;" +
  "font-size:" + 27 * widthK + "px;" +
  "background-color: #09ceff;" +
  "}",

  settingsGeneralDownloadIcon: ".settings-general-download-icon" +
  "{" +
  "position: absolute;" +
  "width: 9%;" +
  "height: 85%;" +
  "top: 13%;" +
  "left: 13%;" +
  "background-repeat: no-repeat;" +
  "background-size: 75%;" +
  "background-position: center;" +
  "background-image: url('resources/icons/ViewSettingsGeneral/general_upload.png');" +
  "}",

  settingsGeneralDeleteContainer: ".settings-general-delete-container" +
  "{" +
  "position: relative;" +
  "width: 40%;" +
  "top: 13%;" +
  "height: 50%;" +
  "float: left;" +
  "}",

  settingsGeneralDeleteTitle: ".settings-general-delete-title" +
  "{" +
  "position: absolute;" +
  "top: 31%;" +
  "left: 26%;" +
  "margin: 0;" +
  "color: white;" +
  "font-size:" + 27 * widthK + "px;" +
  "}",

  settingsGeneralDeleteIcon: ".settings-general-delete-icon" +
  "{" +
  "position: absolute;" +
  "width: 9%;" +
  "height: 85%;" +
  "top: 13%;" +
  "left: 13%;" +
  "background-repeat: no-repeat;" +
  "background-size: 75%;" +
  "background-position: center;" +
  "background-image: url('resources/icons/ViewSettingsGeneral/general_delete.png');" +
  "}",


  settingsGeneralLangContainer: ".settings-general-lang-container" +
  "{" +
  "position: relative;" +
  "width: 79.5%;" +
  "height: " + 70 * widthK + "px; " +
  "top:12%;" +
  "left:10%;" +
  "}",

  settingsGeneralLangText: ".settings-general-lang-text" +
  "{" +
  "position: absolute;" +
  "font-size: " + 28 * widthK + "px; " +
  "color: #595759;" +
  "}",

  settingsGeneralLangCheck: ".settings-general-lang-check" +
  "{" +
  "position: absolute;" +
  "background-image: url('resources/icons/ViewService/unchecked.png');" +
  "width: 7%;" +
  "height: 36%;" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "background-position: center;" +
  "top: 50%;" +
  "left: 93%;" +
  "}",

  //SETTINGS ADD FRIEND
  settingsAddFriendAddContainer: ".settings-add-friend-add-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
    //"border-bottom: 1px solid gray;" +
  "height:" + 150 * widthK + "px;" +
  "}",

  settingsAddFriendAddTitle: ".settings-add-friend-add-title" +
  "{" +
  "position: relative;" +
  "margin-left: 10%;" +
  "top: 12%;" +
  "color: #cbcbcb;" +
  "font-size:" + 24 * widthK + "px;" +
  "}",

  settingsAddFriendContactPhoneField: ".settings-add-friend-contact-phone-field" +
  "{" +
  "position: absolute;" +
  "left: 10%;" +
  "width: 79.5%;" +
  "height:" + 100 * widthK + "px;" +
  "border-bottom:" + 5 * widthK + "px solid #01cfff;" +
  "color: white;" +
  "top: 17%" +
  "}",

  settingsAddFriendContactNumberInputPart: ".settings-add-friend-contact-number-input-part" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "top: 28%;" +
  "padding: 0;" +
  "margin: 0;" +
  "margin-left: 3%;" +
  "width: 65%;" +
  "font-size:" + 51 * widthK + "px;" +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "}",

  settingsAddFriendNameNumberInputPart: ".settings-add-friend-name-number-input-part" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "top: 28%;" +
  "padding: 0;" +
  "margin: 0;" +
  "margin-left: 3%;" +
  "width: 93%;" +
  "font-size:" + 51 * widthK + "px;" +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "}",

  settingsAddFriendNamePhoneField: ".settings-add-friend-name-phone-field" +
  "{" +
  "position: absolute;" +
  "left: 10%;" +
  "width: 79.5%;" +
  "height:" + 100 * widthK + "px;" +
  "border-bottom:" + 5 * widthK + "px solid #01cfff;" +
  "color: white;" +
  "top: 36%" +
  "}",

  settingsAddFriendContactTextField: ".settings-add-friend-contact-text-field" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: #cbcbcb;" +
  "font-size:" + 24 * widthK + "px;" +
  "top: -14%;" +
  "}",

  settingsAddFriendContactPhoneIcon: ".settings-add-friend-contact-phone-icon" +
  "{" +
  "position: absolute;" +
  "background-image: url('resources/icons/ViewService/book.png');" +
  "width: 13%;" +
  "height: 50%;" +
  "background-repeat: no-repeat;" +
  "background-size: 60%;" +
  "background-position: center;" +
  "top: 34%;" +
  "right: -2%;" +
  "}",

  settingsAddFriendContactNumberFirstPart: ".settings-add-friend-contact-number-first-part" +
  "{" +
  "float: left;" +
  "position: relative;" +
  "top: 28%;" +
  "height: 68%;" +
  "font-size:" + 51 * widthK + "px;" +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "margin: 0;" +
  "}",


  settingsAddFriendNextButtonInnerContainer: ".settings-add-friend-next-button-inner-container" +
  "{" +
  "position: relative;" +
  "width: 63%;" +
  "height: 8%;" +
  "margin-right: auto;" +
  "border-radius: " + 80 * widthK + "px; " +
  "margin-left: auto;" +
  "background-color: rgb(1, 124, 227);" +
  "top: 29%;" +
  "}",

  settingsAddFriendNextButtonLabel: ".settings-add-friend-next-button-label" +
  "{" +
  "position: relative;" +
  "top: 20%;" +
  "width: 30%;" +
  "font-size:  " + 45 * widthK + "px; " +
  "margin: auto;" +
  "color: white;" +
  "}",

  settingsAddFriendContactFoundContainerOne: ".settings-add-friend-contact-found-container-one" +
  "{" +
  "position: absolute;" +
  "width: 79.5%;" +
  "height:" + 120 * widthK + "px;" +
  "background-color: #F0F1F4;" +
  "left: 10%;" +
  "top:" + 310 * widthK + "px;" +
  "display: none;" +
  "}",

  settingsAddFriendContactFoundContainerTwo: ".settings-add-friend-contact-found-container-two" +
  "{" +
  "position: absolute;" +
  "width: 79.5%;" +
  "height:" + 120 * widthK + "px;" +
  "background-color: #F0F1F4;" +
  "left: 10%;" +
  "top:" + 435 * widthK + "px;" +
  "display: none;" +
  "}",

  //SETTINGS ABOUT PROGRAM
  settingsAboutProgramBlueContainer: ".settings-about-program-blue-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 418 * widthK + "px;" +
  "background-color: #027ee3;" +
  "}",

  settingsAboutProgramUserAgreementContainer: ".settings-about-program-user-agreement-container" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: 12%;" +
  "border-bottom:1px solid #f4f4f4;" +
  "}",

  settingsAboutProgramUserAgreementTitle: ".settings-about-program-user-agreement-title" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "margin-left: 6%;" +
  "top: 36%;" +
  "font-size:" + 30 * widthK + "px;" +
  "color: #919191;" +
  "}",

  settingsAboutProgramUserAgreementIcon: ".settings-about-program-user-agreement-icon" +
  "{" +
  "position: absolute;" +
  "right: 0;" +
  "width: 15%;" +
  "height: 100%;" +
  "top: 0;" +
  "background-repeat: no-repeat;" +
  "background-size: 11%;" +
  "background-position: center;" +
  "background-image: url(resources/icons/ViewInfo/open.png);" +
  "}",

  settingsAboutProgramRankContainer: ".settings-about-program-rank-container" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: 12%;" +
  "border-bottom:1px solid #f4f4f4;" +
  "}",

  settingsAboutProgramRankTitle: ".settings-about-program-rank-title" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "margin-left: 6%;" +
  "top: 36%;" +
  "font-size:" + 30 * widthK + "px;" +
  "color: #919191;" +
  "background-repeat: no-repeat;" +
  "background-size: 10%;" +
  "background-position: center;" +
  "}",

  settingsAboutProgramRankIcon: ".settings-about-program-rank-icon" +
  "{" +
  "position: absolute;" +
  "right: 0;" +
  "width: 15%;" +
  "height: 100%;" +
  "top: 0;" +
  "background-repeat: no-repeat;" +
  "background-size: 11%;" +
  "background-position: center;" +
  "background-image: url(resources/icons/ViewInfo/open.png);" +
  "}",

  settingsAboutProgramContainer: ".settings-about-program-container" +
  "{" +
  "top:" + 417 * widthK + "px;" +
  "}",

  settingsAboutProgramPageTitle: ".settings-about-program-page-title " +
  "{" +
  "position: absolute;" +
  "top:" + -12 * widthK + "px;" +
  "right:" + 28 * widthK + "px;" +
  "left:" + 25 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "background: transparent;" +
    //"border-bottom:" + 2 + "px solid rgb(149, 230, 253);" +
  "}",

  settingsAboutProgramNameTitle: ".settings-about-program-name-title " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size:" + 34 * widthK + "px; " +
  "left:" + 77 * widthK + "px; " +
  "top:" + 38 * widthK + "px; " +
  "margin: 0;  " +
  "color: #fffaf9;" +
  "}",

  settingsAboutProgramVersionTitlePartOne: ".settings-about-program-version-title-part-one " +
  "{" +
  "position: relative;" +
  "font-size:" + 35 * widthK + "px; " +
  "width:" + 255 * widthK + "px; " +
  "margin: 0; " +
  "margin-left: auto; " +
  "margin-right: auto; " +
  "top: 10%; " +
  "color: white;" +
  "}",

  settingsAboutProgramVersionTitlePartTwo: ".settings-about-program-version-title-part-two " +
  "{" +
  "position: relative;" +
  "font-size:" + 24 * widthK + "px; " +
  "width:" + 150 * widthK + "px; " +
  "margin: 0; " +
  "margin-left: auto; " +
  "margin-right: auto; " +
  "top: 11%; " +
  "color: white;" +
  "}",

  settingsAboutProgramClickIcon: ".settings-about-program-click-icon" +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "top: 14%;" +
  "width: 21%;" +
  "height: 60%;" +
  "background-repeat: no-repeat;" +
  "background-image: url(resources/icons/ViewSettingsAboutProgram/about_logo.png);" +
  "background-size: 100%;" +
  "background-position: center;" +
  "}",

  //SETTINGS FRIEND HELP
  settingsFriendHelpContactContainer: ".settings-friend-help-contact-container" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "border-bottom: 1px solid #f4f4f4;" +
  "height:" + 160 * widthK + "px;" +
  "}",

  settingsFriendHelpAddButton: ".settings-friend-help-add-button " +
  "{" +
  "position: absolute;" +
  "width: 20%;" +
  "height: 100%;" +
  "right: -4%;" +
  "background-image: url(resources/icons/ViewSettingsFriendHelp/plus.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 30%;" +
  "background-position-y: 62%;" +
  "background-position-x: 62%;" +
  "background-size: 30%;" +
  "top:0" +
  "}",

  settingsFriendHelpContactFoundPhoto: ".settings-friend-help-contact-found-photo" +
  "{" +
  "top:" + 32 * widthK + "px;" +
  "position: absolute;" +
  "width:" + 100 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "line-height:" + 100 * widthK + "px;" +
  "font-size:" + 50 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-size: cover;" +
  "background-position: center;" +
  "background-color: #017de8;" +
  "color: white;" +
  "border-radius: 50%;" +
  "text-align: center;" +
  "left: 6%;" +
  "}",

  settingsFriendHelpContactFoundTextContainer: ".settings-friend-help-contact-found-text-container" +
  "{" +
  "position: absolute;" +
  "left: 23%;" +
  "color: gray;" +
  "width: 60%;" +
  "height: 100%;" +
  "display: table;" +
  "}",


  settingsFriendHelpContactFoundTextOne: ".settings-friend-help-contact-found-text-one" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: #999999;" +
  "top: 32%;" +
  "font-size:" + 29 * widthK + "px;" +
  "width:" + 400 * widthK + "px;" +
  "}",

  settingsFriendHelpContactFoundTextTwo: ".settings-friend-help-contact-found-text-two" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left: 0%;" +
  "color: #cbcbcb;" +
  "font-size:" + 24 * widthK + "px;" +
  "top: 53%;" +
  "}",

  settingsFriendHelpContactCancelIcon: ".settings-friend-help-contact-cancel-icon" +
  "{" +
  "top:" + 33 * widthK + "px;" +
  "position: absolute;" +
  "width:" + 100 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-size: 21%;" +
  "background-position: center;" +
  "background-image: url(resources/icons/ViewSettingsFriendHelp/delete.png);" +
  "right: 2%;" +
  "}",


  //SETTINGS SECURITY
  settingsSecurityCheckButton: ".settings-security-check-button " +
  "{" +
  "position: absolute;" +
  "width:" + 135 * widthK + "px;" +
  "height:" + 92 * widthK + "px;" +
  "right:" + -36 * widthK + "px;" +
  "background-image: url('resources/icons/ViewSettingsGeneral/general_save.png');" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 31%;" +
  "background-position-y: center;" +
  "background-position-x:" + 54 * widthK + "px;" +
  "background-size: 31%;" +
  "top: " + 12 * widthK + "px;" +
  "}",

  settingsSecurityCheckIcon: ".settings-security-check-icon" +
  "{" +
  "position: absolute;" +
  "right: 0;" +
  "width: 10%;" +
  "height: 100%;" +
  "top: 0;" +
  "background-repeat: no-repeat;" +
  "background-size: 63%;" +
  "background-position: center;" +
  "background-image: url(resources/icons/ViewSettingsGeneral/general_save.png);" +
  "}",

  settingsSecurityScannerBlock: ".settings-security-scanner-block" +
  "{" +
  "height:" + 120 * widthK + "px;" +
  "}",

  settingsSecurityScannerBlockName: ".settings-security-scanner-block-name" +
  "{" +
  "width: 70%;" +
  "top:" + 18 * widthK + "px;" +
  "}",

  settingsSecurityBlockDetailText: ".settings-security-block-detail-text" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "top: " + 31 * widthK + "px; " +
  "left: 1%;" +
  "text-align: left;" +
  "font-size:" + 22 * widthK + "px; " +
  "color: darkgray;" +
  "}",

  settingsSecurityBlock: ".settings-security-block" +
  "{" +
  "height:" + 160 * widthK + "px;" +
  "}",

  //SETTINGS USER AGREEMENT

  settingsUserAgreementText: ".settings-user-agreement-text" +
  "{" +
  "position: relative;" +
  "top: 5%; " +
  "text-align: justify;" +
  "margin: 0;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "width: 85%;" +
  "font-size:" + 24 * widthK + "px; " +
  "font-family: SFUIDisplay-Light; " +
  "white-space: pre-line; " +
  "overflow-x: hidden; " +
  "}",

  settingsUserAgreementNameTitle: ".settings-user-agreement-name-title " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size:" + 35 * widthK + "px; " +
  "left:" + 85 * widthK + "px; " +
  "top:" + 38 * widthK + "px; " +
  "margin: 0;  " +
  "width: 100%;  " +
  "color: #fffaf9;" +
  "}",

  //TRANSFER DETAIL VIEW

  transferDetailContainer: ".transfer-detail-container" +
  "{" +
  "position: absolute;" +
    //"height:" + 1150 * widthK + "px; " +
  "width:" + 720 * widthK + "px; " +
  "top:" + 380 * widthK + "px; " +
  "bottom:0; " +
  "background-color: #f4f4f4; " +
  "overflow-y: auto; " +
  "overflow-x: hidden; " +
  "}",

  transferDetailTitleContainer: ".transfer-detail-title-container" +
  "{" +
  "position: absolute;" +
  "height:" + 380 * widthK + "px;" +
  "width:100%;" +
  "background-color: #0280e4;" +
  "}",

  transferDetailPageTitle: ".transfer-detail-page-title " +
  "{" +
  "position: absolute;" +
  "top: 0px;" +
  "right:" + 28 * widthK + "px;" +
  "left:" + 19 * widthK + "px;" +
  "height:" + 84 * widthK + "px;" +
  "background: transparent;" +
  "border: none;" +
  "}",


  transferDetailTransferContainer: ".transfer-detail-transfer-container " +
  "{" +
  "position: relative;" +
  "width: 90%;" +
  "height: 11.5%;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "border-bottom: 1px solid lightgrey;" +
  "}",

  transferDetailTransferIcon: ".transfer-detail-transfer-icon" +
  "{" +
  "position: absolute;" +
  "height:" + 90 * widthK + "px;" +
  "width:" + 90 * widthK + "px;" +
  "top:" + 104 * widthK + "px;" +
  "left: 44%;" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "background-position: center;" +
  "background-image: url(resources/icons/bank-operations/transfers.png);" +
  "}",

  transferDetailTransferIconTitlePartOne: ".transfer-detail-transfer-icon-title-part-one " +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "top: 59%;" +
  "margin: 0;" +
  "color: white;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "text-align: center;" +
  "font-size:" + 34 * widthK + "px;" +
  "}",

  transferDetailTransferIconTitlePartTwo: ".transfer-detail-transfer-icon-title-part-two " +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "top: 57%;" +
  "margin: 0;" +
  "color: white;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "text-align: center;" +
  "font-size:" + 34 * widthK + "px;" +
  "}",

  transferDetailTransferIconTitlePhone: ".transfer-detail-transfer-icon-title-phone " +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "top: 56%;" +
  "margin: 0;" +
  "color: white;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "text-align: center;" +
  "font-size:" + 34 * widthK + "px;" +
  "}",

  transferDetailTitle: ".transfer-detail-title " +
  "{" +
  "position: absolute;" +
  "top: 28%;" +
  "left: 3%;" +
  "font-size:" + 25 * widthK + "px;" +
  "color: #c1c1c1;" +
  "margin: 0;" +
  "text-align: center;" +
  "}",

  transferDetailSum: ".transfer-detail-sum " +
  "{" +
  "position: absolute;" +
  "top: 57%;" +
  "left: 3%;" +
  "font-size:" + 30 * widthK + "px;" +
  "color: #c1c1c1;" +
  "margin: 0;" +
  "text-align: center;" +
  "color: #9ec94a;" +
  "}",

  transferDetailNumber: ".transfer-detail-number " +
  "{" +
  "position: absolute;" +
  "top: 57%;" +
  "left: 3%;" +
  "font-size:" + 30 * widthK + "px;" +
  "color: #c1c1c1;" +
  "margin: 0;" +
  "text-align: center;" +
  "color: grey;" +
  "}",

  transferDetailDate: ".transfer-detail-date " +
  "{" +
  "position: absolute;" +
  "top: 53%;" +
  "left: 3%;" +
  "font-size:" + 30 * widthK + "px;" +
  "color: #c1c1c1;" +
  "margin: 0;" +
  "text-align: center;" +
  "color: grey;" +
  "}",

  transferDetailStatus: ".transfer-detail-status " +
  "{" +
  "position: absolute;" +
  "top: 51%;" +
  "left: 3%;" +
  "font-size:" + 30 * widthK + "px;" +
  "color: #c1c1c1;" +
  "margin: 0;" +
  "text-align: center;" +
  "color: #f3ba31;" +
  "}",

  transferDetailButtonsContainer: ".transfer-detail-buttons-container" +
  "{" +
  "position: relative;" +
  "height: 13%;" +
  "width:100%;" +
  "top: 9%;" +
  "}",

  transferDetailButtonAccept: ".transfer-detail-button-accept" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "float: left;" +
  "text-align: center;" +
  "margin-left: 6%;" +
  "color: white;" +
  "background-color: #0280e4;" +
  "height:" + 62 * widthK + "px;" +
  "line-height:" + 63 * widthK + "px;" +
  "border-radius:" + 5 * widthK + "px;" +
  "font-size:" + 29 * widthK + "px;" +
  "width: 40%;" +
  "}",

  transferDetailButtonCancel: ".transfer-detail-button-cancel" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "float: left;" +
  "text-align: center;" +
  "margin-left: 8%;" +
  "color: white;" +
  "background-color: #f46b5b;" +
  "height:" + 62 * widthK + "px;" +
  "line-height:" + 63 * widthK + "px;" +
  "border-radius:" + 5 * widthK + "px;" +
  "font-size:" + 29 * widthK + "px;" +
  "width: 40%;" +
  "}",

  //ACCOUNT DETAIL VIEW

  accountDetailContainer: ".account-detail-container" +
  "{" +
  "position: absolute;" +
    //"height:" + 1150 * widthK + "px; " +
  "width:" + 720 * widthK + "px; " +
  "top:" + 380 * widthK + "px; " +
  "bottom:0; " +
  "background-color: #f4f4f4; " +
  "overflow-y: hidden; " +
  "overflow-x: hidden; " +
  "}",

  accountDetailTitleContainer: ".account-detail-title-container" +
  "{" +
  "position: absolute;" +
  "height:" + 380 * widthK + "px;" +
  "width:100%;" +
  "background-color: #0280e4;" +
  "}",

  accountDetailPageTitle: ".account-detail-page-title " +
  "{" +
  "position: absolute;" +
  "top: 0px;" +
  "right:" + 28 * widthK + "px;" +
  "left:" + 19 * widthK + "px;" +
  "height:" + 84 * widthK + "px;" +
  "background: transparent;" +
  "border: none;" +
  "}",


  accountDetailTransferContainer: ".account-detail-payment-container " +
  "{" +
  "position: relative;" +
  "width: 90%;" +
  "height: 11.5%;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "border-bottom: 1px solid lightgrey;" +
  "}",

  accountDetailTransferPayFromContainer: ".account-detail-payment-pay-from-container " +
  "{" +
  "position: relative;" +
  "width: 90%;" +
  "height: 10%;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "border-bottom: 1px solid lightgrey;" +
  "}",

  accountDetailTransferIcon: ".account-detail-transfer-icon" +
  "{" +
  "position: absolute;" +
  "height:" + 90 * widthK + "px;" +
  "width:" + 90 * widthK + "px;" +
  "top:" + 104 * widthK + "px;" +
  "left: 44%;" +
  "background-repeat: no-repeat;" +
  "background-size: 70%;" +
  "background-position: center;" +
  "background-image: url(resources/icons/bank-operations/payment.png);" +
  "}",

  accountDetailTransferIconTitlePartOne: ".account-detail-transfer-icon-title-part-one " +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "top: 59%;" +
  "margin: 0;" +
  "color: white;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "text-align: center;" +
  "font-size:" + 34 * widthK + "px;" +
  "}",

  accountDetailTransferIconTitlePartTwo: ".account-detail-transfer-icon-title-part-two " +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "top: 57%;" +
  "margin: 0;" +
  "color: white;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "text-align: center;" +
  "font-size:" + 34 * widthK + "px;" +
  "}",

  accountDetailTransferIconTitlePhone: ".account-detail-transfer-icon-title-phone " +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "top: 56%;" +
  "margin: 0;" +
  "color: white;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "text-align: center;" +
  "font-size:" + 34 * widthK + "px;" +
  "}",

  accountDetailTitle: ".account-detail-title " +
  "{" +
  "position: absolute;" +
  "top: 28%;" +
  "left: 3%;" +
  "font-size:" + 25 * widthK + "px;" +
  "color: #c1c1c1;" +
  "margin: 0;" +
  "text-align: center;" +
  "}",

  accountDetailSum: ".account-detail-sum " +
  "{" +
  "position: absolute;" +
  "top: 57%;" +
  "left: 3%;" +
  "font-size:" + 30 * widthK + "px;" +
  "color: #c1c1c1;" +
  "margin: 0;" +
  "text-align: center;" +
  "color: #9ec94a;" +
  "}",

  accountDetailPayFor: ".account-detail-pay-for " +
  "{" +
  "position: absolute;" +
  "top: 57%;" +
  "left: 3%;" +
  "font-size:" + 30 * widthK + "px;" +
  "color: #c1c1c1;" +
  "margin: 0;" +
  "text-align: center;" +
  "color: grey;" +
  "}",

  accountDetailPayFrom: ".account-detail-pay-from " +
  "{" +
  "position: absolute;" +
  "top: 57%;" +
  "left: 3%;" +
  "font-size:" + 30 * widthK + "px;" +
  "color: #c1c1c1;" +
  "margin: 0;" +
  "text-align: center;" +
  "color: grey;" +
  "}",

  accountDetailCardsContainer: ".account-detail-cards-container" +
  "{" +
  "position: relative;" +
  "height: 72%;" +
  "width:90%;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "overflow: hidden;" +
    //"top: 9%;" +
  "}",

  accountDetailButtonsContainer: ".account-detail-buttons-container" +
  "{" +
  "position: relative;" +
  "height: 13%;" +
  "width:100%;" +
  "top: 11%;" +
  "}",

  accountDetailButtonAccept: ".account-detail-button-accept" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "float: left;" +
  "text-align: center;" +
  "margin-left: 1%;" +
  "color: white;" +
  "background-color: #0280e4;" +
  "height:" + 62 * widthK + "px;" +
  "line-height:" + 63 * widthK + "px;" +
  "border-radius:" + 5 * widthK + "px;" +
  "font-size:" + 29 * widthK + "px;" +
  "width: 44%;" +
  "}",

  accountDetailButtonCancel: ".account-detail-button-cancel" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "float: left;" +
  "text-align: center;" +
  "margin-left: 9%;" +
  "color: white;" +
  "background-color: #f46b5b;" +
  "height:" + 62 * widthK + "px;" +
  "line-height:" + 63 * widthK + "px;" +
  "border-radius:" + 5 * widthK + "px;" +
  "font-size:" + 29 * widthK + "px;" +
  "width: 44%;" +
  "}",

  //VIEW TRANSFER TO CARD

  transferToCardContainer: ".transfer-to-card-container" +
  "{" +
  "position: absolute;" +
    //"height:" + 1150 * widthK + "px; " +
  "width:" + 720 * widthK + "px; " +
  "top:" + 220 * widthK + "px; " +
  "bottom:0; " +
  "background-color: #f4f4f4; " +
  "overflow-y: hidden; " +
  "overflow-x: hidden; " +
  "}",

  transferToCardTitleContainer: ".transfer-to-card-title-container" +
  "{" +
  "position: absolute;" +
  "height:" + 220 * widthK + "px;" +
  "width:100%;" +
  "background-color: #0280e4;" +
  "}",

  transferToCardTransferTitlePartOne: ".transfer-to-card-transfer-title-part-one " +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "top: 20%;" +
  "margin: 0;" +
  "color: white;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "text-align: center;" +
  "font-size:" + 34 * widthK + "px;" +
  "}",

  transferToCardTransferTitlePartTwo: ".transfer-to-card-transfer-title-part-two " +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "top: 27%;" +
  "margin: 0;" +
  "color: white;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "text-align: center;" +
  "font-size:" + 34 * widthK + "px;" +
  "}",

  transferToCardTransferTitlePhone: ".transfer-to-card-transfer-title-phone " +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "top: 27%;" +
  "margin: 0;" +
  "color: white;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "text-align: center;" +
  "font-size:" + 34 * widthK + "px;" +
  "}",


//  VIEW REPORTS

  viewReportsMonthsContainer: ".view-reports-months-container " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 80 * widthK + "px;" +
  "top:" + 90 * widthK + "px;" +
    //"overflow-x: auto;" +
    //"overflow-y: hidden;" +
  "font-size:" + 23 * widthK + "px;" +
  "}",


  viewReportsMonthInfoContainer: ".view-reports-month-info-container " +
  "{" +
  "position: absolute;" +
  "height: 100%;" +
  "width: 50%;" +
  "left: 103%;" +
  "color: #8b8b8b;" +
  "}",

  viewReportsMonthInfoName: ".view-reports-month-info-name " +
  "{" +
  "position: absolute;" +
  "height: 25%;" +
  "top: 30%;" +
  "left: 3%;" +
  "margin: 0;" +
  "color: white;" +
  "font-size: " + 32 * widthK + "px; " +
  "}",

  viewReportsBodyContainer: ".view-reports-body-container" +
  "{" +
  "position: absolute;" +
    //"height:" + 1150 * widthK + "px; " +
  "width:" + 720 * widthK + "px; " +
  "top:" + 170 * widthK + "px; " +
  "bottom:0; " +
  "background-color: white; " +
  "overflow-y: auto; " +
  "overflow-x: hidden; " +
  "}",

  viewReportsGraphBodyContainer: ".view-reports-graph-body-container" +
  "{" +
  "position: absolute;" +
    //"height:" + 1150 * widthK + "px; " +
  "width:" + 720 * widthK + "px; " +
  "top:" + 170 * widthK + "px; " +
  "bottom:0; " +
  "background-color: white; " +
  "}",

  viewReportsGraphFrame: ".view-reports-graph-frame" +
  "{" +
  "position: relative;" +
  "width:" + 400 * widthK + "px !important; " +
  "height:" + 400 * widthK + "px !important; " +
  "margin-left: auto; " +
  "margin-right: auto; " +
  "background-color: white; " +
  "}",

  viewReportsFilterContainer: ".view-reports-filter-container " +
  "{" +
  "position: absolute;" +
  "width:" + 195 * widthK + "px;" +
  "height:" + 92 * widthK + "px;" +
  "right:" + 103 * widthK + "px;" +
  "top: 0;" +
  "}",

  viewReportsFilterText: ".view-reports-filter-text " +
  "{" +
  "color: white;" +
  "font-size:" + 28 * widthK + "px;" +
  "}",

  viewReportsFilterButton: ".view-reports-filter-button " +
  "{" +
  "position: absolute;" +
  "width:" + 60 * widthK + "px;" +
  "height:" + 92 * widthK + "px;" +
  "right:0;" +
  "background-image: url('resources/icons/ViewReport/reports_filters.png');" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 31%;" +
  "background-position-y: center;" +
  "background-position-x:" + 10 * widthK + "px;" +
  "background-size: 70%;" +
  "top: 0;" +
  "}",

  viewReportsGraphButton: ".view-reports-graph-button " +
  "{" +
  "position: absolute;" +
  "width:" + 138 * widthK + "px;" +
  "height:" + 92 * widthK + "px;" +
  "right:" + -36 * widthK + "px;" +
  "background-image: url('resources/icons/ViewReport/reports_chart_off.png');" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 31%;" +
  "background-position-y: center;" +
  "background-position-x:" + 54 * widthK + "px;" +
  "background-size: 31%;" +
  "top: 0;" +
  "}",

  //body

  viewReportsPaymentsContainer: ".view-reports-payments-containter" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "}",

  viewReportsPaymentDateContainer: ".view-reports-payment-date-containter" +
  "{" +
  "position: relative;" +
  "height:" + 75 * widthK + "px; " +
  "width: 91%;" +
  "left: 4%;" +
  "margin-top: 1%;" +
  "border-bottom:" + 1 * widthK + "px solid gainsboro;" +
  "background-color: transparent;" +
  "}",

  viewReportsPaymentDateField: ".view-reports-payment-date-field" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "top: " + 26 * widthK + "px; " +
  "left: 1%;" +
  "text-align: left;" +
  "font-size:" + 24 * widthK + "px; " +
  "color: gray;" +
  "}",

  viewReportsPaymentBlockContainer: ".view-reports-payment-block-containter" +
  "{" +
  "position: relative;" +
  "height:" + 150 * widthK + "px; " +
  "width: 91%;" +
  "left: 4%;" +
  "margin-top: 1%;" +
  "border-bottom:" + 1 * widthK + "px solid gainsboro;" +
  "background-color: transparent;" +
  "}",


  viewReportsPaymentIcon: ".view-reports-payment-icon " +
  "{" +
    //"top:" + 50 * widthK + "px;" +
  "background-size: 80%;" +
  "position: absolute;" +
  "width:" + 125 * widthK + "px;" +
  "height:" + 125 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "border-radius:" + 100 * widthK + "px;" +
  "border:solid 1px #b7b7b7;" +
  "top: 6%;" +
  "}",

  viewReportsPaymentInfoContainer: ".view-reports-payment-info-container " +
  "{" +
  "position: absolute;" +
  "height: 100%;" +
  "width: 72%;" +
  "left: 18%;" +
  "color: #8b8b8b;" +
  "}",

  viewReportsPaymentInfoName: ".view-reports-payment-info-name " +
  "{" +
  "position: absolute;" +
  "height: 25%;" +
  "top: 15%;" +
  "left: 8%;" +
  "margin: 0;" +
  "font-size:" + 22 * widthK + "px; " +
  "width: 75%;" +
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "}",

  viewReportsPaymentInfoBalance: ".view-reports-payment-info-balance " +
  "{" +
  "position: relative;" +
  "top: 30%;" +
  "left: 8%;" +
  "margin: 0;" +
  "font-size:" + 45 * widthK + "px;" +
  "color: #ee4d3d;" +
  "float: left;" +
  "}",

  viewReportsPaymentInfoCurrencyField: ".view-reports-payment-info-currency-field" +
  "{" +
  "position: relative;" +
  "top: 42%;" +
  "left: 9%;" +
  "margin: 0;" +
  "font-size:" + 26 * widthK + "px;" +
  "color: #ee4d3d;" +
  "float: left;" +
  "}",

  viewReportsPaymentInfoNumber: ".view-reports-payment-info-number " +
  "{" +
  "position: absolute;" +
  "height: 25%;" +
  "top: 65%;" +
  "left: 8%;" +
  "margin: 0;" +
  "font-size: " + 22 * widthK + "px; " +
  "width: 75%;" +
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "}",

  viewReportsPaymentInfoTime: ".view-reports-payment-info-time " +
  "{" +
  "position: absolute;" +
  "right: 0;" +
  "width: 10%;" +
  "height: 100%;" +
  "top: 15%;" +
  "font-size: " + 22 * widthK + "px; " +
  "margin: 0;" +
  "color: #8b8b8b;" +
  "}",

  //graph

  viewReportsGraphBigamountContainer: ".view-reports-graph-bigamount-container " +
  "{" +
  "position: absolute;" +
  "height: 16%;" +
  "width: 85%;" +
  "left: 7%;" +
  "color: black;" +
  "}",

  viewReportsGraphBigamountText: ".view-reports-graph-bigamount-text " +
  "{" +
  "position: absolute;" +
  "height: 25%;" +
  "top: 15%;" +
  "margin: 0;" +
  "font-size: " + 63 * widthK + "px; " +
  "color:#353340;" +
  "width: 100%;" +
  "text-align: center;" +
  "}",

  viewReportsGraphBigamountDetailText: ".view-reports-graph-bigamount-detail-text " +
  "{" +
  "position: absolute;" +
  "height: 25%;" +
  "top: 63%;" +
  "margin: 0;" +
  "font-size: " + 22 * widthK + "px; " +
  "width: 100%;" +
  "text-align: center;" +
  "color: #8b8b8b;" +
  "}",

  viewReportsGraphImageContainer: ".view-reports-graph-image-container " +
  "{" +
  "position: absolute;" +
  "height: 45%;" +
  "top: 16%;" +
  "width: 100%;" +
  "color: black;" +
  "background-color: white;" +
  "}",

  viewReportsGraphContentContainer: ".view-reports-graph-content-container " +
  "{" +
  "position: absolute;" +
  "height: 39%;" +
  "top: 61%;" +
  "width: 100%;" +
  "color: black;" +
  "overflow-y: auto;" +
  "overflow-x: hidden;" +
  "}",

  viewReportsGraphBlockContainer: ".view-reports-graph-block-containter" +
  "{" +
  "position: relative;" +
  "height:" + 122 * widthK + "px; " +
  "width: 91%;" +
  "left: 4%;" +
  "margin-top: 1%;" +
  "border-bottom:" + 1 * widthK + "px solid gainsboro;" +
  "background-color: transparent;" +
  "}",

  viewReportsGraphBlockNameField: ".view-reports-graph-block-name-field" +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "top: " + 10 * widthK + "px; " +
  "left: 15%;" +
  "text-align: left;" +
  "font-size:" + 25 * widthK + "px; " +
  "color: gray;" +
  "}",

  viewReportsGraphBlockAmountField: ".view-reports-graph-block-amount-field" +
  "{" +
  "position: relative;" +
  "top: 40%;" +
  "left: 2%;" +
  "margin: 0;" +
  "font-size:" + 45 * widthK + "px;" +
  "color: #ee4d3d;" +
  "float: left;" +
  "}",

  viewReportsGraphBlockCurrencyField: ".view-reports-graph-block-currency-field" +
  "{" +
  "position: relative;" +
  "top: 51%;" +
  "left: 3%;" +
  "margin: 0;" +
  "font-size:" + 29 * widthK + "px;" +
  "color: #ee4d3d;" +
  "float: left;" +
  "}",

  viewReportsGraphBlockIcon: ".view-reports-graph-block-icon" +
  "{" +
  "position: relative;" +
  "width: 13%;" +
  "height:" + 95 * widthK + "px; " +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "float: left;" +
  "background-size: 50%;" +
  "}",

  viewReportsGraphBlockNextIcon: ".view-reports-graph-block-next-icon" +
  "{" +
  "position: absolute;" +
  "right: 0;" +
  "width: 10%;" +
  "height: 100%;" +
  "top: 0;" +
  "background-repeat: no-repeat;" +
  "background-size: 17%;" +
  "background-position: center;" +
  "background-image: url(resources/icons/ViewInfo/open.png);" +
  "}",

  billsHolder: ".bills-holder " +
  "{" +
  "height:" + 305 * widthK + "px; " +
  "width:" + 627 * widthK + "px;" +
  "}",

//  VIEW BANK LIST

  componentBankList: ".component-bank-list" +
  "{" +
  "position: absolute;" +
  "opacity: 0.97;" +
  "height: 100%;" +
  "width: 100%;" +
  "background-color: whitesmoke;" +
  "display: none;" +
  "}",

  bankListContainer: ".component-banklist-container" +
  "{" +
  "position: absolute;" +
  "background-color: transparent;" +
  "width: 100%;" +
  "top: 8%;" +
  "bottom: 0;" +
  "overflow:scroll;" +
  "}",

  bankListCard: ".component-banklist-card" +
  "{" +
  "height: " + 286 * widthK + "px;" +
  "width: " + 302 * widthK + "px;" +
  "position: relative;" +
  "top: " + 13 * widthK + "px;" +
  "float: left;" +
  "margin: " + 4 * widthK + "px;" +
  "left: " + 48 * widthK + "px;" +
  "background-color: white;" +
  "}",


  componentBankListNameTitle: ".component-banklist-name-title " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size:" + 35 * widthK + "px;" +
  "left: 9%;" +
  "top: 31%;" +
  "margin: 0;" +
  "color: #353340;" +
  "}",

  closeButton: ".close-button " +
  "{" +
  "position: absolute;" +
  "width:" + 144 * widthK + "px;" +
  "height:" + 92 * widthK + "px;" +
  "right:" + -36 * widthK + "px;" +
  "background-image: url('resources/icons/ViewService/unchecked.png');" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 31%;" +
  "background-position-y: center;" +
  "background-position-x:" + 54 * widthK + "px;" +
  "background-size: 31%;" +
  "top: 0;" +
  "}",

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
firstMount.firstStep();

