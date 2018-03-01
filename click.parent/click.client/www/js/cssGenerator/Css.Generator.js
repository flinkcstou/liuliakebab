if (window.innerWidth / window.innerHeight < 0.7) {
  widthK = window.innerWidth / 720;
  heightK = window.innerHeight / 1232;
}
else {
  widthK = window.innerHeight / 1232;
  heightK = window.innerWidth / 720;
}

var heightOfMobile;
var topOfIos;

// if (localStorage.getItem('device_platform') == 'iOS') {
//   heightK = (window.innerHeight - 20) / 1232;
//   heightOfMobile = window.innerHeight - 20;
//   if (device.platform == 'iOS')
//     cordova.plugins.Keyboard.disableScroll(true);
//   topOfIos = 20;
// }
// else {
heightK = window.innerHeight / 1232;
heightOfMobile = window.innerHeight;
topOfIos = 0;
// }

var css = {

  sfuiDisplay: "@font-face " +
  "{" +
  "font-family: 'SFUIDisplay-Light';" +
  "src: url('resources/font/SFUIDisplay/SFUIDisplay-Light.otf');" +
  "format: ('opentype');" +
  "font-weight: normal;" +
  "font-style: normal;" +
  "}",

  sfuiDisplaySemiBold: "@font-face " +
  "{" +
  "font-family: 'SFUIDisplay-Semibold';" +
  "src: url('resources/font/SFUIDisplay/SFUIDisplay-Semibold.otf');" +
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

  OcrAStdRegular: "@font-face " +
  "{" +
  "font-family: 'OCRAStd';" +
  "src: url('resources/font/OCRAStd/OCRAStd.otf');" +
  "format: ('opentype');" +
  "font-weight: normal;" +
  "font-style: normal;" +
  "}",


  // riotTagsMainContainer: ".riot-tags-main-container " +
  // "{" +
  // "-webkit-animation-name: mountAnimation !important;" +
  // "-webkit-animation-duration: 1s !important;" +
  // "animation-name:mountAnimation !important;" +
  // "animation-duration: 1s !important;" +
  // "}",
  //
  // mountAnimation: "@keyframes mountAnimation " +
  // "{" +
  // "from {opacity: 0 !important;}" +
  // "to {opacity: 1 !important;}" +
  // "}",

  html: "html" +
  "{ " +
  "width: 100%;" +
  "height: 100%;" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "touch-action: manipulation;" +
  // "background-image: url('resources/addcarddraft.png');" +
  // "opacity: 0.6;" +
  // "background-image: -moz-linear-gradient(rgb(1,124,227) 0%, rgb(21,181,243) 50%, rgb(21,181,243) 100%);" +
  // "background-image: -webkit-linear-gradient(rgb(1,124,227) 0%, rgb(21,181,243) 50%, rgb(21,181,243) 100%);" +
  // "background-image: -ms-linear-gradient(rgb(1,124,227) 0%, rgb(21,181,243) 50%, rgb(21,181,243) 100%);" +
  "background: #fafafa;" +
  "font-family: SFUIDisplay-Light;" +
  "margin: 0;" +
  "overflow: hidden;" +
  "bottom: 0;" +
  "-webkit-user-select: text; " +
  "-webkit-touch-callout: none; " +
  "-webkit-user-drag: none; " +
  "-webkit-tap-highlight-color: rgba(0, 0, 0, 0); " +
  "text-decoration:none;" +
  "color:inherit;" +
  "font-size:" + 32 * widthK + "px;" +
  "}",
  //
  //htmlWebkitScrollBar: "html::-webkit-scrollbar" +
  //"{ " +
  //"width:" + 5 * widthK + "px;" +
  //"}",
  //
  //htmlWebkitScrollBarTrack: "html::-webkit-scrollbar-track" +
  //"{ " +
  //"border-radius:" + 10 * widthK + "px;" +
  //"}",
  //
  //htmlWebkitScrollBarThumb: "html::-webkit-scrollbar-thumb" +
  //"{ " +
  //"border-radius:" + 10 * widthK + "px;" +
  //"background: rgb(169,169,169);" +
  //"}",
  //
  //htmlWebkitScrollBarThumbWindowInactive: "html::-webkit-scrollbar-thumb:window-inactive" +
  //"{ " +
  //"background: rgb(128,128,128);" +
  //"}",

  //DEMO

  demoVersionButtonExit: ".demo-version-button-exit" +
  "{ " +
  "position: absolute;" +
  "width:" + 130 * widthK + "px;" +
  "height:" + 130 * widthK + "px;" +
  "bottom:" + 65 * widthK + "px;" +
  "right:" + 40 * widthK + "px;" +
  "background-image: url(resources/demo/demo_close.png);" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "z-index: 999999999;" +
  "}",

  demoVersionContinue: ".demo-version-continue " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 100%;" +
  "top: 0;" +
  "overflow: hidden;" +
  "z-index: 999999;" +
  "background-image: url('resources/icons/background/transparent.png');" +
  "background-size: cover;" +
  "background-repeat: no-repeat;" +
  "}",

  demoVersionDemonstrationText: ".demo-version-demonstration-text " +
  "{" +
  "position: relative;" +
  "text-align: center;" +
  "color: #b7f1ff;" +
  "width: 50%;" +
  "top:" + 37 * heightK + "px;" +
  "font-size:" + 37 * widthK + "px;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "}",

  demoVersionContinueText: ".demo-version-continue-text " +
  "{" +
  "position: relative;" +
  "text-align: center;" +
  "color: #b7f1ff;" +
  "width: 80%;" +
  "top:" + 770 * heightK + "px;" +
  "font-size:" + 27 * widthK + "px;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "}",

  demoVersionContinueContainer: ".demo-version-continue-container " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 1232 * heightK + "px;" +
  "top:" + 0 * widthK + "px;" +
  "overflow: hidden;" +
  "}",

  demoVersionContinueContinue: ".demo-version-continue-continue " +
  "{" +
  "position: absolute;" +
  "width:" + 450 * widthK + "px;" +
  "height:" + 530 * widthK + "px;" +
  "left:" + 135 * widthK + "px;" +
  "top:" + 215 * heightK + "px;" +
  //"top:" + 400 * widthK + "px;" +
  "background-image: url('resources/demo/demo_entrance.png');" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "}",

  demoVersionContinueButtonContinue: ".demo-version-continue-button-continue" +
  "{" +
  "height: " + 62 * widthK + "px;" +
  "font-size: " + 30 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "position: absolute;" +
  "left: 29%;" +
  "width: 42%;" +
  "background-color: #ffffff;" +
  //"border-radius: " + 10 * widthK + "px;" +
  "top: " + 1050 * heightK + "px;" +
  "color: #555555;" +
  "}",
  //

  //animation

  // riotTagsMainContainer: ".riot-tags-main-container" +
  // "{ " +
  // "-webkit-animation-name: mountAnimation; " +
  // "-webkit-animation-duration: 0.2s; " +
  // "}",
  //
  // webkitKeyFrameMountAnimation: "@-webkit-keyframes mountAnimation" +
  // "{ " +
  // "from {opacity: 0;}; " +
  // "to {opacity: 1;}; " +
  // "}",

  body: "body{" +
  "margin: 0;" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + heightOfMobile + "px;" +
  "margin: 0;" +
  "overflow: hidden;" +
  "bottom: 0;" +
  "}",

  // //ALERTS
  // componentAlertBlockId: "#alertComponentBlockId display: none;}",
  //
  // componentAlertId: "#componentAlertId {display: none;}",
  //
  // componentConfirmId: "#componentConfirmId {display: none;}",
  //
  // componentInProcessId: "#componentInProcessingId {display: none;}",
  //
  // componentResultId: "#componentResultId {display: none;}",
  //
  // componentSuccessId: "#componentSuccessId {display: none;}",
  //
  // componentUnsuccessId: "#componentUnsuccessId {display: none;}",
  //
  // componentGenQRId: "#componentGeneratedQrId {display: none;}",
  //
  // //ALERTS

  //VIEW INVOICE LIST

  invoiceListPageTitle: ".invoice-list-page-title" +
  "{" +
  "position: absolute;" +
  "top: 0;" +
  // "right:" + 28 * widthK + "px;" +
  // "left:" + 25 * widthK + "px;" +
  "width: 100%;" +
  "height:" + 93 * widthK + "px;" +
  "background: transparent;" +
  "}",

  invoiceListNameTitle: ".invoice-list-name-title" +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size:" + 35 * widthK + "px;" +
  "left: 11.7%;" +
  "top: 25.5%;" +
  "margin: 0;" +
  "color: #565d6a;" +
  "}",

  invoiceListBackButton: ".invoice-list-back-button" +
  "{" +
  "position: absolute;" +
  "width:" + 48 * widthK + "px;" +
  "height:" + 36 * widthK + "px;" +
  "background-image: url(resources/icons/back/back.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 100%;" +
  "background-position-y: center;" +
  "background-position-x: center;" +
  "background-size: 100%;" +
  "left: 2%;" +
  "top:" + 28 * widthK + "px;" +
  "}",

  invoiceListContentHolder: ".invoice-list-content-holder" +
  "{" +
  "position: absolute;" +
  "top:" + 87 * widthK + "px;" +
  "bottom: 0;" +
  "z-index: 6;" +
  "width: 100%;" +
  "background-color: white" +
  "}",

  invoiceListNavButtonsHolder: ".invoice-list-nav-buttons-holder" +
  "{" +
  "height:" + 120 * widthK + "px;" +
  "}",

  invoiceListNavButtonsBorder: ".invoice-list-nav-buttons-border" +
  "{" +
  "position: absolute;" +
  "height:" + 96 * widthK + "px;" +
  "left: 50%;" +
  "top:" + 12 * widthK + "px;" +
  "border-right:" + 1 * widthK + "px solid #e8e8e8;" +
  "background: transparent;" +
  "}",

  invoiceListInvoicesIn: ".invoice-list-invoices-in" +
  "{" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "}",

  invoiceListInvoicesOut: ".invoice-list-invoices-out" +
  "{" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "}",

  invoiceListNavButtonToUser: ".invoice-list-nav-button-to-user" +
  "{" +
  "width:" + 286 * widthK + "px;" +
  "float: left;" +
  "height:" + 81 * widthK + "px;" +
  "padding-top:" + 26 * widthK + "px;" +
  "padding-left:" + 74 * widthK + "px;" +
  "}",

  invoiceListNavButtonFromUser: ".invoice-list-nav-button-from-user" +
  "{" +
  "width:" + 286 * widthK + "px;" +
  "float: right;" +
  "height:" + 81 * widthK + "px;" +
  "padding-top:" + 26 * widthK + "px;" +
  "}",

  invoiceListNavButtonsIcon: ".invoice-list-nav-buttons-icon" +
  "{" +
  "width:" + 45 * widthK + "px;" +
  "height:" + 52 * widthK + "px;" +
  "float: left;" +
  "}",

  invoiceListNavButtonsTitle: ".invoice-list-nav-buttons-title" +
  "{" +
  "margin:" + 13 * widthK + "px 0 0 " + 57 * widthK + "px;" +
  "letter-spacing:" + (-1.2 * widthK) + "px;" +
  "text-transform: uppercase;" +
  "font-size:" + 26 * widthK + "px;" +
  "}",

  invoiceListNavButtonNotSelected: ".invoice-list-nav-button-not-selected" +
  "{" +
  "color: #ACBDC4;" +
  "}",

  invoiceListInvoicesHolder: ".invoice-list-invoices-holder" +
  "{" +
  "overflow-y: scroll;" +
  "position: absolute;" +
  "top:" + 120 * widthK + "px;" +
  "bottom: 0;" +
  "-webkit-overflow-scrolling: touch;" +
  "padding: 0 " + 25 * widthK + "px 0 " + 30 * widthK + "px;" +
  "width:95%;" +
  "}",

  invoiceListInvoice: ".invoice-list-invoice" +
  "{" +
  "height:" + 132 * widthK + "px;" +
  "border-bottom:" + 3 * widthK + "px solid #f7f7f7;" +
  "padding-top:" + 29 * widthK + "px;" +
  "padding-left:" + 25 * widthK + "px;" +
  "}",

  invoiceListFromWhomLabel: ".invoice-list-from-whom-label" +
  "{" +
  "margin: 0;" +
  "font-size:" + 24 * widthK + "px;" +
  "float: left;" +
  "}",

  invoiceListInvoiceSumHolder: ".invoice-list-invoice-sum-holder" +
  "{" +
  "padding-right:" + 36 * widthK + "px;" +
  "float: right;" +
  "width:" + 295 * widthK + "px;" +
  "height:" + 120 * widthK + "px;" +
  "}",

  invoiceListInvoiceSum: ".invoice-list-invoice-sum" +
  "{" +
  "margin: 0;" +
  "font-size:" + 47 * widthK + "px;" +
  "float: right;" +
  "margin-right:" + 6 * widthK + "px;" +
  "color: inherit;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "max-width:" + 245 * widthK + "px;" +
  "white-space: nowrap;" +
  "color: #595759;" +
  "}",

  invoiceListInvoiceSumSym: ".invoice-list-invoice-sum-sym" +
  "{" +
  "font-size:" + 24 * widthK + "px;" +
  "margin: 0;" +
  "line-height:" + 70 * widthK + "px;" +
  "background-color: transparent;" +
  "color: inherit;" +
  "float: right;" +
  "color: #595759;" +
  "}",

  invoiceListInvoicePhoneNumberHolder: ".invoice-list-invoice-phone-number-holder" +
  "{" +
  "margin: 0;" +
  "float: left;" +
  "font-size:" + 24 * widthK + "px;" +
  "color: #8B8B8B;" +
  "width:" + 290 * widthK + "px;" +
  "}",

  invoiceListInvoicePhoneNumber: ".invoice-list-invoice-phone-number" +
  "{" +
  "margin: 0;" +
  "float: left;" +
  "width:" + 300 * widthK + "px;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "white-space: nowrap;" +
  "}",

  invoiceListInvoiceServiceName: ".invoice-list-invoice-service-name" +
  "{" +
  "margin: 0;" +
  "float: left;" +
  "width:" + 300 * widthK + "px;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "white-space: nowrap;" +
  "}",

  invoiceListInvoiceDate: ".invoice-list-invoice-date" +
  "{" +
  "margin: 0;" +
  "font-size:" + 22 * widthK + "px;" +
  "float: left;" +
  "margin-top:" + 8 * widthK + "px;" +
  "word-spacing:" + 7 * widthK + "px;" +
  "color: #c2c2c2;" +
  "}",

  invoiceListInvoiceIsP2P: ".invoice-list-invoice-is-p2p" +
  "{" +
  "color: #6DBF34;" +
  "}",

  invoiceListInvoiceIsNotP2P: ".invoice-list-invoice-is-not-p2p" +
  "{" +
  "color: #FF544A;" +
  "}",

  //REGISTRATION ANIMATION
  registrationProcess: ".registration-process " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "top: 0;" +
  "height: 100%;" +
  "overflow: hidden;" +
  "z-index: 999999;" +
  "background-image: url('resources/icons/background/transparent.png');" +
  "background-size: cover;" +
  "background-repeat: no-repeat;" +
  "}",

  registrationProcessText: ".registration-process-text " +
  "{" +
  "position: relative;" +
  "text-align: center;" +
  "color: #b7f1ff;" +
  "width: 70%;" +
  "top:" + 35 + "%;" +
  "font-size:" + 30 * widthK + "px;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "}",

  registrationProcessContainer: ".registration-process-container " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 860 * heightK + "px;" +
  "top:" + 290 * widthK + "px;" +
  "overflow: hidden;" +
  "}",

  registrationProcessProcessing: ".registration-process-processing " +
  "{" +
  "position: absolute;" +
  "width:" + 215 * widthK + "px;" +
  "height:" + 190 * widthK + "px;" +
  "left:" + 260 * widthK + "px;" +
  "top:" + 65 * widthK + "px;" +
  //"top:" + 400 * widthK + "px;" +
  "background-image: url('resources/icons/animation/reg_process.png');" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "}",

  registrationProcessOk: ".registration-process-ok " +
  "{" +
  "position: absolute;" +
  "width:" + 190 * widthK + "px;" +
  "height:" + 190 * widthK + "px;" +
  "left:" + 285 * widthK + "px;" +
  //"top:" + 400 * widthK + "px;" +
  "background-image: url('resources/icons/animation/reg_ok.png');" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "}",

  registrationProcessX: ".registration-process-x " +
  "{" +
  "position: absolute;" +
  "width:" + 140 * widthK + "px;" +
  "height:" + 140 * widthK + "px;" +
  "left:" + 300 * widthK + "px;" +
  //"top:" + 400 * widthK + "px;" +
  "background-image: url('resources/icons/animation/reg_error.png');" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "}",

  registrationProcessButtonNext: ".registration-process-button-next" +
  "{" +
  "height: " + 62 * widthK + "px;" +
  "font-size: " + 30 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "position: absolute;" +
  "left: 33%;" +
  "width: 34%;" +
  "background-color: #ffffff;" +
  //"border-radius: " + 10 * widthK + "px;" +
  "top: " + 80 + "%;" +
  "color: #555555;" +
  "}",

  registrationProcessButtonCheckStatus: ".registration-process-button-check-status" +
  "{" +
  "height: " + 62 * widthK + "px;" +
  "font-size: " + 30 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "position: absolute;" +
  "left: 13%;" +
  "width: 74%;" +
  "background-color: #ffffff;" +
  //"border-radius: " + 10 * widthK + "px;" +
  "top: " + 80 + "%;" +
  "color: #555555;" +
  "}",

  registrationProcessCheckStatusLabel: ".registration-process-check-status-label" +
  "{" +
  "margin-top: 34%;" +
  "width: 90%;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "}",

  //VIEW REGISTRATION DEVICE

  viewRegistrationDevice: ".view-registration-device " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 100%;" +
  "overflow: hidden;" +
  // "background-image: url('resources/icons/background/transparent.png');" +
  "background-size: cover;" +
  "background: white;" +
  "background-repeat: no-repeat;" +
  "}",
  registrationDeviceFlexContainer: ".registration-device-flex-container " +
  "{" +
  "position: absolute;" +
  "top: 0;" +
  "height:" + 500 * widthK + "px;" +
  "width: 100%;" +
  "display: flex;" +
  "}",

  registrationDeviceUnchanbgableContainer: ".registration-device-unchangable-container " +
  "{" +
  "width: 100%;" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "height:" + 320 * widthK + "px;" +
  //"top:" + 155 * heightK + "px;" +
  "top:" + 194 * heightK + "px;" +
  "}",

  registrationDevicePhoneField: ".registration-device-phone-field " +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "width:" + 560 * widthK + "px;" +
  "height:" + 142 * widthK + "px;" +
  "border-bottom:" + 3 * widthK + "px solid #e8e8e8;" +
  // "bottom:" + 210 * widthK + "px;" +
  "color: #535b67;" +
  "}",

  registrationDeviceTextField: ".registration-device-text-field " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: #aaabae;" +
  "}",

  registrationDevicePhoneInput: ".registration-device-phone-input " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "top:" + 30 * widthK + "px;" +
  "font-size:" + 64 * widthK + "px;" +
  "}",

  registrationDevicePhoneCodePart: ".registration-device-phone-code-part " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "bottom:" + 12 * widthK + "px;" +
  "font-size:" + 64 * widthK + "px;" +
  "}",

  registrationDevicePhoneInputPart: ".registration-device-phone-input-part " +
  "{" +
  "position: absolute;" +
  "bottom:" + 12 * widthK + "px;" +
  "font-size:" + 64 * widthK + "px;" +
  "border: none;" +
  "outline: none;" +
  "color: #535b67;" +
  "-webkit-text-fill-color: #535b67;" +
  "left: " + 163 * widthK + "px;" +
  "padding: 0;" +
  "margin: 0;" +
  "width: 65%;" +
  "font-family: 'SFUIDisplay-Light';" +
  "background-color: transparent;" +
  "opacity:1;" +
  "}",

  registrationCaret: ".registration-caret " +
  "{" +
  "position: absolute;" +
  "bottom:" + 18 * widthK + "px;" +
  "left:" + 170 * widthK + "px;" +
  "width:" + 2 * widthK + "px;" +
  "height:" + 60 * widthK + "px;" +
  "background-color: #565d6a;" +
  "-webkit-transition-property: width height background-color left top opacity transform -webkit-transform opacity;" +
  "-webkit-transition-duration: 0s;" +
  "-webkit-transition-timing-function: step(1,end);" +
  "transition-property: width height background-color left top opacity transform -webkit-transform opacity;" +
  "transition-duration: 0s;" +
  "}",

  registrationCaretTwo: ".registration-caret-two " +
  "{" +
  "position: absolute;" +
  "bottom:" + 18 * widthK + "px;" +
  "left:" + 180 * widthK + "px;" +
  "width:" + 2 * widthK + "px;" +
  "height:" + 60 * widthK + "px;" +
  "background-color: #565d6a;" +
  "opacity:0;" +
  "-webkit-transition-property: width height background-colorleft top opacity transform -webkit-transform opacity;" +
  "-webkit-transition-duration: 0s;" +
  "-webkit-transition-timing-function: step(1,end);" +
  "transition-property: width height background-color left top opacity transform -webkit-transform opacity;" +
  "transition-duration: 0s;" +
  "}",

  SmsCaret: ".sms-caret " +
  "{" +
  "position: absolute;" +
  "bottom:" + 18 * widthK + "px;" +
  // "left:" + 180 * widthK + "px;" +
  "width:" + 2 * widthK + "px;" +
  "height:" + 60 * widthK + "px;" +
  "background-color: #565d6a;" +
  "-webkit-transition-property: width height background-color left top opacity transform -webkit-transform opacity;" +
  "-webkit-transition-duration: 0s;" +
  "-webkit-transition-timing-function: step(1,end);" +
  "transition-property: width height background-color left top opacity transform -webkit-transform opacity;" +
  "transition-duration: 0s;" +
  "}",

  SmsCaretTwo: ".sms-caret-two " +
  "{" +
  "position: absolute;" +
  "bottom:" + 18 * widthK + "px;" +
  // "left:" + 180 * widthK + "px;" +
  "width:" + 2 * widthK + "px;" +
  "height:" + 60 * widthK + "px;" +
  "background-color: #565d6a;" +
  "opacity:0;" +
  "-webkit-transition-property: width height background-color left top opacity transform -webkit-transform opacity;" +
  "-webkit-transition-duration: 0s;" +
  "-webkit-transition-timing-function: step(1,end);" +
  "transition-property: width height background-color left top opacity transform -webkit-transform opacity;" +
  "transition-duration: 0s;" +
  "}",

  registrationDeviceRemember: ".registration-device-remember " +
  "{" +
  "position: absolute;" +
  "top:" + 155 * widthK + "px;" +
  "width: 100%;" +
  "height:" + 100 * widthK + "px;" +
  "}",

  registrationDeviceRememberLabel: ".registration-device-remember-label " +
  "{" +
  "position: absolute;" +
  "color: #aaabae;" +
  "top:" + 32 * widthK + "px;" +
  "width:" + 340 * widthK + "px;" +
  "margin: 0;" +
  "font-size:" + 32 * widthK + "px;" +
  "}",

  registrationRememberIcon: ".registration-device-remember-icon " +
  "{" +
  "position: absolute;" +
  "background-image: url(resources/icons/authorization/deselected.png);" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "background-position: center;" +
  "width:" + 48 * widthK + "px;" +
  "height:" + 48 * widthK + "px;" +
  "left:" + 508 * widthK + "px;" +
  "top:" + 28 * widthK + "px;" +
  "opacity: 1;" +
  "}",

  registrationRememberIconContainer: ".registration-device-remember-icon-container " +
  "{" +
  "position: absolute;" +
  "width:" + 30 * widthK + "px;" +
  "height:" + 30 * widthK + "px;" +
  "left:" + 496 * widthK + "px;" +
  "top:" + 31 * widthK + "px;" +
  "opacity: 0.3;" +
  "border:" + 4 * widthK + "px solid white;" +
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
  "position: absolute;" +
  "top: 19%;" +
  "width:" + 120 * widthK + "px;" +
  "height:" + 40 * widthK + "px;" +
  "font-size:" + 41 * widthK + "px;" +
  "margin: auto;" +
  "margin-left:" + 260 * widthK + "px;" +
  "color: white;" +
  "}",
  registrationButtonEnter: ".registration-button-enter " +
  "{" +
  "top:" + 230 * widthK + "px;" +
  "}",


  smsButtonEnterLabel: ".sms-button-enter-label " +
  "{" +
  "position: relative;" +
  "top: 19%;" +
  "width:100%;" +
  "height:" + 40 * widthK + "px;" +
  "font-size:" + 44 * widthK + "px;" +
  "margin: auto;" +
  "color: white;" +
  "}",

  smsButtonEnter: ".sms-button-enter " +
  "{" +
  "position: relative;" +
  "width: 90%;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "margin-top:" + 15 * widthK + "px;" +
  "color: #535b67;" +
  "}",

  keyboardField: ".keyboard-field " +
  "{" +
  "position: absolute;" +
  "width:" + 540 * widthK + "px;" +
  "height:" + 472 * heightK + "px;" +
  "}",

  registrationKeyboardField: ".registration-keyboard-field " +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  // "bottom:" + 150 * widthK + "px;" +
  "top:" + 490 * heightK + "px;" +
  // "left:" + 110 * widthK + "px;" +
  "}",

  registrationButtonsContainer: ".registration-buttons-container " +
  "{" +
  "position: absolute;" +
  "margin-left: 5%;" +
  "width: 90%;" +
  "height:" + 87 * widthK + "px;" +
  "bottom:" + 88 * widthK + "px;" +
  "border-top: 1px solid #e8e8e8;" +
  "}",
  registrationContainerOffline: ".registration-container-offline " +
  "{" +
  "position: absolute;" +
  "width:" + 300 * widthK + "px;" +
  "height:" + 110 * widthK + "px;" +
  "top: 0;" +
  "left: 0;" +
  "}",
  registrationButtonOffline: ".registration-button-offline " +
  "{" +
  "position: absolute;" +
  "color: #535b67;" +
  "top: 29%;" +
  "left: 6.5%;" +
  "text-align: center;" +
  "}",
  registrationContainerDemoVersion: ".registration-container-demo-version " +
  "{" +
  "position: absolute;" +
  "width:" + 300 * widthK + "px;" +
  "height:" + 110 * widthK + "px;" +
  "top: 0;" +
  "right: 0;" +
  "}",
  RegistrationButtonDemoVersion: ".registration-button-demo-version " +
  "{" +
  "position: absolute;" +
  "font-size:" + 33 * widthK + "px;" +
  "background-size: contain;" +
  "color: #535b67;" +
  // "border-bottom:" + 1 + "px solid #b7f1ff;" +
  "bottom:" + 32 * widthK + "px;" +
  "margin-left:" + 80 * widthK + "px;" +
  "margin-bottom:" + 14 * widthK + "px;" +
  "text-align: center;" +
  "}",
  registrationButtonHelp: ".registration-button-help " +
  "{" +
  "position: absolute;" +
  "font-size:" + 33 * widthK + "px;" +
  "top: 29%;" +
  "right: 6.5%;" +
  "background-size: contain;" +
  "color: #535b67;" +
  "}",
  registrationButtonRegistration: ".registration-button-registration " +
  "{" +
  "position: absolute;" +
  "top:" + 30 * widthK + "px;" +
  "right:" + 120 * widthK + "px;" +
  "font-size:" + 34 * widthK + "px;" +
  "background-size: contain;" +
  "color: white;" +
  "border-bottom:" + 1 + "px solid white;" +
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
  "width:" + 540 * widthK + "px;" +
  "height:" + 472 * heightK + "px;" +
  "}",
  keyboardFieldOne: ".keyboard-field-one " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 120 * heightK + "px;" +
  "top: 0;" +
  "}",
  keyboardFieldTwo: ".keyboard-field-two " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 120 * widthK + "px;" +
  "top:" + 120 * heightK + "px;" +
  "}",
  keyboardFieldThree: ".keyboard-field-three " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 120 * widthK + "px;" +
  "top:" + 236 * heightK + "px;" +
  "}",
  keyboardFieldFour: ".keyboard-field-four " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 120 * widthK + "px;" +
  "top:" + 353 * heightK + "px;" +
  "}",
  keyboardFieldFive: ".keyboard-field-five " +
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
  "width:" + 134 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "top:" + 15 * widthK + "px;" +
  "color: #565d6a;" +
  "font-size:" + 75 * widthK + "px;" +
  "text-align: center;" +
  "}",
  keyboardButtonsLabel: ".keyboard-buttons-label " +
  "{" +
  "position: absolute;" +
  "left:" + 40 * widthK + "px;" +
  "top:" + 13 * widthK + "px;" +
  "margin: 0;" +
  "}",
  keyboardButtonOne: ".keyboard-button-one {left: 0;}",
  keyboardButtonTwo: ".keyboard-button-two {left:" + 202 * widthK + "px;}",
  keyboardButtonThree: ".keyboard-button-three {right: 0;}",
  keyboardButtonFour: ".keyboard-button-four {left: 0;}",
  keyboardButtonFive: ".keyboard-button-five {left:" + 202 * widthK + "px;}",
  keyboardButtonSix: ".keyboard-button-six {right: 0;}",
  keyboardButtonSeven: ".keyboard-button-seven {left: 0;}",
  keyboardButtonEight: ".keyboard-button-eight {left:" + 202 * widthK + "px;}",
  keyboardButtonNine: ".keyboard-button-nine {right: 0;}",
  keyboardSpace: ".keyboard-space {" +
  "left: 0; " +
  "background-size:" + 60 * widthK + "px;" +
  "background-image: url('resources/icons/authorization/touchid.png');" +
  "background-repeat: no-repeat;" +
  "background-position-y:" + 25 * widthK + "px;" +
  "background-position-x: center;" +
  "}",
  keyboardButtonZero: ".keyboard-button-zero {left:" + 202 * widthK + "px;}",
  keyboardButtonEnter: ".keyboard-button-enter {position: absolute;}",

  //keyboardButtonsActive: ".keyboard-buttons:active " +
  //"{" +
  //"background: radial-gradient(rgba(255, 255, 255, 1), rgba(255, 255, 255, 0.08), transparent);" +
  //"}",

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
  // "background-image: url('resources/icons/background/transparent.png');" +
  "background-size: cover;" +
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
  "margin-left: auto;" +
  "margin-right: auto;" +
  "height:" + 320 * widthK + "px;" +
  "top:" + 194 * heightK + "px;" +
  "}",

  smsTextField: ".sms-text-field " +
  "{" +
  "position: relative;" +
  "text-align: center;" +
  "color: #b0aeb2;" +
  "top:" + 142 * widthK + "px;" +
  "font-size:" + 30 * widthK + "px;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "}",

  smsPhoneField: ".sms-phone-field " +
  "{" +
  "position: absolute;" +
  "left:" + 73 * widthK + "px;" +
  "width:" + 560 * widthK + "px;" +
  "height:" + 142 * widthK + "px;" +
  "border-bottom:" + 3 * widthK + "px solid #e8e8e8;" +
  // "bottom:" + 210 * widthK + "px;" +
  "color: #535b67;" +
  "}",

  smsTextFieldOne: ".sms-text-field-one " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "left: 0;" +
  "text-align: center;" +
  "color: #b0aeb2;" +
  "font-size:" + 30 * widthK + "px;" +
  "margin: 0;" +
  "}",

  smsPhoneInput: ".sms-phone-input " +
  "{" +
  "position: absolute;" +
  "bottom:" + 12 * widthK + "px;" +
  "font-size:" + 64 * widthK + "px;" +
  "border: none;" +
  "outline: none;" +
  "color: #535b67;" +
  "-webkit-text-fill-color: #535b67;" +
  "padding: 0;" +
  "margin: 0;" +
  "width: 65%;" +
  "font-family: 'SFUIDisplay-Light';" +
  "background-color: transparent;" +
  "opacity:1;" +
  "}",

  smsTimer: ".sms-timer " +
  "{" +
  "position: absolute;" +
  "width:" + 160 * widthK + "px;" +
  "height:" + 60 * widthK + "px;" +
  "margin: 0;" +
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

  smsKeyboardField: ".sms-keyboard-field " +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "margin-top:" + 10 * heightK + "px;" +
  // "bottom:" + 150 * widthK + "px;" +
  "top:" + 550 * heightK + "px;" +
  // "left:" + 110 * widthK + "px;" +
  "}",

  //VIEW AUTHORIZATION

  viewAuthorization: ".view-authorization " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 100%;" +
  "overflow: hidden;" +
  // "background-image: url('resources/icons/background/transparent.png');" +
  "background-size: cover;" +
  "background: white;" +
  "background-repeat: no-repeat;" +
  "}",

  authorizationFlexContainer: ".authorization-flex-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "top: 0;" +
  "height:" + 255 * heightK + "px;" +
  "}",

  authorizationButtonFirstEnter: ".authorization-button-first-enter " +
  "{" +
  "position: relative;" +
  "width:" + 620 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "left:" + -20 * widthK + "px;" +
  "top:" + -30 * widthK + "px;" +
  "background-color: #01cfff;" +
  //"margin-right: auto;" +
  "border-radius:" + 80 * widthK + "px;" +
  //"margin-left: auto;" +
  "}",

  authorizationUnchangableContainer: ".authorization-unchangable-container " +
  "{" +
  "position: absolute;" +
  "height:" + 170 * widthK + "px;" +
  "top:" + 85 * widthK + "px;" +
  "width: 100%;" +
  "}",

  authorizationPinContainer: ".authorization-pin-container " +
  "{" +
  "position: relative;" +
  "width:" + 365 * widthK + "px;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "margin-top:" + 60 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "}",

  authorizationPinField: ".authorization-pin-field " +
  "{" +
  "position: relative;" +
  "height:" + 40 * widthK + "px;" +
  "width:" + 365 * widthK + "px;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "margin-top:" + 20 * widthK + "px;" +
  "}",

  authorizationPinInputFirstEnterContainer: ".authorization-pin-input-first-enter-container " +
  "{" +
  "position: relative;" +
  "height:" + 90 * widthK + "px;" +
  "width: 80%;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "margin-top:" + 40 * widthK + "px;" +
  "font-size:" + 100 * widthK + "px;" +
  "background-color: white;" +
  "border: none;" +
  "border-bottom: 1px solid #e8e8e8;" +
  "text-align: center;" +
  "outline: none;" +
  "padding: 0;" +
  "}",

  authorizationPinInputFirstEnter: ".authorization-pin-input-first-enter " +
  "{" +
  "position: absolute;" +
  // "height:" + 80 * widthK + "px;" +
  //"top:" + 5 * widthK + "px;" +
  "width:" + 470 * widthK + "px;" +
  "left: 0;" +
  "font-size:" + 62 * widthK + "px;" +
  "border: none;" +
  "bottom:" + 12 * widthK + "px;" +
  "outline: none;" +
  "}",

  authorizationPinCircle: ".authorization-pin-circles " +
  "{" +
  "position: absolute;" +
  "width:" + 38 * widthK + "px;" +
  "height:" + 38 * widthK + "px;" +
  "border-radius:" + 40 * widthK + "px;" +
  "border:" + 4.5 * widthK + "px solid #fafafa;" +
  "background-color: #b0aeb2;" +
  "}",

  authorizationPinTwo: ".authorization-pin-two " +
  "{" +
  "left:" + 80 * widthK + "px;" +
  "}",

  authorizationPinThree: ".authorization-pin-three " +
  "{" +
  "left:" + 160 * widthK + "px;" +
  "}",

  authorizationPinFour: ".authorization-pin-four " +
  "{" +
  "left:" + 240 * widthK + "px;" +
  "}",

  authorizationPinFive: ".authorization-pin-five " +
  "{" +
  "left:" + 320 * widthK + "px;" +
  "}",

  authorizationKeyboardField: ".authorization-keyboard-field " +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "margin-top:" + 50 * heightK + "px;" +
  "}",

  authorizationKeyboardCentringContainer: ".authorization-keyboard-centring-container " +
  "{" +
  "position: absolute;" +
  "top:" + 455 * heightK + "px;" +
  "height:" + 572 * heightK + "px;" +
  "width: 100%;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "}",

  authorizationButtonEnter: ".authorization-button-enter " +
  "{" +
  "top:" + 240 * widthK + "px;" +
  "}",

  authorizationButtonsContainer: ".authorization-buttons-container " +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "width: 100%;" +
  // "left:" + 70 * widthK + "px;" +
  "margin-top:" + 305 * heightK + "px;" +
  "height:" + 150 * heightK + "px;" +
  "}",

  authorizationButtonForgetPin: ".authorization-button-forget-pin " +
  "{" +
  "position: relative;" +
  "margin-top:" + 30 * widthK + "px;" +
  "margin-left: 5%;" +
  "padding-bottom:" + 30 * widthK + "px;" +
  "width: 90%;" +
  "font-size:" + 34 * widthK + "px;" +
  "text-align: center;" +
  "background-size: contain;" +
  "color: #535b67;" +
  "}",

  authorizationButtonRegistration: ".authorization-button-registration " +
  "{" +
  "position: relative;" +
  "top:" + 30 * widthK + "px;" +
  "font-size:" + 34 * widthK + "px;" +
  "background-size: contain;" +
  "color: #00a8f1;" +
  "text-align: center;" +
  // "border-bottom:" + 1 + "px solid white;" +
  "}",

  authorizationButtonOffline: ".authorization-button-offline " +
  "{" +
  "position: relative;" +
  "font-size:" + 34 * widthK + "px;" +
  "width:" + 240 * widthK + "px;" +
  "background-size: contain;" +
  "color: #535b67;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  // "border-bottom:" + 1 + "px solid white;" +
  "text-align: center;" +
  // "left:" + 240 * widthK + "px;" +
  "}",

  authorizationFooterContainer: ".authorization-footer-button-container " +
  "{" +
  "position: absolute;" +
  "font-size:" + 34 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "color: #535b67;" +
  "width: 90%;" +
  "height:" + 205 * heightK + "px;" +
  "margin-left: 5%;" +
  "bottom: 0;" +
  "padding: 0;" +
  "border: none;" +
  "background-color: white;" +
  "border-top: 1px solid #e8e8e8;" +
  "}",

  authorizationFooterContainerIOS: ".authorization-footer-button-container-ios " +
  "{" +
  "position: absolute;" +
  "font-size:" + 34 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "color: #535b67;" +
  "width: 100%;" +
  "height:" + 135 * heightK + "px;" +
  "bottom: 0;" +
  "padding: 0;" +
  "border: none;" +
  "background-color: white;" +
  "}",

  authorizationFooterContainerIOSForBorder: ".authorization-footer-button-container-ios-for-border " +
  "{" +
  "position: absolute;" +
  "font-family: SFUIDisplay-Light;" +
  "width: 90%;" +
  "height:" + 135 * heightK + "px;" +
  "margin-left: 5%;" +
  "bottom: 0;" +
  "padding: 0;" +
  "border: none;" +
  "background-color: white;" +
  "border-top: 1px solid #e8e8e8;" +
  "}",

  authorizationFooterNotFirstButton: ".authorization-footer-not-first-button " +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "height: 100%;" +
  "float: left;" +
  "}",

  authorizationFooterNotFirstButtonIOS: ".authorization-footer-not-first-button-ios" +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "height: 100%;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "}",

  authorizationFooterNotFirstOfflineIcon: ".authorization-footer-not-first-offline-icon " +
  "{" +
  "position: relative;" +
  "width:" + 80 * widthK + "px ;" +
  "height:" + 80 * widthK + "px ;" +
  "right:" + 12 * widthK + "px ;" +
  "margin-top:" + 40 * heightK + "px ;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "background-image: url(resources/icons/authorization/offline.png);" +
  "background-size: contain;" +
  "background-position: center;" +
  "background-repeat: no-repeat;" +
  "}",

  authorizationFooterNotFirstOfflineLabel: ".authorization-footer-not-first-offline-label " +
  "{" +
  "position: absolute;" +
  "left: 0;" +
  "right: 0;" +
  "width:" + 250 * widthK + "px ;" +
  "margin-right: auto;" +
  "margin-left:" + 28 * widthK + "px ;" +
  "margin-top:" + 20 * widthK + "px ;" +
  "text-align: center;" +
  "font-family: SFUIDisplay-Semibold;" +
  "}",

  authorizationFooterNotFirstClickPassIcon: ".authorization-footer-not-first-click-pass-icon " +
  "{" +
  "position: relative;" +
  "width:" + 80 * widthK + "px ;" +
  "height:" + 80 * widthK + "px ;" +
  "left:" + 19 * widthK + "px ;" +
  "margin-top:" + 40 * heightK + "px ;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "background-image: url(resources/icons/authorization/scaner.png);" +
  "background-size: contain;" +
  "background-position: center;" +
  "background-repeat: no-repeat;" +
  "}",

  authorizationFooterNotFirstClickPassIconIos: ".authorization-footer-not-first-click-pass-icon-ios " +
  "{" +
  "position: absolute;" +
  "width:" + 65 * heightK + "px ;" +
  "height:" + 65 * heightK + "px ;" +
  "left:" + 19 * widthK + "px ;" +
  "margin-top:" + 35 * heightK + "px ;" +
  "background-image: url(resources/icons/authorization/scaner.png);" +
  "background-size: contain;" +
  "background-position: center;" +
  "background-repeat: no-repeat;" +
  "}",

  authorizationFooterNotFirstClickPassLabel: ".authorization-footer-not-first-click-pass-label " +
  "{" +
  "position: absolute;" +
  "left: 0;" +
  "right: 0;" +
  "width:" + 250 * widthK + "px ;" +
  "margin-left: auto;" +
  "margin-right:" + 25 * widthK + "px ;" +
  "margin-top:" + 20 * widthK + "px ;" +
  "text-align: center;" +
  "font-family: SFUIDisplay-Semibold;" +
  "}",

  authorizationFooterNotFirstClickPassLabelIos: ".authorization-footer-not-first-click-pass-label-ios " +
  "{" +
  "position: absolute;" +
  "width:" + 200 * widthK + "px ;" +
  "height:" + 40 * widthK + "px ;" +
  "top:" + 50 * heightK + "px ;" +
  "right:" + 15 * heightK + "px ;" +
  "text-align: center;" +
  "font-family: SFUIDisplay-Semibold;" +
  "}",

  authorizationFooterNotFirstBorderRight: ".authorization-footer-not-first-border-right" +
  "{" +
  "position: absolute;" +
  "height: 60%;" +
  "left: 50%;" +
  "top: 20%;" +
  "border-right:" + 1 * widthK + "px solid #e8e8e8;" +
  "background: transparent;" +
  "}",

  authorizationFooterContainerFirst: ".authorization-footer-button-container-first " +
  "{" +
  "position: absolute;" +
  "font-size:" + 34 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "color: #535b67;" +
  "width: 90%;" +
  "height:" + 87 * widthK + "px;" +
  "margin-left: 5%;" +
  "bottom:" + 87 * widthK + "px;" +
  "padding: 0;" +
  "border: none;" +
  "background-color: white;" +
  "border-top: 1px solid #e8e8e8;" +
  "}",

  authorizationButtonOfflineFirstEnter: ".authorization-button-offline-first-enter " +
  "{" +
  "position: absolute;" +
  "font-size:" + 34 * widthK + "px;" +
  "width:" + 240 * widthK + "px;" +
  "background-size: contain;" +
  "color: white;" +
  "border-bottom:" + 1 + "px solid white;" +
  "text-align: center;" +
  "top:" + 10 * widthK + "px;" +
  "right:" + 50 * widthK + "px;" +
  "}",

  authorizationEnterPinLabel: ".authorization-enter-pin-label " +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "background-size: contain;" +
  "width:" + 275 * widthK + "px;" +
  "color: #aaabae;" +
  "font-size:" + 32 * widthK + "px;" +
  "}",

  authorizationFirstEnterPinLabel: ".authorization-first-enter-pin-label " +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "background-size: contain;" +
  "width:" + 275 * widthK + "px;" +
  "top:" + -200 * widthK + "px;" +
  "color: #b0aeb2;" +
  "font-size:" + 32 * widthK + "px;" +
  "}",

  AuthorizationInputEyeButton: ".authorization-input-eye-button " +
  "{" +
  "position: absolute;" +
  "background-image: url(resources/icons/authorization/pin_hide.png);" +
  "background-size: contain;" +
  "background-position: center;" +
  "background-repeat: no-repeat;" +
  "width:" + 48 * widthK + "px;" +
  "height:" + 48 * widthK + "px;" +
  "top:" + 20 * widthK + "px;" +
  "right:" + 10 * widthK + "px;" +
  "}",


  //VIEW MAIN PAGE

  viewMainPage: ".view-main-page " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 100%;" +
  "overflow: hidden;" +
  // "filter: blur(5px);" +
  "}",

  //TOOLBAR COMPONENT

  toolbar: ".toolbar " +
  "{" +
  "position: absolute;" +
  // "top:" + 20 * widthK + "px;" +
  // "right:" + 26 * widthK + "px;" +
  // "left:" + 26 * widthK + "px;" +
  "height:" + 90 * widthK + "px;" +
  "width: 100%;" +
  "background: white;" +
  "border-bottom: 1px solid #e8e8e8;" +
  "-webkit-box-shadow: 0 0px 40px 8px rgba(0,0,0, .05);" +
  "-moz-box-shadow: 0 0px 40px 8px rgba(0,0,0, .05);" +
  "box-shadow: 0 0px 40px 8px rgba(0,0,0, .05);" +
  "}",

  toolbarCircleContainer: ".toolbar-circle-container " +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "width:" + 105 * widthK + "px;" +
  "height:" + 105 * widthK + "px;" +
  "top:" + 2 * widthK + "px;" +
  // "left:" + 272 * widthK + "px;" +
  // "bottom:" + 2 * widthK + "px;" +
  "border-radius:" + 100 * widthK + "px;" +
  "background-color: white;" +
  "border: 1px solid #e8e8e8;" +
  "background-image: url(resources/icons/bank-operations/circleReport.png);" +
  "background-repeat: no-repeat;" +
  "background-size: 70%;" +
  "background-position-x: 50%;" +
  "background-position-y: 55%;" +
  "-webkit-box-shadow: 10px 10px 30px 0px rgba(0,0,0, .05);" +
  "-moz-box-shadow: 10px 10px 30px 0px rgba(0,0,0, .05);" +
  "box-shadow: 10px 10px 30px 0px rgba(0,0,0, .05);" +
  "}",

  toolbarCircleContainerTitle: ".toolbar-circle-container-title " +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "width:" + 117 * widthK + "px;" +
  "top:" + 3 * widthK + "px;" +
  "color: #a9abaf;" +
  "font-size:" + 30 * widthK + "px;" +
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
  "z-index: 2;" +
  "background-image: url(resources/icons/toolbar/menus.png);" +
  "width:" + 100 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "background-size: 35%;" +
  "top:" + -8 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "left:" + 10 * widthK + "px;" +
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

  bellButtonNewsCounter: ".bell-button-news-counter " +
  "{" +
  "position: absolute;" +
  "left:" + 20 * widthK + "px;" +
  "font-size:" + 16 * widthK + "px;" +
  "width:" + 28 * widthK + "px;" +
  "height:" + 28 * widthK + "px;" +
  "line-height:" + 28 * widthK + "px;" +
  "border-radius:" + 100 * widthK + "px;" +
  "background-color: orange;" +
  "text-align: center;" +
  "color: white;" +
  "overflow: hidden;" +
  "}",

  bellIcon: ".bell-icon " +
  "{" +
  "position: absolute;" +
  "background: transparent;" +
  "z-index: 2;" +
  "background-image: url(resources/icons/toolbar/bell.png);" +
  "width:" + 100 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "background-size: 40%;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "right:" + 14 * widthK + "px;" +
  "top:" + -7 * widthK + "px;" +
  "}",

  //BANK OPERATION COMPONENT

  bankOperations: ".bank-operations " +
  "{" +
  "position: absolute;" +
  "bottom:" + 429 * heightK + "px;" +
  "top:" + 564 * widthK + "px;" +
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
  "left:" + 290 * widthK + "px;" +
  "overflow: hidden;" +
  "border: none;" +
  "outline: none;" +
  "transition-duration: 0.4s;" +
  "}",
  //
  //bankOperationButtonTransferActive: ".bank-operation-button-transfer:active " +
  //"{" +
  //"content: '';" +
  //"background: white;" +
  //"position: absolute;" +
  //"padding-top: 10%;" +
  //"padding-left: 10%;" +
  ////"margin-left: -20px!important;" +
  ////"margin-top: 120%;" +
  //"opacity: 0;" +
  //"transition: all 0.8s;" +
  //"border: none;" +
  //"}",
  //
  //bankOperationButtonTransferActiveAfter: ".bank-operation-button-transfer:active:after " +
  //"{" +
  //"padding: 0;" +
  //"margin: 0;" +
  //"opacity: 1;" +
  //"transition: 0s;" +
  //"border: none;" +
  //"}",

  bankOperationButtonAutoPay: ".bank-operation-button-autopay " +
  "{" +
  "left:" + 511 * widthK + "px;" +
  "}",

  bankOperationButtonQr: ".bank-operation-button-qr " +
  "{" +
  "left:" + 521 * widthK + "px;" +
  "}",

  topOperationsButtons: ".top-operations-buttons " +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "width:" + 720 * widthK + "px;" +
  "height: 60%;" +
  // "bottom:" + 85 * heightK + "px;" +
  "top:" + 55 * heightK + "px;" +
  // "top: 15%;" +
  "}",

  bankOperationsContainers: ".bank-operations-containers " +
  "{" +
  "float: left;" +
  "height: 137%;" +
  "width: 33.33%;" +
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
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "top:" + 30 + "%;" +
  // "left:" + 30 + "%;" +
  "width:" + 270 * widthK + "px;" +
  "height:" + 75 * widthK + "px;" +
  "}",

  bankOperationButtonMyCard: ".bank-operation-button-my-cards " +
  "{" +
  "position: absolute;" +
  "left:" + 27 * widthK + "px;" +
  "right:" + 27 * widthK + "px;" +
  "border-bottom: 1px solid #e8e8e8;" +
  "text-align: center;" +
  "top:" + 473 * widthK + "px;" +
  "height:" + 100 * heightK + "px;" +
  "}",

  bankOperationButtonMyCardsIcon: ".bank-operation-button-my-cards-icon " +
  "{" +
  "position: absolute;" +
  "width:" + 28 * widthK + "px;" +
  "height:" + 24 * widthK + "px;" +
  "left:" + 16 * widthK + "px;" +
  "top:" + 8 * widthK + "px;" +
  "background-size: 100%;" +
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
  "color: #565d6a;" +
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
  "color: #565d6a;" +
  "text-align: center;" +
  "font-size:" + 29 * widthK + "px;" +
  "}",

  bankOperationLabelPay: ".bank-operation-label-pay " +
  "{" +
  "left:" + 73 * widthK + "px;" +
  "}",

  bankOperationLabelTransfer: ".bank-operation-label-transfer " +
  "{" +
  "left:" + 286 * widthK + "px;" +
  "}",

  bankOperationLabelAutoPay: ".bank-operation-label-autopay " +
  "{" +
  "left:" + 496 * widthK + "px;" +
  "}",

  bankOperationLabelQr: ".bank-operation-label-qr " +
  "{" +
  "left:" + 505 * widthK + "px;" +
  "}",

  bankOperationLabelInPlacePay: ".bank-operation-label-inplace-pay " +
  "{" +
  "left:" + 467 * widthK + "px;" +
  "width:" + 250 * widthK + "px;" +
  "bottom:" + -50 * widthK + "px;" +
  "height:" + 66 * widthK + "px;" +
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

  operationQrIcon: ".operation-qr-icon " +
  "{" +
  "background-image: url(resources/icons/bank-operations/qr.png);" +
  "background-size: 56%;" +
  "}",

  //CAROUSEL COMPONENT

  cardCarousel: ".card-carousel " +
  "{" +
  "position: absolute;" +
  "height:" + 290 * widthK + "px;" +
  "width: 100%;" +
  "display: inline-block;" +
  "top:" + 182 * widthK + "px;" +
  "background: transparent;" +
  "transition: 1s;" +
  "-webkit-transform: scale(1);" +
  "}",

  cards: ".cards " +
  "{" +
  "position: relative;" +
  "}",

  card: ".card " +
  "{" +
  //"background-color: #d7d7d7;" +
  "background-image: url(resources/icons/cards/all.png);" +
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
  "-webkit-box-shadow: " + 9 * widthK + "px " + 9 * widthK + "px " + 29.4 * widthK + "px " + "rgba(0,0,0, 0.08);" +
  "-moz-box-shadow: " + 9 * widthK + "px " + 9 * widthK + "px " + 29.4 * widthK + "px " + "rgba(0,0,0, 0.08);" +
  "box-shadow: " + 9 * widthK + "px " + 9 * widthK + "px " + 29.4 * widthK + "px " + "rgba(0,0,0, 0.08);" +
  "background-color: #BDC7D0;" +
  "}",

  invoiceCardPartOne: ".invoice-card-part-one " +
  "{" +
  "-webkit-appearance: none;" +
  "height:" + 130 * widthK + "px;" +
  "width:" + 510 * widthK + "px;" +
  "position: absolute;" +
  "top:" + 17 * widthK + "px;" +
  "background-color: white;" +
  "background-size: cover;" +
  "color: white;" +
  //"-webkit-box-shadow: 0px 50px 50px -50px rgba(0,0,0,1);" +
  //"-moz-box-shadow: 0px 50px 50px -50px rgba(0,0,0,1);" +
  //"box-shadow: 0px 50px 50px -50px rgba(0,0,0,1);" +
  "}",

  invoiceCardPartTwo: ".invoice-card-part-two" +
  "{" +
  "-webkit-appearance: none;" +
  "height:" + 130 * widthK + "px;" +
  "width:" + 510 * widthK + "px;" +
  "position: absolute;" +
  "top:" + 160 * widthK + "px;" +
  "background-color: white;" +
  "background-size: cover;" +
  "color: white;" +
  "}",

  invoiceCardInfoHolder: ".invoice-card-info-holder" +
  "{" +
  "width:" + 430 * widthK + "px;" +
  "float: left;" +
  "}",

  invoiceCardTransfer: ".invoice-card-transfer" +
  "{" +
  "float: right;" +
  "background-color: #98cc1b;" +
  "background-image: url(resources/icons/invoice/transfers_invoice.png);" +
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

  invoiceCardFromSenderHolder: ".invoice-card-from-sender-holder" +
  "{" +
  "color: #8f8f8f;" +
  "margin: 0 0 0 " + 20 * widthK + "px;" +
  "font-size:" + 28 * widthK + "px;" +
  "width:" + 395 * widthK + "px;" +
  "height:" + 35 * widthK + "px;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "max-width:" + 365 * widthK + "px;" +
  "white-space: nowrap;" +
  "}",

  invoiceCardFromSenderServiceName: ".invoice-card-from-sender-service-name" +
  "{" +
  "margin: 0;" +
  "float: left;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "width:" + 70 * widthK + "px;" +
  "white-space: nowrap;" +
  "}",

  invoiceCardFromSenderNumber: ".invoice-card-from-sender-number" +
  "{" +
  "margin: 0;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "max-width:" + 295 * widthK + "px;" +
  "white-space: nowrap;" +
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
  "background-color: #fe7363;" +
  "background-image: url(resources/icons/invoice/payment_invoice.png);" +
  "color: white;" +
  "background-repeat: no-repeat;" +
  "background-size: 50%;" +
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
  "max-height: 52%;" +
  "}",

  cardBalanceFractional: ".card-balance-fractional " +
  "{" +
  "font-size:" + 36 * widthK + "px;" +
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
  "font-size:" + 26 * widthK + "px;" +
  // "text-shadow: white -1px -1px 0.4px, black 0.0px 1px 0.2px, white -1px -1px 0.4px, black 0.0px 1px 0.4px;" +
  // "-webkit-text-shadow: white -1px -1px 0.4px, black 0.0px 1px 0.2px, white -1px -1px 0.4px, black 0.0px 1px 0.4px;" +
  // "color: transparent;" +
  "font-family: 'OCRAStd';" +
  "left:" + 20 * widthK + "px;" +
  "}",

  cardNumberPartOne: ".card-number-part-one " +
  "{" +
  "position: absolute;" +
  "left: 0px;" +
  // "font-weight: bold;" +
  "}",

  cardNumberMiddleTwo: ".card-number-middle-two " +
  "{" +
  "position: absolute;" +
  "left:" + 107 * widthK + "px;" +
  // "font-weight: bold;" +
  "}",

  cardNumberPartTwo: ".card-number-part-two " +
  "{" +
  "position: absolute;" +
  "left:" + 304 * widthK + "px;" +
  // "font-weight: bold;" +
  "}",

  numberStars: ".number-stars " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left:" + 147 * widthK + "px;" +
  // "top: -" + 8 * widthK + "px;" +
  // "letter-spacing:" + -10 * widthK + "px;" +
  "font-size:" + 26 * widthK + "px;" +
  // "word-spacing:" + -8 * widthK + "px;" +
  "}",

  //SERVICE CAROUSEL COMPONENT

  serviceCarousel: ".service-carousel " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "top:" + 875 * heightK + "px;" +
  "bottom:" + 65 * widthK + "px;" +
  "background: transparent;" +
  "}",

  serviceComponent: ".service-component " +
  "{" +
  "position: absolute;" +
  "width:" + 620 * widthK + "px;" +
  "height:" + 255 * heightK + "px;" +
  //"height:" + 338 * heightK + "px;" +
  "top:" + -1 * heightK + "px;" +
  "bottom:" + 5 * widthK + "px;" +
  "background-color: #fefefe;" +
  "-webkit-box-shadow: " + 9 * widthK + "px " + 9 * widthK + "px " + 29.4 * widthK + "px " + "rgba(0,0,0, 0.08);" +
  "-moz-box-shadow: " + 9 * widthK + "px " + 9 * widthK + "px " + 29.4 * widthK + "px " + "rgba(0,0,0, 0.08);" +
  "box-shadow: " + 9 * widthK + "px " + 9 * widthK + "px " + 29.4 * widthK + "px " + "rgba(0,0,0, 0.08);" +
  "}",

  serviceComponentOpenIcon: ".service-component-open-icon " +
  "{" +
  "position: absolute;" +
  "width:" + 20 * widthK + "px;" +
  //"height:" + 338 * heightK + "px;" +
  "height: 100%;" +
  "top:" + 0 * heightK + "px;" +
  "right:" + 0 * heightK + "px;" +
  "background-image: url(resources/icons/ViewInfo/open.png);" +
  "background-size: 50%;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "}",

  serviceContainer: ".service-container " +
  "{" +
  "position: absolute;" +
  "height: 55%;" +
  "width: 100%;" +
  "bottom: 23%;" +
  "left:" + 25 * widthK + "px;" +
  "}",

  serviceButtons: ".service-buttons " +
  "{" +
  "position: relative;" +
  "width:" + 125 * widthK + "px;" +
  "height:" + 125 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  //"border-radius:" + 100 * widthK + "px;" +
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
  "bottom:" + 12 * widthK + "px;" +
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
  "width:" + 260 * widthK + "px;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "background: transparent;" +
  "background-size: contain;" +
  "color: #565d6a;" +
  "font-size:" + 24 * widthK + "px;" +
  "}",

  sideMenuBlockForSwipe: ".side-menu-block-for-swipe " +
  "{" +
  "position: absolute;" +
  "height: 100%;" +
  "top:" + 90 * widthK + "px;" +
  "z-index: 1;" +
  "width:" + 20 * widthK + "px;" +
  "}",

  sideMenu: ".side-menu " +
  "{" +
  "position: absolute;" +
  "height: 100%;" +
  "width:" + 538 * widthK + "px;" +
  "overflow: hidden;" +
  "transform: translate3d(-100%, 0, 0);" +
  "-webkit-transform: translate3d(-100%, 0,0);" +
  "-ms-transform: translate3d(-100%, 0,0);" +
  // "background-color: #22a0e0;" +
  "background-color: #ffffff;" +
  "z-index: 1;" +
  //"top:" + topOfIos + "px;" +
  "}",

  sideMenuInsideButton: ".side-menu-inside-button " +
  "{" +
  "position: absolute;" +
  "height: 5%;" +
  "width: 23%;" +
  "top: 1%;" +
  // "left: 4%;" +
  "background-image: url(resources/icons/toolbar/menus.png);" +
  "background-repeat: no-repeat;" +
  "background-size: 30%;" +
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
  "height:" + 100 * widthK + "px;" +
  "width:" + 100 * widthK + "px;" +
  "left: 52%;" +
  "border:" + 4 * widthK + "px solid white;" +
  "border-radius:" + 100 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-size: cover;" +
  "background-position: center;" +
  "}",

  sideMenuUserFirstName: ".side-menu-user-first-name " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "padding: 0;" +
  "bottom:" + 21 * widthK + "px;" +
  "right: 14%;" +
  "color: #565d6a;" +
  "width: 100%;" +
  "overflow: hidden;" +
  "text-overflow: ellipsis;" +
  "text-align: right;" +
  "white-space: nowrap;" +
  "}",

  sideMenuUserSecondName: ".side-menu-user-second-name " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "padding: 0;" +
  "bottom:" + 53 * widthK + "px;" +
  "right: 14%;" +
  "width: 100%;" +
  "overflow: hidden;" +
  "text-overflow: ellipsis;" +
  "color: #565d6a;" +
  "text-align: right;" +
  "white-space: nowrap;" +
  "}",

  sideMenuBillingsContainer: ".side-menu-billings-container " +
  "{" +
  "position: relative;" +
  "top: 32.2%;" +
  "height: 6%;" +
  "width: 77%;" +
  "left: 8%;" +
  "border-bottom: 1px solid #f2f2f2;" +
  // "border-bottom: 1px solid #43aee5;" +
  "}",

  sideMenuFavoriteContainer: ".side-menu-favorite-container " +
  "{" +
  "position: relative;" +
  "top: 32.7%;" +
  "height: 6%;" +
  "width: 77%;" +
  "left: 8%;" +
  "border-bottom: 1px solid #f2f2f2;" +
  "}",

  sideMenuAutoPayContainer: ".side-menu-auto-pay-container " +
  "{" +
  "position: relative;" +
  "top: 32.7%;" +
  "height: 6%;" +
  "width: 77%;" +
  "left: 8%;" +
  "border-bottom: 1px solid #f2f2f2;" +
  "}",

  sideMenuScannerQrContainer: ".side-menu-scanner-qr-container " +
  "{" +
  "position: relative;" +
  "top: 32.7%;" +
  "height: 12.5%;" +
  "width: 77%;" +
  "left: 8%;" +
  // "border-bottom: 1px solid #2dadf0;" +
  "}",

  sideMenuClickPassContainer: ".side-menu-click-pass-container " +
  "{" +
  "position: relative;" +
  "top: 32.7%;" +
  "height: 12.5%;" +
  "width: 77%;" +
  "left: 8%;" +
  // "border-bottom: 1px solid #2dadf0;" +
  "}",

  sideMenuSettingsContainer: ".side-menu-settings-container " +
  "{" +
  "position: relative;" +
  "top: 36.4%;" +
  "height: 6%;" +
  "width: 77%;" +
  "left: 8%;" +
  "border-bottom: 1px solid #f2f2f2;" +
  "}",


  sideMenuCallContainer: ".side-menu-call-container " +
  "{" +
  "position: relative;" +
  "top: 36.4%;" +
  "height: 6%;" +
  "width: 77%;" +
  "left: 8%;" +
  //"margin-top: 2%;" +
  "border-bottom: 1px solid #f2f2f2;" +
  "}",

  sideMenuExitContainer: ".side-menu-exit-container " +
  "{" +
  "position: absolute;" +
  "bottom: 1.4%;" +
  "height: 6%;" +
  "width: 77%;" +
  "left: 8%;" +
  // "border-bottom: 1px solid #2dadf0;" +
  "}",

  sideMenuContainersIcon: ".side-menu-containers-icon " +
  "{" +
  "position: absolute;" +
  "width: 7%;" +
  "height: 81%;" +
  "top: 12%;" +
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
  "background-image: url(resources/icons/menu/qr_blue.png);" +
  "background-size: 100%;" +
  "width: 18%;" +
  "}",

  sideMenuContainersIconClickPass: ".side-menu-containers-icon-click-pass" +
  "{" +
  "background-image: url(resources/icons/menu/scanner_blue.png);" +
  "background-size: 100%;" +
  "width: 18%;" +
  "}",

  sideMenuContainersIconCall: ".side-menu-containers-icon-call" +
  "{" +
  "background-image: url(resources/icons/menu/menu_call.png);" +
  "background-size: 100%;" +
  "top: 22%;" +
  "}",

  sideMenuContainersIconExit: ".side-menu-containers-icon-exit" +
  "{" +
  "background-image: url(resources/icons/back/back.png);" +
  "background-size: 100%;" +
  "top: 39%;" +
  "height: 36%;" +
  "width: 8%;" +
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
  "color: #565d6a;" +
  "}",

  sideMenuContainersNameAutopayment: ".side-menu-containers-name-autopayment " +
  "{" +
  "}",

  sideMenuContainersNameScannerQr: ".side-menu-containers-name-scanner-qr " +
  "{" +
  "left: 28%;" +
  "top: 23%;" +
  "font-weight: bold;" +
  "}",

  sideMenuContainersHintScannerQr: ".side-menu-containers-hint-scanner-qr " +
  "{" +
  "position: absolute;" +
  "left: 28%;" +
  "top: 50%;" +
  "width: 80%;" +
  "font-size:" + 24 * widthK + "px;" +
  "color: #aaabae;" +
  "}",

  sideMenuContainersNameClickPass: ".side-menu-containers-name-click-pass " +
  "{" +
  "left: 28%;" +
  "top: 23%;" +
  "font-weight: bold;" +
  "}",

  sideMenuContainersHintClickPass: ".side-menu-containers-hint-click-pass " +
  "{" +
  "position: absolute;" +
  "left: 28%;" +
  "top: 50%;" +
  "width: 80%;" +
  "font-size:" + 24 * widthK + "px;" +
  "color: #aaabae;" +
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
  "z-index: 2;" +
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
  "transform: translate3d(0, 0,0);" +
  "-webkit-transform: translate3d(0, 0,0);" +
  "-ms-transform: translate3d(0, 0,0);" +
  "background-color: rgba(0, 0, 0, 0.6);" +
  "opacity: 0;" +
  "}",

  //TITLE COMPONENT

  pageTitle: ".page-title " +
  "{" +
  "position: absolute;" +
  "top: 0px;" +
  "width: 100%;" +
  "height:" + 87 * widthK + "px;" +
  "background: white;" +
  "z-index: 5;" +
  "}",

  pageTitleShadow: ".page-title-shadow " +
  "{" +
  "-webkit-box-shadow: 0 8px 40px 8px rgba(0,0,0, .05);" +
  "-moz-box-shadow: 0 8px 40px 8px rgba(0,0,0, .05);" +
  "box-shadow: 0 8px 40px 8px rgba(0,0,0, .05);" +
  "}",

  upperShadow: ".upper-shadow " +
  "{" +
  "-webkit-box-shadow: 0 8px 40px 8px rgba(0,0,0, .05);" +
  "-moz-box-shadow: 0 -8px 40px 8px rgba(0,0,0, .05);" +
  "box-shadow: 0 -8px 40px 8px rgba(0,0,0, .05);" +
  "}",

  nameTitle: ".name-title " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size:" + 35 * widthK + "px;" +
  "left: 13%;" +
  "top: 27%;" +
  "margin: 0;" +
  "color: #565d6a;" +
  "}",

  backButton: ".back-button " +
  "{" +
  "position: absolute;" +
  "width:" + 87 * widthK + "px;" +
  "height:" + 87 * widthK + "px;" +
  "background-image: url(resources/icons/back/back.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 50%;" +
  "background-position-y: center;" +
  "background-position-x: center;" +
  "background-size: 50%;" +
  "left: 1.5%;" +
  "}",

  titleBottomBorder: ".title-bottom-border " +
  "{" +
  "position: absolute;" +
  "width: 90%;" +
  "left: 5%;" +
  "bottom: 0%;" +
  "border-bottom: 1px solid #e8e8e8;" +
  "}",

  verLineBorder: ".hor-line-border " +
  "{" +
  "position: relative;" +
  "width: 90%;" +
  "left: 5%;" +
  "bottom: 0%;" +
  "border-bottom: 1px solid #e8e8e8;" +
  "}",

  settingsButton: ".settings-button " +
  "{" +
  "position: absolute;" +
  "width:" + 87 * widthK + "px;" +
  "height:" + 87 * widthK + "px;" +
  "right: 2%;" +
  "background-image: url(resources/icons/ViewMyCards/cardsettings.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 50%;" +
  "background-position-y: center;" +
  "background-position-x: center;" +
  "background-size: 50%;" +
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
  "height:" + 87 * widthK + "px;" +
  "width: 100%;" +
  // "border-top:" + 2 + "px solid #00b3fd;" +
  // "color: rgb(197, 233, 239);" +
  // "background-color: #00b3fd;" +
  "background: -moz-linear-gradient(left, rgb(86,93,106) 20%,rgb(87,132,169));" +
  "background: -webkit-linear-gradient(left, rgb(86,93,106) 20%,rgb(87,132,169));" +
  "background: -ms-linear-gradient(left, rgb(86,93,106) 20%,rgb(87,132,169));" +
  "}",

  footerIconTick: ".footer-icon-tick " +
  "{" +
  "position: absolute;" +
  "left:" + 192 * widthK + "px;" +
  "background-size: contain;" +
  "background-image: url(resources/icons/footer/contacts.png);" +
  "background-repeat: no-repeat;" +
  "width:" + 30 * widthK + "px;" +
  "height:" + 15 * widthK + "px;" +
  "top:" + 29 * widthK + "px;" +
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
  "height:" + 275 * widthK + "px;" +
  "width: 100%;" +
  "transform: translate3d(0, " + 200 * widthK + "px,0);" +
  "-webkit-transform: translate3d(0," + 200 * widthK + "px,0);" +
  "-ms-transform: translate3d(0," + 200 * widthK + "px,0);" +
  "}",

  footerContactLabel: ".footer-contacts-label " +
  "{" +
  "position: absolute;" +
  "font-size:" + 27 * widthK + "px;" +
  "margin-top:" + 20 * widthK + "px;" +
  "color: white;" +
  "left:" + -1 * widthK + "px;" +
  "}",

  footerContacts: ".footer-contacts " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 240 * widthK + "px;" +
  "bottom:" + -40 * widthK + "px;" +
  "background: -moz-linear-gradient(left, rgb(86,93,106) 20%,rgb(87,132,169));" +
  "background: -webkit-linear-gradient(left, rgb(86,93,106) 20%,rgb(87,132,169));" +
  "background: -ms-linear-gradient(left, rgb(86,93,106) 20%,rgb(87,132,169));" +
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
  "color: white;" +
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
  "top:" + -64 * widthK + "px;" +
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
  "background-image: url(resources/icons/ViewMyCards/cardpayments.png);" +
  "background-size: 35%;" +
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
  "color: #565d6a;" +
  "top:" + 30 * widthK + "px;" +
  "border-bottom: 1px solid #e8e8e8;" +
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
  "overflow-y: scroll;" +
  "overflow-x: hidden;" +
  "height:" + (1232 * heightK - 922 * widthK) + "px;" +
  "}",

  myCardsLastOperations: ".my-cards-last-operations " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 100%;" +
  // "top:" + 835 * widthK + "px;" +
  // "overflow-y: scroll; " +
  "-webkit-transform: translate3d(0," + 835 * widthK + "px,0); " +
  // "overflow-x: hidden; " +
  "-webkit-transition: 1s; " +
  // "-webkit-overflow-scrolling: touch; " +
  "background-color: #ffffff;" +
  // "bottom: 0;" +
  "}",

  myCardsLastOperationsContainerLabel: ".my-cards-last-operations-container-label " +
  "{" +
  "position: absolute;" +
  "top: 0;" +
  "height:" + 80 * widthK + "px;" +
  "width: 100%;" +
  "background-color: white;" +
  "background-size: contain;" +
  "font-size:" + 24 * widthK + "px;" +
  "color: #8a8a8a;" +
  "z-index: 99999;" +
  // "box-shadow: 0px 17px 63px -23px rgb(37, 36, 36);" +
  "box-shadow: 0px " + 17 * widthK + "px " + 63 * widthK + "px " + -23 * widthK + "px " + " rgb(37, 36, 36);" +
  "}",

  myCardsLastOperationsContainerIcon: ".my-cards-last-operations-container-icon " +
  "{" +
  "position: absolute;" +
  "height:" + 40 * widthK + "px;" +
  "width:" + 25 * widthK + "px;" +
  "left:" + 350 * widthK + "px;" +
  "top:" + 7 * widthK + "px;" +
  "background-image: url(resources/icons/ViewMyCards/double_arrow.png);" +
  "background-size: contain;" +
  "background-position: center;" +
  "-webkit-transition: 1s;" +
  "background-repeat: no-repeat;" +
  "}",

  myCardsLastOperationLabel: ".my-cards-last-operations-label " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left:" + 43 * widthK + "px;" +
  "top:" + 23 * widthK + "px;" +
  "}",

  myCardsLastOperationsInnerContainer: ".my-cards-last-operations-inner-container" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "}",

  myCardsLastOperationInfo: ".my-cards-last-operations-info " +
  "{" +
  "position: relative;" +
  // "top:" + 80 * widthK + "px;" +
  "width: 100%;" +
  "background-color: white;" +
  "height:" + 150 * widthK + "px;" +
  "border-bottom:" + 1 + "px solid #dedfe0;" +
  "overflow: hidden;" +
  "}",

  myCardsLastOperationInfoStateImage: ".my-cards-last-operations-info-state-image " +
  "{" +
  "position: absolute;" +
  "width:" + 60 * widthK + "px;" +
  "right:" + 14 * widthK + "px;" +
  "height:" + 60 * widthK + "px;" +
  //"height: 100%;" +
  "top: 40%;" +
  "background-repeat: no-repeat;" +
  "background-size: 60%;" +
  "background-position: center;" +
  "margin: 0;" +
  "}",

  myCardsLastOperationDate: ".my-cards-last-operations-date " +
  "{" +
  "position: relative;" +
  "background-color: #f6f6f6;" +
  "width: 100%;" +
  "overflow: hidden;" +
  "height:" + 45 * widthK + "px;" +
  "}",

  myCardsLastOperationInfoTime: ".my-cards-last-operation-info-time " +
  "{" +
  "position: absolute;" +
  "right: 0;" +
  "width: 10%;" +
  //"height: 100%;" +
  "top: 15%;" +
  "font-size: " + 22 * widthK + "px; " +
  "margin: 0;" +
  "color: #8b8b8b;" +
  "}",

  myCardsLastOperationInfoDateName: ".my-cards-last-operation-info-date-name " +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "top: " + 10 * widthK + "px; " +
  "left: 9%;" +
  "margin: 0;" +
  "text-align: left;" +
  "font-size:" + 24 * widthK + "px; " +
  "color: gray;" +
  "}",

  myCardsOperationServiceIcon: ".my-cards-operation-service-icon " +
  "{" +
  //"top:" + 50 * widthK + "px;" +
  "background-size: 80%;" +
  "position: absolute;" +
  "width:" + 125 * widthK + "px;" +
  "height:" + 125 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  //"border-radius:" + 100 * widthK + "px;" +
  //"border:solid 1px #f1f1f1;" +
  "top: 6%;" +
  "left: 2%;" +
  "}",


  myCardsOperationAmounts: ".my-cards-operation-amount " +
  "{" +
  "position: relative;" +
  "color: #595759;" +
  "background-size: contain;" +
  "font-size:" + 48 * widthK + "px;" +
  "height:" + 60 * widthK + "px;" +
  "top:" + 40 * widthK + "px;" +
  "left:" + 150 * widthK + "px;" +
  "float: left;" +

  "}",

  myCardsOperationCurrency: ".my-cards-operation-currency " +
  "{" +
  "position: relative;" +
  "color: #919191;" +
  "top:" + 26 * widthK + "px;" +
  "background-size: contain;" +
  "float: left;" +
  "left:" + 160 * widthK + "px;" +
  "font-size:" + 25 * widthK + "px;" +
  "}",

  myCardsOperationDate: ".my-cards-operation-date " +
  "{" +
  "position: absolute;" +
  "color: #919191;" +
  "bottom:" + 30 * widthK + "px;" +
  "left:" + 150 * widthK + "px;" +
  "font-size:" + 25 * widthK + "px;" +
  "}",

  myCardsFirmName: "    .my-cards-firm-name" +
  "{" +
  "position: relative;" +
  // "left:" + 150 * widthK + "px;" +
  "top:" + 15 * widthK + "px;" +
  "font-size:" + 25 * widthK + "px;" +
  "color: #919191;" +
  "}",

  //VIEW CARD EDIT

  cardEditBodyContainer: ".card-edit-body-container" +
  "{" +
  "position: absolute;" +
  "height:" + 1150 * heightK + "px; " +
  "width: 100%; " +
  "top:" + 86 * heightK + "px; " +
  "bottom:0; " +
  "background-color: white; " +
  "overflow-y: auto; " +
  "overflow-x: hidden; " +
  "}",

  checkButton: ".check-button " +
  "{" +
  "position: absolute;" +
  "width:" + 44 * widthK + "px;" +
  "height:" + 41 * widthK + "px;" +
  "right: 6.5%;" +
  "background-image: url('resources/icons/ViewService/unchecked.png');" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 100%;" +
  "background-position-y: center;" +
  "background-position-x: center;" +
  "background-size: 100%;" +
  "top: 28%;" +
  "}",

  cardEditField: ".card-edit-field" +
  "{position: relative;" +
  "left: 10%;" +
  "width: 79.5%;" +
  "height: 9%;" +
  "border-bottom:  " + 3 * widthK + "px solid #01cfff;" +
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
  "background-size: " + 35 * widthK + "px; " +
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
  "overflow-y: hidden;" +
  "background-color: #ffffff;" +
  "}",

  viewInfoTitleContainer: ".view-info-title-container " +
  "{" +
  "position: absolute;" +
  "right:" + 30 * widthK + "px;" +
  "left:" + 30 * widthK + "px;" +
  "height:" + 89 * widthK + "px;" +
  "border-bottom:" + 1 + "px solid #e8e8e8;" +
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
  "z-index: 2;" +
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
  "width: 95%;" +
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
  "display: inline-block;" +
  "width: 78%;" +
  "}",

  viewInfoCardBalanceScaleContainer: ".view-info-card-balance-scale-container " +
  "{" +
  "position: relative;" +
  "left:" + 0 + "px;" +
  "margin: 0;" +
  "float: left;" +
  "padding: 0;" +
  "}",

  viewInfoCardBalanceSum: ".view-info-card-balance-sum " +
  "{" +
  "position: relative;" +
  // "left:" + 25 * widthK + "px;" +
  "color: #585658;" +
  "font-size:" + 67 * widthK + "px;" +
  "margin: 0;" +
  "margin-top:" + -2 * widthK + "px;" +
  "float: left;" +
  "color: #91cc00;" +
  "padding: 0;" +
  // "max-width: 75%;" +
  // "overflow: hidden;" +
  // "text-overflow: ellipsis;" +
  "white-space: nowrap;" +
  "}",

  viewInfoCardBalanceSumFractional: ".view-info-card-balance-sum-fractional " +
  "{" +
  "font-size:" + 51 * widthK + "px;" +
  "}",

  viewInfoCardCurrency: ".view-info-card-currency " +
  "{" +
  // "position: relative;" +
  // "margin-left:" + 30 * widthK + "px;" +
  // "color: #595759;" +
  // "top:" + 12 * widthK + "px;" +
  "font-size:" + 26 * widthK + "px;" +
  // "background-size: contain;" +
  // "float: left;" +
  // "color: #91cc00;" +
  // "width:" + 60 * widthK + "px;" +
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
  "top:" + 280 * widthK + "px;" +
  //"top:" + 408 * widthK + "px;" +
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
  "transition: 0.5s;" +
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

  viewInfoOperationsContainer: ".view-info-operations-container " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  //"height:" + 710 * widthK + "px;" +
  "top:" + 468 * widthK + "px;" +
  "bottom:" + 0 * widthK + "px;" +
  //"top:" + 600 * widthK + "px;" +
  "overflow-y: scroll;" +
  "-webkit-overflow-scrolling: touch;" +
  "overflow-x: hidden;" +
  "font-size:" + 23 * widthK + "px;" +
  "}",

  viewInfoOperationContainer: ".view-info-operation-container " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 200 * widthK + "px;" +
  "z-index: 999999;" +
  "}",

  viewInfoOperationsIcon: ".view-info-operations-icon " +
  "{" +
  "top:" + 50 * widthK + "px;" +
  "background-size: 80%;" +
  "left: 5%;" +
  "position: absolute;" +
  "width:" + 125 * widthK + "px;" +
  "height:" + 125 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  //"border-radius:" + 100 * widthK + "px;" +
  //"border:solid 1px #b7b7b7;" +
  "}",

  viewInfoStateImage: ".view-info-state-image " +
  "{" +
  "position: absolute;" +
  "width:" + 60 * widthK + "px;" +
  "right:" + 5 * widthK + "px;" +
  "height:" + 60 * widthK + "px;" +
  //"height: 100%;" +
  "top: 50%;" +
  "background-repeat: no-repeat;" +
  "background-size: 60%;" +
  "background-position: center;" +
  "margin: 0;" +
  "}",

  viewInfoOperationTitle: ".view-info-operations-title " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 68 * widthK + "px;" +
  //"top:" + 535 * widthK + "px;" +
  "top:" + 400 * widthK + "px;" +
  "z-index:99;" +
  "background-color: white;" +
  "box-shadow:" + 0 * widthK + "px " + 17 * widthK + "px " + 63 * widthK + "px " + -23 * widthK + "px " + "rgb(37, 36, 36);" +
  "}",

  viewInfoOperationsLabel: ".view-info-operations-label " +
  "{" +
  "font-size:" + 24 * widthK + "px;" +
  "position: absolute;" +
  "top: 10%;" +
  "left: 7%;" +
  "color: #8b8b8b;" +
  "}",

  viewOperationInfoContainer: ".view-info-operation-info-container " +
  "{" +
  "position: absolute;" +
  "height: 100%;" +
  "width: 440%;" +
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
  "color: #595759;" +
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
  "top:" + 26 * widthK + "px; " +
  "margin: 0;  " +
  "color: #565d6a;" +
  "}",

  payBackButton: ".pay-back-button " +
  "{" +
  "position: absolute;" +
  "width:" + 48 * widthK + "px;" +
  "height:" + 36 * widthK + "px;" +
  "background-image: url(resources/icons/back/back.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 100%;" +
  "background-position-y: center;" +
  "background-position-x: center;" +
  "background-size: 100%;" +
  "left: 2%;" +
  "top:" + 28 * widthK + "px; " +
  "}",

  paySearchButton: ".pay-search-button " +
  "{" +
  "position: absolute;" +
  "width:" + 84 * widthK + "px;" +
  "height:" + 87 * widthK + "px;" +
  "right: 4.5%;" +
  "top: 4%;" +
  "background-image: url(resources/icons/search/search.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 50%;" +
  "background-position-y: center;" +
  "background-position-x:center;" +
  "background-size: 50%;" +
  "}",

  payCategoryContainer: ".pay-category-container" +
  "{" +
  "position: absolute;" +
  //"height:" + 1150 * widthK + "px; " +
  "width: 100%; " +
  "top:" + 86 * widthK + "px; " +
  "bottom:0; " +
  "background-color: white; " +
  "overflow-y: scroll; " +
  "overflow-x: hidden; " +
  "-webkit-overflow-scrolling: touch; " +
  "}",

  payServiceBlockContainer: ".pay-service-block-containter" +
  "{" +
  "position: relative;" +
  "min-height:" + 100 * widthK + "px; " +
  "width: 100%;" +
  "padding-top: 1%;" +
  // "border-bottom:" + 1 + "px solid gainsboro;" +
  "background-color: transparent;" +
  "}",

  payServiceHintContainer: ".pay-service-hint-containter" +
  "{" +
  "position: absolute;" +
  "height:" + 100 * widthK + "px; " +
  "width: 100%;" +
  //"margin-top: 1%;" +
  "z-index: 999;" +
  "background-color: white;" +
  "top:" + 86 * widthK + "px; " +
  //"display: none;" +
  //"box-shadow: 0 0 20px rgba(0,0,0,0.5);" +
  "-webkit-box-shadow: 0 8px 6px -6px rgba(0,0,0,0.5);" +
  "-moz-box-shadow: 0 8px 6px -6px rgba(0,0,0,0.5);" +
  "box-shadow: 0 8px 6px -6px rgba(0,0,0,0.5);" +
  "}",

  payHintIconTick: ".pay-hint-icon-tick " +
  "{" +
  "position: relative;" +
  "left:" + 653 * widthK + "px;" +
  "background-size: contain;" +
  "background-image: url(resources/icons/ViewPay/catclose.png);" +
  "background-repeat: no-repeat;" +
  "width:" + 19 * widthK + "px;" +
  "height:" + 18 * widthK + "px;" +
  "top:" + 9 * widthK + "px;" +
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
  //"border: " + 1 + "px solid white;" +
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
  //

  payIconTick: ".pay-icon-tick " +
  "{" +
  "position: relative;" +
  "left: 91%;" +
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
  "top:" + 0 * widthK + "px;" +
  "width: 100%;" +
  "height:" + 130 * heightK + "px;" +
  "background: white;" +
  "z-index: 2;" +
  //"border-bottom:" + 2 + "px solid rgb(149, 230, 253);" +
  "}",

  servicePageTitle: ".servicepage-title" +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size: " + 38 * widthK + "px; " +
  "left: 13%;" +
  "top: 15%;" +
  "margin: 0;" +
  "color: #565d6a;" +
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "width: 60%;" +
  "}",

  servicePageLimitTitle: ".servicepage-limit-title" +
  "{" +
  "position: absolute;" +
  "font-size: " + 20 * widthK + "px; " +
  "bottom: " + -30 * widthK + "px; " +
  "margin: 0;" +
  "color: #515151;" +
  "}",

  servicePageCategoryField: ".servicepage-category-field" +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size: " + 29 * widthK + "px; " +
  "left: 13%;" +
  "top: 52%;" +
  "margin: 0;" +
  "color: #565d6a;" +
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
  "display:none;" +
  "}",

  servicePageBodyContainer: ".servicepage-body-container" +
  "{" +
  "position: absolute;" +
  "height: " + 1102 * heightK + "px; " +
  "width: 100%; " +
  "top: " + 130 * heightK + "px; " +
  "background-color: white;" +
  "overflow-x: hidden;" +
  "overflow-y: scroll;" +
  "-webkit-overflow-scrolling: touch; " +
  "}",


  pincardBodyContainer: ".pincard-body-container" +
  "{" +
  "position: absolute;" +
  "height: " + 1102 * heightK + "px; " +
  "width: 100%; " +
  "top: " + 130 * heightK + "px; " +
  "background-color: white;" +
  // "overflow-x: hidden;" +
  // "overflow-y: scroll;" +
  // "-webkit-overflow-scrolling: touch; " +
  "}",

  payconfirmBodyContainer: ".payconfirm-body-container" +
  "{" +
  "position: absolute;" +
  "height: " + 1102 * heightK + "px; " +
  "width: 100%; " +
  "top: " + 130 * heightK + "px; " +
  "background-color: white;" +
  // "overflow-x: hidden;" +
  // "overflow-y: scroll;" +
  // "-webkit-overflow-scrolling: touch; " +
  "border-bottom: 1px solid black;" +
  "}",

  componentFirstField: ".component-first-field" +
  "{" +
  "position: absolute;" +
  "opacity: 0.97;" +
  "height: 100%;" +
  "width: 100%;" +
  "z-index: 15;" +
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
  "border-bottom:" + 3 * widthK + "px solid lightgray;" +
  "top: 5%;" +
  "}",

  servicePagePrefixDropdown: ".servicepage-prefix-dropdown" +
  "{" +
  "position: relative;" +
  "width:" + 223 * widthK + "px;" +
  "height: " + 70 * widthK + "px;" +
  "border-bottom:" + 1 * widthK + "px solid lightgray;" +
  "top: 12%;" +
  "float: left;" +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "margin: 0;" +
  "}",

  servicePagePrefixDropdownTextField: ".servicepage-prefix-dropdown-text-field" +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size:" + 54 * widthK + "px;" +
  "top: 16%;" +
  "margin: 0;" +
  "color: #515151;" +
  "width: 92%;" +
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "}",

  servicePagePrefixDropdownIcon: ".servicepage-prefix-dropdown-icon" +
  "{" +
  "position: absolute;" +
  "background-image: url('resources/icons/ViewService/dropdown_icon.png');" +
  "width: 25%;" +
  "height: 36%;" +
  "background-repeat: no-repeat;" +
  "background-size: 65%;" +
  "background-position: center;" +
  "top: 45%;" +
  "left: 80%;" +
  "}",

  servicePageFieldsDropdownCloseButton: ".servicepage-fields-dropdown-close-button " +
  "{" +
  "position: absolute;" +
  "width:" + 144 * widthK + "px;" +
  "height:" + 92 * widthK + "px;" +
  "right:" + -36 * widthK + "px;" +
  "background-image: url('resources/icons/ViewService/close_icon_grey.png');" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 22%;" +
  "background-position-y: center;" +
  "background-position-x:" + 54 * widthK + "px;" +
  "background-size: 22%;" +
  "top: 0;" +
  "}",

  servicePageFieldsDropdownTwo: ".servicepage-fields-dropdown-two" +
  "{" +
  "position: absolute;" +
  "width: 79.5%;" +
  "height: 8%;" +
  "left: 10%;" +
  "top: 12%;" +
  "color: white;" +
  "border-bottom:" + 3 * widthK + "px solid #95e6fd;" +
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
  "width: 79.5%;" +
  "height: 55%;" +
  "top: 22%;" +
  "left:10%;" +
  "overflow: scroll;" +
  "-webkit-overflow-scrolling: touch; " +
  "}",

  servicePageDropdownVariant: ".servicepage-dropdown-variant" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height:" + 125 * widthK + "px;" +
  "background-color: white;" +
  //"margin-left: auto;" +
  //"margin-right: auto;" +
  "margin-bottom:" + 5 * widthK + "px;" +
  "}",

  servicePageFirstField: ".servicepage-first-field" +
  "{" +
  "position: relative;" +
  "left: 10%;" +
  "width: 79.5%;" +
  "height: 10%;" +
  "border-bottom:  " + 3 * widthK + "px solid #01cfff;" +
  "color: white;" +
  "top: 8%;" +
  "}",

  servicePagePhoneField: ".servicepage-phone-field" +
  "{" +
  "position: relative;" +
  "left: 10%;" +
  "width: 79.5%;" +
  "height: 9%;" +
  "border-bottom:" + 3 * widthK + "px solid lightgray;" +
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
  "top: 25%;" +
  "right: -2%;" +
  "}",

  servicePageAmountField: ".servicepage-amount-field" +
  "{position: relative;" +
  "left: 10%;" +
  "width: 79.5%;" +
  "height: 10%;" +
  "border-bottom:  " + 3 * widthK + "px solid lightgray;" +
  "color: white;" +
  "top: 11%" +
  "}",

  servicePageAmountFieldTwo: ".servicepage-amount-field-two" +
  "{position: relative;" +
  "left: 10%;" +
  "width: 79.5%;" +
  "height: 10%;" +
  "border-bottom:  " + 3 * widthK + "px solid lightgray;" +
  "color: white;" +
  "top: 11%;" +
  "}",

  servicePageAmountTaxTextField: ".servicepage-amount-tax-text-field" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 24 * widthK + "px;" +
  "bottom: -55%;" +
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
  "top: 25%;" +
  "font-size: " + 54 * widthK + "px; " +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "margin: 0;" +
  "}",

  servicePageAmountInput: ".servicepage-amount-input" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "top: 25%; " +
  "width: 88%;" +
  "font-size:" + 54 * widthK + "px; " +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "padding: 0;" +
  "margin: 0;" +
  "background-color: transparent;" +
  "}",

  // servicePageAmountInputPlaceHolder: ".servicepage-amount-input::-webkit-input-placeholder" +
  // "{" +
  // "font-size:" + 30 * widthK + "px; " +
  // "color: gainsboro;" +
  // //"line-height:" + 50 * widthK + "px; " +
  // "}",

  inputDefaultPlaceholder: "input::-webkit-input-placeholder" +
  "{" +
  "font-size:" + 30 * widthK + "px;" +
  "color: gainsboro;" +
  "padding: " + 20 * widthK + "px 0 0 0;" +
  "}",

  // "-moz-placeholder { color:#f00; font-size:" + 40 * widthK + "px;}" + /* firefox 19+ */
  // "-ms-input-placeholder { color:#f00; }" + /* ie */
  // "input:-moz-placeholder { color:#f00; font-size:" + 40 * widthK + "px;}" +

  servicePageNumberInputPart: ".servicepage-number-input-part" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "top: 25%;" +
  "padding: 0;" +
  "margin: 0;" +
  "margin-left: 3%;" +
  "width: 57%;" +
  "font-size:" + 54 * widthK + "px; " +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "background-color: transparent;" +
  "}",

  servicePageNumberInputPartPlaceHolder: ".servicepage-number-input-part::-webkit-input-placeholder" +
  "{" +
  "font-size:" + 36 * widthK + "px; " +
  "color: gainsboro;" +
  "padding: " + 20 * widthK + "px 0 0 0;" +
  "}",

  servicePageAmountInputPlaceholder: ".servicepage-amount-input::-webkit-input-placeholder" +
  "{" +
  "font-size:" + 30 * widthK + "px;" +
  "color: #8b8b8b;" +
  "padding: " + 20 * widthK + "px 0 0 0;" +
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
  "background: transparent;" +
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
  "background-color: transparent;" +
  "}",


  servicePagePhoneInput: ".servicepage-phone-input" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "top: 59%;" +
  "font-size: " + 28 * widthK + "px; " +
  "color: #515151;" +
  "}",

  servicePageButtonEnterEnabled: ".servicepage-button-enter-enabled" +
  "{" +
  "position: relative;" +
  "left: 28%;" +
  "width: 44%;" +
  "height: " + 74 * widthK + "px;" +
  "background-color: #00a8f1;" +
  "border-radius: " + 10 * widthK + "px;" +
  "text-transform: capitalize;" +
  "margin-top: " + 20 * widthK + "px;" +
  "top: " + 200 * widthK + "px;" +
  "padding: 0;" +
  "font-size: " + 32 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "color: #ffffff;" +
  "pointer-events: auto;" +
  "}",

  servicePageButtonEnterDisabled: ".servicepage-button-enter-disabled" +
  "{" +
  "position: relative;" +
  "left: 28%;" +
  "width: 44%;" +
  "height: " + 74 * widthK + "px;" +
  "background-color: #D2D2D2;" +
  "border-radius: " + 10 * widthK + "px;" +
  "text-transform: capitalize;" +
  "margin-top: " + 20 * widthK + "px;" +
  "top: " + 200 * widthK + "px;" +
  "padding: 0;" +
  "font-size: " + 32 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "color: #ffffff;" +
  "pointer-events: none;" +
  "}",

  servicePageButtonSave: ".servicepage-button-save" +
  "{" +
  "position: absolute;" +
  "left: 28%;" +
  "width: 44%;" +
  "height: " + 74 * widthK + "px;" +
  "background-color: #D2D2D2;" +
  "border-radius: " + 10 * widthK + "px;" +
  "bottom: " + 55 * widthK + "px; " +
  "font-size: " + 32 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "color: #ffffff;" +
  "border: none;" +
  "outline: none;" +
  "pointer-events: none;" +
  "}",

  servicePageButtonEnterLabel: ".servicepage-button-enter-label" +
  "{" +
  "position: relative;" +
  "top:" + 8 * widthK + "px; " +
  "width: 36%;" +
  "font-size: " + 32 * widthK + "px; " +
  "margin: auto;" +
  "color: white;" +
  "}",

  buttonEnterIcon: ".button-enter-icon" +
  "{" +
  "position: absolute;" +
  "margin-left:" + 458 * widthK + "px;" +
  "background-size: contain;" +
  "background-image: url(resources/icons/authorization/button_arrow.png);" +
  "background-repeat: no-repeat;" +
  "width:" + 56 * widthK + "px;" +
  "height:" + 28 * widthK + "px;" +
  "top:" + 29 * widthK + "px;" +
  "transition: 0.8s;" +
  "}",

  servicePageButtonBack: ".servicepage-button-back" +
  "{" +
  "position: absolute;" +
  "width: " + 87 * widthK + "px; " +
  "height: " + 87 * widthK + "px; " +
  "background-image: url('resources/icons/back/back.png');" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 50%;" +
  "background-position-y: center;" +
  "background-position-x: center;" +
  "background-size: 50%;" +
  "left: 1.5%;" +
  "}",

  servicePageFormTypeTwoContainer: ".servicepage-formtype-two-container" +
  "{" +
  "position: absolute;" +
  "height: " + 1102 * heightK + "px; " +
  "width: " + 720 * widthK + "px; " +
  "top: " + 130 * heightK + "px; " +
  "background-color: white;" +
  "}",


  servicePagePincardsContainerTwo: ".servicepage-pincards-container-two" +
  "{" +
  "position: absolute;" +
  "height: " + 760 * heightK + "px; " +
  "width: " + 720 * widthK + "px; " +
  "top: 15%;" +
  "overflow-x: hidden;" +
  "overflow-y: scroll;" +
  "-webkit-overflow-scrolling: touch; " +
  "}",

  servicePagePincardsContainer: ".servicepage-pincards-container" +
  "{" +
  "position: absolute;" +
  "height: " + 920 * heightK + "px; " +
  "width: " + 720 * widthK + "px; " +
  "overflow-x: hidden;" +
  "overflow-y: scroll;" +
  "-webkit-overflow-scrolling: touch; " +
  "}",

  servicePagePincardsBlockContainer: ".servicepage-pincards-block-container" +
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

  servicePagePincardRadioUnselected: ".servicepage-pincard-radio-unselected" +
  "{" +
  "position: absolute;" +
  "background-image: url('resources/icons/ViewService/radio_unselected.png');" +
  "width: 5%;" +
  "height: 45%;" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "background-position: center;" +
  "top: 31%;" +
  "left: 94%;" +
  "}",

  servicePagePincardRadioSelected: ".servicepage-pincard-radio-selected" +
  "{" +
  "position: absolute;" +
  "background-image: url('resources/icons/ViewService/radio_selected.png');" +
  "width: 5%;" +
  "height: 45%;" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "background-position: center;" +
  "top: 31%;" +
  "left: 94%;" +
  "}",

  servicePageSecondDropdownField: ".servicepage-second-dropdown-field" +
  "{" +
  "position: relative;" +
  "width: 79.5%;" +
  "height: 8%;" +
  "left: 10%;" +
  "color: white;" +
  "border-bottom:  " + 3 * widthK + "px solid lightgray;" +
  "top: 5%;" +
  "}",

  servicePageSecondDropdownFieldPakety: ".servicepage-second-dropdown-field-pakety" +
  "{" +
  "position: relative;" +
  "width: 79.5%;" +
  "height: 8%;" +
  "left: 10%;" +
  "color: white;" +
  "border-bottom:  " + 3 * widthK + "px solid lightgray;" +
  "top: 12%;" +
  "}",

  servicePageSecondDropdownFieldText: ".servicepage-second-dropdown-field-text" +
  "{" +
  "bottom: 75%;" +
  "font-size:" + 23 * widthK + "px;" +
  "}",

  servicePageSecondDropdownFieldDifTop: ".servicepage-second-dropdown-field-diftop" +
  "{" +
  "position: relative;" +
  "width: 79.5%;" +
  "height: 8%;" +
  "left: 10%;" +
  "color: white;" +
  "border-bottom:  " + 3 * widthK + "px solid lightgray;" +
  "top: 6%;" +
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

  componentCalc: ".component-calc" +
  "{" +
  "position: absolute;" +
  "opacity: 0.97;" +
  "height: 100%;" +
  "width: 100%;" +
  "z-index: 15;" +
  "background-color: #f0f1f4;" +
  //"display: none;" +
  "}",

  componentCalcNameTitle: ".component-calc-name-title " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size:" + 35 * widthK + "px;" +
  "left: 8%;" +
  "top: 14%;" +
  "margin: 0;" +
  "color: #353340;" +
  "}",

  componentCalcFieldsContainer: ".component-calc-fields-container" +
  "{" +
  "position: absolute;" +
  "height: 50%;" +
  "width: 100%;" +
  "top: 20%;" +
  "}",

  componentCalcFirstField: ".component-calc-first-field" +
  "{" +
  "position: absolute;" +
  "left: 8%;" +
  "width: 85%;" +
  "height:" + 90 * widthK + "px;" +
  "border-bottom:" + 3 * widthK + "px solid #01cfff;" +
  "color: white;" +
  "top: 8%;" +
  "}",

  componentCalcFirstFieldText: ".component-calc-first-field-text" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 24 * widthK + "px;" +
  "top: -14%;" +
  "}",

  componentCalcFirstFieldInputPart: ".component-calc-first-field-input-part" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "top: 28%;" +
  "left: 0%;" +
  "margin: 0%;" +
  "padding: 0;" +
  "font-size:" + 42 * widthK + "px;" +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "background-color: transparent" +
  "}",

  componentCalcCurrencyText: ".component-calc-currency-text" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 24 * widthK + "px;" +
  "top: 27%;" +
  "left: 8%;" +
  "}",

  componentCalcSecondField: ".component-calc-second-field" +
  "{" +
  "position: absolute;" +
  "left: 8%;" +
  "width: 85%;" +
  "height:" + 90 * widthK + "px;" +
  "border-bottom:" + 3 * widthK + "px solid #01cfff;" +
  "color: white;" +
  "top: 40%;" +
  "}",

  componentCalcSecondFieldText: ".component-calc-second-field-text" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 24 * widthK + "px;" +
  "top: -14%;" +
  "}",

  componentCalcSecondFieldInputPart: ".component-calc-second-field-input-part" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "top: 28%;" +
  "left: 0%;" +
  "margin: 0%;" +
  "padding: 0;" +
  "font-size:" + 42 * widthK + "px;" +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "background-color: transparent" +
  "}",

  componentCalcButtonsContainer: ".component-calc-buttons-container" +
  "{" +
  "position: absolute;" +
  "height:" + 230 * widthK + "px;" +
  "width: 100%;" +
  "top: 67%;" +
  "}",

  componentCalcButton: ".component-calc-button" +
  "{" +
  "position: relative;" +
  "height:" + 74 * widthK + "px;" +
  "width: 34%;" +
  "display: table;" +
  "background-color: #01b9ff;" +
  "border-radius:" + 5 * widthK + "px;" +
  "float: left;" +
  "left:11%;" +
  "margin-right: 8%;" +
  "}",

  componentCalcButtonLabel: ".component-calc-button-label" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "font-size:" + 28 * widthK + "px;" +
  "color: #ffffff;" +
  "text-align: center;" +
  "display: table-cell;" +
  "vertical-align: middle;" +
  "}",

  componentCalcCancelButton: ".component-calc-cancel-button" +
  "{" +
  "background-color: white;" +
  "}",

  componentCalcCancelButtonLabel: ".component-calc-cancel-button-label" +
  "{" +
  "color: #c1c1c1;" +
  "}",

  //VIEW PINCARD


  pincardPayfromContainer: ".pincard-payfrom-container" +
  "{" +
  "position: relative;" +
  "background-color: transparent;" +
  "width: 100%;" +
  "height: 7.5%;" +
  // "border-bottom: 1px solid lightgray;" +
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
  "height:51%;" +
  "top: 7.5%;" +
  "background-color: transparent;" +
  "overflow-x: hidden;" +
  "overflow-y: scroll;" +
  "-webkit-overflow-scrolling: touch;" +
  "}",

  pincardAllcardsTransparentBlock: ".pincard-allcards-transparent-block" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 8%;" +
  "top: 51%;" +
  "background-image: url(resources/icons/pinCard/cardBorder.png);" +
  "background-size: cover;" +
  "background-repeat: no-repeat;" +
  "}",

  pincardCardContainer: ".pincard-card-container" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: " + 162 * widthK + "px; " +
  "background-color: transparent;" +
  // "border-bottom:  " + 1 + "px solid lightgray;" +
  "}",

  pincardCardLogoContainer: ".pincard-card-logo-container" +
  "{" +
  "width: 25%;" +
  "height: 67%;" +
  "top: 17%;" +
  "left: 5%;" +
  "background-color: transparent;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: contain;" +
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

  pincardCardBalanceFractional: ".pincard-card-balance-fractional" +
  "{" +
  "font-size: " + 34 * widthK + "px; " +
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
  "background-size: 30%;" +
  "background-image: url(resources/icons/ViewService/radio_selected.png);" +
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
  "background-size: 30%;" +
  "background-image: url(resources/icons/ViewService/radio_unselected.png);" +
  "}",

  pincardFriendHelpContainer: ".pincard-friend-help-container" +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "height: 50%;" +
  "top: 3%;" +
  //"bottom:0;" +
  //"background-color: grey;" +
  //"border-bottom:  " + 1 + "px solid lightgray;" +
  "left: 25%;" +
  "}",

  pincardFriendHelpText: ".pincard-friend-help-text" +
  "{" +
  "top: 65%;" +
  "position: relative;" +
  // "left: 23%;" +
  "color: rgb(1, 124, 227);" +
  "font-size: " + 29 * widthK + "px; " +
  "text-align: center;" +
  "text-decoration: underline;" +
  "}",

  pincardFriendHelpIcon: ".pincard-friend-help-icon" +
  "{" +
  "width: 40%;" +
  "height: 67%;" +
  "background-color: transparent;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: 65%;" +
  "float: left;" +
  "right: 30%;" +
  "position: absolute;" +
  "background-image: url(resources/icons/ViewService/friend.png);" +
  "}",

  pincardChosenFriendContainer: ".pincard-chosen-friend-container" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height:55%;" +
  //"background-color: grey;" +
  //"left: 10%;" +
  //"top:" + 165 * widthK + "px;" +
  "}",

  pincardFriendHelpTextTwo: ".pincard-friend-help-text-two" +
  "{" +
  //"top: 65%;" +
  "position: absolute;" +
  "left: 9%;" +
  "color: grey;" +
  "font-size: " + 29 * widthK + "px; " +
  "text-align: center;" +
  //"text-decoration: underline;" +
  "}",

  pincardFriendChangeText: ".pincard-friend-change-text" +
  "{" +
  "top: 80%;" +
  "position: absolute;" +
  "left: 40%;" +
  "color: rgb(1, 124, 227);" +
  "font-size: " + 29 * widthK + "px; " +
  "text-align: center;" +
  "text-decoration: underline;" +
  "}",

  pincardChosenFriendInnerContainer: ".pincard-chosen-friend-inner-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 130 * widthK + "px;" +
  "background-color: #F0F1F4;" +
  // "left: 10%;" +
  "top:22%;" +
  "}",

  pincardChosenFriendPhoto: ".pincard-chosen-friend-photo" +
  "{" +
  "top:" + 21 * widthK + "px;" +
  "position: absolute;" +
  "width:" + 85 * widthK + "px;" +
  "height:" + 85 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-size: cover;" +
  "background-position: center;" +
  "border-radius: 50%;" +
  "text-align: center;" +
  "line-height:" + 85 * widthK + "px;" +
  "font-size:" + 50 * widthK + "px;" +
  "background-color: #027fe3;" +
  "color: white;" +
  "left: 12%;" +
  "}",

  pincardChosenFriendTextContainer: ".pincard-chosen-friend-text-container" +
  "{" +
  "position: absolute;" +
  "left: 36%;" +
  "color: gray;" +
  "width: 38%;" +
  "height: 100%;" +
  "display: table;" +
  "}",


  pincardChosenFriendTextOne: ".pincard-chosen-friend-text-one" +
  "{" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 27 * widthK + "px;" +
  "display: table-cell;" +
  "vertical-align: middle;" +
  "position: absolute;" +
  "top: 15%;" +
  "font-weight: bold;" +
  "width: 100%;" +
  "height: 48%;" +
  "overflow: hidden;" +
  "line-height: 30px;" +
  "}",

  pincardChosenFriendTextTwo: ".pincard-chosen-friend-text-two" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  // "left: 60%;" +
  "color: gray;" +
  "font-size:" + 23 * widthK + "px;" +
  "top: 60%;" +
  "}",

  pincardChosenFriendEditIcon: ".pincard-chosen-friend-edit-icon" +
  "{" +
  "position: absolute;" +
  "right: 14%;" +
  "width: 10%;" +
  "height: 100%;" +
  "background-repeat: no-repeat;" +
  "background-size: 44%;" +
  "background-position: center;" +
  "background-image: url(resources/icons/ViewService/edit.png);" +
  "}",

  pincardChosenFriendRadioIcon: ".pincard-chosen-friend-radio-icon" +
  "{" +
  "position: absolute;" +
  "right: 5%;" +
  "width: 10%;" +
  "height: 100%;" +
  "background-repeat: no-repeat;" +
  "background-size: 46%;" +
  "background-position: center;" +
  "background-image: url(resources/icons/ViewService/radio_selected.png);" +
  "}",


  pincardBottomContainer: ".pincard-bottom-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  //"height: 46%;" +
  "top: 62%;" +
  "bottom:0;" +
  "background-color: transparent;" +
  "border-bottom:  " + 1 + "px solid lightgray;" +
  // "overflow-y: scroll;" +
  // "overflow-x: hidden;" +
  // "-webkit-overflow-scrolling: touch; " +
  "}",

  pincardButtonEnter: " .pincard-button-enter" +
  "{" +
  //"top: " + 230 * heightK + "px;" +
  "height: " + 74 * widthK + "px;" +
  "margin: 3% auto 0 auto;" +
  "background-color: #00a8f1;" +
  "padding: 0;" +
  "font-size: " + 32 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "left: 28%;" +
  "width: 44%;" +
  "border-radius: " + 10 * widthK + "px;" +
  "color: #ffffff;" +
  "}",

  pincardButtonEnterLabel: ".pincard-button-enter-label" +
  "{" +
  "position: relative;" +
  "top: " + 10 * widthK + "px; " +
  "width: 36%;" +
  "font-size: " + 32 * widthK + "px; " +
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
  // "border-bottom: 1px solid lightgray;" +
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

  payconfirmCategoryField: ".payconfirm-category-input" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left: 8%;" +
  "top: 47%;" +
  "font-size: " + 40 * widthK + "px; " +
  "color: gray;" +
  "text-decoration: underline" +
  "}",

  payconfirmField: ".payconfirm-field" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: 22.5%;" +
  // "border-bottom:  " + 1 + "px solid lightgray;" +
  "color: white;" +
  //"top: 23%;" +
  "}",

  payconfirmAmountField: ".payconfirm-amount-field" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: 24.5%;" +
  // "border-bottom:  " + 1 + "px solid lightgray;" +
  "color: white;" +
  //"top: 23%;" +
  "}",

  payconfirmAmountTextField: ".payconfirm-amount-text-field" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "color: darkgray;" +
  "font-size: " + 24 * widthK + "px; " +
  "left: 8%;" +
  "top: 15%;" +
  "}",

  payconfirmAmountValue: ".payconfirm-amount-value" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "left: 8%;" +
  "top: 12%;" +
  "font-size: " + 40 * widthK + "px; " +
  "color: gray;" +
  "}",

  payconfirmAmountTaxField: ".payconfirm-amount-tax-field" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "color: darkgray;" +
  "font-size: " + 24 * widthK + "px; " +
  "left: 8%;" +
  "top: 8%;" +
  "}",

  payconfirmAmountCountField: ".payconfirm-amount-count-field" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "color: darkgray;" +
  "font-size: " + 24 * widthK + "px; " +
  "left: 8%;" +
  "top: 8%;" +
  "}",

  payconfirmCardField: ".payconfirm-card-field" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: 32%;" +
  // "border-bottom:1px solid lightgray;" +
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
  "width: 90%;" +
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
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
  "width: 25%;" +
  "height: 67%;" +
  "left: 70%;" +
  "top: 15%;" +
  "background-color: transparent;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: contain;" +
  "float: left;" +
  "}",

  payconfirmChosenFriendPhoto: ".payconfirm-chosen-friend-photo" +
  "{" +
  "top:" + 40 * widthK + "px;" +
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
  "right: 10%;" +
  "}",


  payconfirmBottomContainer: ".payconfirm-bottom-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "top: 60%;" +
  "bottom: 0;" +
  "background-color: transparent;" +
  "border-bottom:  1px solid lightgray;" +
  "overflow: hidden;" +
  "}",

  payconfirmActionAutoPayContainer: ".payconfirm-action-autopay-container" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: " + 290 * widthK + "px;" +
  "}",

  payconfirmActionContainer: ".payconfirm-action-containter" +
  "{" +
  "position: relative;" +
  "float: left;" +
  "width: 50%;" +
  "top: 9%;" +
  "height: 60%;" +
  "background-color: transparent;" +
  "margin: auto;" +
  "}",

  payconfirmActionContainerAutoPayNone: ".payconfirm-action-containter-autopay-none" +
  "{" +
  "position: relative;" +
  "float: left;" +
  "width: 50%;" +
  "top: 9%;" +
  "height: 60%;" +
  "background-color: transparent;" +
  "display: none;" +
  "}",

  payconfirmActionContainerFavoriteCenter: ".payconfirm-action-containter-favorite-center" +
  "{" +
  "position: relative;" +
  //"float: left;" +
  "width: 50%;" +
  "top: 9%;" +
  "height: 60%;" +
  "background-color: transparent;" +
  "margin: auto;" +
  "}",

  payconfirmActionIconOne: ".payconfirm-action-icon-one" +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "height: 50%;" +
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
  "height: 50%;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "left: 25%;" +
  "top: 14%;" +
  "background-size: 41%;" +
  "}",

  payconfirmActionText: ".payconfirm-action-text" +
  "{" +
  "top: 30%;" +
  "left: 1%;" +
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
  "height: " + 74 * widthK + "px;" +
  "text-transform: capitalize;" +
  "position: relative;" +
  "background-color: #00a8f1;" +
  "padding: 0;" +
  "font-size: " + 32 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "left: 28%;" +
  "width: 44%;" +
  "border-radius: " + 10 * widthK + "px;" +
  "color: #ffffff;" +
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

  payconfirmButtonDelete: ".payconfirm-button-delete" +
  "{" +
  "height: " + 74 * widthK + "px;" +
  "text-transform: capitalize;" +
  "position: absolute;" +
  "background-color: #ee4d3d;" +
  "padding: 0;" +
  "font-size: " + 32 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "left: 28%;" +
  "width: 44%;" +
  "border-radius: " + 10 * widthK + "px;" +
  "color: #ffffff;" +
  "bottom:" + 100 * widthK + "px;" +
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
  "z-index: 9999;" +
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
  "position: absolute;" +
  "width:" + 36 * widthK + "px;" +
  "height:" + 37 * widthK + "px;" +
  "left: 5.5%;" +
  "top: 29%;" +
  "background-repeat: no-repeat;" +
  "float: left;" +
  "background-image: url(resources/icons/search/search_white.png);" +
  "background-position: center;" +
  "background-size: 100%;" +
  "}",

  searchTitleName: ".search-title-name " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "margin-top:" + 25 * widthK + "px;" +
  "font-size:" + 35 * widthK + "px;" +
  "left: 13%;" +
  "color: white;" +
  "}",

  searchCancelIcon: ".search-cancel-icon " +
  "{" +
  "position: absolute;" +
  "right: 4.5%;" +
  "width:" + 87 * widthK + "px;" +
  "height:" + 87 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-image: url(resources/icons/search/close.png);" +
  "-webkit-background-size: 40%;" +
  "background-position-y: center;" +
  "background-position-x: center;" +
  "background-size: 40%;" +
  "z-index: 1;" +
  "}",

  searchInput: ".search-input " +
  "{" +
  "position: absolute;" +
  "font-family: 'SFUIDisplay-Light';" +
  "font-size:" + 32 * widthK + "px;" +
  "background: none;" +
  "border: none;" +
  "border-bottom:" + 3 * widthK + "px solid #a3deee;" +
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
  "border-bottom:" + 3 * widthK + "px solid rgb(149, 230, 253);" +
  "}",

  mycardlistAddButton: ".add-button " +
  "{" +
  "position: absolute;" +
  "width:" + 87 * widthK + "px;" +
  "height:" + 87 * widthK + "px;" +
  "right: 2.5%;" +
  "background-image: url(resources/icons/ViewSettingsFriendHelp/plus.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 50%;" +
  "background-position-y: center;" +
  "background-position-x: center;" +
  "background-size: 50%;" +
  "top: 5%" +
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
  "background-color: white;" +
  "width: 100%;" +
  "height: 92%;" +
  "top:" + 87 * widthK + "px;" +
  "bottom: 0;" +
  "overflow-y:scroll;" +
  "overflow-x:hidden;" +
  "-webkit-overflow-scrolling: touch; " +
  "}",

  myCardListCard: ".mycardlist-card" +
  "{" +
  "background-image: url(resources/icons/cards/all.png);" +
  "height: " + 188 * widthK + "px;" +
  "width: " + 327 * widthK + "px;" +
  "position: relative;" +
  "top: " + 13 * widthK + "px;" +
  "-webkit-border-radius:" + 10 * widthK + "px;" +
  "-moz-border-radius:" + 10 * widthK + "px;" +
  "border-radius:" + 10 * widthK + "px;" +
  "background-size: cover;" +
  "color: white;" +
  //"-webkit-box-shadow: 0px 50px 50px -50px rgba(0,0,0,1);" +
  //"-moz-box-shadow: 0px 50px 50px -50px rgba(0,0,0,1);" +
  //"box-shadow: 0px 50px 50px -50px rgba(0,0,0,1);" +
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
  "background-size: contain;" +
  "font-size:" + 17 * widthK + "px;" +
  "height: 10%;" +
  "overflow: hidden;" +
  "width: 90%;" +
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
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
  "font-size:" + 33 * widthK + "px;" +
  "margin: 0;" +
  "float: left;" +
  "padding: 0;" +
  "overflow: hidden;" +
  "max-width: 50%;" +
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
  "}",

  myCardListcardBalanceFractional: ".mycardlist-card-balance-fractional " +
  "{" +
  "font-size:" + 27 * widthK + "px;" +
  "}",

  myCardListcardCurrency: ".mycardlist-card-currency " +
  "{" +
  "position: relative;" +
  "left: 6%;" +
  "top: 32%;" +
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
  "font-size:" + 18 * widthK + "px;" +
  // "text-shadow: white -1px -1px 0.4px, black 0.0px 1px 0.2px, white -1px -1px 0.4px, black 0.0px 1px 0.4px;" +
  // "-webkit-text-shadow: white -1px -1px 0.4px, black 0.0px 1px 0.2px, white -1px -1px 0.4px, black 0.0px 1px 0.4px;" +
  "font-family: 'OCRAStd';" +
  // "color: transparent;" +
  "left:5%" +
  "}",

  myCardListcardNumberPartOne: ".mycardlist-card-number-part-one " +
  "{" +
  "position: absolute;" +
  "left: 0px;" +
  // "font-weight: bold;" +
  "}",

  myCardListcardNumberMiddleTwo: ".mycardlist-card-number-middle-two " +
  "{" +
  "position: absolute;" +
  "left: 19%;" +
  // "font-weight: bold;" +
  "}",

  myCardListcardNumberPartTwo: ".mycardlist-card-number-part-two " +
  "{" +
  "position: absolute;" +
  "left:58%;" +
  // "font-weight: bold;" +
  "}",

  myCardListnumberStars: ".mycardlist-number-stars " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left: 27%;" +
  // "letter-spacing:" + -8 * widthK + "px;" +
  "font-size:" + 18 * widthK + "px;" +
  "}",

  //VIEW TRANSFER

  transferBlockContainer: ".transfer-block-container" +
  "{" +
  "position: relative;" +
  "min-height:" + 100 * widthK + "px; " +
  "width: 100%;" +
  "padding-top: 1%;" +
  "border-bottom:" + 1 + "px solid gainsboro;" +
  "background-color: transparent;" +
  "}",

  transferCategoryIcon: ".transfer-category-icon" +
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

  transferCategoryNameField: ".transfer-category-name-field" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "top: " + 31 * widthK + "px; " +
  "left: 6%;" +
  "text-align: left;" +
  "font-size:" + 29 * widthK + "px; " +
  "color: gray;" +
  "}",

  transferIconTick: ".transfer-icon-tick " +
  "{" +
  "position: relative;" +
  "left: 91%;" +
  "background-size: contain;" +
  "background-image: url(resources/icons/ViewService/right.png);" +
  "background-repeat: no-repeat;" +
  "width:" + 19 * widthK + "px;" +
  "height:" + 18 * widthK + "px;" +
  "top:" + 9 * widthK + "px;" +
  "}",

  transferBetweenCardsTitle: ".transfer-between-cards-title" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 32 * widthK + "px;" +
  "}",

  transferBetweenCardsComission: ".transfer-between-cards-commission" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 32 * widthK + "px;" +
  "right:" + 6 * widthK + "px;" +
  "bottom: -" + 52 * widthK + "px;" +
  "}",

  transferBetweenCardsSumContainer: ".transfer-between-cards-sum-container" +
  "{" +
  "position: relative;" +
  "left: 10%;" +
  "width: 79.5%;" +
  "height:" + 130 * widthK + "px;" +
  "border-bottom:" + 3 * widthK + "px solid #01cfff;" +
  "color: white;" +
  "top:" + 52 * widthK + "px;" +
  "}",

  transferBetweenCardsCardsContainer: ".transfer-between-cards-cards-container" +
  "{" +
  "position: relative;" +
  "left: 10%;" +
  "width: 79.5%;" +
  "height:" + 130 * widthK + "px;" +
  "color: white;" +
  "top:" + 52 * widthK + "px;" +
  "}",

  transferBetweenCardsFromContainer: ".transfer-between-cards-from-to-container" +
  "{" +
  "position: relative;" +
  "width: 79.5%;" +
  "height:" + 130 * widthK + "px;" +
  "color: white;" +
  "top:" + 52 * widthK + "px;" +
  "}",

  transferBetweenCardsSumInput: ".transfer-between-cards-sum-input" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "top:" + 10 * widthK + "px;" +
  "padding: 0;" +
  "margin: 0;" +
  "font-size:" + 55 * widthK + "px;" +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "}",

  transferBetweenCardsArrowDown: ".transfer-between-cards-arrow-down" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "margin: auto;" +
  "height:" + 32 * widthK + "px;" +
  "width:" + 30 * widthK + "px;" +
  "background-image: url('resources/icons/ViewTransfer/banks_limit_receipt.png');" +
  "}",

  transferBodyContainer: ".transfer-body-container" +
  "{" +
  "position: absolute;" +
  "bottom: 0;" +
  "width: 100%;" +
  "top:" + 87 * widthK + "px;" +
  "background-color: white;" +
  "overflow: hidden;" +
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
  "height: 88%;" +
  "width: 30%;" +
  "left: 18%;" +
  "background-color: transparent;" +
  "}",

  transferNewMenuItem: ".transfer-new-menu-item" +
  "{" +
  "width: 33.33%;" +
  "height: 100%;" +
  "float: left;" +
  "font-size:" + 27 * widthK + "px;" +
  "}",

  transferNewMenuContainer: ".transfer-new-menu-container" +
  "{" +
  "position: absolute;" +
  "height:" + 155 * widthK + "px;" +
  "width: 100%;" +
  "top: 0;" +
  "z-index: 10;" +
  "background-color: white;" +
  "-webkit-box-shadow: 0 8px 40px 8px rgba(0,0,0, .05);" +
  "-moz-box-shadow: 0 8px 40px 8px rgba(0,0,0, .05);" +
  "box-shadow: 0 8px 40px 8px rgba(0,0,0, .05);" +
  "}",

  transferNewContactPhoneField: ".transfer-new-contact-phone-field" +
  "{" +
  "position: relative;" +
  "left: 10%;" +
  "width: 81%;" +
  "height:" + 130 * widthK + "px;" +
  // "border-bottom:" + 3 * widthK + "px solid #01cfff;" +
  "color: white;" +
  "padding-top: 8%;" +
  "}",

  transferCardOwnerContainer: ".transfer-card-owner-container " +
  "{" +
  "position: relative;" +
  "width: 90%;" +
  "height: 20%;" +
  "top: 33%;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "border-bottom: 1px solid lightgrey;" +
  "border-top: 1px solid lightgrey;" +
  "}",

  transferCardOwnerTitle: ".transfer-card-owner-title " +
  "{" +
  "position: absolute;" +
  "top: 18%;" +
  "left: 5.5%;" +
  "font-size:" + 25 * widthK + "px;" +
  "color: #c1c1c1;" +
  "margin: 0;" +
  "text-align: center;" +
  "}",

  transferCardOwnerInfo: ".transfer-card-owner-info " +
  "{" +
  "position: absolute;" +
  "top: 43%;" +
  "left: 6%;" +
  "font-size:" + 30 * widthK + "px;" +
  "color: #c1c1c1;" +
  "margin: 0;" +
  "text-align: center;" +
  "color: #626062;" +
  "}",

  transferMenuContainerCard: ".transfer-menu-container-card" +
  "{" +
  "position: absolute;" +
  "height: 88%;" +
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

  transferNewMenuLabelContact: ".transfer-new-menu-label-contact" +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "left: 4%;" +
  "margin-top:" + 12 * widthK + "px;" +
  "width:" + 190 * widthK + "px;" +
  "text-align: center;" +
  "word-wrap: break-word;" +
  "margin-bottom: 0;" +
  "}",

  transferNewMenuLabelCard: ".transfer-new-menu-label-card" +
  "{" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "margin-top:" + 14 * widthK + "px;" +
  "width:" + 115 * widthK + "px;" +
  "text-align: center;" +
  "word-wrap: break-word;" +
  "margin-bottom: 0;" +
  "}",

  transferNewMenuLabelBetween: ".transfer-new-menu-label-between" +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "right: 5%;" +
  "margin-top:" + 10 * widthK + "px;" +
  "width:" + 187 * widthK + "px;" +
  "text-align: center;" +
  "word-wrap: break-word;" +
  "margin-bottom: 0;" +
  "}",

  transferNewContactPhoneIcon: ".transfer-new-contact-phone-icon" +
  "{" +
  "position: absolute;" +
  "background-image: url('resources/icons/ViewTransfer/phonebook.png');" +
  "width: 13%;" +
  "height: 50%;" +
  "background-repeat: no-repeat;" +
  "background-size:" + 42 * widthK + "px;" +
  "background-position: center;" +
  "top: 56%;" +
  "right: -2%;" +
  "}",

  transferNewContactPhoneBottom: ".transfer-new-contact-phone-bottom" +
  "{" +
  "position: relative;" +
  "width: 85%;" +
  "border-bottom:" + 3 * widthK + "px solid #01cfff;" +
  "top:" + 16 * widthK + "px;" +
  "}",

  transferNewContactTextField: ".transfer-new-contact-text-field" +
  "{" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 32 * widthK + "px;" +
  "}",

  transferNewContactNumberFirstPart: ".transfer-new-contact-number-first-part" +
  "{" +
  "float: left;" +
  "position: relative;" +
  "margin-top: 3%;" +
  "margin-bottom: 0;" +
  "font-size:" + 51 * widthK + "px;" +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "}",

  transferNewMenuContactIcon: ".transfer-new-menu-contact-icon" +
  "{" +
  "position: relative;" +
  "height:" + 51 * widthK + "px;" +
  "width:" + 62 * widthK + "px;" +
  "left: 3%;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "margin-top:" + 12 * widthK + "px;" +
  "background: transparent;" +
  "background-repeat: no-repeat;" +
  "background-size:" + 61 * widthK + "px;" +
  "background-position: center;" +
  "}",

  transferNewMenuBorderRight: ".transfer-new-menu-border-right" +
  "{" +
  "position: absolute;" +
  "height: 80%;" +
  "width: 33.31%;" +
  "top: 10%;" +
  "border-right:" + 1 * widthK + "px solid #e8e8e8;" +
  "background: transparent;" +
  "}",

  transferNewMenuBorderLeft: ".transfer-new-menu-border-left" +
  "{" +
  "position: absolute;" +
  "height: 80%;" +
  "width: 33.31%;" +
  "top: 10%;" +
  "left: 66.66%;" +
  "border-left:" + 1 * widthK + "px solid #e8e8e8;" +
  "background: transparent;" +
  "}",

  transferNewMenuContactIconImg1: ".transfer-new-menu-contact-icon-img-1" +
  "{" +
  "position: relative;" +
  "height:" + 51 * widthK + "px;" +
  "width:" + 62 * widthK + "px;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "background: transparent;" +
  "background-repeat: no-repeat;" +
  "background-size:" + 61 * widthK + "px;" +
  "background-position: center;" +
  "}",

  transferNewMenuContactIconImg2: ".transfer-new-menu-contact-icon-img-2" +
  "{" +
  "position: absolute;" +
  "height:" + 51 * widthK + "px;" +
  "width:" + 62 * widthK + "px;" +
  "margin-top:-" + 58 * widthK + "px;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "background: transparent;" +
  "background-repeat: no-repeat;" +
  "background-size:" + 61 * widthK + "px;" +
  "background-position: center;" +
  "}",

  transferNewMenuCardIcon: ".transfer-new-menu-card-icon" +
  "{" +
  "position: relative;" +
  "height:" + 43 * widthK + "px;" +
  "width:" + 61 * widthK + "px;" +
  "margin-top:" + 18 * widthK + "px;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "background: transparent;" +
  "background-repeat: no-repeat;" +
  "background-size:" + 58 * widthK + "px;" +
  "background-position: center;" +
  "}",

  transferNewMenuCardIconImg1: ".transfer-new-menu-card-icon-img-1" +
  "{" +
  "position: relative;" +
  "height:" + 43 * widthK + "px;" +
  "width:" + 61 * widthK + "px;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "background: transparent;" +
  "background-repeat: no-repeat;" +
  "background-size:" + 58 * widthK + "px;" +
  "background-position: center;" +
  "}",


  transferNewMenuCardIconImg2: ".transfer-new-menu-card-icon-img-2" +
  "{" +
  "position: absolute;" +
  "height:" + 43 * widthK + "px;" +
  "width:" + 61 * widthK + "px;" +
  "margin-top: -" + 49 * widthK + "px;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "background: transparent;" +
  "background-repeat: no-repeat;" +
  "background-size:" + 58 * widthK + "px;" +
  "background-position: center;" +
  "}",

  transferNewMenuBetweenIcon: ".transfer-new-menu-between-icon" +
  "{" +
  "position: relative;" +
  "height:" + 53 * widthK + "px;" +
  "width:" + 52 * widthK + "px;" +
  "right: 5%;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "margin-top:" + 12 * widthK + "px;" +
  "background: transparent;" +
  "background-repeat: no-repeat;" +
  "background-size:" + 50 * widthK + "px;" +
  "background-position: center;" +
  "}",

  transferNewMenuBetweenIconImg1: ".transfer-new-menu-between-icon-img-1" +
  "{" +
  "position: relative;" +
  "height:" + 53 * widthK + "px;" +
  "width:" + 52 * widthK + "px;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "background: transparent;" +
  "background-repeat: no-repeat;" +
  "background-size:" + 50 * widthK + "px;" +
  "background-position: center;" +
  "}",

  transferNewMenuBetweenIconImg2: ".transfer-new-menu-between-icon-img-2" +
  "{" +
  "position: absolute;" +
  "height:" + 53 * widthK + "px;" +
  "width:" + 52 * widthK + "px;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "margin-top: -" + 60 * widthK + "px;" +
  "background: transparent;" +
  "background-repeat: no-repeat;" +
  "background-size:" + 50 * widthK + "px;" +
  "background-position: center;" +
  "}",

  transferNewButtonContainer: ".bottom-button-container" +
  "{" +
  "height: " + 87 * widthK + "px;" +
  "font-size: " + 38 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "position: absolute;" +
  "width: 100%;" +
  "background-color: #00a8f1;" +
  "background: -moz-linear-gradient(left, #00a8f1 20%, #76c1f4);" +
  "background: -webkit-linear-gradient(left, #00a8f1 20%, #76c1f4);" +
  "background: -ms-linear-gradient(left, #00a8f1 20%, #76c1f4);" +
  "bottom: 0;" +
  "padding: 0;" +
  "left: 0;" +
  "color: #ffffff;" +
  "}",

  transferNewSubmitButtonContainer: ".transfer-new-submit-button-container" +
  "{" +
  "height: " + 87 * widthK + "px;" +
  "font-size: " + 38 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "position: absolute;" +
  "width: 100%;" +
  "background-color: #9ACF65;" +
  "bottom: 0;" +
  "padding: 0;" +
  "color: #ffffff;" +
  "left: 0;" +
  "}",

  transferNewSubmitButtonIcon: ".transfer-new-submit-button-icon" +
  "{" +
  "height: " + 22 * widthK + "px;" +
  "width: " + 32 * widthK + "px;" +
  "top: " + 32.5 * widthK + "px;" +
  // "float: left;" +
  "position: absolute;" +
  "margin-left:" + 99 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-size: cover;" +
  "background-position: center;" +
  "background-image: url('resources/icons/ViewTransfer/check_mark_submit.png');" +
  "}",

  transferNewSubmitButtonText: ".transfer-new-submit-button-text" +
  "{" +
  // "float: left;" +
  "position: absolute;" +
  "margin-left:" + 183 * widthK + "px;" +
  "margin-top:" + 24 * widthK + "px;" +
  "top: 0;" +
  "}",

  transferNewContactNumberInputPart: ".transfer-new-contact-number-input-part" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "padding: 0;" +
  "margin: 0;" +
  "margin-left: 3%;" +
  "margin-top: 3%;" +
  "width: 65%;" +
  "font-size:" + 51 * widthK + "px;" +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "}",

  transferNewContactSuggestion: ".transfer-new-contact-suggestion" +
  "{" +
  "width: 79.5%;" +
  "position: relative;" +
  "height:" + 120 * widthK + "px;" +
  "background-color: #F0F1F4;" +
  "left: 10%;" +
  "margin-top:" + 5 * widthK + "px;" +
  "}",

  transferNewFormContainer: ".transfer-new-form-container" +
  "{" +
  "position: absolute;" +
  "margin-top:" + 155 * widthK + "px;" +
  "height:" + (1232 * heightK - 241 * widthK) + "px;" +
  "width: 100%;" +
  "}",

  transferNewTypeCarousel: ".transfer-new-type-carousel" +
  "{" +
  "height: 100%;" +
  "width: 100%;" +
  "}",

  transferNewContactPhoto: ".transfer-new-contact-photo" +
  "{" +
  "top:" + 8 * widthK + "px;" +
  "position: relative;" +
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

  transferNewCardTextField: ".transfer-new-card-text-field" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "color: gray;" +
  "left: 16%;" +
  "padding-top:" + 35 * widthK + "px;" +
  "font-size:" + 32 * widthK + "px;" +
  "}",

  transferNewCardContainer: ".transfer-new-card-container" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "top:" + 20 * widthK + "px;" +
  "height:" + 345 * widthK + "px;" +
  "width:" + 607 * widthK + "px;" +
  "background-size: cover;" +
  "background-position: center;" +
  "background-repeat: no-repeat;" +
  "background-image: url('resources/icons/ViewTransfer/transfer_card.png');" +
  "}",

  transferNewCardNumberInputContainer: ".transfer-new-card-number-input-container" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: absolute;" +
  "top:" + 136 * widthK + "px;" +
  "left:" + 28 * widthK + "px;" +
  "width:" + 547 * widthK + "px;" +
  "height:" + 75 * widthK + "px;" +
  "background-color: white;" +
  "margin: 0%;" +
  "padding: 0;" +
  "}",

  transferNewCardNumberInput: ".transfer-new-card-number-input" +
  "{" +
  "position: absolute;" +
  "top:" + 20 * widthK + "px;" +
  "left:" + 18 * widthK + "px;" +
  "border: none;" +
  "outline: none;" +
  "width:" + 510 * widthK + "px;" +
  "font-size:" + 37 * widthK + "px;" +
  "font-family: 'OCRAStd';" +
  "color: #515151;" +
  "background-color: transparent;" +
  "margin: 0%;" +
  "padding: 0;" +
  "}",

  transferNewCardOwnerContainer: ".transfer-new-card-owner-container " +
  "{" +
  "position: absolute;" +
  "top:" + 254 * widthK + "px;" +
  "left:" + 60 * widthK + "px;" +
  "}",

  transferNewCardOwnerTitle: ".transfer-new-card-owner-title " +
  "{" +
  "position: relative;" +
  "font-size:" + 32 * widthK + "px;" +
  "color: #c1c1c1;" +
  "margin: 0;" +
  "float: left;" +
  "}",

  transferNewCardOwnerInfo: ".transfer-new-card-owner-info " +
  "{" +
  "position: relative;" +
  "font-size:" + 32 * widthK + "px;" +
  "margin: 0;" +
  "float: left;" +
  "padding-left:" + 8 * widthK + "px;" +
  "color: #626062;" +
  "}",

  transferNewCardProcessingIcon: ".transfer-new-card-processingIcon" +
  "{" +
  "position: absolute;" +
  "width:" + 129 * widthK + "px;" +
  "height:" + 37 * widthK + "px;" +
  "top:" + 34 * widthK + "px;" +
  "right:" + 34 * widthK + "px;" +
  "background-size: contain;" +
  "background-position: center;" +
  "background-repeat: no-repeat;" +
  // "display: none;" +
  // "background-image: url('resources/icons/cards/typeOfCards/uzcard.png');" +
  "}",

  transferNewCardBankIcon: ".transfer-new-card-bankIcon" +
  "{" +
  "position: absolute;" +
  "width:" + 185 * widthK + "px;" +
  "height:" + 90 * widthK + "px;" +
  "top:" + 20 * widthK + "px;" +
  "left:" + 10 * widthK + "px;" +
  "background-size: contain;" +
  "background-position: center;" +
  "background-repeat: no-repeat;" +
  // "display: none;" +
  // "background-image: url('resources/icons/cards/typeOfCards/uzcard.png');" +
  "}",

  transferNewCardSuggestionsContainer: ".transfer-new-card-suggestions-container" +
  "{" +
  "padding-top:" + 207 * widthK + "px;" +
  "}",

  transferNewContactFoundContainer: ".transfer-new-card-found-container" +
  "{" +
  "position: relative;" +
  "width: 90%;" +
  "height:" + 117 * widthK + "px;" +
  "background-color: #F0F1F4;" +
  "left: 5%;" +
  "margin-top:" + 13 * widthK + "px;" +
  "}",

  transferNewCardFoundTextTwo: ".transfer-new-card-found-text-two" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left:" + 315 * widthK + "px;" +
  "color: gray;" +
  "font-size:" + 24 * widthK + "px;" +
  "top: 40%;" +
  "max-width:" + 231 * widthK + "px;" +
  "overflow: hidden;" +
  "text-overflow: ellipsis;" +
  "white-space: nowrap;" +
  "}",

  transferNewContactSuggestionsContainer: ".transfer-new-contact-suggestions-container" +
  "{" +
  "padding-top:" + 15 * widthK + "px;" +
  "}",

  transferNewBetweenAmountField: ".transfer-new-between-amount-field" +
  "{" +
  "position: relative;" +
  "left: 10%;" +
  "width: 79.5%;" +
  "height:" + 120 * widthK + "px;" +
  "border-bottom:" + 3 * widthK + "px solid #01cfff;" +
  "color: white;" +
  "padding-top:" + 25 * widthK + "px;" +
  "}",

  transferNewBetweenTextField: ".transfer-new-between-text-field" +
  "{" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 32 * widthK + "px;" +
  "}",

  transferNewSubmitNoCards: ".transfer-new-submit-no-cards" +
  "{" +
  "margin: 0;" +
  "margin-top:" + 85 * widthK + "px;" +
  "color: gray;" +
  "text-align: center;" +
  "word-break: break-word;" +
  "font-size:" + 32 * widthK + "px;" +
  "}",

  transferNewBetweenAmountInput: ".transfer-new-between-amount-input" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "padding: 0;" +
  "margin: 0;" +
  "width: 65%;" +
  "font-size:" + 51 * widthK + "px;" +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "}",

  transferNewBetweenInputCommission: ".transfer-new-between-input-commission" +
  "{" +
  "position: relative;" +
  "color: gray;" +
  "text-align: right;" +
  "font-size:" + 32 * widthK + "px;" +
  "margin-top:" + 30 * heightK + "px;" +
  "}",

  transferNewCardCarousel: ".transfer-new-card-carousel " +
  "{" +
  // "left:" + (360 * widthK - 296 * heightK) + "px;" +
  "position: relative;" +
  "overflow: hidden;" +
  "height:" + 230 * heightK + "px;" +
  "width: 100%;" +
  "display: inline-block;" +
  "background: transparent;" +
  "transition: 1s;" +
  "-webkit-transform: scale(1);" +
  "}",

  transferNewCard: ".transfer-new-card " +
  "{" +
  "background-image: url(resources/icons/cards/all.png);" +
  "-webkit-appearance: none;" +
  "height:" + 222 * heightK + "px;" +
  "width:" + 393 * heightK + "px;" +
  "position: absolute;" +
  "top:" + 7 * heightK + "px;" +
  "-webkit-border-radius:" + 14 * heightK + "px;" +
  "-moz-border-radius:" + 14 * heightK + "px;" +
  "border-radius:" + 14 * heightK + "px;" +
  "background-size: cover;" +
  "color: white;" +
  "}",

  transferNewCardFrom: ".transfer-new-card-from " +
  "{" +
  "position: relative;" +
  "margin-top:" + 50 * heightK + "px;" +
  "}",

  transferNewCardTo: ".transfer-new-card-to " +
  "{" +
  "position: relative;" +
  "margin-top:" + 7 * heightK + "px;" +
  "}",

  transferNewCardBalansCurrencyContainer: ".transfer-new-card-balance-currency-container " +
  "{" +
  "position: absolute;" +
  "width:" + 366 * heightK + "px;" +
  "top:" + 116 * heightK + "px;" +
  "left:" + 27 * heightK + "px;" +
  "display: inline-block;" +
  "margin: 0;" +
  "overflow: hidden;" +
  "}",

  transferNewCardBalance: ".transfer-new-card-balance " +
  "{" +
  "position: relative;" +
  "font-size:" + 40 * heightK + "px;" +
  "margin: 0;" +
  "float: left;" +
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "max-height: 52%;" +
  "max-width: 65%;" +
  "}",

  transferNewCardBalanceFractional: ".transfer-new-card-balance-fractional" +
  "{" +
  "font-size:" + 34 * heightK + "px;" +
  "}",

  transferNewCardCurrency: ".transfer-new-card-currency " +
  "{" +
  "position: relative;" +
  "bottom:" + 8 * heightK + "px;" +
  "font-size:" + 24 * heightK + "px;" +
  "margin-left:" + 7 * heightK + "px;" +
  "background-size: contain;" +
  "float: left;" +
  "width:" + 60 * heightK + "px;" +
  "}",

  transferNewCardSalaryTitle: ".transfer-new-card-salary-title " +
  "{" +
  "position: absolute;" +
  "top:" + 93 * heightK + "px;" +
  "left:" + 27 * heightK + "px;" +
  "background-size: contain;" +
  "font-size:" + 23 * heightK + "px;" +
  "height:" + 24 * heightK + "px;" +
  "width: 90%;" +
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "}",

  transferNewCardNumber: ".transfer-new-card-number " +
  "{" +
  "position: absolute;" +
  "top:" + 181 * heightK + "px;" +
  "width:" + 384 * heightK + "px;" +
  "height:" + 40 * heightK + "px;" +
  "font-size:" + 23 * heightK + "px;" +
  "font-family: 'OCRAStd';" +
  "left:" + 27 * heightK + "px;" +
  "}",

  transferNewCardNumberPartOne: ".transfer-new-card-number-part-one " +
  "{" +
  "position: absolute;" +
  "left: 0px;" +
  "}",

  transferNewCardNumberMiddleTwo: ".transfer-new-card-number-middle-two " +
  "{" +
  "position: absolute;" +
  "left:" + 76 * heightK + "px;" +
  "}",

  transferNewNumberStars: ".transfer-new-number-stars " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left:" + 110 * heightK + "px;" +
  "font-size:" + 23 * heightK + "px;" +
  "}",

  transferNewCardNumberPartTwo: ".transfer-new-card-number-part-two " +
  "{" +
  "position: absolute;" +
  "left:" + 233 * heightK + "px;" +
  "}",

  transferNewBetweenFromTextField: ".transfer-new-between-from-text-field" +
  "{" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 29 * widthK + "px;" +
  "margin-left: 10%;" +
  "}",

  transferNewBetweenCardsArrow: ".transfer-new-between-cards-arrow" +
  "{" +
  "position: relative;" +
  "background-image: url('resources/icons/ViewTransfer/between_cards_arrow.png');" +
  "margin-top:" + 20 * heightK + "px;" +
  "margin-left:" + 336 * widthK + "px;" +
  "width:" + 46 * heightK + "px;" +
  "height:" + 49 * heightK + "px;" +
  "background-repeat: no-repeat;" +
  "background-size: cover;" +
  "background-position: center;" +
  "}",

  transferNewSubmitReceiverContainer: ".transfer-new-submit-receiver-container" +
  "{" +
  "position: relative;" +
  "background-color: #f1f1f1;" +
  "font-size:" + 29 * widthK + "px;" +
  "width: 80%;" +
  "height:" + 85 * widthK + "px;" +
  "margin-left: 10%;" +
  "margin-top:" + 30 * widthK + "px;" +
  "}",

  transferNewSubmitReceiverLabel: ".transfer-new-submit-receiver-label" +
  "{" +
  "margin: 0;" +
  "padding-top:" + 24 * widthK + "px;" +
  "padding-left:" + 28 * widthK + "px;" +
  "color: gray;" +
  "max-width: 90%;" +
  "white-space: nowrap;" +
  "overflow: hidden;" +
  "text-overflow: ellipsis;" +
  "font-size:" + 32 * widthK + "px;" +
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

  transferNewContactBodyContainer: ".transfer-new-contact-body-container" +
  "{" +
  "position: absolute;" +
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
  "border-bottom:" + 3 * widthK + "px solid #01cfff;" +
  "color: white;" +
  "top: 7%;" +
  "}",

  transferContactTextField: ".transfer-contact-text-field" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 24 * widthK + "px;" +
  "top: -9%;" +
  "}",

  transferContactAccess: ".transfer-contact-access-text" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 24 * widthK + "px;" +
  "}",

  transferContactAccessSettings: ".transfer-contact-access-text-settings" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "color: #01cfff;" +
  "font-size:" + 24 * widthK + "px;" +
  "}",

  transferContactAccessContainer: ".transfer-contact-access-container" +
  "{" +
  "position: relative;" +
  "width: 79.5%;" +
  "height:" + 120 * widthK + "px;" +
  "left: 10%;" +
  "top:" + 15 * widthK + "px;" +
  "}",

  transferContactPhoneIcon: ".transfer-contact-phone-icon" +
  "{" +
  "position: absolute;" +
  "background-image: url('resources/icons/ViewService/book.png');" +
  "width: 13%;" +
  "height: 50%;" +
  "background-repeat: no-repeat;" +
  "background-size:" + 45 * widthK + "px;" +
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
  "top: 32%;" +
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
  "left: 30%;" +
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
  "height: " + 74 * widthK + "px;" +
  "top: 41%;" +
  "font-size: " + 32 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "position: absolute;" +
  "left: 28%;" +
  "width: 44%;" +
  "background-color: #00a8f1;" +
  "border-radius: " + 10 * widthK + "px;" +
  "bottom: 0;" +
  "color: #ffffff;" +
  "}",

  transferNextButtonLabel: ".transfer-next-button-label" +
  "{" +
  "position: relative;" +
  "top: 14%;" +
  "width: 36%;" +
  "font-size:  " + 32 * widthK + "px; " +
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
  "color: #565d6a;" +
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
  "background-size: 42%;" +
  "left:" + -39 * widthK + "px;" +
  "top: 0;" +
  "}",

  transferIButton: ".transfer-i-button " +
  "{" +
  "position: absolute;" +
  "width:" + 87 * widthK + "px;" +
  "height:" + 87 * widthK + "px;" +
  "right: 1.5%;" +
  "background-image: url(resources/icons/ViewTransfer/i.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 48%;" +
  "background-position-y: center;" +
  "background-position-x: center;" +
  "background-size: 48%;" +
  "}",

  //VIEW TRANSFER TWO

  transferTwoBodyContainer: ".transfertwo-body-container " +
  "{" +
  "position: absolute;" +
  "height:" + 1150 * heightK + "px;" +
  "width: 100%;" +
  "top:" + 93 * heightK + "px;" +
  "background-color: white;" +
  "overflow: hidden;" +
  "}",

  transferTwoContactPhoneField: ".transfertwo-contact-phone-field" +
  "{" +
  "position: absolute;" +
  "left: 10%;" +
  "width: 79.5%;" +
  "height:" + 100 * widthK + "px;" +
  "border-bottom:" + 3 * widthK + "px solid #01cfff;" +
  "color: white;" +
  "top:" + 100 * widthK + "px;" +
  "}",

  transferTwoContactTextField: ".transfertwo-contact-text-field" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 24 * widthK + "px;" +
  "bottom:" + -15 * widthK + "px;" +
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
  "height: " + 74 * widthK + "px;" +
  "top: 41%;" +
  "font-size: " + 32 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "position: absolute;" +
  "left: 28%;" +
  "width: 44%;" +
  "background-color: #00a8f1;" +
  "border-radius: " + 10 * widthK + "px;" +
  "bottom: 0;" +
  "color: #ffffff;" +
  "}",


  transferTwoNextButtonLabel: ".transfertwo-next-button-label" +
  "{" +
  "position: relative;" +
  "top: 14%;" +
  "width: 38%;" +
  "font-size:  " + 32 * widthK + "px; " +
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

  transferTwoLimitTitle: ".transfertwo-limit-title" +
  "{" +
  "position: relative;" +
  "font-size: " + 20 * widthK + "px; " +
  "bottom: " + -15 * widthK + "px; " +
  "margin: 0;" +
  "color: red;" +
  "}",


  //VIEW TRANSFER THREE

  transferThreeBodyContainer: ".transferthree-body-container " +
  "{" +
  "position: absolute;" +
  "height:" + 1150 * heightK + "px;" +
  "width: 100%;" +
  "top:" + 93 * heightK + "px;" +
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
  "border-bottom: 3px solid #01cfff;" +
  "color: white;" +
  "top: 45px;" +
  "margin-bottom: 8%;" +
  "}",

  transferThreeNextButtonInnerContainer: ".transferthree-next-button-inner-container" +
  "{" +
  "position: absolute;" +
  "width: 44%;" +
  "height: " + 74 * widthK + "px;" +
  "bottom: 10%;" +
  "background-color: #00a8f1;" +
  "color: white;" +
  "outline: none;" +
  "border: none;" +
  "padding: 0;" +
  "left: 28%; " +
  "font-size: " + 32 * widthK + "px; " +
  "font-family: SFUIDisplay-Light;" +
  "border-radius: " + 10 * widthK + "px; " +
  "}",

  transferThreeNextButtonLabel: ".transferthree-next-button-label" +
  "{" +
  "position: relative;" +
  "top: 14%;" +
  "width: 38%;" +
  "font-size:  " + 32 * widthK + "px; " +
  "margin: auto;" +
  "color: white;" +
  "}",

  //VIEW TRANSFER FOUR

  transferFourBodyContainer: ".transferfour-body-container " +
  "{" +
  "position: absolute;" +
  "height:" + 1142 * heightK + "px;" +
  "width: 100%;" +
  "top:" + 93 * heightK + "px;" +
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
  "width: 90%;" +
  "top: 27%;" +
  "font-size: " + 40 * widthK + "px; " +
  "color: gray;" +
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
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
  "width: 25%;" +
  "height: 67%;" +
  "left: 70%;" +
  "top: 15%;" +
  "background-color: transparent;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: contain;" +
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
  "background-color: #00a8f1;" +
  "height: " + 74 * widthK + "px;" +
  "bottom: 10%;" +
  "color: white;" +
  "padding: 0;" +
  "font-size: " + 32 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "position: absolute;" +
  "left: 28%;" +
  "width: 44%;" +
  "border-radius: " + 10 * widthK + "px;" +
  "}",

  transferFourButtonEnterLabel: ".transferfour-button-enter-label" +
  "{" +
  "position: relative;" +
  "top: 15%;" +
  //"left: 1%;" +
  //"letter-spacing:" + 3 * widthK + "px;" +
  "font-size: " + 32 * widthK + "px; " +
  "color: white;" +
  "margin: 0;" +
  "width: 63%;" +
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
  "z-index: 10;" +
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
  "position: relative;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "width:" + 450 * widthK + "px;" +
  "height:" + 450 * widthK + "px;" +
  // "left:" + 135 * widthK + "px;" +
  "top:" + 150 * widthK + "px;" +
  "}",

  codeConfirmCodeText: ".code-confirm-code-text " +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "left: 50%;" +
  "-webkit-transform: translate3d(-50%,0,0);" +
  // "height: 25%;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "margin-bottom: 0;" +
  "margin-top: 0;" +
  "color: white;" +
  "text-align: center;" +
  "border: none;" +
  "background-color: transparent;" +
  "outline: none;" +
  "padding: 0;" +
  "border-bottom:" + 3 * widthK + "px solid #6abfff;" +
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
  //"bottom: 24%;" +
  "margin: 0;" +
  "margin-top: 25%;" +
  //"float: left;" +
  "text-align: center;" +
  "background-color: #017ce3;" +
  "font-size: " + 29 * widthK + "px;" +
  "height: " + 74 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "width: 63%;" +
  "border-radius: " + 10 * widthK + "px;" +
  "color: #ffffff;" +
  "text-transform: capitalize;" +
  "left: 19%;" +
  "position: absolute;" +
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
  "border-bottom:" + 3 * widthK + "px solid #01cfff;" +
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
  //"background-color: #353340;" +
  //"background-image: url(resources/icons/transparent.png);" +
  // "display: none;" +
  "z-index: 999999999;" +
  "background-color: rgba(255,255,255,0.95);" +
  "}",

  InProcessingOperationSuccessMessagePartOne: ".in-processing-operation-success-message-part-one" +
  "{" +
  "position: relative;" +
  "color: black;" +
  "width: 100%;" +
  "text-align: center;" +
  "margin-left: auto;" +
  "margin-top: 0;" +
  "margin-bottom: 0;" +
  "margin-right: auto;" +
  "top:" + 400 * widthK + "px;" +
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
  "top:" + 400 * widthK + "px;" +
  "left:" + -10 * widthK + "px;" +
  "font-size:" + 36 * widthK + "px;" +
  "}",

  InProcessingOperationSuccessMessagePartTwoForTransfer: ".in-processing-operation-success-message-part-two-for-transfer" +
  "{" +
  "position: relative;" +
  "color: black;" +
  "width: 100%;" +
  "text-align: center;" +
  "margin-left: auto;" +
  "margin-top: 0;" +
  "margin-bottom: 0;" +
  "margin-right: auto;" +
  "top:" + 400 * widthK + "px;" +
  "left: 0;" +
  "font-size:" + 36 * widthK + "px;" +
  "}",

  InProcessingNextButtonInnerContainer: ".in-processing-next-button-inner-container" +
  "{" +
  // "top: 83%;" +
  "bottom: " + 114.2 * heightK + "px;" +
  "height: " + 74 * widthK + "px;" +
  "margin: 0 auto 0 auto;" +
  "background-color: white;" +
  "padding: 0;" +
  "font-size: " + 38 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  //"border: none;" +
  "border:" + 3 * widthK + "px solid #00a8f1;" +
  "outline: none;" +
  "width: 44%;" +
  "border-radius: " + 10 * widthK + "px;" +
  "color: #00a8f1;" +
  "position: absolute;" +
  "left: 28%;" +
  "display: table;" +
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
  "position: relative;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "top:" + 230 * widthK + "px;" +
  "width:" + 270 * widthK + "px;" +
  "height:" + 250 * widthK + "px;" +
  // "left:" + 234 * widthK + "px;" +
  "background-image: url(resources/icons/ViewSuccessUnsuccess/processing2.png);" +
  "background-repeat: no-repeat;" +
  "background-size: 93%;" +
  "background-position: center;" +
  "}",

  //COMPONENT SUCCESS
  componentSuccess: ".component-success " +
  "{" +
  "position: absolute;" +
  "opacity: 0.95;" +
  "height: 100%;" +
  "width: 100%;" +
  "z-index: 999999999;" +
  "background-color: rgba(255,255,255,0.95);" +
  "}",

  successOperationSuccessMessage: ".success-operation-success-message" +
  "{" +
  "position: relative;" +
  "color: black;" +
  "width:" + 340 * widthK + "px;" +
  "height:" + 380 * heightK + "px;" +
  "text-align: center;" +
  "margin-left: auto;" +
  "margin-top: 0;" +
  "margin-bottom: 0;" +
  "margin-right: auto;" +
  "top:" + 280 * widthK + "px;" +
  "left:" + -10 * widthK + "px;" +
  "font-size:" + 36 * widthK + "px;" +
  "overflow-y: auto;" +
  "word-wrap: break-word;" +
  "}",

  successNextButtonInnerContainer: ".success-next-button-inner-container" +
  "{" +
  "top: 83%;" +
  "height: " + 74 * widthK + "px;" +
  "margin: 0 auto 0 auto;" +
  "background-color: white;" +
  "padding: 0;" +
  "font-size: " + 38 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  //"border: none;" +
  "border:" + 3 * widthK + "px solid #00a8f1;" +
  "outline: none;" +
  "position: absolute;" +
  "left: 28%;" +
  "width: 44%;" +
  "border-radius: " + 10 * widthK + "px;" +
  "color: #00a8f1;" +
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
  "position: relative;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "top:" + 230 * widthK + "px;" +
  "width:" + 270 * widthK + "px;" +
  "height:" + 250 * widthK + "px;" +
  // "left:" + 234 * widthK + "px;" +
  "background-image: url(resources/icons/ViewSuccessUnsuccess/ok2.png);" +
  "background-repeat: no-repeat;" +
  "background-size: 93%;" +
  "background-position: center;" +
  "}",

  //COMPONENT DELETE
  componentDelete: ".component-delete " +
  "{" +
  "position: absolute;" +
  "opacity: 0.98;" +
  "height: 100%;" +
  "width: 101%;" +
  "display: none;" +
  //"background-color: #efeff1;" +
  "background-image: url(resources/icons/transparent.png);" +
  //"background-repeat: no-repeat;" +
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
  "color: #ffffff;" +
  "background-color: #c8c8c8;" +
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
  // "display: none;" +
  "z-index: 999999999;" +
  "}",

  unsuccessOperationSuccessMessage: ".unsuccess-operation-success-message" +
  "{" +
  "position: relative;" +
  "color: #ff3c5e;" +
  "width:" + 640 * widthK + "px;" +
  "height:" + 380 * heightK + "px;" +
  "font-size:" + 30 * widthK + "px;" +
  "text-align: center;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "margin-top: 0;" +
  "margin-bottom: 0;" +
  "top:" + 340 * widthK + "px;" +
  "overflow-y: auto;" +
  "word-wrap: break-word;" +
  "}",

  unsuccessNextButtonInnerContainer: ".unsuccess-next-button-inner-container" +
  "{" +
  "top: 89%;" +
  "height: 6%;" +
  "margin: 0 auto 0 auto;" +
  "background-color: #027fe4;" +
  "padding: 0;" +
  "font-size: " + 38 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "position: absolute;" +
  "left: 28%;" +
  "width: 44%;" +
  "border-radius: " + 10 * widthK + "px;" +
  "color: #ffffff;" +
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


  unsuccessUnsuccessIcon: ".unsuccess-unsuccess-icon" +
  "{" +
  "position: relative;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "top:" + 250 * widthK + "px;" +
  "width:" + 270 * widthK + "px;" +
  "height:" + 250 * widthK + "px;" +
  // "left:" + 243 * widthK + "px;" +
  "background-image: url(resources/icons/ViewSuccessUnsuccess/fail.png);" +
  "background-repeat: no-repeat;" +
  "background-size: 93%;" +
  "background-position: center;" +
  "}",

  viewClickPass: ".view-click-pass" +
  "{" +
  "position: absolute;" +
  "height: 100%;" +
  "width: 100%;" +
  "background-color: white;" +
  "}",

  clickPassHelpButton: ".click-pass-help-button " +
  "{" +
  "position: absolute;" +
  "width:" + 87 * widthK + "px;" +
  "height:" + 87 * widthK + "px;" +
  "right: 4.2%;" +
  "background-image: url('resources/icons/ViewClickPass/help.png');" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 48%;" +
  "background-position-y: center;" +
  "background-position-x: center;" +
  "background-size: 65%;" +
  "}",

  clickPassHelpMenu: ".click-pass-help-menu " +
  "{" +
  "position: absolute;" +
  "height: 100%;" +
  "width:" + 607 * widthK + "px;" +
  "right: 0;" +
  "overflow: hidden;" +
  "transform: translate3d(" + window.innerWidth + "px, 0, 0);" +
  "-webkit-transform: translate3d(" + window.innerWidth + "px, 0, 0);" +
  "-ms-transform: translate3d(" + window.innerWidth + "px, 0, 0);" +
  "background-color: #ffffff;" +
  "z-index: 1;" +
  "}",

  clickPassHelpMenuCloseButton: ".click-pass-help-menu-close-button " +
  "{" +
  "position: absolute;" +
  "width:" + 87 * widthK + "px;" +
  "height:" + 87 * widthK + "px;" +
  "right: 4.4%;" +
  "background-image: url('resources/icons/ViewClickPass/close.png');" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 40%;" +
  "background-position-y: center;" +
  "background-position-x: center;" +
  "background-size: 40%;" +
  "}",

  clickPassHelpMenuTextContainer: ".click-pass-help-menu-text-container " +
  "{" +
  "position: absolute;" +
  "top:" + 123 * widthK + "px;" +
  "left:" + 45 * widthK + "px;" +
  "height:" + 103 * widthK + "px;" +
  "width:" + 273 * widthK + "px;" +
  "border-bottom: 1px solid #e8e8e8;" +
  "color: #565d6a;" +
  "}",

  clickPassHelpMenuFirst: ".click-pass-help-menu-first " +
  "{" +
  "position: relative;" +
  "text-align: left;" +
  "font-size:" + 32 * widthK + "px;" +
  "margin: 0;" +
  "}",

  clickPassHelpMenuSecond: ".click-pass-help-menu-second " +
  "{" +
  "position: relative;" +
  "text-align: left;" +
  "margin: 0;" +
  "font-size:" + 31.5 * widthK + "px;" +
  "}",

  clickPassHelpMenuHand: ".click-pass-help-menu-hand " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "width:" + 310 * widthK + "px;" +
  "height:" + 310 * widthK + "px;" +
  "top:" + 83 * widthK + "px;" +
  "left:" + 260 * widthK + "px;" +
  "background-image: url('resources/icons/ViewClickPass/hand.png');" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 100%;" +
  "background-position-y: center;" +
  "background-position-x: center;" +
  "background-size: 100%;" +
  "}",

  clickPassHelpMenuProgress: ".click-pass-help-menu-progress " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "width:" + 60 * widthK + "px;" +
  "height:" + 425 * widthK + "px;" +
  "top:" + 330 * widthK + "px;" +
  "left:" + 38 * widthK + "px;" +
  "background-image: url('resources/icons/ViewClickPass/step.png');" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: contain;" +
  "background-position-y: center;" +
  "background-position-x: center;" +
  "background-size: contain;" +
  "}",

  clickPassHelpMenuSteps: ".click-pass-help-menu-steps " +
  "{" +
  "position: absolute;" +
  "top:" + 330 * widthK + "px;" +
  "left:" + 137 * widthK + "px;" +
  "height:" + 425 * widthK + "px;" +
  "width:" + 450 * widthK + "px;" +
  "font-size:" + 30 * widthK + "px;" +
  "color: #565d6a;" +
  "}",

  clickPassHelpMenuFirstStep: ".click-pass-help-menu-first-step " +
  "{" +
  "position: relative;" +
  "margin-top:" + 104 * widthK + "px;" +
  "}",

  clickPassHelpMenuSecondStep: ".click-pass-help-menu-second-step " +
  "{" +
  "position: relative;" +
  "margin-top:" + 93 * widthK + "px;" +
  "}",

  clickPassHelpMenuThirdStep: ".click-pass-help-menu-third-step " +
  "{" +
  "position: relative;" +
  "margin-top:" + 56 * widthK + "px;" +
  "}",

  clickPassShowToSeller: ".view-click-pass-shot-to-seller " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "top:" + 123 * widthK + "px;" +
  "text-align: center;" +
  "font-size:" + 33 * widthK + "px;" +
  "color: #01cfff;" +
  "}",

  clickPassQrCodeCanvas: ".click-pass-qr-code-canvas " +
  "{" +
  "position: absolute;" +
  "margin: auto;" +
  "margin-top:" + 200 * widthK + "px;" +
  "left: 0;" +
  "right: 0;" +
  "}",

  clickPassProgressBarContainer: ".click-pass-progress-bar-container" +
  "{" +
  "position: absolute;" +
  "left: 0;" +
  "right: 0;" +
  "margin: auto;" +
  "margin-top:" + 630 * widthK + "px;" +
  "width:" + 410 * widthK + "px;" +
  "height:" + 20 * widthK + "px;" +
  "border-radius:" + 20 * widthK + "px;" +
  "background-color: #e8e8e8;" +
  "background-image: url(resources/icons/ViewClickPass/progress.png);" +
  "background-repeat: no-repeat;" +
  "background-size: cover;" +
  "overflow: hidden;" +
  "}",

  clickPassProgressBarContainerLine: ".click-pass-progress-bar-container-line" +
  "{" +
  "position: absolute;" +
  "left: 0;" +
  "margin: 0;" +
  "width:" + 410 * widthK + "px;" +
  "height:" + 20 * widthK + "px;" +
  "border-radius:" + 20 * widthK + "px;" +
  "background-color: #01cfff;" +
  "background-repeat: no-repeat;" +
  "background-size: cover;" +
  "overflow: hidden;" +
  "}",

  clickPassProgressBarContainerStart: ".progress-bar-start" +
  "{" +
  "background-position-x: -" + 220 * widthK + "px;" +
  "}",

  clickPassProgressBarContainerStop: ".progress-bar-stop" +
  "{" +
  "background-position-x: -" + 694 * widthK + "px;" +
  "}",

  clickPassProgressBarLine: ".click-pass-progress-bar-line" +
  "{" +
  "position: relative;" +
  "right:" + 410 * widthK + "px;" +
  "width:" + 410 * widthK + "px;" +
  "height:" + 20 * widthK + "px;" +
  "background-image: url(resources/icons/ViewClickPass/progress.png);" +
  "background-size: cover;" +
  "background-repeat: round;" +
  "}",

  clickPassBarCodeCanvas: ".click-pass-bar-code-canvas " +
  "{" +
  "position: absolute;" +
  "margin: auto;" +
  "margin-top:" + 700 * widthK + "px;" +
  "width:" + 584 * widthK + "px;" +
  "left: 0;" +
  "right: 0;" +
  "}",

  clickPassChosenCardContainer: ".click-pass-chosen-card-container" +
  "{" +
  "position: absolute;" +
  "width: 90%;" +
  "height: " + 140 * widthK + "px; " +
  "margin: auto;" +
  "bottom: " + 55 * widthK + "px; " +
  "left: 0;" +
  "right: 0;" +
  "background-color: transparent;" +
  "border-top: " + 1 + "px solid #e8e8e8;" +
  "border-bottom: " + 1 + "px solid #e8e8e8;" +
  "}",

  clickPassChosenCardInfoContainer: ".click-pass-chosen-card-info-container" +
  "{" +
  "position: absolute;" +
  "width: 41%;" +
  "height: 100%;" +
  "left: 35%;" +
  "background-color: transparent;" +
  "}",

  clickPassChosenCardInfoTextOne: ".click-pass-chosen-card-info-text-one" +
  "{" +
  "position: absolute;" +
  "font-size: " + 24 * widthK + "px; " +
  "color: gray;" +
  "width: 110%;" +
  "top: 22%;" +
  "margin-top: 0;" +
  "text-overflow: ellipsis;" +
  "white-space: nowrap;" +
  "overflow: hidden;" +
  "}",

  clickPassChosenCardInfoTextThree: ".click-pass-chosen-card-info-text-three" +
  "{" +
  "position: absolute;" +
  "font-size: " + 23 * widthK + "px; " +
  "color: gray;" +
  "top: 48%;" +
  "}",

  clickPassChosenCardLogoContainer: ".click-pass-chosen-card-logo-container" +
  "{" +
  "width: 35%;" +
  "height: 100%;" +
  "left: 0;" +
  "background-color: transparent;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: contain;" +
  "float: left;" +
  "position: absolute;" +
  "}",

  clickPassChosenCardNextIcon: ".click-pass-chosen-card-next-icon" +
  "{" +
  "position: absolute;" +
  "right: 0;" +
  "width: 10%;" +
  "height: 100%;" +
  "top: 0;" +
  "background-repeat: no-repeat;" +
  "background-size: 17%;" +
  "background-position: center;" +
  "background-image: url(resources/icons/ViewClickPass/open.png);" +
  "}",

  clickPassCardsListContainer: ".click-pass-cards-list-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "top: " + 88 * widthK + "px; " +
  "margin: auto;" +
  "}",

  clickPassCardInList: ".click-pass-card-in-list" +
  "{" +
  "position: relative;" +
  "width: 90%;" +
  "height: " + 140 * widthK + "px; " +
  "margin: auto;" +
  "left: 0;" +
  "right: 0;" +
  "background-color: transparent;" +
  "border-bottom: " + 1 + "px solid #e8e8e8;" +
  "}",

  clickPassChosenCardBackground: ".click-pass-chosen-card-background" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: " + 140 * widthK + "px; " +
  "margin: auto;" +
  "left: 0;" +
  "right: 0;" +
  "background-color: rgba(231,231,231,0.5);" +
  "}",


  //COMPONENT Generated qr
  componentGeneratedQr: ".component-generated-qr " +
  "{" +
  "position: absolute;" +
  "opacity: 0.99;" +
  "height:" + 1232 * heightK + "px;" +
  "width: 100%;" +
  //"background-color: #353340;" +
  //"background-image: url(resources/icons/transparent.png);" +
  // "display: none;" +
  "z-index: 999999999;" +
  "background-color: rgba(255,255,255,0.95);" +
  "}",

  generatedqrOperationUpperInfoMessage: ".generatedqr-operation-upper-info-message" +
  "{" +
  "position: relative;" +
  "color: black;" +
  "width:" + 500 * widthK + "px;" +
  "text-align: center;" +
  "margin-left: auto;" +
  "margin-top: 0;" +
  "margin-bottom: 0;" +
  "margin-right: auto;" +
  "top:" + 150 * heightK + "px;" +
  "font-size:" + 32 * widthK + "px;" +
  "}",

  generatedqrOperationInfoMessage: ".generatedqr-operation-info-message" +
  "{" +
  "position: relative;" +
  "color: #515151;" +
  "width:" + 415 * widthK + "px;" +
  "text-align: center;" +
  "margin-left: auto;" +
  "margin-top: 0;" +
  "margin-bottom: 0;" +
  "margin-right: auto;" +
  "top:" + 215 * heightK + "px;" +
  "font-size:" + 30 * widthK + "px;" +
  "}",

  generatedqrCloseButtonInnerContainer: ".generatedqr-close-button-inner-container" +
  "{" +
  "top:" + 275 * heightK + "px;" +
  "height: " + 74 * widthK + "px;" +
  "margin: 0 auto 0 auto;" +
  "background-color: white;" +
  "padding: 0;" +
  "font-size: " + 38 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  //"border: none;" +
  "border:" + 3 * widthK + "px solid #00a8f1;" +
  "outline: none;" +
  "position: relative;" +
  "left: 28%;" +
  "width: 44%;" +
  "border-radius: " + 10 * widthK + "px;" +
  "color: #00a8f1;" +
  "}",

  generatedqrImage: ".generatedqr-image" +
  "{" +
  "position: relative;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "top:" + 175 * heightK + "px;" +
  "width:" + 500 * widthK + "px;" +
  "height:" + 500 * widthK + "px;" +
  // "left:" + 234 * widthK + "px;" +
  //"background-image: url(resources/icons/ViewSuccessUnsuccess/ok.png);" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "background-position: center;" +
  "background-color: grey;" +
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
  "background-size: cover;" +
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
  "color: white;" +
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
  "text-align: center;" +
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
  "left: 16%;" +
  "height: 60%;" +
  "top: 20%;" +
  "background-color: transparent;" +
  "border: none;" +
  "color: white;" +
  "text-align: center;" +
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
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "width:" + 560 * widthK + "px;" +
  "bottom:" + -10 * widthK + "px;" +
  // "left:" + 84 * widthK + "px;" +
  "}",

  registrationClientButtonEnter: ".registration-client-button-enter " +
  "{" +
  "top:" + 20 * widthK + "px;" +
  "}",

  registrationClientKeyboardField: ".registration-client-keyboard-field " +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "top:" + 30 * heightK + "px;" +
  // "left:" + 110 * widthK + "px;" +
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
  "background-color: #ffffff;" +
  "}",

  pinCodeFlexContainer: ".pincode-flex-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "top: 0;" +
  "bottom:" + 610 * widthK + "px;" +
  "}",

  pinCodeBackButton: ".pincode-back-button " +
  "{" +
  "position: absolute;" +
  "width:" + 120 * widthK + "px;" +
  "height:" + 91 * widthK + "px;" +
  "background-image: url(resources/icons/back/back.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 19%;" +
  "background-position-y: " + 45 * widthK + "px;" +
  "background-position-x:" + 47 * widthK + "px;" +
  "background-size: 20%;" +
  // "left:" + -25 * widthK + "px;" +
  "top: 0;" +
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
  "border:" + 4.5 * widthK + "px solid #fafafa;" +
  "background-color: #b0aeb2;" +
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
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "top:" + 460 * heightK + "px;" +
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
  "border-bottom:" + 1 + "px solid #05eeff;" +
  "}",

  pinCodeButtonRegistration: ".pincode-button-registration " +
  "{" +
  "position: absolute;" +
  "font-size:" + 34 * widthK + "px;" +
  "background-size: contain;" +
  "color: white;" +
  "right: 0;" +
  "border-bottom:" + 1 + "px solid white;" +
  "}",

  pinCodeButtonOffline: ".pincode-button-offline " +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "font-size:" + 34 * widthK + "px;" +
  "width:" + 240 * widthK + "px;" +
  "background-size: contain;" +
  "color: white;" +
  "border-bottom:" + 1 + "px solid white;" +
  "text-align: center;" +
  "top:" + 580 * heightK + "px;" +
  // "left:" + 240 * widthK + "px;" +
  "}",

  pinCodeEnterPinLabel: ".pincode-enter-pin-label " +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "background-size: contain;" +
  "text-align: center;" +
  "width:" + 320 * widthK + "px;" +
  "color: #aaabae;" +
  "font-size:" + 32 * widthK + "px;" +
  "}",

  pinCodeEnterPinConfirmLabel: ".pincode-enter-pin-confirm-label " +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "background-size: contain;" +
  "width:" + 350 * widthK + "px;" +
  "color: #565d6a;" +
  "font-size:" + 32 * widthK + "px;" +
  "}",

  //COMPONENT PIN RESET

  componentPinReset: ".component-pinreset" +
  "{" +
  "position: absolute;" +
  "top: 0;" +
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
  "top:" + 500 * widthK + "px;" +
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
  "width: 100%; " +
  "top:" + 87 * widthK + "px; " +
  "bottom:0; " +
  "background-color: white; " +
  "overflow-y: auto; " +
  "overflow-x: hidden; " +
  "-webkit-overflow-scrolling: touch; " +
  "}",

  settingsPageTitle: ".settings-page-title " +
  "{" +
  "position: absolute;" +
  "top: 0;" +
  // "right:" + 28 * widthK + "px;" +
  // "left:" + 25 * widthK + "px;" +
  "height:" + 92 * widthK + "px;" +
  "width: 100%;" +
  "background: transparent;" +
  //"border-bottom:" + 2 + "px solid rgb(149, 230, 253);" +
  "}",

  settingsNameTitle: ".settings-name-title " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size:" + 35 * widthK + "px; " +
  "left:" + 85 * widthK + "px; " +
  "top:" + 27 * widthK + "px; " +
  "margin: 0;  " +
  "color: #565d6a;" +
  "}",

  settingsBackButton: ".settings-back-button " +
  "{" +
  "position: absolute;" +
  "width:" + 113 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "background-image: url(resources/icons/back/back.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 19%;" +
  "background-position-y: 43%;" +
  "background-position-x: center;" +
  "background-size: 42%;" +
  "right: 87%;" +
  "}",

  settingsBlockContainer: ".settings-block-containter" +
  "{" +
  "position: relative;" +
  "height:" + 92 * widthK + "px; " +
  "width: 91%;" +
  "left: 4%;" +
  "margin-top: 1%;" +
  "border-bottom:" + 1 + "px solid #e8e8e8;" +
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
  "background-size: 55%;" +
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
  "height:" + 81 * widthK + "px;" +
  "background-image: url(resources/icons/back/back.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 19%;" +
  "background-position-y:" + 25 * widthK + "px; " +
  "background-position-x:" + 9 * widthK + "px; " +
  "background-size: 37%;" +
  // "left: -3%;" +
  "top: 0;" +
  "}",

  settingsGeneralCheckButton: ".settings-general-check-button " +
  "{" +
  "position: absolute;" +
  "width:" + 135 * widthK + "px;" +
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

  settingsGeneralContainer: ".settings-general-container" +
  "{" +
  "top:" + 582 * widthK + "px; " +
  "}",

  settingsGeneralUserInfoContainer: ".settings-general-user-info-container" +
  "{" +
  "position: absolute;" +
  "height:" + 582 * widthK + "px;" +
  "width:100%;" +
  "background: white;" +
  "}",

  settingsGeneralUserIcon: ".settings-general-user-icon" +
  "{" +
  "position: absolute;" +
  "height:" + 179 * widthK + "px;" +
  "width:" + 179 * widthK + "px;" +
  "top:" + 149 * widthK + "px;" +
  "left:" + 271 * widthK + "px;" +
  //"border:" + 4 * widthK + "px solid white;" +
  "border-radius:" + 100 * widthK + "px;" +
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
  "left: 10.5%;" +
  "width: 80%;" +
  "font-size:" + 38.5 * widthK + "px; " +
  "font-family: 'SFUIDisplay-Light';" +
  "padding: 0;" +
  "margin: 0;" +
  "color: #565d6a;" +
  "background: transparent;" +
  "text-align: center;" +
  "}",

  settingsGeneralGenderContainer: ".settings-general-gender-container " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 25%;" +
  "top: 5%;" +
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
  "height:" + 162 * widthK + "px;" +
  "left: 25%;" +
  "}",

  settingsGeneralFemaleContainer: ".settings-general-female-container" +
  "{" +
  "position: absolute;" +
  "width: 20%;" +
  "height:" + 162 * widthK + "px;" +
  "left: 54%;" +
  "}",

  settingsGeneralMaleIcon: ".settings-general-male-icon" +
  "{" +
  "position: relative;" +
  "width:" + 89 * widthK + "px;" +
  "height:" + 94 * widthK + "px;" +
  "left: 21%;" +
  "top: 17%;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: 100%;" +
  "background-image: url('resources/icons/ViewSettingsGeneral/general_male_inactive.png');" +
  "}",

  settingsGeneralFemaleIcon: ".settings-general-female-icon" +
  "{" +
  "position: relative;" +
  "width:" + 89 * widthK + "px;" +
  "height:" + 94 * widthK + "px;" +
  "top: 17%;" +
  "left: 18%;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: 100%;" +
  "background-image: url('resources/icons/ViewSettingsGeneral/general_female_inactive.png');" +
  "}",

  settingsGeneralGenderText: ".settings-general-gender-text" +
  "{" +
  "position: relative;" +
  "margin-top:" + 30 * widthK + "px;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "text-align: center;" +
  "padding: 0;" +
  "color: lightgray;" +
  "font-size:" + 24 * widthK + "px;" +
  "}",

  settingsGeneralLineBetween: ".settings-general-line-between" +
  "{" +
  "position: absolute;" +
  "left: 50%;" +
  "width: 1px;" +
  "height: 60%;" +
  "top: 18%;" +
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
  "width: 90%;" +
  "height:" + 97 * widthK + "px;" +
  "top: 60%;" +
  "border-bottom: 1px solid #e8e8e8;" +
  "left: 5%;" +
  "}",

  settingsGeneralUserNameSave: ".settings-general-user-name-save" +
  "{" +
  "position: absolute;" +
  "width:" + 32 * widthK + "px;" +
  "height:" + 32 * widthK + "px;" +
  "top: 34%;" +
  "right: 3.3%;" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
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
  "margin-left: 11%;" +
  "margin-right: 0%;" +
  "float: left;" +
  "}",

  settingsGeneralDownloadTitle: ".settings-general-download-title" +
  "{" +
  "position: absolute;" +
  "top: 32%;" +
  "left: 27%;" +
  "margin: 0;" +
  "color: #565d6a;" +
  "font-size:" + 27 * widthK + "px;" +
  "}",

  settingsGeneralDownloadIcon: ".settings-general-download-icon" +
  "{" +
  "position: absolute;" +
  "width:" + 17 * widthK + "px;" +
  "height:" + 30 * widthK + "px;" +
  "top: 29%;" +
  "left: 11%;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: 100%;" +
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
  "color: #565d6a;" +
  "font-size:" + 27 * widthK + "px;" +
  "}",

  settingsGeneralDeleteIcon: ".settings-general-delete-icon" +
  "{" +
  "position: absolute;" +
  "width:" + 25 * widthK + "px;" +
  "height:" + 24 * widthK + "px;" +
  "top: 36%;" +
  "left: 10%;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: 100%;" +
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
  "position: relative;" +
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
  "position: relative;" +
  "left: 10%;" +
  "width: 79.5%;" +
  "height:" + 100 * widthK + "px;" +
  "border-bottom:" + 3 * widthK + "px solid #01cfff;" +
  "color: white;" +
  "margin-top: 10%" +
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
  "border-bottom:" + 3 * widthK + "px solid #01cfff;" +
  "color: white;" +
  "top: 30%" +
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
  "background-size:" + 45 * widthK + "px;" +
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
  "height: " + 74 * widthK + "px;" +
  "text-transform: capitalize;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "margin: 15% auto 0 auto;" +
  "background-color: #00a8f1;" +
  "padding: 0;" +
  "font-size: " + 32 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "width: 44%;" +
  "border-radius: " + 10 * widthK + "px;" +
  "color: #ffffff;" +
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
  "top:" + 365 * widthK + "px;" +
  "display: none;" +
  "}",

  settingsAddFriendContactFoundContainerTwo: ".settings-add-friend-contact-found-container-two" +
  "{" +
  "position: absolute;" +
  "width: 79.5%;" +
  "height:" + 120 * widthK + "px;" +
  "background-color: #F0F1F4;" +
  "left: 10%;" +
  "top:" + 490 * widthK + "px;" +
  "display: none;" +
  "}",

  //SETTINGS ABOUT PROGRAM
  settingsAboutProgramBlueContainer: ".settings-about-program-blue-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 418 * widthK + "px;" +
  "background-color: white;" +
  "text-align: center;" +
  "}",

  settingsAboutProgramUserAgreementContainer: ".settings-about-program-user-agreement-container" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: 12%;" +
  "}",

  settingsAboutProgramUserAgreementTitle: ".settings-about-program-user-agreement-title" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "margin-left: 7.5%;" +
  "top: 33%;" +
  "font-size:" + 29 * widthK + "px;" +
  "color: #565d6a;" +
  "}",

  settingsAboutProgramUserAgreementIcon: ".settings-about-program-user-agreement-icon" +
  "{" +
  "position: absolute;" +
  "right:" + 12 * widthK + "px;" +
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
  "}",

  settingsAboutProgramRankTitle: ".settings-about-program-rank-title" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "margin-left: 7.2%;" +
  "top: 25%;" +
  "font-size:" + 29 * widthK + "px;" +
  "color: #565d6a;" +
  "background-repeat: no-repeat;" +
  "background-size: 10%;" +
  "background-position: center;" +
  "}",

  settingsAboutProgramRankIcon: ".settings-about-program-rank-icon" +
  "{" +
  "position: absolute;" +
  "right:" + 12 * widthK + "px;" +
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
  "top:" + 418 * widthK + "px;" +
  "}",

  settingsAboutProgramPageTitle: ".settings-about-program-page-title " +
  "{" +
  "position: absolute;" +
  "top:" + 0 * widthK + "px;" +
  "right:" + 28 * widthK + "px;" +
  "left:" + 25 * widthK + "px;" +
  "height:" + 88 * widthK + "px;" +
  "background: transparent;" +
  //"border-bottom:" + 2 + "px solid rgb(149, 230, 253);" +
  "}",

  settingsAboutProgramNameTitle: ".settings-about-program-name-title " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size:" + 34 * widthK + "px; " +
  "left:" + 77 * widthK + "px; " +
  "top:" + 26 * widthK + "px; " +
  "margin: 0;  " +
  "color: #fffaf9;" +
  "}",

  settingsAboutProgramVersionTitlePartOne: ".settings-about-program-version-title-part-one " +
  "{" +
  "position: relative;" +
  "font-size:" + 40 * widthK + "px; " +
  "width: 50%; " +
  "margin: 0; " +
  "margin-left: 43%; " +
  "margin-top:" + 182 * widthK + "px; " +
  "text-align: left; " +
  "color: #565d6a;" +
  "}",

  settingsAboutProgramVersionTitlePartTwo: ".settings-about-program-version-title-part-two " +
  "{" +
  "position: relative;" +
  "font-size:" + 26 * widthK + "px; " +
  // "width:" + 150 * widthK + "px; " +
  "width: 50%; " +
  "margin: 0; " +
  "margin-left: 43%; " +
  "margin-top: -" + 4 * widthK + "px; " +
  "text-align: left; " +
  //"top: 11%; " +
  "color: #a9abaf;" +
  "}",

  settingsAboutProgramClickIcon: ".settings-about-program-click-icon" +
  "{" +
  "position: absolute;" +
  "position: absolute;" +
  "left:" + 90 * widthK + "px; " +
  "top:" + 154 * widthK + "px; " +
  "width:" + 165 * widthK + "px; " +
  "height:" + 168 * widthK + "px; " +
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
  "right: 0%;" +
  "background-image: url(resources/icons/ViewSettingsFriendHelp/plus.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 30%;" +
  "background-position-y: 55%;" +
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
  "background-color: #00a8f1;" +
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
  "z-index: 2;" +
  "}",


  //SETTINGS SECURITY
  settingsSecurityCheckButton: ".settings-security-check-button " +
  "{" +
  "position: absolute;" +
  "display: none;" +
  "width:" + 135 * widthK + "px;" +
  "height:" + 92 * widthK + "px;" +
  "right:" + -36 * widthK + "px;" +
  "background-image: url('resources/icons/ViewSettingsGeneral/general_save.png');" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 31%;" +
  "background-position-y: center;" +
  "background-position-x:" + 54 * widthK + "px;" +
  "background-size: 31%;" +
  "top: " + 0 * widthK + "px;" +
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
  "top:" + 26 * widthK + "px; " +
  "margin: 0;  " +
  "width: 100%;  " +
  "color: #565d6a;" +
  "}",

  //TRANSFER DETAIL VIEW

  transferDetailCover: ".transfer-detail-cover" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 100 * widthK + "px;" +
  "bottom: 0;" +
  "background-color: #f4f4f4;" +
  "}",

  transferDetailContainer: ".transfer-detail-container" +
  "{" +
  "position: absolute;" +
  //"height:" + 1150 * widthK + "px; " +
  "width:100%; " +
  "top:" + 410 * widthK + "px; " +
  "bottom:0; " +
  "background-color: white; " +
  "overflow-y: hidden; " +
  "overflow-x: hidden; " +
  "}",

  transferDetailTitleContainer: ".transfer-detail-title-container" +
  "{" +
  "position: absolute;" +
  "height:" + 410 * widthK + "px;" +
  "width:100%;" +
  "background-color: white;" +
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
  "height:" + 147 * widthK + "px;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "border-bottom: 1px solid #e8e8e8;" +
  "}",

  transferDetailTransferIcon: ".transfer-detail-transfer-icon" +
  "{" +
  "position: absolute;" +
  "height:" + 142 * widthK + "px;" +
  "width:" + 110 * widthK + "px;" +
  "top:" + 169 * widthK + "px;" +
  "left:" + 120 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "background-position: center;" +
  "background-image: url(resources/icons/bank-operations/transfers.png);" +
  "}",

  transferDetailTransferIconTitlePartOne: ".transfer-detail-transfer-icon-title-part-one " +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "margin: 0;" +
  "color: #565d6a;" +
  "margin-left: 46%;" +
  "margin-top:" + 172 * widthK + "px;" +
  "text-align: left;" +
  "font-size:" + 40 * widthK + "px;" +
  "}",

  transferDetailTransferIconTitlePartTwo: ".transfer-detail-transfer-icon-title-part-two " +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "margin: 0;" +
  "color: #565d6a;" +
  "margin-left: 46%;" +
  "text-align: left;" +
  "font-size:" + 40 * widthK + "px;" +
  "}",

  transferDetailTransferIconTitlePhone: ".transfer-detail-transfer-icon-title-phone " +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "margin: 0;" +
  "color: #a9abaf;" +
  "margin-left: 46%;" +
  "margin-top:" + 8 * widthK + "px;" +
  "text-align: left;" +
  "font-size:" + 24 * widthK + "px;" +
  "}",

  transferDetailTitle: ".transfer-detail-title " +
  "{" +
  "position: absolute;" +
  "top: 19%;" +
  "left: 2.8%;" +
  "font-size:" + 29 * widthK + "px;" +
  "color: #a9abaf;" +
  "margin: 0;" +
  "text-align: center;" +
  "}",

  transferDetailSum: ".transfer-detail-sum " +
  "{" +
  "position: absolute;" +
  "top: 49%;" +
  "left: 2.5%;" +
  "font-size:" + 40 * widthK + "px;" +
  "color: #a9abaf;" +
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
  "position: absolute;" +
  "width:100%;" +
  "height:" + 105 * widthK + "px;" +
  "bottom: 0;" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "}",

  transferDetailButtonCancel: ".transfer-detail-button-cancel" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "float: left;" +
  "text-align: center;" +
  "margin-left: 4%;" +
  "margin-top: " + 15.5 * widthK + "px;" +
  "background-color: #f46b5b;" +
  "font-size: " + 29 * widthK + "px;" +
  "height: " + 74 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "width: 44%;" +
  "color: #ffffff;" +
  "text-transform: capitalize;" +
  "}",

  transferDetailButtonAccept: ".transfer-detail-button-accept" +
  "{" +
  "margin: 0;" +
  "margin-right: 4%;" +
  "margin-top: " + 15.5 * widthK + "px;" +
  "background-color: #00a8f1;" +
  "font-size: " + 29 * widthK + "px;" +
  "position: relative;" +
  "float: right;" +
  "text-align: center;" +
  "height: " + 74 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "width: 44%;" +
  "color: #ffffff;" +
  "text-transform: capitalize;" +
  "}",

  transferDetailCodeConfirm: ".transfer-detail-code-confirm" +
  "{" +
  "position: absolute;" +
  "opacity: 0.95;" +
  "height: 100%;" +
  "width: 100%;" +
  "z-index: 10;" +
  "background-color: #353340;" +
  "}",

  transferDetailCodeConfirmCodeContainer: ".transfer-detail-code-confirm-code-container " +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "width:" + 450 * widthK + "px;" +
  "height:" + 450 * widthK + "px;" +
  // "left:" + 135 * widthK + "px;" +
  "top:" + 100 * widthK + "px;" +
  "}",

  transferDetailCodeConfirmMessageText: ".transfer-detail-code-confirm-message-text " +
  "{" +
  "position: relative;" +
  "width: 81%;" +
  "text-align: center;" +
  "margin:0 auto;" +
  "font-size:" + 31 * widthK + "px;" +
  "color: white;" +
  "}",

  transferDetailCodeConfirmCodeInput: ".transfer-detail-code-confirm-code-input" +
  "{" +
  "position: relative;" +
  "width: 46%;" +
  "height: 25%;" +
  "color: white;" +
  "text-align: center;" +
  "border: none;" +
  "border-bottom:" + 3 * widthK + "px solid #6abfff;" +
  "font-size:" + 100 * widthK + "px;" +
  "background: none;" +
  "margin:" + 35 * widthK + "px " + 125 * widthK + "px;" +
  "outline: none;" +
  "padding: 0;" +
  "}",

  transferDetailCodeConfirmButtonEnter: ".transfer-detail-code-confirm-button-enter" +
  "{" +
  "margin: 0;" +
  "margin-top: 10%;" +
  //"float: left;" +
  "text-align: center;" +
  "background-color: #017ce3;" +
  "font-size: " + 29 * widthK + "px;" +
  "height: " + 74 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "width: 63%;" +
  "border-radius: " + 10 * widthK + "px;" +
  "color: #ffffff;" +
  "text-transform: capitalize;" +
  "left: 19%;" +
  "bottom: 4.4%;" +
  "position: relative;" +
  "}",

  //transferDetailCodeConfirmButtonEnterLabel: ".transfer-detail-code-confirm-button-enter-label" +
  //"{" +
  //"position: relative;" +
  //"top: 17%;" +
  //"width: 100%;" +
  //"font-size: " + 30 * widthK + "px; " +
  //"margin: auto;" +
  //"color: white;" +
  //"margin: 0;" +
  //"text-align: center;" +
  //"}",

  transferDetailCodeConfirmMessageTextInfo: ".transfer-detail-code-confirm-message-text-info" +
  "{" +
  "position: relative;" +
  "width: 106%;" +
  "text-align: center;" +
  "top: 0.5%;" +
  "left: -0.7%;" +
  "margin:0 auto;" +
  "font-size:" + 27 * widthK + "px;" +
  "color: white;" +
  "}",

  //ACCOUNT DETAIL VIEW

  accountDetailCover: ".account-detail-cover" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 100 * widthK + "px;" +
  "bottom: 0;" +
  "background-color: #f4f4f4;" +
  "}",

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
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 105 * widthK + "px;" +
  "bottom: 0;" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "}",

  //accountDetailButtonAccept: ".account-detail-button-accept" +
  //"{" +
  //"position: relative;" +
  //"margin: 0;" +
  //"float: left;" +
  //"text-align: center;" +
  //"margin-left: 1%;" +
  //"color: white;" +
  //"background-color: #00a8f1;" +
  //"height:" + 62 * widthK + "px;" +
  //"line-height:" + 63 * widthK + "px;" +
  //"border-radius:" + 5 * widthK + "px;" +
  //"font-size:" + 29 * widthK + "px;" +
  //"width: 44%;" +
  //"}",
  //
  //accountDetailButtonCancel: ".account-detail-button-cancel" +
  //"{" +
  //"position: relative;" +
  //"margin: 0;" +
  //"float: left;" +
  //"text-align: center;" +
  //"margin-left: 9%;" +
  //"color: white;" +
  //"background-color: #f46b5b;" +
  //"height:" + 62 * widthK + "px;" +
  //"line-height:" + 63 * widthK + "px;" +
  //"border-radius:" + 5 * widthK + "px;" +
  //"font-size:" + 29 * widthK + "px;" +
  //"width: 44%;" +
  //"}",

  accountDetailButtonAccept: ".account-detail-button-cancel" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "float: left;" +
  "text-align: center;" +
  "margin-left: 4%;" +
  "background-color: #f46b5b;" +
  "font-size: " + 29 * widthK + "px;" +
  "margin-top: " + 15.5 * widthK + "px;" +
  "height: " + 74 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "width: 44%;" +
  // "border-radius: " + 10 * widthK + "px;" +
  "color: #ffffff;" +
  "text-transform: capitalize;" +
  "}",

  accountDetailButtonCancel: ".account-detail-button-accept" +
  "{" +
  "margin: 0;" +
  "margin-right: 4%;" +
  "background-color: #00a8f1;" +
  "font-size: " + 29 * widthK + "px;" +
  "position: relative;" +
  "float: right;" +
  "text-align: center;" +
  "margin-top: " + 15.5 * widthK + "px;" +
  "height: " + 74 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "width: 44%;" +
  // "border-radius: " + 10 * widthK + "px;" +
  "color: #ffffff;" +
  "text-transform: capitalize;" +
  "}",

  //VIEW TRANSFER TO CARD ----> VIEW PAYMENT DETAIL

  viewTransferDetail: ".view-transfer-detail" +
  "{" +
  "position: absolute;" +
  "height: 100%;" +
  "width:100%;" +
  "z-index:999999;" +
  "}",

  transferToCardContainer: ".transfer-to-card-container" +
  "{" +
  "position: absolute;" +
  "width: 100%; " +
  "top:" + 410 * widthK + "px; " +
  "bottom:0; " +
  "background-color: #ffffff; " +
  "overflow-y: hidden; " +
  "overflow-x: hidden; " +
  "}",

  transferToCardTitleContainer: ".transfer-to-card-title-container" +
  "{" +
  "position: absolute;" +
  "height:" + 410 * widthK + "px;" +
  "width:100%;" +
  "background-color: white;" +
  "}",

  transferToCardTransferTitlePartOne: ".transfer-to-card-transfer-title-part-one " +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "margin: 0;" +
  "color: #565d6a;" +
  "margin-left: 46%;" +
  "margin-top:" + 172 * widthK + "px;" +
  "text-align: left;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "font-size:" + 40 * widthK + "px;" +
  "}",

  transferToCardTransferTitlePartTwo: ".transfer-to-card-transfer-title-part-two " +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "margin: 0;" +
  "color: #565d6a;" +
  "margin-left: 46%;" +
  "text-align: left;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "font-size:" + 40 * widthK + "px;" +
  "}",

  transferToCardTransferTitlePhone: ".transfer-to-card-transfer-title-phone " +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "margin: 0;" +
  "color: #a9abaf;" +
  "margin-left: 46%;" +
  "margin-top:" + 8 * widthK + "px;" +
  "text-align: left;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "font-size:" + 24 * widthK + "px;" +
  "}",

  changedHeightForPaymentDetail: ".changed-height-for-payment-detail" +
  "{" +
  "height: 48%;" +
  "}",

  changedHeightForFilterAccount: ".changed-height-for-filter-account" +
  "{" +
  "height: 60%;" +
  "}",

  viewPaymentDetail: ".view-payment-detail" +
  "{" +
  "position: absolute;" +
  "height: 100%;" +
  "width:100%;" +
  "z-index:999999;" +
  "}",

  paymentDetailPaymentIcon: ".payment-detail-payment-icon" +
  "{" +
  "position: absolute;" +
  "height:" + 142 * widthK + "px;" +
  "width:" + 110 * widthK + "px;" +
  "top:" + 169 * widthK + "px;" +
  "left:" + 120 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "background-position: center;" +
  "background-image: url(resources/icons/bank-operations/payment.png);" +
  "}",

  paymentDetailPaymentContainer: ".payment-detail-payment-container" +
  "{" +
  "position: relative;" +
  "width: 90%;" +
  "height:" + 148 * widthK + "px;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "border-bottom: 1px solid #e8e8e8;" +
  "}",

  paymentDetailPaymentContainerPayFrom: ".payment-detail-payment-container-pay-from" +
  "{" +
  "position: relative;" +
  "width: 90%;" +
  "height: 8%;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "}",

  paymentDetailTitle: ".payment-detail-title " +
  "{" +
  "position: absolute;" +
  "top: 19%;" +
  "left: 2.8%;" +
  "font-size:" + 29 * widthK + "px;" +
  "color: #a9abaf;" +
  "margin: 0;" +
  "text-align: center;" +
  "}",

  paymentDetailTitlePayFrom: ".payment-detail-title-pay-from " +
  "{" +
  "position: absolute;" +
  "bottom: 0%;" +
  "left: 3%;" +
  "font-size:" + 29 * widthK + "px;" +
  "color: #a9abaf;" +
  "margin: 0;" +
  "text-align: center;" +
  "}",

  paymentDetailCommission: ".payment-detail-commission" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: #c1c1c1;" +
  "font-size:" + 24 * widthK + "px;" +
  "bottom: -37%;" +
  "left: 3%;" +
  "}",

  paymentDetailSum: ".payment-detail-sum " +
  "{" +
  "position: absolute;" +
  "top: 49%;" +
  "left: 2.5%;" +
  "font-size:" + 40 * widthK + "px;" +
  "color: #a9abaf;" +
  "margin: 0;" +
  "text-align: center;" +
  "}",

  paymentDetailNumber: ".payment-detail-number " +
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

//  VIEW REPORTS

  viewReportsPage: ".view-reports-page " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 100%;" +
  "background: white;" +
  "}",

  viewReportsMonthsContainer: ".view-reports-months-container " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 65 * widthK + "px;" +
  "top:" + 98 * heightK + "px;" +
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
  "transform: translate3d(-50%, 0,0);" +
  "-webkit-transform: translate3d(-50%, 0,0);" +
  "text-align: center;" +
  "}",

  viewReportsMonthInfoName: ".view-reports-month-info-name " +
  "{" +
  "position: absolute;" +
  "top: 10%;" +
  "margin: 0;" +
  "color: #565d6a;" +
  "font-size: " + 30 * widthK + "px; " +
  "width: 100%;" +
  "}",

  viewReportsMonthNotStartedYetLabel: ".view-reports-month-not-started-yet-label" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "transform: translate3d(-50%, 0,0);" +
  "-webkit-transform: translate3d(-50%, 0,0);" +
  "width: 100%;" +
  "top: " + 540 * widthK + "px;" +
  "left: 50%;" +
  "font-size: " + 24 * widthK + "px;" +
  "z-index: 1;" +
  "color: #b6b6b6;" +
  "text-align: center;" +
  "}",

  viewReportsBodyContainer: ".view-reports-body-container" +
  "{" +
  "position: absolute;" +
  //"height:" + 1150 * widthK + "px; " +
  "width:100%; " +
  "top:" + 160 * widthK + "px; " +
  "bottom:0; " +
  "background-color: white; " +
  "overflow-y: scroll; " +
  "overflow-x: hidden; " +
  "-webkit-overflow-scrolling: touch; " +
  "}",

  viewReportsGraphBodyContainer: ".view-reports-graph-body-container" +
  "{" +
  "position: absolute;" +
  //"height:" + 1150 * widthK + "px; " +
  "width: 100%; " +
  "top:" + 160 * heightK + "px; " +
  "bottom:0; " +
  "background-color: white; " +
  "}",

  viewReportsGraphFrame: ".view-reports-graph-frame" +
  "{" +
  "position: absolute;" +
  "left: 50%;" +
  "-webkit-transform:translate3d(-50%, 0, 0);" +
  "width:" + 470 * heightK + "px !important; " +
  "height:" + 470 * heightK + "px !important; " +
  "margin-left: auto; " +
  "overflow: visible; " +
  "margin-right: auto; " +
  "background-color: white; " +
  "}",

  viewReportsGraphPercentImageContainer: ".view-reports-graph-percent-image-container" +
  "{" +
  "position: absolute;" +
  "opacity: 0;" +
  "transition: 3s;" +
  "width:" + 79 * heightK + "px; " +
  "height:" + 79 * heightK + "px; " +
  //"transform: translate(-50%, -50%); " +
  "}",

  viewReportsGraphPercent: ".view-reports-graph-percent" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "top: 5%;" +
  "color: white;" +
  "width: 100%;" +
  "text-align: center;" +
  "font-weight: bold;" +
  "font-size:" + 30 * widthK + "px !important; " +
  "}",

  viewReportsGraphImage: ".view-reports-graph-image" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "color: white;" +
  "background-position: center;" +
  "background-size: 70%;" +
  "background-repeat: no-repeat;" +
  "width: 100%;" +
  "height:" + 50 * heightK + "px;" +
  "}",

  filterMenu: ".filter-menu " +
  "{" +
  "position: absolute;" +
  "height: 100%;" +
  "width:" + 610 * widthK + "px;" +
  "overflow: hidden;" +
  "transform: translate3d(0, -100%,0);" +
  "-webkit-transform: translate3d(0, -100%,0);" +
  "-ms-transform: translate3d(0, -100%,0);" +
  "z-index: 1;" +
  "right:0;" +
  //"top:" + topOfIos + "px;" +
  "}",

  filterMainMenu: ".filter-main-menu" +
  "{" +
  "background-color: white;" +
  "}",

  filterMinorMenu: ".filter-minor-menu" +
  "{" +
  "background-color: white;" +
  "}",

  reportFilterFiltersContentContainer: ".report-filter-filters-content-container" +
  "{" +
  "position: absolute;" +
  "top: " + 206 * widthK + "px;" +
  "width: 100%;" +
  "bottom: 0;" +
  "}",

  reportFilterFilterContainer: ".report-filter-filter-container" +
  "{" +
  "width: " + 516 * widthK + "px;" +
  "height: " + 147 * widthK + "px;" +
  "padding: 0px " + 48 * widthK + "px 0 " + 45 * widthK + "px;" +
  "}",

  reportFilterFilterTitle: ".report-filter-filter-title" +
  "{" +
  "margin: 0;" +
  "float: left;" +
  "margin-left: " + 21 * widthK + "px;" +
  "color: #565d6a;" +
  "}",

  reportFilterFilterPlusIcon: ".report-filter-filter-plus-icon" +
  "{" +
  "position: relative;" +
  "left: " + 20 * widthK + "px;" +
  "float: right;" +
  "padding: " + 18 * widthK + "px " + 28 * widthK + "px " + 15 * widthK + "px " + 30 * widthK + "px;" +
  "height: " + 25 * widthK + "px;" +
  "width: " + 25 * widthK + "px;" +
  "}",

  reportFilterFilterChosenFilterContainer: ".report-filter-filter-chosen-filter-container" +
  "{" +
  "position: relative;" +
  "width: 95.7%;" +
  "height: " + 75 * widthK + "px;" +
  "float: left;" +
  //"margin-top: " + 15 * widthK + "px;" +
  "border-top: 1px solid #e8e8e8;" +
  "padding: " + 13.5 * widthK + "px 0 0 4.3%;" +
  "}",

  viewReportsFilterContainer: ".view-reports-filter-container " +
  "{" +
  "position: absolute;" +
  "width:" + 195 * widthK + "px;" +
  "height: 100%;" +
  "right: 12.6%;" +
  "top: 0;" +
  "z-index: 1;" +
  "}",

  viewReportsFilterText: ".view-reports-filter-text " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: #565d6a;" +
  "top: 31%;" +
  "font-size:" + 29 * widthK + "px;" +
  "}",

  viewReportsDateFilterText: ".view-reports-date-filter-text" +
  "{" +
  "margin: 0;" +
  "color: #565d6a;" +
  "top: " + 95 * widthK + "px;" +
  "position: absolute;" +
  "width: 100%;" +
  "text-align: center;" +
  "font-size: " + 30 * widthK + "px;" +
  "}",

  viewReportsAccountFilterText: ".view-reports-account-filter-text" +
  "{" +
  "margin: 0;" +
  "position: absolute;" +
  "top: " + 111 * widthK + "px;" +
  "width: 100%;" +
  "text-align: center;" +
  "font-size: " + 24 * widthK + "px;" +
  "left: " + 6 * widthK + "px;" +
  "color: #525252;" +
  "}",

  viewReportsFilterButton: ".view-reports-filter-button " +
  "{" +
  "position: absolute;" +
  "width:" + 25 * widthK + "px;" +
  "height:" + 20 * widthK + "px;" +
  "right:" + 26 * widthK + "px;" +
  "top: 41%;" +
  "background-image: url('resources/icons/ViewReport/reports_filters.png');" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 100%;" +
  "background-position-y: center;" +
  "background-position-x: center;" +
  "background-size: 100%;" +
  "}",

  reportFilterReadyButton: ".report-filter-ready-button" +
  "{" +
  //"transform: translate3d(-50%, 0,0);" +
  //"-webkit-transform: translate3d(-50%, 0,0);" +
  "text-transform: capitalize;" +
  "left: 28.5%;" +
  "font-size: " + 27 * widthK + "px;" +
  "background-color: #00A1EC;" +
  "height: " + 74 * widthK + "px;" +
  "margin:" + 5 * widthK + "px auto 0 auto;" +
  "padding: 0;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "width: 44%;" +
  "border-radius: " + 10 * widthK + "px;" +
  "color: #ffffff;" +
  "}",

  reportFilterFilterInfoContainer: ".report-filter-filter-info-container" +
  "{" +
  "height: " + 36 * widthK + "px;" +
  "contain: content;" +
  "float: left;" +
  "background-color: #ffffff;" +
  "}",

  reportFilterFilterInfoText: ".report-filter-filter-info-text" +
  "{" +
  "margin: 0;" +
  "font-size: " + 24 * widthK + "px;" +
  "float: left;" +
  "margin-left: " + 20 * widthK + "px;" +
  "margin-top: " + 3 * widthK + "px;" +
  "color: #565d6a;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "max-width: " + 400 * widthK + "px;" +
  "}",

  reportFilterFilterDeleteIcon: ".report-filter-filter-delete-icon" +
  "{" +
  "width: " + 15 * widthK + "px;" +
  "height: " + 15 * widthK + "px;" +
  "padding-left: " + 26 * widthK + "px;" +
  "padding-right: " + 13 * widthK + "px;" +
  "padding-bottom: " + 11 * widthK + "px;" +
  "padding-top: " + 10 * widthK + "px;" +
  "}",

  reportFilterClearFiltersContainer: ".report-filter-clear-filters-container" +
  "{" +
  "height: " + 92 * widthK + "px;" +
  "width: " + 195 * widthK + "px;" +
  "position: absolute;" +
  "top:0;" +
  "left: " + 65 * widthK + "px;" +
  "}",

  reportFilterClearFiltersLabel: ".report-filter-clear-filters-label" +
  "{" +
  "margin: 0;" +
  "right:" + 30 * widthK + "px;" +
  "top: 29%;" +
  "position: absolute;" +
  "font-size: " + 29 * widthK + "px;" +
  "color: #565d6a;" +
  "}",

  reportFilterClearFiltersIcon: ".report-filter-clear-filters-icon" +
  "{" +
  "height: " + 40 * widthK + "px;" +
  "width: " + 30 * widthK + "px;" +
  "background-image: url('resources/icons/ViewReport/garbage.png');" +
  "background-repeat: no-repeat;" +
  "background-size: contain;" +
  "background-position: center;" +
  "position: absolute;" +
  "top: 23%;" +
  "}",

  reportFilterOKButton: ".report-filter-ok-button" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: absolute;" +
  "height: " + 74 * widthK + "px;" +
  "left: 27%;" +
  "width: 44%;" +
  "background-color: #01B8FE;" +
  "border-radius: " + 10 * widthK + "px;" +
  "font-size: " + 27 * widthK + "px;" +
  "color: #ffffff;" +
  "bottom: " + 38 * widthK + "px;" +
  "text-transform: uppercase;" +
  "}",

  filterMenuInsideButton: ".filter-menu-inside-button " +
  "{" +
  "position: absolute;" +
  "width:" + 195 * widthK + "px;" +
  "height:" + 92 * widthK + "px;" +
  "right:" + 90 * widthK + "px;" +
  "top: 0;" +
  "}",

  filterInsideText: ".filter-inside-text " +
  "{" +
  "color: 	#00A1EA;" +
  "}",

  filterInsideButton: ".filter-inside-button " +
  "{" +
  "background-image: url('resources/icons/ViewReport/reports_filters_close.png');" +
  "}",

  filterInsideTextMain: ".filter-inside-text-main " +
  "{" +
  "color: white;" +
  "}",

  filterInsideButtonMain: ".filter-inside-button-main " +
  "{" +
  "background-image: url('resources/icons/ViewReport/reports_filters_close.png');" +
  "}",

  filterMenuBodyContainer: ".filter-menu-body-container " +
  "{" +
  "position: absolute;" +
  "width:84%;" +
  "height:65%;" +
  "left: 9%;" +
  "top: 21.3%;" +
  "}",

  filterMenuTitle: ".filter-menu-title " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: 	#565d6a;" +
  "font-size:" + 32 * widthK + "px;" +
  "width: 35%;" +
  "top: 12%;" +
  "left: 9%;" +
  "}",

  filterMenuBlockContainer: ".filter-menu-block-containter" +
  "{" +
  "position: relative;" +
  "height:" + 90 * widthK + "px; " +
  "width: 100%;" +
  //"left: 4%;" +
  //"margin-top: 1%;" +
  "border-bottom:" + 1 * widthK + "px solid gainsboro;" +
  "background-color: transparent;" +
  "float: left;" +
  "}",

  filterMenuNameField: ".filter-menu-name-field" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "top: " + 26 * widthK + "px; " +
  //"left: 3%;" +
  "text-align: left;" +
  "font-size:" + 29 * widthK + "px; " +
  "color: gray;" +
  "}",

  filterMenuDateIcon: ".filter-menu-date-icon" +
  "{" +
  "position: relative;" +
  "width: 13%;" +
  "height:100%; " +
  "background-repeat: no-repeat;" +
  "background-position-y: center;" +
  "float: left;" +
  "background-size: 65%;" +
  "}",

  filterMenuDateNextIcon: ".filter-menu-date-next-icon" +
  "{" +
  "position: absolute;" +
  "right: 0;" +
  "width: 10%;" +
  "height: 100%;" +
  "top: 0;" +
  "background-repeat: no-repeat;" +
  "background-size: 28%;" +
  "background-position: center;" +
  "background-image: url(resources/icons/ViewInfo/open.png);" +
  "}",


  filterMenuBillingsContainer: ".filter-menu-billings-container " +
  "{" +
  "position: relative;" +
  "top: 32.2%;" +
  "height: 6%;" +
  "width: 77%;" +
  "left: 8%;" +
  "border-bottom: 1px solid #43aee5;" +
  "}",

  filterMenuFavoriteContainer: ".filter-menu-favorite-container " +
  "{" +
  "position: relative;" +
  "top: 32.7%;" +
  "height: 6%;" +
  "width: 77%;" +
  "left: 8%;" +
  "border-bottom: 1px solid #43aee5;" +
  "}",

  viewReportsGraphButton: ".view-reports-graph-button " +
  "{" +
  "position: absolute;" +
  "width:" + 74 * widthK + "px;" +
  "height:" + 87 * widthK + "px;" +
  "right: 2.1%;" +
  "top: 3%;" +
  "background-image: url('resources/icons/ViewReport/reports_chart_off.png');" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 41%;" +
  "background-position-y: center;" +
  "background-position-x: center;" +
  "background-size: 41%;" +
  "}",

  //body

  viewReportsPaymentsContainer: ".view-reports-payments-container" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "}",

  viewReportsPaymentDateContainer: ".view-reports-payment-date-containter" +
  "{" +
  "position: relative;" +
  "height:" + 45 * widthK + "px; " +
  "width: 98%;" +
  // "left: 4%;" +
  // "margin-top: 1%;" +
  //"border-bottom:" + 1 * widthK + "px solid gainsboro;" +
  "background-color: #f6f6f6;" +
  "}",

  viewReportsPaymentDateField: ".view-reports-payment-date-field" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "top: " + 10 * widthK + "px; " +
  "left: 9%;" +
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
  "z-index: 1;" +
  //"margin-top: 1%;" +
  "border-top:" + 1 * widthK + "px solid #f1f1f1;" +
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
  //"border-radius:" + 100 * widthK + "px;" +
  //"border:solid 1px #f1f1f1;" +
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
  "color: #595759;" +
  "float: left;" +
  "}",

  viewReportsPaymentInfoCurrencyField: ".view-reports-payment-info-currency-field" +
  "{" +
  "position: relative;" +
  "top: 42%;" +
  "left: 9%;" +
  "margin: 0;" +
  "font-size:" + 26 * widthK + "px;" +
  "color: #595759;" +
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
  //"height: 100%;" +
  "top: 15%;" +
  "font-size: " + 22 * widthK + "px; " +
  "margin: 0;" +
  "color: #8b8b8b;" +
  "}",

  viewReportsPaymentInfoStateImage: ".view-reports-payment-info-state-image " +
  "{" +
  "position: absolute;" +
  "width:" + 60 * widthK + "px;" +
  "right:" + 5 * widthK + "px;" +
  "height:" + 60 * widthK + "px;" +
  //"height: 100%;" +
  "top: 50%;" +
  "background-repeat: no-repeat;" +
  "background-size: 60%;" +
  "background-position: center;" +
  "margin: 0;" +
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
  "color:#595759;" +
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
  "height:" + 480 * widthK + "px;" +
  "top: 15.5%;" +
  "width: 100%;" +
  "color: black;" +
  "background-color: white;" +
  "}",

  viewReportsGraphContentContainer: ".view-reports-graph-content-container " +
  "{" +
  "position: absolute;" +
  "height:" + 390 * heightK + "px;" +
  "bottom: 0;" +
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
  "border-bottom:" + 1 * widthK + "px solid #f1f1f1;" +
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
  "color: #595759;" +
  "float: left;" +
  "}",

  viewReportsGraphBlockCurrencyField: ".view-reports-graph-block-currency-field" +
  "{" +
  "position: relative;" +
  "top: 51%;" +
  "left: 3%;" +
  "margin: 0;" +
  "font-size:" + 29 * widthK + "px;" +
  "color: #595759;" +
  //"color: #ee4d3d;" +
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
  "background-size: 70%;" +
  "top: 6%;" +
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
  "position: absolute;" +
  //"z-index: 99999999;" +
  "height:" + 305 * widthK + "px; " +
  "width:" + 627 * widthK + "px;" +
  "}",

  addCardCarousel: ".add-card-carousel" +
  "{" +
  "height:" + 289 * widthK + "px;" +
  "width:" + 320 * widthK + "px;" +
  "position: absolute;" +
  "top:" + 7 * widthK + "px;" +
  "left:" + 735 * widthK + "px;" +
  "}",

  addCardCarouselIcon: ".add-card-carousel-icon" +
  "{" +
  "background-image: url(resources/icons/cards/addCard/add_first_card.png);" +
  "height:" + 150 * widthK + "px;" +
  "width:" + 230 * widthK + "px;" +
  "position: absolute;" +
  "top:15%;" +
  "left:17%;" +
  "background-size: 85%;" +
  "background-position-y: 45%;" +
  "background-repeat: no-repeat;" +
  "}",

  addCardCarouselText: ".add-card-carousel-text" +
  "{" +
  "width:100%;" +
  "position: absolute;" +
  "top:70%;" +
  "text-align: center;" +
  "font-size: " + 28 * widthK + "px;" +
  "color: #565d6a;" +
  "}",

//  VIEW BANK LIST

  componentBankList: ".component-bank-list" +
  "{" +
  "position: absolute;" +
  "opacity: 0.97;" +
  "height: 100%;" +
  "width: 100%;" +
  "z-index: 15;" +
  "background-color: #f0f1f4;" +
  //"display: none;" +
  "}",

  componentBankListContainer: ".component-banklist-container" +
  "{" +
  "position: absolute;" +
  "background-color: transparent;" +
  "width: 100%;" +
  "height: 90%;" +
  "top: 8%;" +
  "bottom: 0;" +
  "overflow-y:scroll;" +
  "overflow-x:hidden;" +
  "-webkit-overflow-scrolling: touch; " +
  "margin-bottom: 15px;" +
  "}",

  componentBankListCardFlipper: ".component-banklist-card-flipper" +
  "{" +
  "height: " + 298 * widthK + "px;" +
  "width: " + 302 * widthK + "px;" +
  "position: relative;" +
  "top: " + 13 * widthK + "px;" +
  "float: left;" +
  "margin: " + 4 * widthK + "px;" +
  "left: " + 48 * widthK + "px;" +
  "background-color: white;" +
  "perspective: 1000px;" +
  "transition: 0.6s;" +
  "transform: translate3d(0, 0, 0);" +
  "-webkit-transform: translate3d(0, 0, 0);" +
  "-webkit-transition: 0.6s;" +
  "transform-style: preserve-3d;" +
  "-webkit-transform-style: preserve-3d;" +
  "}",

  componentBankListCardBack: ".component-banklist-card-back" +
  "{" +
  "height: " + 298 * widthK + "px;" +
  "width: " + 302 * widthK + "px;" +
  "position: absolute;" +
  // "top: " + 13 * widthK + "px;" +
  // "float: left;" +
  // "margin: " + 4 * widthK + "px;" +
  // "left: " + 48 * widthK + "px;" +
  "background-color: white;" +
  "backface-visibility: hidden;" +
  "-webkit-backface-visibility: hidden;" +
  "transform: rotateY(180deg);" +
  "-webkit-transform: rotateY(180deg);" +
  "}",

  componentBankListCardFront: ".component-banklist-card-front" +
  "{" +
  "height: " + 298 * widthK + "px;" +
  "width: " + 302 * widthK + "px;" +
  "position: absolute;" +
  // "top: " + 13 * widthK + "px;" +
  // "float: left;" +
  // "margin: " + 4 * widthK + "px;" +
  // "left: " + 48 * widthK + "px;" +
  "background-color: white;" +
  "backface-visibility: hidden;" +
  "-webkit-backface-visibility: hidden;" +
  "z-index: 2;" +
  "transform: rotateY(0deg);" +
  "-webkit-transform: rotateY(0deg);" +
  "}",


  componentBankListNameTitle: ".component-banklist-name-title " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size:" + 35 * widthK + "px;" +
  "left: 6%;" +
  "top: 31%;" +
  "margin: 0;" +
  "color: #353340;" +
  "}",

  componentBankListCloseButton: ".component-banklist-close-button " +
  "{" +
  "position: absolute;" +
  "width:" + 87 * widthK + "px;" +
  "height:" + 87 * widthK + "px;" +
  "right: 1.5%;" +
  "background-image: url('resources/icons/ViewTransfer/banks_close.png');" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 40%;" +
  "background-position-y: center;" +
  "background-position-x: center;" +
  "background-size: 40%;" +
  "}",

  componentBankListRotate: ".component-banklist-bank-rotate" +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "height:" + 30 * widthK + "px;" +
  "width:" + 30 * widthK + "px;" +
  "top: 4%;" +
  "float: right;" +
  "right: 7%;" +
  "background-image: url('resources/icons/ViewTransfer/banks_rotate.png');" +
  "}",

  componentBankListBankLogo: ".component-banklist-bank-logo" +
  "{" +
  "position: absolute;" +
  "top:" + 10 * widthK + "px;" +
  "right:" + 51 * widthK + "px;" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "font-size:" + 36 * widthK + "px;" +
  "height:" + 122 * widthK + "px;" +
  "width:" + 200 * widthK + "px;" +
  "background-position: top right;" +
  "background-position-x: center;" +
  "background-position-y: center;" +
  "}",

  componentBankListBankLogoFront: ".component-banklist-bank-logo-front" +
  "{" +
  "position: absolute;" +
  "top:" + 74 * widthK + "px;" +
  "right:" + 28.5 * widthK + "px;" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "height:" + 150 * widthK + "px;" +
  "width:" + 245 * widthK + "px;" +
  "background-position: top right;" +
  "background-position-x: center;" +
  "background-position-y: center;" +
  "}",


  componentBankListBankLimitContainer: ".component-banklist-bank-limit-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 34%;" +
  "top: 42%;" +
  "display: inline-block;" +
  "margin: 0;" +
  "}",

  componentBankListBankLimitReceiptContainer: ".component-banklist-bank-limit-receipt-container" +
  "{" +
  "position: relative;" +
  "display: inline-block;" +
  "top: 0%;" +
  "left: 10%;" +
  "margin: 0;" +
  "}",

  componentBankListBankLimitTransferContainer: ".component-banklist-bank-limit-transfer-container" +
  "{" +
  "position: relative;" +
  "display: inline-block;" +
  "top: 0%;" +
  "left: 10%;" +
  "margin: 0;" +
  "}",

  componentBankListArrowDown: ".component-banklist-bank-arrow-down" +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "height:" + 22 * widthK + "px;" +
  "width:" + 20 * widthK + "px;" +
  "left: 0%;" +
  "background-image: url('resources/icons/ViewTransfer/banks_limit_receipt.png');" +
  "}",

  componentBankListArrowUp: ".component-banklist-bank-arrow-up" +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "height:" + 22 * widthK + "px;" +
  "width:" + 20 * widthK + "px;" +
  "left: 0%;" +
  "background-image: url('resources/icons/ViewTransfer/banks_limit_transfer.png');" +
  "}",

  componentBankListBankLimitReceipt: ".component-banklist-bank-limit-receipt " +
  "{" +
  "position: relative;" +
  "top: 0%;" +
  "left: 10%;" +
  "margin: 0;" +
  "font-size:" + 20 * widthK + "px;" +
  "color: #585658;" +
  "float: left;" +
  "width: 92%;" +
  "}",

  componentBankListBankLimitTransfer: ".component-banklist-bank-limit-transfer " +
  "{" +
  "position: relative;" +
  "top: 2%;" +
  "left: 10%;" +
  "margin: 0;" +
  "font-size:" + 20 * widthK + "px;" +
  "color: #585658;" +
  "float: left;" +
  "width: 92%;" +
  "}",

  componentBankListBankLimitCurrencyReceipt: ".component-banklist-bank-limit-currency-receipt" +
  "{" +
  "position: relative;" +
  "top: 0%;" +
  "left: 10%;" +
  "margin: 0;" +
  "font-size:" + 22 * widthK + "px;" +
  "color: #aed83d;" +
  "float: left;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "width: 90%;" +
  "}",

  componentBankListBankLimitCurrencyTransfer: ".component-banklist-bank-limit-currency-transfer" +
  "{" +
  "position: relative;" +
  "top: 0%;" +
  "left: 10%;" +
  "margin: 0;" +
  "font-size:" + 22 * widthK + "px;" +
  "color: #ff8067;" +
  "float: left;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "width: 90%;" +
  "}",

  componentBankListPublicOfferContainer: ".component-banklist-public-offer-container" +
  "{" +
  "position: relative;" +
  "top: " + 253 * widthK + "px;" +
  "background-color: #09b1ff;" +
  "margin: auto;" +
  "width: " + 301 * widthK + "px;" +
  "height: " + 45 * widthK + "px;" +
  "font-weight: bold;" +
  "text-decoration: none;" +
  "font-size:" + 18 * widthK + "px;" +
  "color: white;" +
  "}",

  componentBankListPublicOfferLink: ".component-banklist-public-offer-link" +
  "{" +
  "position: absolute;" +
  "top: 30%;" +
  "float: left;" +
  "left: 10%;" +
  "}",

  componentBankListPublicOfferArrow: ".component-banklist-public-offer-arrow" +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "height:" + 11 * widthK + "px;" +
  "width:" + 11 * widthK + "px;" +
  "top: 38%;" +
  "float: right;" +
  "right: 9%;" +
  "background-image: url('resources/icons/ViewTransfer/banks_offerta.png');" +
  "}",

//  VIEW FAVORITES

  viewFavoritesContainer: ".view-favorites-container" +
  "{" +
  "position: absolute;" +
  //"height:" + 1150 * widthK + "px; " +
  "width: 100%; " +
  "top:" + 87 * widthK + "px; " +
  "bottom:0; " +
  "background-color: white; " +
  "overflow-y: auto; " +
  "overflow-x: hidden; " +
  "}",

  viewFavoritesBlockContainer: ".view-favorites-block-containter" +
  "{" +
  "position: relative;" +
  "height:" + 150 * widthK + "px; " +
  "width: 91%;" +
  "left: 4%;" +
  "margin-top: 1%;" +
  "border-bottom:" + 1 * widthK + "px solid gainsboro;" +
  "background-color: transparent;" +
  "}",

  viewFavoritesBlockInnerContainer: ".view-favorites-block-inner-containter" +
  "{" +
  "position: absolute;" +
  "height:100%;" +
  "width: 100%;" +
  "}",


  viewFavoritesIcon: ".view-favorites-icon " +
  "{" +
  //"top:" + 50 * widthK + "px;" +
  "background-size: 80%;" +
  "position: absolute;" +
  "width:" + 125 * widthK + "px;" +
  "height:" + 125 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "top: 6%;" +
  "}",

  viewFavoritesInfoContainer: ".view-favorites-info-container " +
  "{" +
  "position: absolute;" +
  "height: 100%;" +
  "width: 72%;" +
  "left: 21%;" +
  "color: #8b8b8b;" +
  "}",

  viewFavoritesInfoName: ".view-favorites-info-name " +
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

  viewFavoritesInfoBalance: ".view-favorites-info-balance " +
  "{" +
  "position: relative;" +
  "top: 30%;" +
  "left: 8%;" +
  "margin: 0;" +
  "font-size:" + 45 * widthK + "px;" +
  "color: #595759;" +
  "float: left;" +
  "}",

  viewFavoritesInfoCurrencyField: ".view-favorites-info-currency-field" +
  "{" +
  "position: relative;" +
  "top: 42%;" +
  "left: 9%;" +
  "margin: 0;" +
  "font-size:" + 26 * widthK + "px;" +
  "color: #595759;" +
  "float: left;" +
  "}",

  viewFavoritesInfoNumber: ".view-favorites-info-number " +
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

  viewFavoritesDeleteIcon: ".view-favorites-delete-icon" +
  "{" +
  "position: absolute;" +
  "right: 0;" +
  "width: 10%;" +
  "height: 100%;" +
  "background-repeat: no-repeat;" +
  "background-size: 36%;" +
  "background-position: center;" +
  "background-image: url(resources/icons/services/delete.png);" +
  "}",

  viewFavoritesEditIcon: ".view-favorites-edit-icon" +
  "{" +
  "position: absolute;" +
  "right: 10%;" +
  "width: 10%;" +
  "height: 100%;" +
  "background-repeat: no-repeat;" +
  "background-size: 36%;" +
  "background-position: center;" +
  "background-image: url(resources/icons/services/edit_favorite.png);" +
  "}",


  //VIEW ADD CARD

  viewAddCard: ".view-add-card " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "bottom: 0;" +
  "top:" + 87 * widthK + "px;" +
  "overflow: hidden;" +
  "background-size: contain;" +
  "background-color: white;" +
  "background-repeat: no-repeat;" +
  "}",

  viewAddNextButton: ".view-add-next-button " +
  "{" +
  "position: absolute;" +
  "height: " + 74 * widthK + "px;" +
  "top: " + 440 * heightK + "px;" +
  //"top: 50%;" +
  "background-color: #00a8f1;" +
  "padding: 0;" +
  "font-size: " + 32 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "left: 28%;" +
  "width: 44%;" +
  "border-radius: " + 10 * widthK + "px;" +
  "color: #ffffff;" +
  "text-transform: capitalize;" +
  "}",

  addCardCardField: ".add-card-card-field " +
  "{" +
  "position: relative;" +
  "top:" + 132 * heightK + "px;" +
  "width:" + 610 * widthK + "px;" +
  "height:" + 340 * heightK + "px;" +
  "border:" + 1 + "px solid #e7e7e7;" +
  //"border:" + 3 * heightK + "px solid #e7e7e7;" +
  "background-color: white;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "border-radius:" + 10 * heightK + "px;" +
  "background-image: url(resources/icons/cards/addCard/new_card.png);" +
  "background-repeat: no-repeat;" +
  "background-size: cover;" +
  "}",


  addCardUzcardIcon: ".add-card-uzcard-icon " +
  "{" +
  // "visibility: hidden;" +
  "position: absolute;" +
  "top:5%;" +
  "right:1%;" +
  "width: 30%;" +
  "height: 18%;" +
  "background-repeat: no-repeat;" +
  "background-size: 70%;" +
  "background-position: center;" +
  "}",

  addCardMainCardField: ".add-card-main-card-field " +
  "{" +
  "position: absolute;" +
  "top: 49%;" +
  "width: 84%;" +
  "height: 6%;" +
  "left: 8%;" +
  "border-top: 1px solid #e7e7e7;" +
  "border-bottom: 1px solid #e7e7e7;" +
  "font-size:" + 30 * widthK + "px;" +
  "}",

  addCardMainCardText: ".add-card-main-card-text " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "top: 22%;" +
  "color: #3b3b3b;" +
  "}",

  addCardMainCardIcon: ".add-card-main-card-icon " +
  "{" +
  "position: absolute;" +
  "right: -4%;" +
  "width: 15%;" +
  "height: 100%;" +
  "background-repeat: no-repeat;" +
  "background-size: 49%;" +
  "background-position: center;" +
  "background-image: url(resources/icons/ViewService/unchecked.png);" +
  "}",

  addCardCardNumberText: ".add-card-card-number-text " +
  "{" +
  "left: 7%;" +
  "top: 13%;" +
  "}",

  addCardTextField: ".add-card-text-field " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "text-align: center;" +
  "color: #757389;" +
  "font-size:" + 24 * widthK + "px;" +
  "top: 3%;" +
  "left: 8%;" +
  "}",

  addCardCardNumber: ".add-card-card-number " +
  "{" +
  "position: absolute;" +
  "padding: 0;" +
  "color: white;" +
  "background-color: white;" +
  "border:" + 1 + "px solid #e7e7e7;" +
  "width:" + 550 * widthK + "px;" +
  "height:" + 71 * widthK + "px;" +
  "left: 5%;" +
  "top: 27%;" +
  "}",

  addCardCardNumberBox: ".add-card-card-number-box " +
  "{" +
  "position: absolute;" +
  "width:96%;" +
  "height: 100%;" +
  "top: 4%;" +
  "padding: 0;" +
  "background-color: transparent;" +
  "border: none;" +
  "outline: none;" +
  "font-size:" + 36 * widthK + "px;" +
  "font-family: 'OCRAStd';" +
  //"letter-spacing:1px;" +
  "word-spacing:" + 4 * widthK + "px;" +
  "}",

  addCardCardNumberBoxOne: ".add-card-card-number-box-one " +
  "{" +
  "left:" + 21 * widthK + "px;" +
  "}",

  addCardCardText: ".add-card-card-text " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "background-size: contain;" +
  "color: #757389;" +
  "font-size:" + 28 * widthK + "px;" +
  "}",

  addCardCardTextDate: ".add-card-card-text-date " +
  "{" +
  "left: 7%;" +
  "width: 200%;" +
  "top: 53%;" +
  "}",

  addCardCardTextPin: ".add-card-card-text-pin " +
  "{" +
  "bottom: 36%;" +
  "left: 46%;" +
  "width: 200%;" +
  "}",

  addCardCardDate: ".add-card-card-date " +
  "{" +
  "position: absolute;" +
  "padding: 0;" +
  "color: white;" +
  "background-color: white;" +
  "border:" + 1 + "px solid #e7e7e7;" +
  "width: 29%;" +
  "height:" + 71 * widthK + "px;" +
  "left: 5%;" +
  "top: 66%;" +
  "}",


  addCardBankIcon: ".add-card-bankIcon" +
  "{" +
  "position: absolute;" +
  "width:" + 185 * widthK + "px;" +
  "height:" + 90 * widthK + "px;" +
  "bottom: 13%;" +
  "right: 3%;" +
  "background-size: contain;" +
  "background-position: center;" +
  "background-repeat: no-repeat;" +
  // "display: none;" +
  // "visibility: hidden;" +
  "}",

  addCardCardDateBox: ".add-card-card-date-box " +
  "{" +
  "position: absolute;" +
  "width:80%;" +
  "height:97%;" +
  "left:" + 20 * widthK + "px;" +
  "top: 3%;" +
  "padding: 0;" +
  "background-color: transparent;" +
  "outline: none;" +
  "border: none;" +
  "font-size:" + 37 * widthK + "px;" +
  "font-family: 'OCRAStd';" +
  "}",

  addCardCardPin: ".add-card-card-pin " +
  "{" +
  "position: absolute;" +
  "padding: 0;" +
  "color: white;" +
  "background-color: white;" +
  "border:" + 3 * heightK + "px solid #e7e7e7;" +
  "width: 26%;" +
  "height: 18%;" +
  "left: 46%;" +
  "bottom: 14%;" +
  "}",

  addCardCardDatePinBox: ".add-card-card-date-pin-box " +
  "{" +
  "position: absolute;" +
  "width: 65%;" +
  "left: 19%;" +
  "height: 60%;" +
  "top: 20%;" +
  "background-color: transparent;" +
  "border: none;" +
  //"outline: none;" +
  "border: none;" +
  "font-size:" + 32 * widthK + "px;" +
  "letter-spacing:" + 12 * widthK + "px;" +
  "}",

  addCardPageTitle: ".add-card-page-title " +
  "{" +
  "position: absolute;" +
  "top: 0;" +
  "right:" + 28 * widthK + "px;" +
  "left:" + 25 * widthK + "px;" +
  "height:" + 92 * widthK + "px;" +
  "background: transparent;" +
  //"border-bottom:" + 2 + "px solid rgb(149, 230, 253);" +
  "}",

  addCardNameTitle: ".add-card-name-title " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size:" + 35 * widthK + "px; " +
  "left:" + 85 * widthK + "px; " +
  "top:" + 27 * widthK + "px; " +
  "margin: 0;  " +
  "color: #fffaf9;" +
  "}",

  addCardBackButton: ".add-card-back-button " +
  "{" +
  "position: absolute;" +
  "width:" + 113 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "background-image: url(resources/icons/back/back.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 19%;" +
  "background-position-y: 43%;" +
  "background-position-x: center;" +
  "background-size: 17%;" +
  "right: 87%;" +
  "}",

  addCardCardNameInputPartContainer: ".add-card-card-name-input-part-container" +
  "{" +
  "position: absolute;" +
  "top: 6%;" +
  "padding: 0;" +
  "margin: 0;" +
  "margin-left: 8%;" +
  "margin-right: 8%;" +
  "width: 84%;" +
  "height: 6%;" +
  "font-size:" + 51 * widthK + "px;" +
  "border:" + 3 * heightK + "px solid #e7e7e7;" +
  "color: #515151;" +
  "}",

  addCardCardNameInputPart: ".add-card-card-name-input-part" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: absolute;" +
  "padding: 0;" +
  "top: 12%;" +
  "margin: 0;" +
  "width: 100%;" +
  "font-size:" + 39 * widthK + "px;" +
  "font-family: 'SFUIDisplay-Light';" +
  "}",

  //VIEW INVOICE HISTORY DETAIL
  viewInvoiceHistory: ".view-invoice-history" +
  "{" +
  "position: absolute;" +
  "height: 100%;" +
  "width:100%;" +
  "z-index:999999;" +
  "}",

  invoiceHistoryDetailTitleContainer: ".invoice-history-detail-title-container" +
  "{" +
  "position: absolute;" +
  "height:" + 410 * widthK + "px;" +
  "width:100%;" +
  "background-color: white;" +
  "}",

  invoiceHistoryDetailTitle: ".invoice-history-detail-title" +
  "{" +
  "position: absolute;" +
  "top: 0px;" +
  "right:" + 28 * widthK + "px;" +
  "left:" + 19 * widthK + "px;" +
  "height:" + 84 * widthK + "px;" +
  "background: transparent;" +
  "border: none;" +
  "}",

  invoiceHistoryDetailIcon: ".invoice-history-detail-icon" +
  "{" +
  "position: absolute;" +
  "height:" + 142 * widthK + "px;" +
  "width:" + 110 * widthK + "px;" +
  "top:" + 169 * widthK + "px;" +
  "left:" + 120 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "background-position: center;" +
  "}",

  invoiceHistoryDetailGeneralBackButton: ".invoice-history-detail-general-back-button " +
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

  invoiceHistoryDetailPaymentIcon: ".invoice-history-detail-payment-icon" +
  "{" +
  "background-image: url(resources/icons/bank-operations/payment.png);" +
  "}",

  invoiceHistoryDetailTransferIcon: ".invoice-history-detail-transfer-icon" +
  "{" +
  "background-image: url(resources/icons/bank-operations/transfers.png);" +
  "}",

  invoiceHistoryDetailTitlePartOne: ".invoice-history-detail-title-part-one" +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "margin: 0;" +
  "color: #565d6a;" +
  "margin-left: 46%;" +
  "margin-top:" + 172 * widthK + "px;" +
  "text-align: left;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "font-size:" + 40 * widthK + "px;" +
  "}",

  invoiceHistoryDetailTitlePhoneNumber: ".invoice-history-detail-title-phone-number" +
  "{" +
  "position: relative;" +
  "width: 50%;" +
  "margin: 0;" +
  "color: #a9abaf;" +
  "margin-left: 46%;" +
  "margin-top:" + 8 * widthK + "px;" +
  "text-align: left;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "font-size:" + 24 * widthK + "px;" +
  "}",

  invoiceHistoryDetailContainer: ".invoice-history-detail-container" +
  "{" +
  "position: absolute;" +
  "width: 100%; " +
  "top:" + 410 * widthK + "px; " +
  "bottom:0; " +
  "background-color: #ffffff; " +
  "overflow-y: hidden; " +
  "overflow-x: hidden; " +
  "}",

  invoiceHistoryDetailInvoiceContainer: ".invoice-history-detail-invoice-container" +
  "{" +
  "position: relative;" +
  "width: 90%;" +
  "height:" + 120 * heightK + "px;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "border-bottom: 1px solid #e8e8e8;" +
  "}",

  invoiceHistoryDetailInvoiceTitle: ".invoice-history-detail-invoice-title" +
  "{" +
  "position: absolute;" +
  "top: 19%;" +
  "left: 2.8%;" +
  "font-size:" + 29 * widthK + "px;" +
  "color: #a9abaf;" +
  "margin: 0;" +
  "text-align: center;" +
  "}",

  invoiceHistoryDetailStatus: ".invoice-history-detail-status " +
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

  invoiceHistoryDetailStatusWait: ".invoice-history-detail-status-wait" +
  "{" +
  "color: #f3ba31;" +
  "}",

  invoiceHistoryDetailStatusSuccess: ".invoice-history-detail-status-success" +
  "{" +
  "color: #6ABD38;" +
  "}",

  invoiceHistoryDetailStatusDeleted: ".invoice-history-detail-status-deleted" +
  "{" +
  "color: #ff6d65;" +
  "}",

  invoiceHistoryDetailCover: ".invoice-history-detail-cover" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "bottom: 0;" +
  "background-color: #f4f4f4;" +
  "top: 90%;" +
  "}",

  invoiceHistoryDetailData: ".invoice-history-detail-data" +
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

  invoiceHistoryDetailSum: ".invoice-history-detail-sum " +
  "{" +
  "position: absolute;" +
  "top: 49%;" +
  "left: 2.5%;" +
  "font-size:" + 40 * widthK + "px;" +
  "color: #a9abaf;" +
  "margin: 0;" +
  "text-align: center;" +
  "color: #9ec94a;" +
  "}",

  invoiceHistoryDetailNumber: ".invoice-history-detail-number " +
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

  //VIEW CONTACT

  viewContact: ".view-contact " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "bottom: 0;" +
  "top:" + 92 * heightK + "px;" +
  "overflow: hidden;" +
  "background-size: contain;" +
  "background-color: white;" +
  "background-repeat: no-repeat;" +
  "}",

  viewContactPageTitle: ".view-contact-page-title " +
  "{" +
  "position: absolute;" +
  "top: 0;" +
  "right:" + 28 * widthK + "px;" +
  "left:" + 25 * widthK + "px;" +
  "height:" + 92 * widthK + "px;" +
  "background: transparent;" +
  //"border-bottom:" + 2 + "px solid rgb(149, 230, 253);" +
  "}",

  viewContactNameTitle: ".view-contact-name-title " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size:" + 35 * widthK + "px; " +
  "left:" + 85 * widthK + "px; " +
  "top:" + 24 * widthK + "px; " +
  "margin: 0;  " +
  "color: #fffaf9;" +
  "}",

  viewContactBackButton: ".view-contact-back-button " +
  "{" +
  "position: absolute;" +
  "width:" + 113 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "background-image: url(resources/icons/back/back.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 19%;" +
  "background-position-y: 43%;" +
  "background-position-x: center;" +
  "background-size: 17%;" +
  "right: 87%;" +
  "}",

  viewContactInfoTitle: ".view-contact-info-title " +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height:" + 150 * widthK + "px;" +
  "}",

  viewContactInfoIcon: ".view-contact-info-icon " +
  "{" +
  "position: relative;" +
  "width:" + 95 * widthK + "px;" +
  "height:" + 95 * widthK + "px;" +
  "float: left;" +
  "color: white;" +
  "margin-left: 6%;" +
  "background-color: #0099e2;" +
  "margin-top: 4%;" +
  "border-radius:" + 100 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-size: cover;" +
  "text-align: center;" +
  "line-height:" + 100 * widthK + "px;" +
  "font-size:" + 32 * widthK + "px;" +
  "}",

  viewContactInfoText: ".view-contact-info-text " +
  "{" +
  "position: relative;" +
  "float: left;" +
  "color: #7a808d;" +
  "margin: 0;" +
  "margin-left: 4%;" +
  "width: 60%;" +
  "margin-top: 7%;" +
  "font-size:" + 40 * widthK + "px;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "white-space: nowrap;" +
  "}",

  viewContactPayTransferContainer: ".view-contact-pay-transfer-container " +
  "{" +
  "position: relative;" +
  "width: 90%;" +
  "margin-left: auto;" +
  "border-top: 1px solid #e8e8e8;" +
  "margin-right: auto;" +
  "height:" + 105 * widthK + "px;" +
  "}",

  viewContactPayDeleteContainer: ".view-contact-pay-delete-container " +
  "{" +
  "position: relative;" +
  "width: 90%;" +
  "margin-left: auto;" +
  "border-top: 1px solid #e8e8e8;" +
  "margin-right: auto;" +
  "height:" + 105 * widthK + "px;" +
  "}",

  viewContactDeleteIcon: ".view-contact-delete-icon " +
  "{" +
  "position: absolute;" +
  "width: 8%;" +
  "height: 80%;" +
  "top: 7%;" +
  "left: 1%;" +
  "background-image: url(resources/icons/ViewContact/contact_remove.png);" +
  "background-repeat: no-repeat;" +
  "background-position: left;" +
  "background-size: 70%;" +
  "}",

  viewContactPayIcon: ".view-contact-pay-icon " +
  "{" +
  "position: absolute;" +
  "width: 8%;" +
  "height: 80%;" +
  "top: 7%;" +
  "left: 1%;" +
  "background-image: url(resources/icons/ViewContact/contact_pay.png);" +
  "background-repeat: no-repeat;" +
  "background-position: left;" +
  "background-size: 63%;" +
  "}",

  viewContactTransferIcon: ".view-contact-transfer-icon " +
  "{" +
  "position: absolute;" +
  "width: 8%;" +
  "height: 80%;" +
  "top: 7%;" +
  "background-image: url(resources/icons/ViewContact/contact_transfer.png);" +
  "background-repeat: no-repeat;" +
  "background-position: left;" +
  "background-size: 90%;" +
  "}",

  viewContactOpenIcon: ".view-contact-open-icon " +
  "{" +
  "position: absolute;" +
  "width: 20%;" +
  "height: 80%;" +
  "right: -6%;" +
  "top: 12%;" +
  "background-image: url(resources/icons/ViewInfo/open.png);" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: 9%;" +
  "}",

  viewContactPayTitle: ".view-contact-pay-title " +
  "{" +
  "position: absolute;" +
  //"width: 60%;" +
  "left: 10%;" +
  "top: 4%;" +
  "text-align: center;" +
  "font-size:" + 29 * widthK + "px;" +
  "color: #8b8b8b;" +
  "}",

  viewContactTransferTitle: ".view-contact-transfer-title " +
  "{" +
  "position: absolute;" +
  //"width: 65%;" +
  "left: 10%;" +
  "top: 3%;" +
  "text-align: center;" +
  "font-size:" + 29 * widthK + "px;" +
  "color: #8b8b8b;" +
  "}",


  //CONTACT SELECT

  viewContactSelectContainer: ".view-contact-select-container " +
  "{" +
  "position: absolute;" +
  "opacity: 0.98;" +
  "height: 100%;" +
  "width: 101%;" +
  "display: none;" +
  "background-color: white;" +
  "}",

  viewContactSelectInfoTitle: ".view-contact-select-info-title " +
  "{" +
  "position: relative;" +
  "top: 7%;" +
  "width: 100%;" +
  "height:" + 150 * widthK + "px;" +
  "}",

  viewContactSelectChooseTitle: ".view-contact-select-choose-title " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left: 10.5%;" +
  "top: 25%;" +
  //"font-size:" + 29 * widthK + "px;" +
  //"color: #8b8b8b;" +
  "}",

  viewContactSelectPhoneNumberContainer: ".view-contact-select-phone-number-container " +
  "{" +
  "position: relative;" +
  "width: 78%;" +
  "height: 15%;" +
  "background-color: white;" +
  "margin: 0;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "margin-top: 1%;" +
  "}",

  viewContactSelectPhoneNumber: ".view-contact-select-phone-number" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "background-size: contain;" +
  "left: 9%;" +
  "top: 36%;" +
  "color: #a1a1a2;" +
  "overflow: hidden;" +
  "width: 84%;" +
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
  "}",

  viewContactSelectPhoneContainer: ".view-contact-select-phone-container " +
  "{" +
  "position: absolute;" +
  "height:" + 800 * heightK + "px;" +
  "width: 100%;" +
  "overflow: auto;" +
  "top: 30%;" +
  //"display: none;" +
  "background-color: #efeff1;" +
  "}",

  viewContactSelectXButton: ".view-contact-select-x-button " +
  "{" +
  "position: absolute;" +
  "width:" + 135 * widthK + "px;" +
  "height:" + 92 * widthK + "px;" +
  "right:" + -36 * widthK + "px;" +
  "background-image: url('resources/icons/ViewTransfer/banks_close.png');" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 22%;" +
  "background-position-y: center;" +
  "background-position-x:" + 54 * widthK + "px;" +
  "background-size: 22%;" +
  "top: 0;" +
  "}",

  //VIEW QR
  viewQrBlueContainer: ".view-qr-blue-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "z-index: 2;" +
  "height:" + 410 * widthK + "px;" +
  "background-color: white;" +
  "}",

  viewQrContainer: ".view-qr-container" +
  "{" +
  "position: absolute;" +
  //"height:" + 1150 * widthK + "px; " +
  "width: 100%; " +
  "top:" + 92 * widthK + "px; " +
  "bottom:0; " +
  "background-color: #f4f4f4; " +
  "overflow: hidden; " +
  "top:" + 410 * widthK + "px;" +
  "}",

  viewQrPageTitle: ".view-qr-page-title " +
  "{" +
  "position: absolute;" +
  "top:" + 0 * widthK + "px;" +
  "right:" + 28 * widthK + "px;" +
  "left:" + 25 * widthK + "px;" +
  "height:" + 88 * widthK + "px;" +
  "background: transparent;" +
  //"border-bottom:" + 2 + "px solid rgb(149, 230, 253);" +
  "}",

  viewQrNameTitle: ".view-qr-name-title " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size:" + 34 * widthK + "px; " +
  "left:" + 77 * widthK + "px; " +
  "top:" + 26 * widthK + "px; " +
  "margin: 0;  " +
  "color: ##565d6a;" +
  "}",

  viewQrCompanyName: ".view-qr-company-name " +
  "{" +
  "position: relative;" +
  "font-size:" + 40 * widthK + "px; " +
  "width: 50%; " +
  "text-align: left; " +
  "margin: 0; " +
  "margin-left: 46%; " +
  "margin-top:" + 172 * widthK + "px; " +
  "color: #565d6a;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "}",

  viewQrAddressName: ".view-qr-address-name " +
  "{" +
  "position: relative;" +
  "font-size:" + 24 * widthK + "px; " +
  "width: 50%; " +
  "text-align: left; " +
  "margin: 0; " +
  "margin-left: 46%; " +
  "margin-top:" + 8 * widthK + "px; " +
  "color: #a9abaf;" +
  "text-overflow: ellipsis;" +

  //"white-space: nowrap;" +
  "overflow: hidden;" +
  "}",

  viewQrCompanyIcon: ".view-qr-company-icon" +
  "{" +
  "position: absolute;" +
  "left:" + 55 * widthK + "px; " +
  "top:" + 130 * widthK + "px; " +
  "width:" + 235 * widthK + "px; " +
  "height:" + 235 * widthK + "px; " +
  "background-repeat: no-repeat;" +
  "background-size: cover;" +
  "background-position: center;" +
  "}",

  viewQrContactPhoneFieldContainer: ".view-qr-contact-phone-field-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 100%;" +
  "background-color: #fafafa;" +
  "}",

  viewQrContactPhoneField: ".view-qr-contact-phone-field" +
  "{" +
  "position: absolute;" +
  "left: 10%;" +
  "width: 80%;" +
  "height:" + 140 * widthK + "px;" +
  "border-bottom:" + 3 * widthK + "px solid #e8e8e8;" +
  "color: white;" +
  "top:" + 43 * widthK + "px;" +
  "}",

  viewQrContactTextField: ".view-qr-contact-text-field" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: #565d6a;" +
  "font-size:" + 32 * widthK + "px;" +
  "}",

  viewQrContactNumberInputPart: ".view-qr-contact-number-input-part" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "top: 53%;" +
  "padding: 0;" +
  "margin: 0;" +
  "font-size:" + 40 * widthK + "px;" +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #565d6a;" +
  "background: transparent;" +
  "}",

  viewQrContactNumberInputCommission: ".view-qr-contact-number-input-commission" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 24 * widthK + "px;" +
  "bottom: -30%;" +
  "}",

  viewQrButtonsContainer: ".view-qr-buttons-container" +
  "{" +
  "position: absolute;" +
  "width:100%;" +
  "height:" + 90 * widthK + "px;" +
  "top: 29%;" +
  "background-image: url(resources/icons/invoice/invoice_footer.png);" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "padding-top:" + 60 * widthK + "px;" +
  "}",

  viewQrButtonAccept: ".view-qr-button-accept" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "height: " + 74 * widthK + "px;" +
  "font-size: " + 32 * widthK + "px;" +
  "top: 60%;" +
  "background-color: #00a8f1;" +
  "padding: 0;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "left: 28%;" +
  "width: 44%;" +
  "border-radius: " + 10 * widthK + "px;" +
  "color: #ffffff;" +
  "}",

  viewQrButtonCancel: ".view-qr-button-cancel" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "float: left;" +
  "text-align: center;" +
  "margin-left: 13%;" +
  "margin-top: 2%;" +
  "color: white;" +
  "background-color: white;" +
  "color: #c0c0c0;" +
  "height:" + 74 * widthK + "px;" +
  "line-height:" + 74 * widthK + "px;" +
  "border-radius:" + 5 * widthK + "px;" +
  "font-size:" + 29 * widthK + "px;" +
  "width: 33%;" +
  "}",


  //VIEW TRANSFER ON CARD

  viewTransferOnCard: ".view-transfer-on-card" +
  "{" +
  "position: absolute;" +
  "height: 100%;" +
  "width:100%;" +
  "z-index:999999;" +
  "}",

  viewTransferOnCardBackButton: ".view-transfer-on-card-back-button " +
  "{" +
  "position: absolute;" +
  "width:" + 113 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "background-image: url(resources/icons/back/back.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 19%;" +
  "background-position-y: 90%;" +
  "background-position-x: center;" +
  "background-size: 21%;" +
  "right: 87%;" +
  "}",


  viewTransferOnCardTitleContainer: ".view-transfer-on-card-title-container" +
  "{" +
  "position: absolute;" +
  "top: 0;" +
  "height:" + 300 * widthK + "px;" +
  "width: 100%;" +
  "background-color: white;" +
  "}",

  viewTransferOnCardTitleTextPartOne: ".view-transfer-on-card-title-text-part-one" +
  "{" +
  "color: #565d6a;" +
  "position: relative;" +
  "margin:" + 130 * widthK + "px 0 0 " + 120 * widthK + "px;" +
  "font-size:" + 34 * widthK + "px;" +
  "word-spacing:" + 3 * widthK + "px;" +
  "}",

  viewTransferOnCardTitleTextPartTwoSum: ".view-transfer-on-card-title-text-part-two-sum" +
  "{" +
  "color: #565d6a;" +
  "position: relative;" +
  "margin: " + 2 * widthK + "px 0 0 " + 250 * widthK + "px;" +
  "font-size: " + 40 * widthK + "px;" +
  "word-spacing: " + 4.6 * widthK + "px;" +
  "}",

  viewTransferOnCardTitleTextPartThree: ".view-transfer-on-card-title-text-part-three" +
  "{" +
  "color: #565d6a;" +
  "position: relative;" +
  "margin:" + (-9) * widthK + "px 0 0 " + 291 * widthK + "px;" +
  "font-size:" + 34 * widthK + "px;" +
  "word-spacing:" + 3 * widthK + "px;" +
  "}",

  viewTransferOnCardContentContainer: ".view-transfer-on-card-content-container" +
  "{" +
  "position: absolute;" +
  "top: " + 300 * widthK + "px;" +
  "width: 100%;" +
  "bottom: 0;" +
  "background: white;" +
  "}",

  transferOnCardPincardAllCardsContainer: ".transfer-on-card-pincard-all-cards-container" +
  "{" +
  "height:80%;" +
  "}",

  transferOnCardOkButton: ".transfer-on-card-ok-button" +
  "{" +
  "position: relative;" +
  "margin: " + 49 * widthK + "px 0 0 " + 214 * widthK + "px;" +
  "float: left;" +
  "text-align: center;" +
  "line-height: " + 63 * widthK + "px;" +
  "font-size: " + 29 * widthK + "px;" +
  "background-color: #00a8f1;" +
  "height: " + 74 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "width: 44%;" +
  "border-radius: " + 10 * widthK + "px;" +
  "color: #ffffff;" +
  "text-transform: capitalize;" +
  "}",

//  Component Alert
  componentAlert: ".component-alert " +
  "{" +
  "position: absolute;" +
  //"opacity: 0.92;" +
  "height: 100%;" +
  "top: 0;" +
  "width: 100%;" +
  //"background-color: white;" +
  "background-image: url(resources/icons/transparent.png);" +
  "z-index: 999999999;" +
  "}",

  componentAlertMessage: ".component-alert-message" +
  "{" +
  "position: relative;" +
  "color: #1d1d1f;" +
  "width:" + 400 * widthK + "px;" +
  "text-align: center;" +
  "margin-left: auto;" +
  "margin-top: 0;" +
  "margin-bottom: 0;" +
  "margin-right: auto;" +
  "top:" + 370 * widthK + "px;" +
  // "left:" + -10 * widthK + "px;" +
  "font-size:" + 36 * widthK + "px;" +
  "height:" + 435 * widthK + "px;" +
  "overflow-y: auto;" +
  "}",

  componentAlertMessageSettings: ".component-alert-message-settings" +
  "{" +
  "position: relative;" +
  "color: #1d1d1f;" +
  "width:" + 600 * widthK + "px;" +
  "text-align: center;" +
  "margin-left: auto;" +
  "margin-top: 0;" +
  "margin-bottom: 0;" +
  "margin-right: auto;" +
  "top:" + 380 * widthK + "px;" +
  // "left:" + -10 * widthK + "px;" +
  "font-size:" + 36 * widthK + "px;" +
  "}",

  componentAlertClickPinErrorContainer: ".component-alert-clickpin-error-container" +
  "{" +
  "position: relative;" +
  "color: #1d1d1f;" +
  "width:" + 500 * widthK + "px;" +
  "text-align: center;" +
  "margin-left: auto;" +
  "margin-top: 0;" +
  "margin-bottom: 0;" +
  "margin-right: auto;" +
  "top:" + 601 * widthK + "px;" +
  "left:" + -10 * widthK + "px;" +
  "}",

  componentAlertClickPinErrorMsgOne: ".component-alert-clickpin-message-one" +
  "{" +

  //"color: #1d1d1f;" +
  "width:100%;" +
  "top:0;" +
  "left:0;" +
  "}",

  componentAlertClickPinErrorMsgTwo: ".component-alert-clickpin-message-two" +
  "{" +
  "color: #FFAE0A;" +
  "width:100%;" +
  "top:0;" +
  "left:0;" +
  "font-weight: bold;" +
  "}",

  componentAlertClickPinErrorMsgThree: ".component-alert-clickpin-message-three" +
  "{" +
  //"color: yellow;" +
  "width:100%;" +
  "top:0;" +
  "left:0;" +
  "}",

  componentAlertButtonInnerContainer: ".component-alert-button-inner-container" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: absolute;" +
  "height: " + 74 * widthK + "px;" +
  "left: 28%;" +
  "width: 44%;" +
  "top: 90%;" +
  "background-color: #01B8FE;" +
  "border-radius: " + 10 * widthK + "px;" +
  "bottom: 0;" +
  "font-size: " + 38 * widthK + "px;" +
  "color: #ffffff;" +
  "}",

  componentAlertButtonLabel: ".component-alert-button-label" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "font-size:" + 38 * widthK + "px;" +
  "color: #ffffff;" +
  "text-align: center;" +
  "display: table-cell;" +
  "vertical-align: middle;" +
  "}",

  componentAlertIcon: ".component-alert-icon" +
  "{" +
  "position: relative;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "top:" + 300 * widthK + "px;" +
  "width:" + 270 * widthK + "px;" +
  "height:" + 250 * widthK + "px;" +
  // "left:" + 225 * widthK + "px;" +
  "background-image: url(resources/icons/icon/alert_icon2.png);" +
  "background-repeat: no-repeat;" +
  "background-size: 85%;" +
  "background-position-x: center;" +
  "}",

  componentConfirmButtonOkContainer: ".component-confirm-button-ok-container" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: absolute;" +
  "height: " + 74 * widthK + "px;" +
  "left: 52%;" +
  "width: 40%;" +
  "top: 82%;" +
  "background-color: #01B8FE;" +
  "border-radius: " + 10 * widthK + "px;" +
  "bottom: 0;" +
  "font-size: " + 38 * widthK + "px;" +
  "color: #ffffff;" +
  "}",

  componentConfirmButtonCancelContainer: ".component-confirm-button-cancel-container" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: absolute;" +
  "height: " + 74 * widthK + "px;" +
  "left: 8%;" +
  "width: 40%;" +
  "top: 82%;" +
  "background-color: lightgrey;" +
  "border-radius: " + 10 * widthK + "px;" +
  "bottom: 0;" +
  "font-size: " + 38 * widthK + "px;" +
  "color: #ffffff;" +
  "}",


  //COMPONENT RESULT

  //  Component Alert
  componentResult: ".component-result " +
  "{" +
  "position: absolute;" +
  //"opacity: 0.92;" +
  "height: 100%;" +
  "top: 0;" +
  "width: 100%;" +
  //"background-color: white;" +
  "background-image: url(resources/icons/transparent.png);" +
  "z-index: 9999999;" +
  "}",

  componentResultMessage: ".component-result-message" +
  "{" +
  "position: relative;" +
  "color: #757389;" +
  "width:" + 500 * widthK + "px;" +
  "margin: auto;" +
  "text-align: center;" +
  "top:" + 250 * widthK + "px" + "!important;" +
  "font-size:" + 36 * widthK + "px;" +
  "opacity: 0;" +
  "height: " + 240 * heightK + "px;" +
  "overflow-y: auto;" +

  "}",

  componentResultMessageStart: ".component-result-message-start " +
  "{" +
  "-webkit-transition: 0.7s;" +
  "-webkit-transition-delay: 0.8s;" +
  "transition: 0.7s;" +
  "transition-delay: 0.8s;" +
  "top:" + 214 * widthK + "px" + "!important;" +
  "opacity: 1 !important;" +
  "}",

  componentResultMessageStop: ".component-result-message-stop " +
  "{" +
  "-webkit-transition: 0.7s;" +
  "transition: 0.7s;" +
  "top:" + 226 * widthK + "px" + "!important;" +
  "opacity: 0 !important;" +
  "}",

  componentResultWait: ".component-result-wait " +
  "{" +
  "position: relative;" +
  "margin: auto;" +
  "top:" + 250 * widthK + "px;" +
  "text-align: center;" +
  "color: #757389;" +
  "font-size:" + 36 * widthK + "px;" +
  "-webkit-animation-name: componentResultWaitStartWebKitAnimation;" +
  "-webkit-animation-duration: 0.7s;" +
  "animation-name: componentResultWaitStartAnimation;" +
  "animation-duration: 0.7s;" +
  "}",

  componentResultWaitStop: ".component-result-wait-stop " +
  "{" +
  "-webkit-transition: 0.7s;" +
  "transition: 0.7s;" +
  "top:" + 262 * widthK + "px" + "!important;" +
  "opacity: 0 !important;" +
  "}",

  componentResultWaitStart: ".component-result-wait-start " +
  "{" +
  "-webkit-transition: 0.7s;" +
  "-webkit-transition-delay: 0.8s;" +
  "transition: 0.7s;" +
  "transition-delay: 0.8s;" +
  "top:" + 250 * widthK + "px" + "!important;" +
  "opacity: 1 !important;" +
  "}",

  componentResultWaitStartWebKitAnimation: "@-webkit-keyframes componentResultWaitStartWebKitAnimation " +
  "{" +
  "from {" +
  "opacity: 0;" +
  "top:" + 262 * widthK + "px;" +
  "}" +
  "to {" +
  "opacity: 1;" +
  "top:" + 250 * widthK + "px;" +
  "}" +
  "}",

  componentResultWaitStartAnimation: "@keyframes componentResultWaitStartAnimation " +
  "{" +
  "from {" +
  "opacity: 0;" +
  "top:" + 262 * widthK + "px;" +
  "}" +
  "to {" +
  "opacity: 1;" +
  "top:" + 250 * widthK + "px;" +
  "}" +
  "}",

  componentResultButtonInnerContainer: ".component-result-button-inner-container" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: absolute;" +
  "height: " + 74 * widthK + "px;" +
  "left: 28%;" +
  "width: 44%;" +
  "background-color: #01B8FE;" +
  "border-radius: " + 10 * widthK + "px;" +
  "bottom: 10%;" +
  "font-size: " + 32 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "color: #ffffff;" +
  "opacity: 0;" +
  "}",

  componentResultButtonSuccess: ".component-result-button-success" +
  "{" +
  "background-color: #8FD032 !important;" +
  "}",

  componentResultButtonUnsuccess: ".component-result-button-unsuccess" +
  "{" +
  "background-color: #EB2A48 !important;" +
  "}",

  componentResultButtonWaiting: ".component-result-button-waiting" +
  "{" +
  "background-color: #F8AE22 !important;" +
  "}",

  componentResultButtonStart: ".component-result-button-start" +
  "{" +
  "-webkit-transition: 0.7s;" +
  "-webkit-transition-delay: 1s;" +
  "transition: 0.7s;" +
  "transition-delay: 1s;" +
  "opacity: 1 !important;" +
  "}",

  componentResultButtonStop: ".component-result-button-stop" +
  "{" +
  "-webkit-transition: 0.7s;" +
  "transition: 0.7s;" +
  "opacity: 0 !important;" +
  "}",

  componentResultButtonLabel: ".component-result-button-label" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "font-size:" + 38 * widthK + "px;" +
  "color: #ffffff;" +
  "text-align: center;" +
  "display: table-cell;" +
  "vertical-align: middle;" +
  "}",

  componentResultIcon: ".component-result-icon" +
  "{" +
  "position: relative;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "top:" + 200 * widthK + "px;" +
  "width:" + 400 * widthK + "px;" +
  "height:" + 400 * widthK + "px;" +
  "background-image: url(resources/icons/icon/alert_icon.png);" +
  "background-repeat: no-repeat;" +
  "background-size: 115%;" +
  "background-position-x: center;" +
  "}",


  //VIEW TRUSTED DEVICES
  trustedDevicesTitle: ".trusted-devices-title " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size:" + 35 * widthK + "px; " +
  "left:" + 85 * widthK + "px; " +
  "top:" + 26 * widthK + "px; " +
  "margin: 0;  " +
  "color: #fffaf9;" +
  "text-transform: uppercase;" +
  "}",

  trustedDevicesPageTitle: ".trusted-devices-page-title" +
  "{" +
  "position: absolute;" +
  "top:" + 0 * widthK + "px;" +
  "right:" + 28 * widthK + "px;" +
  "left:" + 25 * widthK + "px;" +
  "height:" + 88 * widthK + "px;" +
  "background: transparent;" +
  //"border-bottom:" + 2 + "px solid rgb(149, 230, 253);" +
  "}",

  trustedDevicesBackButton: ".trusted-devices-back-button " +
  "{" +
  "position: absolute;" +
  "width:" + 113 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "background-image: url(resources/icons/back/back.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 19%;" +
  "background-position-y: 45%;" +
  "background-position-x: center;" +
  "background-size: 17%;" +
  "right: 87%;" +
  "}",

  trustedDevicesContentContainer: ".trusted-devices-content-container" +
  "{" +
  "position: absolute;" +
  "top: " + 94 * widthK + "px;" +
  "bottom: 0;" +
  "width: 91.4%;" +
  "padding: 0 4.3%;" +
  "background: white;" +
  "overflow-y: scroll; " +
  "overflow-x: hidden; " +
  "-webkit-overflow-scrolling: touch; " +
  "}",

  trustedDevicesDeviceInfoContainer: ".trusted-devices-device-info-container" +
  "{" +
  "width: " + 661 * widthK + "px;" +
  "height: " + 123 * widthK + "px;" +
  "border-bottom: 1px solid #e8e8e8;" +
  "}",

  trustedDevicesDeviceInfoIconContainer: ".trusted-devices-device-info-icon-container" +
  "{" +
  "background-image: url(resources/icons/ViewTrustedDevices/devices_android.png);" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: 56%;" +
  "height: " + 121 * widthK + "px;" +
  "width: " + 57 * widthK + "px;" +
  "float: left;" +
  "}",

  trustedDevicesIosDeviceIcon: ".trusted-devices-ios-device-icon" +
  "{" +
  "background-image: url('resources/icons/ViewTrustedDevices/devices_ios.png');" +
  "background-size: " + 47 * widthK + "px;" +
  "}",

  trustedDevicesIosDeviceAndroid: ".trusted-devices-android-device-icon" +
  "{" +
  "background-image: url('resources/icons/ViewTrustedDevices/devices_android.png');" +
  "background-size: " + 35 * widthK + "px;" +
  "}",

  trustedDevicesIosDeviceWeb: ".trusted-devices-web-device-icon" +
  "{" +
  "background-image: url('resources/icons/ViewTrustedDevices/devices_web.png');" +
  "background-size: " + 55 * widthK + "px;" +
  "}",

  trustedDevicesInfoContainer: ".trusted-devices-info-container" +
  "{" +
  "padding: " + 32 * widthK + "px " + 11 * widthK + "px " + 32 * widthK + "px " + 81 * widthK + "px;" +
  "}",

  trustedDevicesDeviceInfoName: ".trusted-devices-device-info-name" +
  "{" +
  "margin: 0;" +
  "font-size: " + 30 * widthK + "px;" +
  "width:" + 515 * widthK + "px;" +
  "float: left;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "white-space: nowrap;" +
  "line-height: " + 31 * widthK + "px;" +
  "color: #8a8a8a;" +
  "}",

  trustedDevicesDeviceInfoDate: ".trusted-devices-device-info-date" +
  "{" +
  "float: left;" +
  "margin: 0;" +
  "font-size: " + 24 * widthK + "px;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "width: " + 514 * widthK + "px;" +
  "white-space: nowrap;" +
  "line-height: " + 31 * widthK + "px;" +
  "color: #c8c8c8;" +
  "}",

  trustedDevicesDeviceDeleteIcon: ".trusted-devices-device-delete-icon" +
  "{" +
  //"margin: " + 20 * widthK + "px 0 0 " + 21 * widthK + "px;" +
  "position: absolute;" +
  "height: " + 70 * widthK + "px;" +
  "width: " + 70 * widthK + "px;" +
  "right: " + 10 * widthK + "px;" +
  "margin-top: " + -10 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-size: 30%;" +
  "background-position: center;" +
  "background-image: url(resources/icons/ViewSettingsFriendHelp/delete.png);" +
  "}",

  //VIEW QR PIN CARD

  qrPincardBodyContainer: ".qr-pincard-body-container" +
  "{" +
  "position: absolute;" +
  "height: " + 1102 * heightK + "px; " +
  "width: 100%; " +
  "top: " + 130 * heightK + "px; " +
  "background-color: white;" +
  "overflow-x: hidden;" +
  "overflow-y: scroll;" +
  "}",

  qrPincardPayfromContainer: ".qr-pincard-payfrom-container" +
  "{" +
  "position: relative;" +
  "background-color: transparent;" +
  "width: 100%;" +
  "height: 7.5%;" +
  // "border-bottom: 1px solid lightgray;" +
  "}",

  qrPincardPayfromField: ".qr-pincard-payfrom-field" +
  "{" +
  "position: absolute;" +
  "font-size: " + 29 * widthK + "px; " +
  "color: gray;" +
  "margin: 0;" +
  "left: 8%;" +
  "top:29%;" +
  "}",

  qrPincardAllcardsContainer: ".qr-pincard-allcards-container" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height:51%;" +
  "top: 7.5%;" +
  "background-color: transparent;" +
  "overflow-x: hidden;" +
  "overflow-y: auto;" +
  "}",

  qrPincardCardContainer: ".qr-pincard-card-container" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: " + 162 * widthK + "px; " +
  "background-color: transparent;" +
  "border-bottom:  " + 1 + "px solid lightgray;" +
  "}",

  qrPincardCardLogoContainer: ".qr-pincard-card-logo-container" +
  "{" +
  "width: 25%;" +
  "height: 67%;" +
  "top: 17%;" +
  "left: 5%;" +
  "background-color: transparent;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: contain;" +
  "float: left;" +
  "right: 61%;" +
  "position: absolute;" +
  "}",

  qrPincardCardInfoContainer: ".qr-pincard-card-info-container" +
  "{" +
  "position: absolute;" +
  "width: 41%;" +
  "height: 100%;" +
  "left: 42%;" +
  "background-color: transparent;" +
  "}",

  qrPincardCardInfoTextOne: ".qr-pincard-card-info-text-one" +
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

  qrPincardCardInfoTextTwo: ".qr-pincard-card-info-text-two" +
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

  qrPincardCardInfoTextThree: ".qr-pincard-card-info-text-three" +
  "{" +
  "position: absolute;" +
  "font-size: " + 23 * widthK + "px; " +
  "color: gray;" +
  "top: 51%;" +
  "}",

  qrPincardCardCheckmark: ".qr-pincard-card-checkmark" +
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
  qrPincardCardUnCheckmark: ".qr-pincard-card-uncheckmark" +
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

  qrPincardFriendHelpContainer: ".qr-pincard-friend-help-container" +
  "{" +
  "position: absolute;" +
  "width: 50%;" +
  "height: 50%;" +
  "top: 3%;" +
  //"bottom:0;" +
  //"background-color: grey;" +
  //"border-bottom:  " + 1 + "px solid lightgray;" +
  "left: 25%;" +
  "}",

  qrPincardFriendHelpText: ".qr-pincard-friend-help-text" +
  "{" +
  "top: 65%;" +
  "position: relative;" +
  // "left: 23%;" +
  "color: rgb(1, 124, 227);" +
  "font-size: " + 29 * widthK + "px; " +
  "text-align: center;" +
  "text-decoration: underline;" +
  "}",

  qrPincardFriendHelpIcon: ".qr-pincard-friend-help-icon" +
  "{" +
  "width: 40%;" +
  "height: 67%;" +
  "background-color: transparent;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: 65%;" +
  "float: left;" +
  "right: 30%;" +
  "position: absolute;" +
  "background-image: url(resources/icons/ViewService/friend.png);" +
  "}",

  qrPincardChosenFriendContainer: ".qr-pincard-chosen-friend-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:55%;" +
  //"background-color: grey;" +
  //"left: 10%;" +
  //"top:" + 165 * widthK + "px;" +
  "}",

  qrPincardFriendHelpTextTwo: ".qr-pincard-friend-help-text-two" +
  "{" +
  //"top: 65%;" +
  "position: absolute;" +
  "left: 36%;" +
  "color: grey;" +
  "font-size: " + 29 * widthK + "px; " +
  "text-align: center;" +
  //"text-decoration: underline;" +
  "}",

  qrPincardFriendChangeText: ".qr-pincard-friend-change-text" +
  "{" +
  "top: 80%;" +
  "position: absolute;" +
  "left: 40%;" +
  "color: rgb(1, 124, 227);" +
  "font-size: " + 29 * widthK + "px; " +
  "text-align: center;" +
  "text-decoration: underline;" +
  "}",

  qrPincardChosenFriendInnerContainer: ".qr-pincard-chosen-friend-inner-container" +
  "{" +
  "position: absolute;" +
  "width: 79.5%;" +
  "height:" + 115 * widthK + "px;" +
  "background-color: #F0F1F4;" +
  "left: 10%;" +
  "top:22%;" +
  "}",

  qrPincardChosenFriendPhoto: ".qr-pincard-chosen-friend-photo" +
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

  qrPincardChosenFriendTextContainer: ".qr-pincard-chosen-friend-text-container" +
  "{" +
  "position: absolute;" +
  "left: 25%;" +
  "color: gray;" +
  "width: 20%;" +
  "height: 100%;" +
  "display: table;" +
  "}",


  qrPincardChosenFriendTextOne: ".qr-pincard-chosen-friend-text-one" +
  "{" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 24 * widthK + "px;" +
  "display: table-cell;" +
  "vertical-align: middle;" +
  "}",

  qrPincardChosenFriendTextTwo: ".qr-pincard-chosen-friend-text-two" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left: 60%;" +
  "color: gray;" +
  "font-size:" + 24 * widthK + "px;" +
  "top: 40%;" +
  "}",

  qrPincardBottomContainer: ".qr-pincard-bottom-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  //"height: 46%;" +
  "top: 62%;" +
  "bottom:0;" +
  "background-color: transparent;" +
  "border-bottom:  " + 1 + "px solid lightgray;" +
  "overflow: scroll;" +
  "}",

  qrPincardButtonEnter: " .qr-pincard-button-enter" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "height: " + 74 * widthK + "px;" +
  "font-size: " + 32 * widthK + "px;" +
  "top: 60%;" +
  "background-color: #00a8f1;" +
  "padding: 0;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "left: 28%;" +
  "width: 44%;" +
  "border-radius: " + 10 * widthK + "px;" +
  "color: #ffffff;" +
  "}",

  qrPincardButtonEnterLabel: ".qr-pincard-button-enter-label" +
  "{" +
  "position: relative;" +
  "top: " + 10 * widthK + "px; " +
  "width: 30%;" +
  "font-size: " + 44 * widthK + "px; " +
  "margin: auto;" +
  "color: white;" +
  //"right: 10%;" +
  "}",

  qrPayPageTitle: ".qr-pay-page-title " +
  "{" +
  "position: absolute;" +
  "top:" + 0 * widthK + "px;" +
  "right:" + 28 * widthK + "px;" +
  "left:" + 25 * widthK + "px;" +
  "height:" + 88 * widthK + "px;" +
  "background: transparent;" +
  //"border-bottom:" + 2 + "px solid rgb(149, 230, 253);" +
  "}",

  qrServicePageTitle: ".qr-servicepage-title" +
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

  qrServicePageQrTitle: ".qr-servicepage-qr-title" +
  "{" +
  "top: 57%;" +
  "}",

  qrServicePageCategoryField: ".qr-servicepage-category-field" +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size: " + 29 * widthK + "px; " +
  "left: 13%;" +
  "top: 87%;" +
  "margin: 0;" +
  "color: lavender;" +
  "}",

  qrServicePageServiceIcon: ".qr-servicepage-service-icon" +
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
  "display:none;" +
  "}",

  qrServicePageButtonBack: ".qr-servicepage-button-back" +
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

  //VIEW QR PAY CONFIRM
  qrPayconfirmBodyContainer: ".qr-payconfirm-body-container" +
  "{" +
  "position: absolute;" +
  "height: " + 1102 * heightK + "px; " +
  "width: 100%; " +
  "top: " + 130 * heightK + "px; " +
  "background-color: white;" +
  "overflow-x: hidden;" +
  "overflow-y: scroll;" +
  "border-bottom: 1px solid black;" +
  "}",

  qrPayconfirmDataContainer: ".qr-payconfirm-data-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: " + 569 * widthK + "px; " +
  "background-color: transparent;" +
  //"border-bottom:  " + 1 + "px solid lightgray;" +
  "}",

  qrPayconfirmPhoneField: ".qr-payconfirm-phone-field" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: 24%;" +
  "border-bottom: 1px solid lightgray;" +
  "color: white;" +
  "}",

  qrPayconfirmTextField: ".qr-payconfirm-text-field" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "color: darkgray;" +
  "font-size: " + 24 * widthK + "px; " +
  "left: 8%;" +
  "top: 15%;" +
  "}",

  qrPayconfirmPhoneInput: ".qr-payconfirm-phone-input" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "left: 8%;" +
  "top: 12%;" +
  "font-size: " + 40 * widthK + "px; " +
  "color: gray;" +
  "}",

  qrPayconfirmTaxField: ".qr-payconfirm-tax-field" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "color: darkgray;" +
  "font-size: " + 24 * widthK + "px; " +
  "left: 8%;" +
  "top: 10%;" +
  "}",

  qrPayconfirmField: ".qr-payconfirm-field" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: 24.5%;" +
  // "border-bottom:  " + 1 + "px solid lightgray;" +
  "color: white;" +
  //"top: 23%;" +
  "}",

  qrPayconfirmCardField: ".qr-payconfirm-card-field" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "height: 32%;" +
  // "border-bottom:1px solid lightgray;" +
  "color: white;" +
  //"top: 23%;" +
  "}",

  qrPayconfirmCardInfoContainer: ".qr-payconfirm-card-info-container" +
  "{" +
  "position: absolute;" +
  "width: 60%;" +
  "height: 100%;" +
  "background-color: transparent;" +
  "left: 4%;" +
  "}",

  qrPayconfirmTextOne: ".qr-payconfirm-text-one" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: darkgray;" +
  "font-size: " + 23 * widthK + "px; " +
  "left: 7%;" +
  "top: 17%;" +
  "}",

  qrPayconfirmTextTwo: ".qr-payconfirm-text-two" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left: 7%;" +
  "top: 30%;" +
  "font-size: " + 40 * widthK + "px; " +
  "color: gray;" +
  "width: 90%;" +
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "}",

  qrPayconfirmetailText: ".qr-payconfirm-detail-text" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "color: darkgray;" +
  "font-size: " + 25 * widthK + "px; " +
  "left: 7%;" +
  "top: 56%;" +
  "}",

  qrPayconfirmCardLogoContainer: ".qr-payconfirm-card-logo-container" +
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

  qrPayconfirmChosenFriendPhoto: ".qr-payconfirm-chosen-friend-photo" +
  "{" +
  "top:" + 40 * widthK + "px;" +
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
  "right: 10%;" +
  "}",


  qrPayconfirmBottomContainer: ".qr-payconfirm-bottom-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "top: 60%;" +
  "bottom: 0;" +
  "background-color: transparent;" +
  "border-bottom:  1px solid lightgray;" +
  "overflow: scroll;" +
  "}",

  qrPayconfirmActionContainer: ".qr-payconfirm-action-containter" +
  "{" +
  "position: relative;" +
  "float: left;" +
  "width: 50%;" +
  "height: 50%;" +
  "background-color: transparent;" +
  "}",

  qrPayconfirmActionIconOne: ".qr-payconfirm-action-icon-one" +
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

  qrPayconfirmActionIconTwo: ".qr-payconfirm-action-icon-two" +
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

  qrPayconfirmActionText: ".qr-payconfirm-action-text" +
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

  qrPayconfirmButtonEnter: ".qr-payconfirm-button-enter" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "height: " + 74 * widthK + "px;" +
  "font-size: " + 32 * widthK + "px;" +
  "top: 60%;" +
  "background-color: #00a8f1;" +
  "padding: 0;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "left: 28%;" +
  "width: 44%;" +
  "border-radius: " + 10 * widthK + "px;" +
  "color: #ffffff;" +
  "}",

  qrPayconfirmButtonEnterLabel: ".qr-payconfirm-button-enter-label" +
  "{" +
  "position: relative;" +
  "top: " + 9 * widthK + "px; " +
  "width: 48%;" +
  "font-size: " + 44 * widthK + "px; " +
  "margin: auto;" +
  "color: white;" +
  "}",


//  View Report Service

  viewReportService: ".view-report-service" +
  "{" +
  "position: absolute;" +
  "height: 100%;" +
  "width:100%;" +
  "z-index:999999;" +
  "}",

  reportServiceUpperContainer: ".report-service-upper-container" +
  "{" +
  "position: absolute;" +
  "height:" + 410 * widthK + "px;" +
  "width:100%;" +
  "background-color: white;" +
  "}",

  reportServiceIcon: ".report-service-icon" +
  "{" +
  "position: absolute;" +
  "height:" + 235 * widthK + "px;" +
  "width:" + 235 * widthK + "px;" +
  "top:" + 130 * widthK + "px;" +
  "left:" + 55 * widthK + "px;" +
  // "-webkit-transform: translate3d(-50%, 0, 0);" +
  //"border:" + 4 * widthK + "px solid white;" +
  // "border-radius:" + 90 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-size: cover;" +
  "background-position: center;" +
  "}",

  reportServiceUpperInfoContainer: ".report-service-upper-info-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 120 * widthK + "px;" +
  "top: " + 220 * widthK + "px;" +
  "}",

  reportServiceTitle: ".report-service-title " +
  "{" +
  "position: relative;" +
  "font-size:" + 40 * widthK + "px; " +
  "width: 50%;" +
  "margin: 0; " +
  "margin-left: 46%; " +
  "margin-top:" + 172 * widthK + "px; " +
  "text-align: left;" +
  "text-overflow: ellipsis; " +
  "overflow: hidden; " +
  "color: #565d6a;" +
  "}",

  reportServicePaymentInfoText: ".report-service-payment-info-text " +
  "{" +
  "position: relative;" +
  "font-size:" + 24 * widthK + "px; " +
  "width: 50%; " +
  "margin: 0; " +
  "margin-left: 46%; " +
  "margin-top:" + 8 * widthK + "px; " +
  "color: #a9abaf;" +
  "text-align: left;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "}",

  reportServiceBodyContainer: ".report-service-body-container" +
  "{" +
  "position: absolute;" +
//"height:" + 1150 * widthK + "px; " +
  "width: 100%; " +
  "bottom:0; " +
  "background-color: white; " +
  "overflow-y: auto; " +
  "overflow-x: hidden; " +
  "top:" + 410 * widthK + "px; " +
  "}",

  reportServiceDataButtonInfoContainer: ".report-service-data-button-info-container" +
  "{" +
  "position: absolute;" +
  "background-image: url(resources/icons/invoice/invoice_footer.png);" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "width: 100%;" +
  "top: 49.7%;" +
  "padding-top: 6.4%;" +
  "bottom: 0;" +
  "}",

  reportServiceBodyInfoContainer: ".report-service-body-info-container" +
  "{" +
  "position: relative;" +
  "top: 0;" +
  "height: " + 452 * widthK + "px; " +
  "}",

  reportServiceDataContainer: ".report-service-data-container" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "top: 0;" +
  "bottom: " + 440 * widthK + "px; " +
  "background-color: transparent;" +
  //"border-bottom:  " + 1 + "px solid lightgray;" +
  "}",

  reportServicePhoneField: ".report-service-phone-field" +
  "{" +
  "position: relative;" +
  "width: 90%;" +
  "margin: 0 5%;" +
  "height: " + 110 * widthK + "px; " +
  "border-bottom: 1px solid lightgray;" +
  "color: white;" +
  "}",

  reportServiceTextField: ".report-service-text-field" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: darkgray;" +
  "font-size: " + 23 * widthK + "px; " +
  "left: 3%;" +
  "top: 9%; " +
  "}",

  reportServicePhoneInput: ".report-service-phone-input" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left: 3%;" +
  "top: 52%;" +
  "font-size: " + 29 * widthK + "px; " +
  "color: gray;" +
  "}",

  reportServiceInfoInput: ".report-service-info-input" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left: 3%;" +
  "top: " + 49 * widthK + "px; " +
  "font-size: " + 29 * widthK + "px; " +
  "color: gray;" +
  "text-overflow: ellipsis;" +
  "width: " + 625 * widthK + "px;" +
  "max-height: " + 110 * widthK + "px;" +
  "overflow: hidden;" +
  "word-wrap: break-word;" +
  "}",

  reportServiceInfoInputCardName: ".report-service-info-input-card-name" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left: 3%;" +
  "top: " + 49 * widthK + "px; " +
  "font-size: " + 29 * widthK + "px; " +
  "color: gray;" +
  "text-overflow: ellipsis;" +
  "width: " + 625 * widthK + "px;" +
  "max-height: " + 110 * widthK + "px;" +
  "overflow: hidden;" +
  "word-wrap: break-word;" +
  "white-space: nowrap;" +
  "}",

  reportServiceInfoInputAmount: ".report-service-info-input-amount" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left: 3%;" +
  "top: " + 49 * widthK + "px; " +
  "font-size: " + 29 * widthK + "px; " +
  "text-overflow: ellipsis;" +
  "width: " + 625 * widthK + "px;" +
  "max-height: " + 80 * widthK + "px;" +
  "overflow: hidden;" +
  "color: #ff6d65;" +
  "}",

  reportServiceInfoInputAmountWithTax: ".report-service-info-input-amount-with-tax" +
  "{" +
  "top: 35%;" +
  "}",

  reportServiceTaxField: ".report-service-tax-field" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: darkgray;" +
  "font-size: " + 24 * widthK + "px; " +
  "left: 4%;" +
  "top: 63%;" +
  "}",

  reportServiceField: ".report-service-field" +
  "{" +
  "position: relative;" +
  "width: 90%;" +
  "margin: 0 5%;" +
  "height: " + 94 * widthK + "px; " +
  "border-bottom:  " + 1 + "px solid lightgray;" +
  "color: white;" +
  //"top: 23%;" +
  "}",

  reportServiceAmountField: ".report-service-amount-field" +
  "{" +
  "height: 28%;" +
  "}",

  reportServiceLastField: ".report-service-last-field" +
  "{" +
  "border: none;" +
  "height: 34%;" +
  "}",

  reportServiceStatusError: ".report-service-status-error" +
  "{" +
  "color: #ff6d65;" +
  "}",

  reportServiceStatusWait: ".report-service-status-wait" +
  "{" +
  "color: #f3ba31;" +
  "}",

  reportServiceStatusSuccess: ".report-service-status-success" +
  "{" +
  "color: #6ABD38;" +
  "}",

  reportServiceButtonContainer: ".report-service-button-container" +
  "{" +
  "position: relative;" +
  "bottom: 0;" +
  "top: " + 22 * widthK + "px;" +
  "width: 100%;" +
  "background-image: url(resources/icons/invoice/invoice_footer.png);" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "padding: " + 42 * widthK + "px " + 20 * widthK + "px;" +
  "}",

  reportServiceCover: ".report-service-cover" +
  "{" +
  "position: absolute;" +
  "bottom: 0;" +
  "top: " + 600 * widthK + "px;" +
  "width: 100%;" +
  "background-color: #f4f4f4;" +
  "}",

  reportServiceButtonInfoContainer: ".report-service-button-info-container" +
  "{" +
  "height: " + 50 * widthK + "px;" +
  "margin-top: " + 22 * widthK + "px;" +
  "margin-left: 3%;" +
  "margin-bottom: 0;" +
  "}",

  reportServiceButtonIcon: ".report-service-button-icon" +
  "{" +
  "height: " + 50 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: " + 47 * widthK + "px;" +
  "width: " + 115 * widthK + "px;" +
  "float: left;" +
  "}",

  reportServiceButtonAction: ".report-service-button-action" +
  "{" +
  "position: relative;" +
  "top: " + 5 * widthK + "px;" +
  "font-size: " + 30 * widthK + "px;" +
  "color: #0185E3;" +
  "text-decoration: underline;" +
  "}",

  reportServiceButtonFavoritesIcon: ".report-service-button-favorites-icon" +
  "{" +
  "background-image: url(resources/icons/ViewReportService/details_favorites.png);" +
  "}",

  reportServiceButtonFavoritesIconAdded: ".report-service-button-favorites-icon-added" +
  "{" +
  "background-image: url(resources/icons/ViewReportService/details_favoritesadded.png);" +
  "}",

  reportServiceButtonAutoPaymentIcon: ".report-service-button-auto-payment-icon" +
  "{" +
  "background-image: url(resources/icons/ViewReportService/details_autopayment.png);" +
  "}",

  reportServiceButtonSupportIcon: ".report-service-button-support-icon" +
  "{" +
  "background-image: url(resources/icons/ViewReportService/details_support.png);" +
  "}",

  reportServiceRepeatButton: ".report-service-repeat-button" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "left: " + 210 * widthK + "px;" +
  // "left: 50%;" +
  "top: " + 24 * widthK + "px;" +
  "height: " + 74 * widthK + "px;" +
  "text-transform: capitalize;" +
  "width: " + 287 * widthK + "px;" +
  "font-size: " + 28 * widthK + "px;" +
  "color: white;" +
  // "-webkit-transform: translate3d(-50%, 0, 0);" +
  "border-radius: " + 10 * widthK + "px;" +
  "background-color: #00a8f1;" +
  "}",

  //VIEW SETTINGS SUPPORT

  viewSettingsSupport: ".view-settings-support" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 100%;" +
  "opacity: 0.97;" +
  "z-index: 10;" +
  "}",

  settingsSupportBlueContainer: ".settings-support-blue-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height:" + 555 * heightK + "px;" +
  "background-color: white;" +
  "}",

  settingsSupportContainer: ".settings-support-container" +
  "{" +
  "position: absolute;" +
  //"height:" + 1150 * widthK + "px; " +
  "width:100%; " +
  "top:" + 555 * heightK + "px; " +
  "bottom:0; " +
  "background-color: #00a8f1; " +
  "overflow: hidden; " +
  "}",

  settingsSupportContainerTitle: ".settings-support-container-title" +
  "{" +
  "position: relative;" +
  "width: 40%; " +
  "left: 12%; " +
  "margin: 0; " +
  "margin-top: 10%; " +
  "color: white; " +
  "font-size:" + 35 * widthK + "px; " +
  "}",

  settingsSupportPageTitle: ".settings-support-page-title " +
  "{" +
  "position: absolute;" +
  "top: 0;" +
  "right:" + 28 * widthK + "px;" +
  "left:" + 25 * widthK + "px;" +
  "height:" + 92 * widthK + "px;" +
  "background: transparent;" +
  //"border-bottom:" + 2 + "px solid rgb(149, 230, 253);" +
  "}",

  settingsSupportXButton: ".settings-support-x-button " +
  "{" +
  "position: absolute;" +
  "width:" + 135 * widthK + "px;" +
  "height:" + 84 * widthK + "px;" +
  "right:" + -32 * widthK + "px;" +
  "background-image: url('resources/icons/ViewTransfer/banks_close.png');" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 22%;" +
  "background-position-y: center;" +
  "background-position-x:" + 54 * widthK + "px;" +
  "background-size: 22%;" +
  "top: 0;" +
  "}",

  settingsSupportHelpIcon: ".settings-support-help-icon " +
  "{" +
  "position: absolute;" +
  "width:" + 170 * widthK + "px;" +
  "height:" + 170 * widthK + "px;" +
  "top: 20%;" +
  "left: 10%;" +
  "background-image: url('resources/icons/ViewSettingsSupport/support_icon.png');" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: 100%;" +
  "}",

  settingsSupportHelpTitle: ".settings-support-help-title " +
  "{" +
  "position: relative;" +
  "color: #7c7c7c;" +
  "width: 80%;" +
  "margin: 0;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "top: 58%;" +
  "}",

  settingsSupportButtonsContainer: ".settings-support-buttons-container " +
  "{" +
  "position: relative;" +
  "width: 80%;" +
  "height: 72%;" +
  "margin: 0 auto 0 auto;" +
  "}",

  settingsSupportButtons: ".settings-support-buttons " +
  "{" +
  "position: relative;" +
  "width: 99%;" +
  "left:" + 2 * widthK + "px;" +
  "height:" + 80 * widthK + "px;" +
  "border-bottom:" + 1 + "px solid #f4f4f4;" +
  "}",

  settingsSupportButtonsRegistration: ".settings-support-buttons-registration " +
  "{" +
  "margin-top: 3.5%;" +
  "}",

  settingsSupportButtonsPay: ".settings-support-buttons-pay " +
  "{" +
  "margin-top: 0%;" +
  "}",

  settingsSupportButtonsBalance: ".settings-support-buttons-balance " +
  "{" +
  "margin-top: 0;" +
  "}",

  settingsSupportButtonsOther: ".settings-support-buttons-other " +
  "{" +
  "margin-top: 0;" +
  "border: none;" +
  "}",

  settingsSupportOpenIcon: ".settings-support-open-icon " +
  "{" +
  "position: absolute;" +
  "width: 20%;" +
  "height: 80%;" +
  "right: -7%;" +
  "top: 19%;" +
  "background-image: url(resources/icons/ViewSettingsSupport/support_open.png);" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-size: 9%;" +
  "}",

  settingsSupportButtonsTitle: ".settings-support-buttons-title " +
  "{" +
  "position: absolute;" +
  "width: 36%;" +
  "margin: 0;" +
  "left: 2%;" +
  "top: 37%;" +
  "text-align: left;" +
  "font-size:" + 29 * widthK + "px;" +
  "color: white;" +
  "}",

  //VIEW SETTINGS SUPPORT PART TWO

  viewSettingsSupportPartTwo: ".view-settings-support-part-two" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 100%;" +
  "background-color: #00b8ff;" +
  "}",


  settingsSupportPartTwoContainerTitle: ".settings-support-part-two-container-title" +
  "{" +
  "position: relative;" +
  "width: 50%; " +
  "left: 13%; " +
  "top: 5%; " +
  "margin: 0; " +
  "color: white; " +
  "font-size:" + 35 * widthK + "px; " +
  "}",

  settingsSupportPartTwoContainer: ".settings-support-part-two-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 60%;" +
  "}",

  settingsSupportPartTwoPageTitle: ".settings-support-part-two-page-title " +
  "{" +
  "position: absolute;" +
  "top: 0;" +
  "right:" + 28 * widthK + "px;" +
  "left:" + 25 * widthK + "px;" +
  "height:" + 92 * widthK + "px;" +
  "background: transparent;" +
  //"border-bottom:" + 2 + "px solid rgb(149, 230, 253);" +
  "}",

  settingsSupportPartTwoXButton: ".settings-support-part-two-x-button " +
  "{" +
  "position: absolute;" +
  "width:" + 135 * widthK + "px;" +
  "height:" + 84 * widthK + "px;" +
  "right:" + -32 * widthK + "px;" +
  "background-image: url('resources/icons/ViewSettingsSupport/support_close.png');" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 22%;" +
  "background-position-y: center;" +
  "background-position-x:" + 54 * widthK + "px;" +
  "background-size: 22%;" +
  "top: 0;" +
  "}",

  settingsSupportPartTwoInputContainer: ".settings-support-part-two-input-container" +
  "{" +
  "position: relative;" +
  "width: 82%;" +
  "margin: 0 auto 0 auto;" +
  "height: 65%;" +
  "top: 6%;" +
  "background-image: url('resources/icons/ViewSettingsSupport/support_message.png');" +
  "background-repeat: no-repeat;" +
  "background-position-y: center;" +
  "background-size: 100%;" +
  "}",

  settingsSupportPartTwoSendButton: ".settings-support-part-two-send-button" +
  "{" +
  "position: relative;" +
  "width: 39%;" +
  "margin: 0 auto 0 auto;" +
  "height: 7%;" +
  "top: 4%;" +
  "color: white;" +
  "text-align: center;" +
  "border:" + 4 * widthK + "px solid white;" +
  "line-height: 160%;" +
  "font-size:" + 30 * widthK + "px;" +
  "}",


  settingsSupportPartTwoInput: ".settings-support-part-two-input" +
  "{" +
  "position: absolute;" +
  "width: 87%;" +
  "height: 59%;" +
  "top: 18%;" +
  "left: 6%;" +
  "font-size:" + 24 * widthK + "px;" +
  "font-family: 'SFUIDisplay-Light';" +
  "border: none;" +
  "outline: none;" +
  "margin: 0;" +
  "padding: 0;" +
  "color: gray;" +
  "}",


  viewNews: ".view-news" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 100%;" +
  "display: none;" +
  "z-index: 9999;" +
  "background-image: url('resources/icons/transparent.png');" +
  //"background-repeat: no-repeat;" +
  "background-position-y: center;" +
  "background-size: 100%;" +
  "}",

  viewNewsContainer: ".view-news-container" +
  "{" +
  "position: relative;" +
  "width:" + 660 * widthK + "px;" +
  "margin: 0 auto 0 auto;" +
  "top:" + 100 * widthK + "px;" +
  "height: 100%;" +
  "overflow-x: hidden;" +
  "overflow-y: scroll;" +
  "-webkit-overflow-scrolling: touch;" +
  "}",

  viewNewsBlock: ".view-news-block" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "margin: 0 auto 3% auto;" +
  "padding-bottom: 0;" +
  "height:" + 360 * widthK + "px;" +
  //"contain: content;" +
  "background-image: url('resources/icons/ViewNews/news.png');" +
  "background-repeat: no-repeat;" +
  "background-position-y: bottom;" +
  "background-size: 100%;" +
  "background-color: white;" +
  "border-bottom-right-radius:" + 70 * widthK + "px;" +
  "}",

  viewNewsBlockWithLink: ".view-news-block-with-link" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "margin: 0 auto 3% auto;" +
  "padding-bottom: 0;" +
  "height:" + 415 * widthK + "px;" +
  //"contain: content;" +
  "background-image: url('resources/icons/ViewNews/news.png');" +
  "background-repeat: no-repeat;" +
  "background-position-y: bottom;" +
  "background-size: 100%;" +
  "background-color: white;" +
  "border-bottom-right-radius:" + 70 * widthK + "px;" +
  "}",

  viewNewsPageTitle: ".view-news-page-title " +
  "{" +
  "position: absolute;" +
  "top: 0;" +
  "border-bottom: 1px solid white;" +
  "right:" + 28 * widthK + "px;" +
  "left:" + 25 * widthK + "px;" +
  "height:" + 92 * widthK + "px;" +
  //"border-bottom:" + 2 + "px solid rgb(149, 230, 253);" +
  "}",

  viewNewsNameTitle: ".view-news-name-title " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size:" + 35 * widthK + "px; " +
  "left: 6%; " +
  "top:" + 26 * widthK + "px; " +
  "margin: 0;  " +
  "color: #4f4f4f;" +
  "}",

  viewNewsBackButton: ".view-news-back-button " +
  "{" +
  "position: absolute;" +
  "width:" + 113 * widthK + "px;" +
  "height:" + 100 * widthK + "px;" +
  "background-image: url(resources/icons/back/back.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 19%;" +
  "background-position-y: 43%;" +
  "background-position-x: center;" +
  "background-size: 17%;" +
  "right: 87%;" +
  "display: block;" +
  "}",

  viewNewsRightButton: ".view-news-right-button " +
  "{" +
  "position: absolute;" +
  "width:" + 144 * widthK + "px;" +
  "height:" + 92 * widthK + "px;" +
  "right:" + -36 * widthK + "px;" +
  "background-image: url('resources/icons/ViewTransfer/banks_close.png');" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 22%;" +
  "background-position-y: center;" +
  "background-position-x:" + 54 * widthK + "px;" +
  "background-size: 22%;" +
  "top: 0;" +
  "}",

  viewNewsBlockOfAll: ".view-news-block-of-all " +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  // "contain: content;" +
  "margin-bottom: 7%;" +
  "}",

  viewNewsBlockText: ".view-news-block-text " +
  "{" +
  "position: relative;" +
  "font-size:" + 24 * widthK + "px; " +
  "width: 88%; " +
  "margin:" + 50 * widthK + "px auto 0 auto;  " +
  "color: #4f4f4f;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "text-align: justify;" +
  "white-space: pre-line;" +
  "}",

  viewNewsBlockImage: ".view-news-block-image " +
  "{" +
  "position: relative;" +
  "background-image: url('resources/icons/ViewNews/news.png');" +
  "background-repeat: no-repeat;" +
  "background-position-y: bottom;" +
  "background-size: 100%;" +
  "width: 100%;" +
  "height:" + 330 * widthK + "px;" +
  "}",

  viewNewsBlockTitle: ".view-news-block-title " +
  "{" +
  "position: relative;" +
  "font-size:" + 34 * widthK + "px; " +
  "top:" + 40 * widthK + "px; " +
  // "height:" + 130 * widthK + "px; " +
  "width: 87%; " +
  "margin: 0 auto 0 auto;  " +
  "color: #00b8ff;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "}",

  viewNewsBlockDate: ".view-news-block-date " +
  "{" +
  "position: relative;" +
  "font-size:" + 24 * widthK + "px; " +
  "margin: 0;  " +
  "width: 30%;  " +
  "margin-top:" + 35 * widthK + "px; " +
  "margin-bottom:" + 52 * widthK + "px; " +
  "left: 6%;  " +
  "float: left;  " +
  "color: #bbbbbb;" +
  "}",

  viewNewsBlockReadMoreContainer: ".view-news-block-readmore-container " +
  "{" +
  "position: relative;" +
  "font-size:" + 24 * widthK + "px; " +
  "margin: 0;  " +
  "left: 30%;  " +
  "margin-top:" + 35 * widthK + "px; " +
  "margin-bottom:" + 35 * widthK + "px; " +
  "width: 30%;  " +
  "height: 17%;  " +
  "float: left;  " +
  "color: #bbbbbb;" +
  "}",

  viewNewsBlockReadMoreIcon: ".view-news-block-readmore-icon " +
  "{" +
  "position: absolute;" +
  "right: 3%;  " +
  "top: 0;  " +
  "width: 23%;  " +
  "height:" + 32 * widthK + "px; " +
  "background-image: url(resources/icons/ViewInfo/open.png);" +
  "background-repeat: no-repeat;" +
  "background-position-y: center;" +
  "background-size: 27%;" +
  "}",

  viewNewsBlockOpenedIcon: ".view-news-block-opened-icon " +
  "{" +
  "position: absolute;" +
  "right: 3%;  " +
  "top: 0;  " +
  "width: 23%;  " +
  "height:" + 32 * widthK + "px; " +
  "background-image: url(resources/icons/ViewPay/catclose.png);" +
  "background-repeat: no-repeat;" +
  "background-position-y: center;" +
  "background-size: 40%;" +
  "}",

  viewNewsBlockSpace: ".view-news-block-space " +
  "{" +
  "position: relative;" +
  "height: 10%;  " +
  "width: 100%;  " +
  "}",

  viewNewsFollowLinkContainer: ".view-news-follow-link-container" +
  "{" +
  "position: relative;" +
  "margin-top: " + 25 * widthK + "px;" +
  "left: 6%;" +
  "background-color: #09b1ff;" +
  "width: 44%;" +
  "height: " + 60 * widthK + "px;" +
  "text-decoration: none;" +
  "font-size:" + 25 * widthK + "px;" +
  "border-radius:" + 5 * widthK + "px;" +
  "color: white;" +
  "}",

  viewNewsFollowLinkText: ".view-news-follow-link-text" +
  "{" +
  "position: absolute;" +
  "top: 27%;" +
  "float: left;" +
  "left: 22%;" +
  "}",

  viewNewsFollowLinkArrow: ".view-news-follow-link-arrow" +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "height:" + 17 * widthK + "px;" +
  "width:" + 17 * widthK + "px;" +
  "top: 38%;" +
  "float: right;" +
  "right: 14%;" +
  "background-image: url('resources/icons/ViewTransfer/banks_offerta.png');" +
  "}",


  //COMPONENT NOTIFICATION

  componentNotification: ".component-notification " +
  "{" +
  "position: absolute;" +
  "height:" + 200 * widthK + "px;  " +
  "width: 100%;  " +
  "z-index: 9999999;  " +
  "-webkit-transform: translate3d(0, -100%,0);  " +
  "background-color: #f1eff3;  " +
  "}",

  componentNotificationSetTransition: ".component-notification-set-transition" +
  "{" +
  "transition: 1s;  " +
  "}",

  componentNotificationShow: ".component-notification-show" +
  "{" +
  "-webkit-transform: translate3d(0, 0,0);  " +
  "transform: translate3d(0, 0,0);  " +
  "}",

  ComponentNotificationButtonsContainer: ".component-notification-buttons-container" +
  "{" +
  "position: absolute;" +
  "width:100%;" +
  "height:" + 70 * widthK + "px;" +
  "bottom:" + 10 * widthK + "px;" +
  "}",

  ComponentNotificationButtonAccept: ".component-notification-button-accept" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "float: left;" +
  "opacity: 0.95;" +
  "text-align: center;" +
  "margin-left: 6%;" +
  "color: #666466;" +
  "background-color: #fffeff;" +
  "height:" + 57 * widthK + "px;" +
  "line-height:" + 58 * widthK + "px;" +
  "border-radius:" + 5 * widthK + "px;" +
  "font-size:" + 29 * widthK + "px;" +
  "width: 40%;" +
  "}",

  ComponentNotificationButtonCancel: ".component-notification-button-cancel" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "float: left;" +
  "text-align: center;" +
  "margin-left: 8%;" +
  "color: white;" +
  "background-color: #00acf5;" +
  "height:" + 55 * widthK + "px;" +
  "line-height:" + 58 * widthK + "px;" +
  "border-radius:" + 5 * widthK + "px;" +
  "font-size:" + 29 * widthK + "px;" +
  "width: 40%;" +
  "}",

  ComponentNotificationIcon: ".component-notification-icon" +
  "{" +
  "position: absolute;" +
  "height:" + 100 * widthK + "px;" +
  "width:" + 100 * widthK + "px;" +
  "left: 10%;" +
  "top: 10%;" +
  "background-image: url(resources/icons/ViewSuccessUnsuccess/notification.png);" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "}",

  ComponentNotificationText: ".component-notification-text" +
  "{" +
  "position: relative;" +
  "color: black;" +
  "width: 90%;" +
  "max-height: 45%;" +
  "text-align: center;" +
  "margin: 0 auto 0 auto;" +
  "top: 15%;" +
  "overflow: hidden;" +
  "font-size:" + 24 * widthK + "px;" +
  "}",

//  View AutoPay

  viewAutopayContainer: ".view-autopay-container" +
  "{" +
  "position: absolute;" +
  //"height:" + 1150 * widthK + "px; " +
  "width: 100%; " +
  "top:" + 86 * widthK + "px; " +
  "bottom:0; " +
  "background-color: white; " +
  "overflow-y: auto; " +
  "overflow-x: hidden; " +
  "}",

  viewAutopayBlockContainer: ".view-autopay-block-containter" +
  "{" +
  "position: relative;" +
  "height:" + 197 * widthK + "px; " +
  "width: 91%;" +
  "left: 4%;" +
  "margin-top: 1%;" +
  "border-bottom:" + 1 + "px solid gainsboro;" +
  "background-color: transparent;" +
  "}",

  viewAutopayBlockInnerContainer: ".view-autopay-block-inner-containter" +
  "{" +
  "position: absolute;" +
  "height:100%;" +
  "width: 100%;" +
  //"left: 4%;" +
  "}",


  viewAutopayIcon: ".view-autopay-icon " +
  "{" +
  //"top:" + 50 * widthK + "px;" +
  "background-size: 100%;" +
  "position: absolute;" +
  "left: 4%;" +
  "width:" + 125 * widthK + "px;" +
  "height:" + 125 * widthK + "px;" +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "top: 15%;" +
  "}",

  viewAutopayInfoContainer: ".view-autopay-info-container " +
  "{" +
  "position: absolute;" +
  "height: 100%;" +
  "width: 72%;" +
  "left: 25%;" +
  "color: #8b8b8b;" +
  "}",

  viewAutopayInfoName: ".view-autopay-info-name " +
  "{" +
  "position: absolute;" +
  "height: 25%;" +
  "top: 17%;" +
  "left: 8%;" +
  "margin: 0;" +
  "font-size:" + 24 * widthK + "px; " +
  "width: 75%;" +
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "}",

  viewAutopayInfoBalance: ".view-autopay-info-balance " +
  "{" +
  "position: relative;" +
  "top: 27%;" +
  "left: 8%;" +
  "margin: 0;" +
  "font-size:" + 45 * widthK + "px;" +
  "color: #595759;" +
  "float: left;" +
  "}",

  viewAutopayInfoCurrencyField: ".view-autopay-info-currency-field" +
  "{" +
  "position: relative;" +
  "top: 36%;" +
  "left: 11%;" +
  "margin: 0;" +
  "font-size:" + 26 * widthK + "px;" +
  "color: #595759;" +
  "float: left;" +
  "}",

  viewAutopayInfoCondition: ".view-autopay-info-condition " +
  "{" +
  "position: absolute;" +
  "height: 25%;" +
  "top: 50%;" +
  "left: 9%;" +
  "margin: 0;" +
  "font-size: " + 25 * widthK + "px; " +
  "width: 75%;" +
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "color: #353340;" +
  "}",

  viewAutopayInfoNumber: ".view-autopay-info-number " +
  "{" +
  "position: absolute;" +
  "height: 25%;" +
  "top: 70%;" +
  "left: 8%;" +
  "margin: 0;" +
  "font-size: " + 24 * widthK + "px; " +
  "width: 75%;" +
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "}",

  viewAutopayNextIcon: ".view-autopay-next-icon" +
  "{" +
  "position: absolute;" +
  "right: 0;" +
  "width: 10%;" +
  "height: 100%;" +
  "background-repeat: no-repeat;" +
  "background-size: 20%;" +
  "background-position: center;" +
  "background-position-x: 74%;" +
  "background-image: url(resources/icons/ViewInfo/open.png);" +
  "}",

  autopayButton: ".autopay-button" +
  "{" +
  "position: absolute;" +
  "height: " + 74 * widthK + "px;" +
  "text-transform: capitalize;" +
  "background-color: #00a8f1;" +
  "padding: 0;" +
  "font-size: " + 32 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "left: 28%;" +
  "width: 44%;" +
  "border-radius: " + 10 * widthK + "px;" +
  "color: #ffffff;" +
  "bottom:" + 100 * widthK + "px; " +
  "}",


  emptyListContainer: ".empty-list-container " +
  "{" +
  "position: absolute;" +
  "height:" + 1130 * heightK + "px;" +
  "width: 100%;" +
  "top:0;" +
  //"background-color: lightgray;" +
  "left:0;" +
  "}",

  emptyListUpperContainer: ".empty-list-upper-container " +
  "{" +
  "position: absolute;" +
  //"height:" + 460 * widthK + "px;" +
  "height: 40.14%;" +
  "width: 100%;" +
  "top:0;" +
  //"background-color: lightgray;" +
  "left:0;" +
  "}",


  emptyListUpperIconIn: ".empty-list-upper-icon" +
  "{" +
  "position: absolute;" +
  "height:83%;" +
  "width:100%;" +
  "top:17%;" +
  "background-repeat: no-repeat;" +
  "background-size: 50%;" +
  "background-position: center;" +
  "background-position-y: 50%;" +
  "background-image: url(resources/icons/ViewAutoPay/autopayment_empty.png);" +
  "}",

  emptyListLowerContainer: ".empty-list-lower-container " +
  "{" +
  "position: absolute;" +
  //"height:" + 650 * widthK + "px;" +
  "height: 56.72%;" +
  "width: 100%;" +
  //"top:" + 460 * widthK + "px;" +
  "top:40.14%;" +
  "background-color: transparent;" +
  "left:0;" +
  "}",


  emptyListLowerTitleText: ".empty-list-lower-title-text " +
  "{" +
  "position: relative;" +
  "color: black;" +
  "width:" + 490 * widthK + "px;" +
  "text-align: center;" +
  "margin-left: auto;" +
  "margin-top: 0;" +
  "margin-bottom: 0;" +
  "margin-right: auto;" +
  "top:11%;" +
  //"left:" + -5 * widthK + "px;" +
  "font-size:" + 36 * widthK + "px;" +
  "font-weight: bold;" +
  "letter-spacing: 1px;" +
  "word-spacing: 1px;" +
  "}",

  emptyListLowerBodyText: ".empty-list-lower-body-text " +
  "{" +
  "position: relative;" +
  "color: #8b8b8b;" +
  "width:65%;" +
  "text-align: center;" +
  "margin-left: auto;" +
  "margin-top: 0;" +
  "margin-bottom: 0;" +
  "margin-right: auto;" +
  "top:15%;" +
  //"left:" + -5 * widthK + "px;" +
  "font-size:" + 35 * widthK + "px;" +
  "font-weight: bold;" +
  "letter-spacing: 1px;" +
  "word-spacing: 1px;" +
  "line-height:" + 46 * widthK + "px;" +
  "}",


//  View autopay method

  autopayMethodBodyContainer: ".autopay-method-body-container" +
  "{" +
  "position: absolute;" +
  "height: " + 1102 * heightK + "px; " +
  "width: 100%; " +
  "top:" + 130 * heightK + "px; " +
  "bottom:0; " +
  "background-color: white; " +
  "overflow-y: auto; " +
  "overflow-x: hidden; " +
  "}",

  autopayMethodPageTitle: ".autopay-method-page-title" +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "left: 13%;" +
  "top: 36%;" +
  "margin: 0;" +
  "color: #fffaf9;" +
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "width: 75%;" +
  "font-size: " + 36 * widthK + "px; " +
  "}",

  //autopayMethodServiceIcon: ".autopay-method-service-icon" +
  //"{" +
  //"display: block; " +
  //"}",

  autopayMethodBackButton: ".autopay-method-back-button" +
  "{" +
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
  "top: " + -10 * widthK + "px; " +
  "}",

  autopayMethodEventContainer: ".autopay-method-event-container" +
  "{" +
  "position: absolute;" +
  "width: 45%;" +
  "height: 100%;" +
  "left: 4%;" +
  "}",

  autopayMethodScheduleContainer: ".autopay-method-schedule-container" +
  "{" +
  "position: absolute;" +
  "width: 45%;" +
  "height: 100%;" +
  "left: 51%;" +
  "}",

  autopayMethodChooseText: ".autopay-method-choose-text" +
  "{" +
  "color: darkgray;" +
  "font-size: " + 24 * widthK + "px; " +
  "top: 4%;" +
  "left: 10%;" +
  "position: absolute;" +
  "}",


  autopayMethodContainer: ".autopay-method-container " +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 25%;" +
  "top: 9%;" +
  "}",


  autopayMethodEventIcon: ".autopay-method-event-icon" +
  "{" +
  "position: relative;" +
  "width: " + 170 * widthK + "px; " +
  "height: " + 170 * widthK + "px; " +
  "top: 0%;" +
  "left: 23%;" +
  "background-repeat: no-repeat;" +
  "background-size: 65%;" +
  "background-position: center;" +
  "background-image: url('resources/icons/ViewAutoPay/autopayment_event.png');" +
  "}",

  autopayMethodScheduleIcon: ".autopay-method-schedule-icon" +
  "{" +
  "position: relative;" +
  "width: " + 170 * widthK + "px; " +
  "height: " + 170 * widthK + "px; " +
  "top: 0%;" +
  "left: 23%;" +
  "background-repeat: no-repeat;" +
  "background-size: 65%;" +
  "background-position: center;" +
  "background-image: url('resources/icons/ViewAutoPay/autopayment_scheduler.png');" +
  "}",

  autopayMethodText: ".autopay-method-text" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "text-align: center;" +
  "padding: 0;" +
  "bottom: 0%;" +
  "color: #585658;" +
  "font-size:" + 31 * widthK + "px;" +
  "}",

  autopayMethodLineBetween: ".autopay-method-line-between" +
  "{" +
  "position: absolute;" +
  "left: 50%;" +
  "width: 1px;" +
  "height: 20%;" +
  "top: 25%;" +
  "background-color: lightgrey;" +
  "}",

//  View autopay event method

  autopayEventNumberField: ".autopay-event-number-field" +
  "{" +
  "height: 10%;" +
  "top: 11%;" +
  "}",

  autopayEventNameField: ".autopay-event-name-field" +
  "{" +
  // "height:" + 90 * widthK + "px;" +
  "top: 4%;" +
  "}",

  autopayEventStepField: ".autopay-event-step-field" +
  "{" +
  "position: relative;" +
  "left: 10%;" +
  "width: 85%;" +
  "height:" + 90 * widthK + "px;" +
  "top: 18%;" +
  "background-color: transparent;" +
  "}",

  autopayEventStepFieldText: ".autopay-event-step-field-text" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 24 * widthK + "px;" +
  "top: -14%;" +
  "}",

  autopayEventStepContainer: ".autopay-event-step-container" +
  "{" +
  "position: relative;" +
  "height:" + 80 * widthK + "px; " +
  "width: 30.5%;" +
  //"left: 4%;" +
  "top: 15%;" +
  "margin-right: " + 32 * widthK + "px; " +
  "border-bottom:" + 1 + "px solid gainsboro;" +
  "background-color: transparent;" +
  "float: left;" +
  "}",

  autopayEventStepDropdownIcon: ".autopay-event-step-dropdown-icon" +
  "{" +
  "position: absolute;" +
  "background-image: url('resources/icons/ViewService/dropdown_icon.png');" +
  "width: 22%;" +
  "height: 36%;" +
  "background-repeat: no-repeat;" +
  "background-size: 65%;" +
  "background-position: center;" +
  "top: 35%;" +
  "left: 92%;" +
  "}",

  autopayEventStepText: ".autopay-event-step-text" +
  "{" +
  "position: relative;" +
  "display: inline-block;" +
  "background-size: contain;" +
  "top: 18%;" +
  "left: 1%;" +
  "text-align: left;" +
  "font-size:" + 45 * widthK + "px; " +
  "color: #515151;" +
  "}",

  autopayEventStepCheckIcon: ".autopay-event-step-check-icon" +
  "{" +
  // "position: absolute;" +
  "display: inline-block;" +
  "right: 0;" +
  "width:" + 40 * widthK + "px; " +
  "height: 100%;" +
  // "top: 0;" +
  "background-repeat: no-repeat;" +
  "background-size: 100%;" +
  "background-position-y: 80%;" +
  "background-image: url(resources/icons/ViewService/radio_unselected.png);" +
  "}",


  autopayEventAmountDropdownField: ".autopay-event-amount-dropdown-field" +
  "{" +
  "position: relative;" +
  "width: 79.5%;" +
  "height: 9%;" +
  "left: 10%;" +
  "color: white;" +
  "border-bottom:1px solid lightgray;" +
  "top: 23%;" +
  "}",

  autopayEventAmountsDropdownComponent: ".autopay-event-amount-dropdown-component" +
  "{" +
  "position: absolute;" +
  "opacity: 0.97;" +
  "height: 100%;" +
  "width: 100%;" +
  "background-color: #353340;" +
  "z-index: 5;" +
  "display: none;" +
  "}",

  autopayEventAmountDropdownFieldTwo: ".autopay-event-amount-dropdown-field-two" +
  "{" +
  "position: absolute;" +
  "width: 79.5%;" +
  "height: 8%;" +
  "left: 10%;" +
  "top: 12%;" +
  "color: white;" +
  "border-bottom:" + 3 * widthK + "px solid #95e6fd;" +
  "}",

  autopayEventDropdownTextField: ".autopay-event-dropdown-text-field" +
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

  autopayEventDropdownContainer: ".autopay-event-dropdown-container" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  "height: 55%;" +
  "top: 22%;" +
  "overflow: scroll;" +
  "}",

  autopayEventDropdownVariant: ".autopay-event-dropdown-variant" +
  "{" +
  "position: relative;" +
  "width: 79.5%;" +
  "height:" + 125 * widthK + "px;" +
  "background-color: white;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "margin-bottom:" + 5 * widthK + "px;" +
  "}",

  autopayEventAmountsInfoText: ".autopay-event-amounts-info-text" +
  "{" +
  "position: relative;" +
  "margin: 0;" +
  "color: gray;" +
  "font-size:" + 24 * widthK + "px;" +
  "top: 24%;" +
  "left: 10%;" +
  "}",

  autopayEventAmountsInfoTextTwo: ".autopay-event-amounts-info-text-two" +
  "{" +
  "top: 25%;" +
  "}",

  autopayEventButtonEnterEnabled: " .autopay-event-button-enter-enabled" +
  "{" +
  "top:" + 400 * heightK + "px;" +
  "height:" + 74 * widthK + "px;" +
  "margin: 0 auto 0 auto;" +
  "background-color: #00a8f1;" +
  "padding: 0;" +
  "font-size: " + 32 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "left: 28%;" +
  "width: 44%;" +
  "border-radius: " + 10 * widthK + "px;" +
  "color: #ffffff;" +
  "pointer-events: auto;" +
  "}",

  autopayEventButtonEnterDisabled: " .autopay-event-button-enter-disabled" +
  "{" +
  "top:" + 400 * heightK + "px;" +
  "height:" + 74 * widthK + "px;" +
  "margin: 0 auto 0 auto;" +
  "background-color: #D2D2D2;" +
  "padding: 0;" +
  "font-size: " + 32 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "left: 28%;" +
  "width: 44%;" +
  "border-radius: " + 10 * widthK + "px;" +
  "color: #ffffff;" +
  "pointer-events: none;" +
  "}",


//  View autopay schedule method

  autopayScheduleHowOftenText: ".autopay-schedule-howoften-text" +
  "{" +
  "top: 3%; " +
  "position:relative;" +
  "}",

  autopayScheduleBlockContainer: ".autopay-schedule-block-containter" +
  "{" +
  "position: relative;" +
  "height:" + 110 * widthK + "px; " +
  "width: 91%;" +
  "left: 4%;" +
  "margin-top: 1%;" +
  "border-top:" + 1 * widthK + "px solid gainsboro;" +
  "background-color: transparent;" +
  "top: 6%; " +
  "}",

  autopayScheduleBlockText: ".autopay-schedule-block-text" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "top: " + 26 * widthK + "px; " +
  "left: 6%;" +
  "text-align: left;" +
  "font-size:" + 29 * widthK + "px; " +
  "color: #585658;" +
  "}",

  autopayScheduleBlockNextIcon: ".autopay-schedule-block-next-icon" +
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

  autopayScheduleBlockDetailText: ".autopay-schedule-block-detail-text" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "top: " + 31 * widthK + "px; " +
  "left: 6%;" +
  "text-align: left;" +
  "font-size:" + 22 * widthK + "px; " +
  "color: darkgray;" +
  "width: 70%;" +
  "}",

  scheduleDateBlock: ".schedule-date-block " +
  "{" +
  "position: absolute;" +
  "height: 100%;" +
  "width: 100%;" +
  "background-image:  url(resources/icons/transparent.png);" +
  "z-index: 99999;" +
  "display: none;" +
  "}",

  scheduleDateBlockTitleContainer: ".schedule-date-block-title-container" +
  "{" +
  "position: absolute;" +
  "width: 80%;" +
  //"margin-top: " + 42 * widthK + "px;" +
  //"margin-bottom: " + 30 * widthK + "px;" +
  "top: 16%;" +
  "left: 10%;" +
  "height:" + 100 * widthK + "px;" +
  //"background-color: #c1c1c1;" +
  "}",

  scheduleDateBlockTitleLine: ".schedule-date-block-title-line" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  //"margin-top: " + 42 * widthK + "px;" +
  //"margin-bottom: " + 30 * widthK + "px;" +
  "top:34%;" +
  "}",

  scheduleDateBlockTitle: ".schedule-date-block-title" +
  "{" +
  "position: relative;" +
  "color: #8b8b8b;" +
  "width:" + 300 * widthK + "px;" +
  "text-align: center;" +
  "margin-left: auto;" +
  "margin-top: auto;" +
  "margin-bottom: auto;" +
  "margin-right: auto;" +
  "top: 25%;" +
  "font-size:" + 33 * widthK + "px;" +
  "background-color: #f4f4f4;" +
  "}",

  scheduleDateBlockButtonChoose: ".schedule-date-block-button-choose " +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: absolute;" +
  "height: " + 74 * widthK + "px;" +
  "left: 28%;" +
  "width: 44%;" +
  //"top: 82%;" +
  "background-color: #01B8FE;" +
  "border-radius: " + 10 * widthK + "px;" +
  "bottom: 0;" +
  "font-size: " + 32 * widthK + "px;" +
  "color: #ffffff;" +
  "bottom: 17%;" +
  "}",

  scheduleDateBlockDaysOuterContainer: ".schedule-date-block-days-outer-container " +
  "{" +
  "position: absolute;" +
  "width: " + 600 * widthK + "px;" +
  "height:" + 530 * widthK + "px;" +
  "top:" + 309 * widthK + "px;" +
  "left: 8%;" +
  //"background-color: #01B8FE;" +
  "overflow: hidden;" +
  "}",

  scheduleDateBlockTimeOuterContainer: ".schedule-date-block-time-outer-container " +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "width: " + 440 * widthK + "px;" +
  "height:" + 440 * widthK + "px;" +
  "top: " + 311 * widthK + "px;" +
  // "left:" + 140 * widthK + "px;" +
  //"background-color: #01B8FE;" +
  "overflow: hidden;" +
  "}",

  scheduleDateBlockWeekOuterContainer: ".schedule-date-block-week-outer-container " +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "width: " + 600 * widthK + "px;" +
  "height:" + 260 * widthK + "px;" +
  "top:  " + 335 * widthK + "px;" +
  // "left: 7%;" +
  //"background-color: #01B8FE;" +
  "overflow: hidden;" +
  "}",

  scheduleDateBlockDaysContainer: ".schedule-date-block-days-container " +
  "{" +
  "position: absolute;" +
  "width:" + 600 * widthK + "px;" +
  "height:" + 500 * widthK + "px;" +
  "}",

  scheduleDateBlockHoursContainer: ".schedule-date-block-hours-container " +
  "{" +
  "position: absolute;" +
  "width: " + 200 * widthK + "px;" +
  "height:" + 440 * widthK + "px;" +
  "left: 0;" +
  "}",

  scheduleDateBlockHMColonContainer: ".schedule-date-block-hmcolon-container " +
  "{" +
  "position: absolute;" +
  "width: " + 50 * widthK + "px;" +
  "height:" + 440 * widthK + "px;" +
  "left: " + 195 * widthK + "px;" +
  //"background-color: #01B8FE;" +
  "}",

  scheduleDateBlockMinutesContainer: ".schedule-date-block-minutes-container " +
  "{" +
  "position: absolute;" +
  "width: " + 200 * widthK + "px;" +
  "height:" + 440 * widthK + "px;" +
  "right:" + 10 * widthK + "px;" +
  "}",


  scheduleDateBlockDay: ".schedule-date-block-day " +
  "{" +
  "position: absolute;" +
  "height: " + 185 * widthK + "px;" +
  "width: 100%;" +
  "color: #8b8b8b;" +
  "text-align: center;" +
  "}",

  scheduleDateBlockWeek: ".schedule-date-block-week " +
  "{" +
  "position: absolute;" +
  "height: " + 84 * widthK + "px;" +
  "width: 100%;" +
  "color: #8b8b8b;" +
  "text-align: center;" +
  "}",

  scheduleDateBlockTime: ".schedule-date-block-time " +
  "{" +
  "position: absolute;" +
  "height: " + 143 * widthK + "px;" +
  "width: 100%;" +
  "color: #8b8b8b;" +
  "text-align: center;" +
  "}",

  scheduleDateBlockDayText: ".schedule-date-block-day-text " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: #c1c1c1;" +
  "font-size: " + 190 * widthK + "px; " +
  "width: 100%;" +
  "text-align: center;" +
  "top: " + -15 * widthK + "px; " +
  "}",

  scheduleDateBlockWeekText: ".schedule-date-block-week-text " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: #c1c1c1;" +
  "width: 100%;" +
  "text-align: center;" +
  "font-size: " + 70 * widthK + "px; " +
  "}",

  scheduleDateBlockTimeText: ".schedule-date-block-time-text " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: #c1c1c1;" +
  "width: 100%;" +
  "text-align: center;" +
  "font-size: " + 120 * widthK + "px; " +
  "}",

  scheduleDateBlockTimeColonText: ".schedule-date-block-time-colon-text " +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: #c1c1c1;" +
  "width: 100%;" +
  "text-align: center;" +
  "font-size: " + 120 * widthK + "px; " +
  "top: " + 135 * widthK + "px;" +
  "color: #01B8FE;" +
  "}",

  scheduleDateBlockHMBottom: ".schedule-date-block-hm-bottom" +
  "{" +
  "position: relative;" +
  "width: 80%;" +
  "top: 24%;" +
  "left: 10%;" +
  "height:" + 100 * widthK + "px;" +
  "}",

  scheduleDateBlockHMBottomLine: ".schedule-date-block-hm-bottom-line" +
  "{" +
  "position: absolute;" +
  "width: 100%;" +
  //"margin-top: " + 42 * widthK + "px;" +
  //"margin-bottom: " + 30 * widthK + "px;" +
  "top:34%;" +
  "}",

  scheduleDateBlockHMBottomHourText: ".schedule-date-block-hm-bottom-hour-text" +
  "{" +
  "position: relative;" +
  "color: #8b8b8b;" +
  "width:" + 55 * widthK + "px;" +
  "text-align: center;" +
  "top: 25%;" +
  "font-size:" + 25 * widthK + "px;" +
  "background-color: #f4f4f4;" +
  "left: 25%;" +
  "margin: 0;" +
  "float: left;" +
  "}",

  scheduleDateBlockHMBottomMinText: ".schedule-date-block-hm-bottom-min-text" +
  "{" +
  "position: relative;" +
  "color: #8b8b8b;" +
  "width:" + 55 * widthK + "px;" +
  "text-align: center;" +
  "top: 25%;" +
  "font-size:" + 25 * widthK + "px;" +
  "background-color: #f4f4f4;" +
  "left: 55%;" +
  "margin: 0;" +
  "float: left;" +
  "}",

  autoPayNameInputPart: ".autopay-name-input-part" +
  "{" +
  "width: 96%;" +
  "margin-left: 0;" +
  "top: 25%;" +
  "}",

  //VIEW SERVICE INFO

  serviceInfoBodyContainer: ".serviceinfo-body-container" +
  "{" +
  "position: absolute;" +
  "height: " + 1102 * heightK + "px; " +
  "width: 100%; " +
  "top: " + 130 * heightK + "px; " +
  "background-color: #f2f2f1;" +
  // "overflow-x: hidden;" +
  // "overflow-y: scroll;" +
  // "-webkit-overflow-scrolling: touch; " +
  "}",

  serviceInfoOptions: ".serviceinfo-options" +
  "{" +
  "width: 100%;" +
  "height: 85%;" +
  "overflow: auto;" +
  //"border-bottom: 1px solid lightgray;" +
  "}",


  serviceInfoOptionTextContainer: ".serviceinfo-option-text-container" +
  "{" +
  "position: relative;" +
  "background-color: white;" +
  "width: 100%;" +
  "height: 7.5%;" +
  //"border-bottom: 1px solid lightgray;" +
  "}",

  serviceInfoOptionText: ".serviceinfo-option-text" +
  "{" +
  "font-size: " + 27 * widthK + "px; " +
  "text-align: center;" +
  "color: gray;" +
  "margin: 0;" +
  "padding-top: " + 22 * widthK + "px; " +
  "}",

  serviceInfoOptionContainer: ".serviceinfo-option-containter" +
  "{" +
  "position: relative;" +
  //"height: auto;" +
  // "min-height:" + 240 * widthK + "px; " +
  "width: 100%;" +
  //"margin-top: 1%;" +
  "background-color: white;" +
  "}",

  serviceInfoOptionInfoContainer: ".serviceinfo-option-info-container" +
  "{" +
  "position: relative;" +
  "width: 100%;" +
  "padding: 0;" +
  "margin:0;" +
  //"border:" + 1 * widthK + "px solid gainsboro;" +
  "}",

  serviceInfoOptionDetail: ".serviceinfo-option-detail" +
  "{" +
  "position: relative;" +
  "height: " + 150 * widthK + "px; " +
  "width: 100%;" +
  //"border:" + 1 * widthK + "px solid red;" +
  "overflow:hidden;" +
  "border-bottom:" + 1 * widthK + "px solid gainsboro;" +
  "}",

  serviceInfoOptionTitleText: ".serviceinfo-option-title-text" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "top: " + 25 * widthK + "px; " +
  "text-align: center;" +
  "font-size:" + 29 * widthK + "px; " +
  "color: gray;" +
  "}",

  serviceInfoOptionValueText: ".serviceinfo-option-value-text" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "top: " + 35 * widthK + "px; " +
  "text-align: center;" +
  "font-size:" + 29 * widthK + "px; " +
  "font-weight: bold;" +
  "color: #35a8f1;" +
  "height: " + 70 * widthK + "px; " +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "}",

  serviceInfoOptionTitleTextOption: ".serviceinfo-option-title-text-option" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "top: " + 25 * widthK + "px; " +
  "left: 4%;" +
  "text-align: left;" +
  "width: 80%;" +
  "font-size:" + 29 * widthK + "px; " +
  "color: gray;" +
  "}",

  serviceInfoOptionValueTextOption: ".serviceinfo-option-value-text-option" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "top: " + 35 * widthK + "px; " +
  "left: 4%;" +
  "text-align: left;" +
  "width: 80%;" +
  "font-size:" + 29 * widthK + "px; " +
  "font-weight: bold;" +
  "color: #35a8f1;" +
  "height: " + 70 * widthK + "px; " +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "}",

  serviceInfoOptionCheckIcon: ".serviceinfo-option-check-icon" +
  "{" +
  "position: absolute;" +
  "right: 0;" +
  "width: 10%;" +
  "height: 100%;" +
  "top: 0;" +
  "background-repeat: no-repeat;" +
  "background-size: 63%;" +
  "background-position-y: 40%;" +
  "background-image: url(resources/icons/ViewService/radio_unselected.png);" +
  "}",

  serviceInfoButtonNext: ".serviceinfo-button-next" +
  "{" +
  "position: absolute;" +
  "left: 28%;" +
  "width: 44%;" +
  "height: " + 74 * widthK + "px;" +
  "background-color: #00a8f1;" +
  "border-radius: " + 10 * widthK + "px;" +
  "bottom: " + 55 * widthK + "px; " +
  "font-size: " + 32 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "color: #ffffff;" +
  "border: none;" +
  "outline: none;" +
  "}",

  serviceInfoInformField: ".serviceinfo-inform-field" +
  "{" +
  "position: relative;" +
  "width: 90%;" +
  "height:" + 120 * widthK + "px; " +
  "border-bottom:  " + 1 + "px solid lightgray;" +
  "color: white;" +
  "left: 5%;" +
  "}",

  serviceInfoInformFieldTitle: ".serviceinfo-inform-field-title" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "color: darkgray;" +
  "font-size: " + 24 * widthK + "px; " +
  "left: 4%;" +
  "top: 17%;" +
  "}",

  serviceInfoInformFieldValue: ".serviceinfo-inform-field-value" +
  "{" +
  "position: absolute;" +
  "margin: 0;" +
  "left: 4%;" +
  "top: 39%;" +
  "font-size: " + 29 * widthK + "px; " +
  "color: gray;" +
  "width: 90%;" +
  "height: " + 70 * widthK + "px; " +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "}",

//  COMPONENT TOUR

  tourBackPage: ".tour-back-page " +
  "{" +
  "position: absolute;" +
  "height: 100%;" +
  "top: 0;" +
  "width: 100%;" +
  "overflow: hidden;" +
  "z-index: 900;" +
  "transform: translate3d(0, 0,0);" +
  "-webkit-transform: translate3d(0, 0,0);" +
  "-ms-transform: translate3d(0, 0,0);" +
  "background-color: rgba(0, 0, 0, 0.6);" +
  "opacity: 1;" +
  "}",

  componentTour: ".component-tour " +
  "{" +
  "top:" + 30 * heightK + "px;" +
  "position: absolute;" +
  "opacity: 1;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "height:" + 1158 * heightK + "px;" +
  "width:" + 604.797 * widthK + "px;" +
  //"top: 5%;" +
  "left: 50%;" +
  "-webkit-transform: translate3d(-50%, 0, 0);" +
  "background-color: white;" +
  "overflow : hidden;" +
  //"display:none;" +
  "z-index:999;" +
  "-webkit-box-shadow: 0 0 10px rgba(0,0,0, .65);" +
  "-moz-box-shadow: 0 0 10px rgba(0,0,0, .65);" +
  "box-shadow: 0 0 10px rgba(0,0,0, .65);" +
  "}",

  tourTitleText: ".tour-title-text" +
  "{" +
  "position: absolute;" +
  "color: #8b8b8b;" +
  "width:70%;" +
  "text-align: center;" +
  "margin-left: auto;" +
  "margin-top: 0;" +
  "margin-bottom: 0;" +
  "margin-right: auto;" +
  "top:3%;" +
  "left: 15%;" +
  "font-size:" + 33 * widthK + "px;" +
  "z-index: 999;" +
  "font-weight: bold;" +
  "}",

  tourCloseIcon: ".tour-close-icon " +
  "{" +
  "position: absolute;" +
  "width:" + 127 * widthK + "px;" +
  "height:" + 86 * widthK + "px;" +
  "left:80%;" +
  "background-image: url(resources/icons/ComponentTour/tutorial_close.png);" +
  "background-repeat: no-repeat;" +
  "-webkit-background-size: 55%;" +
  "background-position-y: center;" +
  "background-position-x:center;" +
  "background-size: 25%;" +
  "top:1%;" +
  "z-index: 999;" +
  "}",

  tourCardCarousel: ".tour-card-carousel" +
  "{" +
  "position: relative;" +
  "height:" + 900 * heightK + "px;" +
  "width: 100%;" +
  "display: inline-block;" +
  "top: 0;" +
  "bottom:" + 258 * widthK + "px;" +
  "}",


  componentTourCard: ".component-tour-card " +
  "{" +
  "position: absolute;" +
  "opacity: 1;" +
  "height:" + 900 * heightK + "px;" +
  "width:" + 604.797 * widthK + "px;" +
  "left: 8%;" +
  //"background-color: #ee4d3d;" +
  "transform: translate3d(-84%, 0,0);" +
  "-webkit-transform: translate3d(-84%, 0,0);" +
  "background-position: center;" +
  "background-size: 100%;" +
  "background-repeat: no-repeat;" +
  "top: -1px;" +
  "}",

  componentCardUpperContainer: ".component-card-upper-container " +
  "{" +
  "position: absolute;" +
  //"height:" + 510 * widthK + "px;" +
  "height:" + 460 * heightK + "px;" +
  "width: 100%;" +
  "top:0;" +
  //"background-color: lightgray;" +
  "}",

  componentCardUpperIcon: ".component-card-upper-icon" +
  "{" +
  "position: absolute;" +
  "height:83%;" +
  "width:100%;" +
  "top:20%;" +
  "background-repeat: no-repeat;" +
  "background-size: 68%;" +
  "background-position: center;" +
  "background-position-y: 60%;" +
  "}",

  componentCardUpperIconIn: ".component-card-upper-icon-in" +
  "{" +
  "position: absolute;" +
  "height:83%;" +
  "width:100%;" +
  "top:17%;" +
  "background-repeat: no-repeat;" +
  "background-size: 28%;" +
  "background-position: center;" +
  "background-position-y: 50%;" +
  "}",

  componentCardLowerContainer: ".component-card-lower-container " +
  "{" +
  "position: absolute;" +
  "height:" + 390 * heightK + "px;" +
  "width: 100%;" +
  "top:" + 460 * heightK + "px;" +
  "background-color: transparent;" +
  "}",

  componentCardLowerTitleText: ".component-card-lower-title-text " +
  "{" +
  "position: relative;" +
  "color: black;" +
  "width:" + 540 * widthK + "px;" +
  "text-align: center;" +
  "margin-left: auto;" +
  "margin-top: 0;" +
  "margin-bottom: 0;" +
  "margin-right: auto;" +
  "top:21%;" +
  //"left:" + -5 * widthK + "px;" +
  "font-size:" + 35 * widthK + "px;" +
  "font-weight: bold;" +
  "}",

  componentCardLowerBodyText: ".component-card-lower-body-text " +
  "{" +
  "position: relative;" +
  "color: #8b8b8b;" +
  "width:75%;" +
  "text-align: center;" +
  "margin-left: auto;" +
  "margin-top: 0;" +
  "margin-bottom: 0;" +
  "margin-right: auto;" +
  "top:27%;" +
  //"left:" + -5 * widthK + "px;" +
  "font-size:" + 34 * widthK + "px;" +
  "font-weight: bold;" +
  "letter-spacing: 1px;" +
  "word-spacing: 1px;" +
  "line-height:" + 46 * widthK + "px;" +
  "}",

  componentTourBottom: ".component-tour-bottom " +
  "{" +
  "position: relative;" +
  "height:" + 258 * heightK + "px;" +
  "width: 100%;" +
  //"top:" + 110 * widthK + "px;" +
  //"background-color: #ee4d3d;" +
  "}",

  tourNextButtonInnerContainer: ".tour-next-button-inner-container" +
  "{" +
  "top: 83%;" +
  "height: " + 74 * heightK + "px;" +
  "margin: 0 auto 0 auto;" +
  "background-color: #027fe4;" +
  "padding: 0;" +
  "font-size: " + 38 * widthK + "px;" +
  "font-family: SFUIDisplay-Light;" +
  "border: none;" +
  "outline: none;" +
  "position: absolute;" +
  "left: 28%;" +
  "width: 44%;" +
  "border-radius: " + 10 * widthK + "px;" +
  "color: #ffffff;" +
  "}",


  tourButtonsContainer: ".tour-buttons-container" +
  "{" +
  "position: absolute;" +
  "height: " + 97 * heightK + "px;" +
  "width:" + 604.797 * widthK + "px;" +
  "top:" + 90 * heightK + "px;" +
  "bottom:0;" +
  "display: table;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "}",

  tourNextButton: ".tour-next-button" +
  "{" +
  "position: relative;" +
  "height: 100%;" +
  "width: 40%;" +
  "top: 36%;" +
  "display: table;" +
  "background-color: #0CA5E2;" +
  "border-radius:" + 50 * widthK + "px;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "float: left;" +
  "left:" + 60.4 * widthK + "px;" +
  "margin-right: 4%;" +
  "}",

  tourButtonLabel: ".tour-button-label" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "font-size:" + 35 * widthK + "px;" +
  "color: #ffffff;" +
  "text-align: center;" +
  "display: table-cell;" +
  "vertical-align: middle;" +
  "}",

  tourCloseButton: ".tour-close-button" +
  "{" +
  "background-color: transparent;" +
  "border: 2px solid gainsboro;" +
  "width: 35%;" +
  "}",

  tourCloseButtonLabel: ".tour-close-button-label" +
  "{" +
  "color: #595759;" +
  "}",

  tourRegistrationButton: ".tour-registration-button" +
  "{" +
  "position: relative;" +
  "height: 100%;" +
  //"left: -2%;" +
  "width: 80%;" +
  "top: 36%;" +
  "display: table;" +
  "background-color: transparent;" +
  "border: 2px solid gainsboro;" +
  "border-radius:" + 50 * widthK + "px;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "}",

  tourCloseButtonCenter: ".tour-close-button-center" +
  "{" +
  "position: relative;" +
  "height: 85%;" +
  //"left: -2%;" +
  "width: 35%;" +
  "top: 36%;" +
  "display: table;" +
  "background-color: transparent;" +
  "border: 2px solid #c1c1c1;" +
  "border-radius:" + 50 * widthK + "px;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "}",

  tourRegistrationButtonLabel: ".tour-registration-button-label" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "font-size:" + 35 * widthK + "px;" +
  "color: #595759;" +
  "text-align: center;" +
  "display: table-cell;" +
  "vertical-align: middle;" +
  "}",

  tourCirclesContainer: ".tour-circles-container " +
  "{" +
  "position: relative;" +
  "width:" + 320 * widthK + "px;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "height:" + 35 * heightK + "px;" +
  "top:" + 24 * heightK + "px;" +
  "}",

  tourCirclesField: ".tour-circles-field " +
  "{" +
  "position: relative;" +
  //"height:" + 40 * widthK + "px;" +
  "width:" + 130 * widthK + "px;" +
  "margin-right: auto;" +
  "margin-left: auto;" +
  "margin-top:" + 20 * heightK + "px;" +
  "display: inline-block;" +
  "left: 12%;" +
  "}",

  tourCircle: ".tour-circles " +
  "{" +
  "position: absolute;" +
  "width:" + 12 * widthK + "px;" +
  "height:" + 12 * widthK + "px;" +
  "background-color:gainsboro;" +
  "border-radius:" + 50 * widthK + "px;" +
  "}",

  iframeContainer: ".iFrame-container " +
  "{" +
  "position: absolute;" +
  "top: 0;" +
  "z-index: 99999;" +
  "width:" + 720 * widthK + "px;" +
  "height:" + heightOfMobile + "px;" +
  "}",

  iframeMain: ".iFrame-main " +
  "{" +
  "position: absolute;" +
  "bottom: 0;" +
  //"z-index: 99999;" +
  "width: 100%;" +
  "height: 93%;" +
  "background-color: white;" +
  "}",

  iframeToolbarContainer: ".iFrame-toolbar-container " +
  "{" +
  "position: absolute;" +
  "bottom: 92%;" +
  "width: 100%;" +
  "height: 10%;" +
  "background-color: #00b8ff;" +
  "}",

  iFrameBackButton: ".iFrame-back-button " +
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
  "left: 0%;" +
  "top:" + 20 * widthK + "px;" +
  "}",

  iFrameTitle: ".iFrame-title " +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size:" + 35 * widthK + "px;" +
  "left: 12.5%;" +
  "top:" + 40 * widthK + "px;" +
  "margin: 0;" +
  "color: #fffaf9;" +
  "}",

  defaultAccountTitle: ".default-account-title" +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "font-size: " + 38 * widthK + "px; " +
  "left: 25%;" +
  "top: 56%;" +
  "margin: 0;" +
  "color: #fffaf9;" +
  "white-space: nowrap;" +
  "text-overflow: ellipsis;" +
  "overflow: hidden;" +
  "width: 60%;" +
  "}",


  // InPlace Payment

  inPlacePayCategoryContainer: ".inplace-pay-category-container" +
  "{" +
  "position: absolute;" +
  "height:94%; " +
  "width: 100%; " +
  "top:" + 88 * widthK + "px; " +
  "bottom:0; " +
  "z-index:3; " +
  "overflow:hidden; " +
  "background-color: white; " +
  "}",


  inPlacePayCategoryInnerContainer: ".inplace-pay-category-inner-container" +
  "{" +
  "position: absolute;" +
  // "height:100%; " +
  "width: 100%; " +
  "top: 0; " +
  // "top:15%; " +
  "bottom:0; " +
  "overflow-y: auto; " +
  "overflow-x: hidden; " +
  "-webkit-overflow-scrolling: touch; " +
  "}",

  inPlacePayServiceInnerContainer: ".inplace-pay-service-inner-container" +
  "{" +
  "position: absolute;" +
  "height:85%; " +
  "width: 100%; " +
  "top:12%; " +
  "bottom:0; " +
  "overflow-y: auto; " +
  "overflow-x: hidden; " +
  "-webkit-overflow-scrolling: touch; " +
  "}",

  inPlacePayServiceInnerContainerScroll: ".inplace-pay-service-inner-container::-webkit-scrollbar" +
  "{" +
  "width:" + 10 * widthK + "px; " +
  "}",

  inPlacePayServiceInnerContainerScrollThumb: ".inplace-pay-service-inner-container::-webkit-scrollbar-thumb" +
  "{" +
  "background-color: rgba(0, 0, 0, .15); " +
  "}",


  inPlacePayBlockContainer: ".inplace-pay-block-containter" +
  "{" +
  "position: relative;" +
  "min-height:" + 95 * widthK + "px; " +
  "width: 90%;" +
  "left: 5%;" +
  "padding-top: 1%;" +
  "border-top: 1px solid gainsboro;" +
  "background-color: transparent;" +
  "}",


  inPlacePayCategoryIcon: ".inplace-pay-category-icon" +
  "{" +
  "position: relative;" +
  "width:" + 77 * widthK + "px; " +
  "height:" + 77 * widthK + "px; " +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "background-position-x: left;" +
  "float: left;" +
  // "left: 2%;" +
  "background-size: 100%;" +
  "}",

  inPlacePayCategoryNameField: ".inplace-pay-category-name-field" +
  "{" +
  "position: relative;" +
  "background-size: contain;" +
  "top: " + 25 * widthK + "px; " +
  "left: 4%;" +
  "text-align: left;" +
  "font-size:" + 33 * widthK + "px; " +
  "color: rgb(45,45,45);" +
  "overflow: hidden;" +
  "text-overflow: ellipsis;" +
  "white-space: nowrap;" +
  "}",

  inPlacePayIconTick: ".inplace-pay-icon-tick " +
  "{" +
  "position: relative;" +
  "left: 95%;" +
  "background-size: contain;" +
  "background-image: url(resources/icons/ViewInPlacePay/indoor_arrow.png);" +
  "background-repeat: no-repeat;" +
  "width:" + 19 * widthK + "px;" +
  "height:" + 18 * widthK + "px;" +
  // "top:" + 9 * widthK + "px;" +
  "}",

  inPlacePaySearchContainer: ".inplace-pay-search-container" +
  "{" +
  "position: absolute;" +
  "height:12%; " +
  "width: 100%; " +
  "background-color: white; " +
  "z-index: 99999;" +
  "}",


  inPlacePaySearchField: ".inplace-pay-search-field" +
  "{" +
  "position: relative;" +
  "left: 10%;" +
  "width: 79.5%;" +
  "height: 74.5%;" +
  "border-bottom:  " + 3 * widthK + "px solid #e8e8e8;" +
  "color: white;" +
  // "top: 8%;" +
  "}",

  inPlacePaySearchInputPart: ".inplace-pay-search-input-part" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "top: 25%;" +
  "padding: 0;" +
  "margin: 0;" +
  // "margin-left: 3%;" +
  "width: 85%;" +
  "font-size:" + 50 * widthK + "px; " +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "}",

  inPlacePaySearchInputPlaceholder: ".inplace-pay-search-input-part::-webkit-input-placeholder" +
  "{" +
  "font-size:" + 30 * widthK + "px;" +
  "color: darkgray;" +
  "padding: " + 20 * widthK + "px 0 0 0;" +
  "}",

  inPlacePaySearchIcon: ".inplace-pay-search-icon" +
  "{" +
  "position: relative;" +
  "float: right;" +
  "right: -4%;" +
  "background-image: url(resources/icons/ViewInPlacePay/indoor_search.png);" +
  "width:" + 76 * widthK + "px;" +
  "height:" + 87 * widthK + "px;" +
  "-webkit-background-size: 50%;" +
  "background-repeat: no-repeat;" +
  "background-size: 50%;" +
  "background-position: center;" +
  "top: 22%;" +
  "}",

  // View InPlacePayService

  inPlacePayServiceContainer: ".inplace-pay-service-container" +
  "{" +
  "position: relative;" +
  "height:" + 230 * widthK + "px; " +
  "width: 90%;" +
  "left: 5%;" +
  "top:" + -4 * widthK + "px; " +
  "border-top:" + 0.5 + "px solid gainsboro;" +
  "background-color: transparent;" +
  "z-index:9999999;" +
  "}",


  inPlacePayServiceIcon: ".inplace-pay-service-icon" +
  "{" +
  "position: absolute;" +
  "width:" + 167 * widthK + "px; " +
  "height:" + 167 * widthK + "px; " +
  "background-repeat: no-repeat;" +
  "background-position: center;" +
  "float: left;" +
  "left: 1%;" +
  "top:" + 31 * widthK + "px; " +
  "background-size: 100%;" +
  "}",

  inPlacePayServiceInfo: ".inplace-pay-service-info" +
  "{" +
  "position: absolute;" +
  "height:" + 190 * widthK + "px; " +
  "width: 70%;" +
  "left: 38%;" +
  "top: 9%;" +
  // "float: left;" +
  "background-color: transparent;" +
  "}",

  inPlacePayServiceNameField: ".inplace-pay-service-name-field" +
  "{" +
  "position: relative;" +
  "top: " + 20 * widthK + "px; " +
  // "left: 18%;" +
  "text-align: left;" +
  "font-size:" + 36 * widthK + "px; " +
  "color: rgb(45,45,45);" +
  "overflow: hidden;" +
  "text-overflow: ellipsis;" +
  "white-space: nowrap;" +
  "}",

  inPlacePayServiceAddressField: ".inplace-pay-service-address-field" +
  "{" +
  "position: relative;" +
  "top: " + 28 * widthK + "px; " +
  "text-align: left;" +
  "font-size:" + 24 * widthK + "px; " +
  "color: #a9abaf;" +
  // "height: " + 65 * widthK + "px; " +
  "width: 70%;" +
  "overflow: hidden;" +
  "text-overflow: ellipsis;" +
  "}",

  inPlacePayServiceDistanceContainer: ".inplace-pay-service-distance-container" +
  "{" +
  "position: relative;" +
  "top: " + 30 * widthK + "px; " +
  "left: " + 2 * widthK + "px; " +
  "text-align: left;" +
  // "font-size:" + 26 * widthK + "px; " +
  // "color: #00a8f1;" +
  "}",

  inPlacePayServiceDistanceField: ".inplace-pay-service-distance-field" +
  "{" +
  "position: relative;" +
  // "top: " + 54 * widthK + "px; " +
  "text-align: left;" +
  "font-size:" + 26 * widthK + "px; " +
  "left:" + 7 * widthK + "px; " +
  "color: #00a8f1;" +
  "}",

  inPlacePayServiceDistanceIcon: ".inplace-pay-service-distance-icon " +
  "{" +
  "position: relative;" +
  // "left: 96%;" +
  "background-size: contain;" +
  "background-image: url(resources/icons/ViewInPlacePay/indoor_position.png);" +
  "background-repeat: no-repeat;" +
  "width:" + 23 * widthK + "px;" +
  "height:" + 23 * widthK + "px;" +
  "margin-top: " + 4 * widthK + "px;" +
  "float: left;" +
  "}",

  inPlacePayServiceIconTick: ".inplace-pay-service-icon-tick " +
  "{" +
  "position: absolute;" +
  "right: 1.5%;" +
  "background-size: contain;" +
  "background-image: url(resources/icons/ViewInPlacePay/indoor_arrow.png);" +
  "background-repeat: no-repeat;" +
  "width:" + 19 * widthK + "px;" +
  "height:" + 18 * widthK + "px;" +
  "top: 47%;" +
  "}",

  inPlacePayGoToQrContainer: ".inplace-pay-gotoqr-container" +
  "{ " +
  "position: absolute;" +
  "width:" + 115 * widthK + "px;" +
  "height:" + 160 * widthK + "px;" +
  "bottom:" + 36 * widthK + "px;" +
  "right:" + 54 * widthK + "px;" +
  "}",

  inPlacePayGoToQrButton: ".inplace-pay-gotoqr-button" +
  "{ " +
  "position: absolute;" +
  "width:" + 115 * widthK + "px;" +
  "height:" + 115 * widthK + "px;" +
  // "bottom:" + 79 * widthK + "px;" +
  // "right:" + 54 * widthK + "px;" +
  "background-image: url(resources/icons/ViewInPlacePay/indoor_qr.png);" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "z-index: 9999999;" +
  "border-radius: " + 100 * widthK + "px;" +
  "-webkit-box-shadow: 0px " + 5 * widthK + "px " + 12 * widthK + "px " + -7 * widthK + "px " + "rgba(0,0,0,1);" +
  "-moz-box-shadow: 0px " + 5 * widthK + "px " + 12 * widthK + "px " + -7 * widthK + "px " + "rgba(0,0,0,1);" +
  "box-shadow:  0px " + 5 * widthK + "px " + 12 * widthK + "px " + -7 * widthK + "px " + "rgba(0,0,0,1);" +
  "}",

  inPlacePayGoToQrLabel: ".inplace-pay-gotoqr-label" +
  "{" +
  "position: absolute;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "width:" + 240 * widthK + "px;" +
  "bottom:" + -3 * widthK + "px;" +
  "color: #515151;" +
  "font-size:" + 24 * widthK + "px;" +
  "}",

  inPlacePaySearchNoMatch: ".inplace-pay-search-no-match " +
  "{" +
  "position: relative;" +
  "margin-left: auto;" +
  "margin-right: auto;" +
  "width:" + 240 * widthK + "px;" +
  "bottom:" + 17 * widthK + "px;" +
  "color: #515151;" +
  "top: 25%;" +
  "font-size:" + 30 * widthK + "px;" +
  "}",


  //Service Additional Info


  // serviceAddInfoPeriodField: ".service-addinfo-period-field" +
  // "{" +
  // "position: relative;" +
  // "left: 10%;" +
  // "width: 79.5%;" +
  // "height: 8%;" +
  // "border-bottom:  " + 3 * widthK + "px solid #01cfff;" +
  // "color: white;" +
  // "top: 8%;" +
  // "}",
  //
  serviceAddInfoFromInput: ".service-addinfo-from-input" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "top: 20%;" +
  "padding: 0;" +
  "margin: 0;" +
  // "margin-left: 3%;" +
  "width: 95%;" +
  "font-size:" + 44 * widthK + "px; " +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "}",

  serviceAddInfoChoosePeriodText: ".service-addinfo-choose-period-text" +
  "{" +
  "position: relative;" +
  "margin-bottom: 0;" +
  "color: gray;" +
  "font-size:" + 24 * widthK + "px; " +
  "left: 10%;" +
  // "top: 3%;" +
  "}",

  serviceAddInfoPeriodContainer: ".service-addinfo-period-containter" +
  "{" +
  "position: relative;" +
  "height: 7%; " +
  "width: 79.5%;" +
  "left: 10%;" +
  "border-bottom:" + 3 * widthK + "px solid lightgrey;" +
  "background-color: transparent;" +
  // "top: 6%;" +
  "}",

  serviceAddInfoFieldTitle: ".service-addinfo-field-title" +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "bottom: " + 15 * widthK + "px; " +
  //"left: 3%;" +
  "text-align: left;" +
  "font-size:" + 29 * widthK + "px; " +
  "color: gray;" +
  "}",

  serviceAddInfoFieldDate: ".service-addinfo-field-date" +
  "{" +
  "position: absolute;" +
  "background-size: contain;" +
  "bottom: " + 15 * widthK + "px; " +
  "right: 0;" +
  "text-align: right;" +
  "font-size:" + 29 * widthK + "px; " +
  "color: gray;" +
  "}",

  serviceAddInfoAmountField: ".service-addinfo-amount-field" +
  "{position: relative;" +
  "left: 10%;" +
  "width: 79.5%;" +
  "height: 10%;" +
  "border-bottom:  " + 3 * widthK + "px solid lightgray;" +
  "color: white;" +
  "top: 5%" +
  "}",

  serviceAddInfoAmountIcon: ".service-addinfo-amount-icon" +
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

  serviceAddInfoAmountInput: ".service-addinfo-amount-input" +
  "{" +
  "border: none;" +
  "outline: none;" +
  "position: relative;" +
  "top: 25%; " +
  "width: 88%;" +
  "font-size:" + 54 * widthK + "px; " +
  "font-family: 'SFUIDisplay-Light';" +
  "color: #515151;" +
  "padding: 0;" +
  "margin: 0;" +
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
riotTags.setAttribute('class', 'riot-tags-main-container')
firstMount.firstStep();

