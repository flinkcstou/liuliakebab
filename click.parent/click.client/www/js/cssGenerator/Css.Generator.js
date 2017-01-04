widthK = window.innerWidth / 720;
heightK = window.innerHeight / 1280;
var css = {
  sfuiDisplay                            : "@font-face " +
  "{" +
  "font-family: 'SFUIDisplay-Light';" +
  "src: url('resources/font/SFUIDisplay/SFUIDisplay-Light.otf');" +
  "format: ('opentype');" +
  "font-weight: normal;" +
  "font-style: normal;" +
  "}",
  html                                   : "html" +
  "{ " +
  "-webkit-user-select: none; " +
  "-webkit-touch-callout: none; " +
  "-webkit-user-drag: none; " +
  "-webkit-tap-highlight-color:rgba(0,0,0,0);" +
  "text-decoration:none;" +
  "color:inherit;" +
  " font-size:" + 32 * widthK + "px;" +
  "}",
  htmlId                                 : "#htmlId " +
  "{" +
  "width: 100%;" +
  "height: 100%;" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "background-image: -moz-linear-gradient(rgb(0, 122, 226) 0%, rgb(28, 200, 249) 60%, rgb(27, 198, 248) 100%);" +
  "background-image: -webkit-linear-gradient(rgb(0, 122, 226) 0%, rgb(28, 200, 249) 60%, rgb(27, 198, 248) 100%);" +
  "background-image: -ms-linear-gradient(rgb(0, 122, 226) 0%, rgb(28, 200, 249) 60%, rgb(27, 198, 248) 100%);" +
  "font-family: SFUIDisplay-Light;" +
  "margin: 0;" +
  "overflow: hidden;" +
  "}",
  body                                   : "body{margin: 0;}",
  input                                  : "input " +
  "{" +
  "font-family: Neuron;" +
  "font-size:" + 24 * widthK + "px;" +
  "}",
  viewRegistrationDevice                 : ".view-registration-device " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 100%;" +
  "overflow: hidden;" +
  "background-image: url('resources/icons/background/transparent.png');" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "}",
  registrationDeviceFlexContainer        : ".registration-device-flex-container " +
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
  "bottom:" + 20 + "%;" +
  "}",
  registrationDevicePhoneField           : ".registration-device-phone-field " +
  "{" +
  "position: absolute;" +
  "left:" + 80 * widthK + "px;" +
  "width:" + 560 * widthK + "px;" +
  "height:" + 107 * widthK + "px;" +
  "border-bottom:" + 6 * widthK + "px solid rgba(163, 222, 238, 0.95);" +
  "bottom:" + 210 * widthK + "px;" +
  "color: white;" +
  "}",
  registrationDeviceTextField            : ".registration-device-text-field " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "}",
  registrationDevicePhoneInput           : ".registration-device-phone-input " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "top:" + 30 * widthK + "px;" +
  "font-size:" + 64 * widthK + "px;" +
  "}",
  registrationDeviceRemember             : ".registration-device-remember " +
  "{" +
  "position: absolute;" +
  "top:" + 110 * widthK + "px;" +
  "width: 100%;" +
  "height:" + 100 * widthK + "px;" +
  "}",
  registrationDeviceRememberLabel        : ".registration-device-remember-label " +
  "{" +
  "position: absolute;" +
  "color: #4bd5ff;" +
  "top:" + 32 * widthK + "px;" +
  "width:" + 340 * widthK + "px;" +
  "margin: 0;" +
  "font-size:" + 32 * widthK + "px;" +
  "}",
  registrationRememberIcon               : ".registration-device-remember-icon " +
  "{" +
  "position: absolute;" +
  "background-image: url(resources/icons/back/back.png);" +
  "background-repeat: no-repeat;" +
  "transform: rotate(-90deg);" +
  "background-size: 60%;" +
  "width:" + 52 * widthK + "px;" +
  "height:" + 72 * widthK + "px;" +
  "left:" + 490 * widthK + "px;" +
  "top: 0px;" +
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

  buttonEnterLabel       : ".button-enter-label " +
  "{" +
  "position: relative;" +
  "top: " + 30 * widthK + "px;" +
  "width:" + 120 * widthK + "px;" +
  "height:" + 40 * widthK + "px;" +
  "font-size:" + 44 * widthK + "px;" +
  "margin: auto;" +
  "color: white;" +
  "}",
  registrationButtonEnter: ".registration-button-enter " +
  "{" +
  "top:" + 110 * widthK + "px;" +
  "}",

  keyboardField: ".keyboard-field " +
  "{" +
  "position: relative;" +
  "width:" + 500 * widthK + "px;" +
  "height:" + 500 * widthK + "px;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "}",

  registrationKeyboardField       : ".registration-keyboard-field " +
  "{" +
  "position: absolute;" +
  "bottom:" + 150 * widthK + "px;" +
  "left:" + 110 * widthK + "px;" +
  "}",
  registrationButtonsContainer    : ".registration-buttons-container " +
  "{" +
  "position: absolute;" +
  "width:" + 560 * widthK + "px;" +
  "bottom:" + -10 * widthK + "px;" +
  "left:" + 84 * widthK + "px;" +
  "}",
  registrationContainerOffline    : ".registration-container-offline " +
  "{" +
  "position: absolute;" +
  "width:" + 300 * widthK + "px;" +
  "height:" + 140 * widthK + "px;" +
  "bottom: 0;" +
  "left: 0;" +
  "}",
  registrationButtonOffline       : ".registration-button-offline " +
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
  RegistrationButtonDemoVersion   : ".registration-button-demo-version " +
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
  registrationButtonHelp          : ".registration-button-help " +
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
  registrationButtonRegistration  : ".registration-button-registration " +
  "{" +
  "position: absolute;" +
  "top:" + 30 * widthK + "px;" +
  "right:" + 120 * widthK + "px;" +
  "font-size:" + 34 * widthK + "px;" +
  "background-size: contain;" +
  "color: white;" +
  "border-bottom:" + 2 * widthK + "px solid white;" +
  "}",
  registrationTextField           : ".registration-text-field " +
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
  keyboardContainer               : ".keyboard-container " +
  "{" +
  "position: absolute;" +
  "width:" + 500 * widthK + "px;" +
  "height:" + 400 * widthK + "px;" +
  "}",
  keyboardFieldOne                : ".keyboard-field-one " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 120 * widthK + "px;" +
  "top: 0;" +
  "}",
  keyboardFieldTwo                : ".keyboard-field-two " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 120 * widthK + "px;" +
  "top:" + 120 * widthK + "px;" +
  "}",
  keyboardFieldThree              : ".keyboard-field-three " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 120 * widthK + "px;" +
  "top:" + 240 * widthK + "px;" +
  "}",
  keyboardFieldFour               : ".keyboard-field-four " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 120 * widthK + "px;" +
  "top:" + 360 * widthK + "px;" +
  "}",
  keyboardFieldFive               : ".keyboard-buttons " +
  "{" +
  "position: absolute;" +
  "width: " + 140 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "top:" + 16 * widthK + "px;" +
  "color: white;" +
  "font-size:" + 70 * widthK + "px;" +
  "text-align: center;" +
  "}",
  keyboardButtons                 : ".keyboard-buttons " +
  "{" +
  "position: absolute;" +
  "width:" + 140 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "top:" + 16 * widthK + "px;" +
  "color: white;" +
  "font-size:" + 70 * widthK + "px;" +
  "text-align: center;" +
  "}",
  keyboardButtonsLabel            : ".keyboard-buttons-label " +
  "{" +
  "position: absolute;" +
  "left:" + 54 * widthK + "px;" +
  "top:" + 16 * widthK + "px;" +
  "margin: 0;" +
  "}",
  keyboardButtonsActive           : ".keyboard-buttons:active " +
  "{" +
  "background: radial-gradient(rgba(255, 255, 255, 0.23), rgba(255, 255, 255, 0.04), transparent);" +
  "border-radius:" + 80 * widthK + "px;" +
  "}",
  keyboardButtonOne               : ".keyboard-button-one {left: 0;}",
  keyboardButtonTwo               : ".keyboard-button-two {left:" + 180 * widthK + "px;}",
  keyboardButtonThree             : ".keyboard-button-three {right: 0;}",
  keyboardButtonFour              : ".keyboard-button-four {left: 0;}",
  keyboardButtonFive              : ".keyboard-button-five {left:" + 180 * widthK + "px;}",
  keyboardButtonSix               : ".keyboard-button-six {right: 0;}",
  keyboardButtonSeven             : ".keyboard-button-seven {left: 0;}",
  keyboardButtonEight             : ".keyboard-button-eight {left:" + 180 * widthK + "px;}",
  keyboardButtonNine              : ".keyboard-button-nine {right: 0;}",
  keyboardSpace                   : ".keyboard-space {left: 0;}",
  keyboardButtonZero              : ".keyboard-button-zero {left:" + 180 * widthK + "px;}",
  keyboardButtonenter             : ".keyboard-button-enter {position: absolute;}",

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
  "background-image: url(resources/icons/sms/resend.png);" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "width:" + 80 * widthK + "px;" +
  "height:" + 44 * widthK + "px;" +
  "margin: 0;" +
  "left:" + 70 * widthK + "px;" +
  "top:" + -4 * widthK + "px;" +
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


