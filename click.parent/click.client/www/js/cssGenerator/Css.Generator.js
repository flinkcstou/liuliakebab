var css = {
  html               : "html" +
  "{ " +
  "-webkit-user-select: none; " +
  "-webkit-touch-callout: none; " +
  "-webkit-user-drag: none; " +
  "-webkit-tap-highlight-color:rgba(0,0,0,0);" +
  "text-decoration:none;" +
  "color:inherit;" +
  "}",
  htmlId : "#htmlId " +
  "{" +
  "width: 100%;" +
  "height: 100%;" +
  "background-size: contain;" +
  "background-repeat: no-repeat;" +
  "background-image: -moz-linear-gradient(rgb(0, 122, 226) 0%, rgb(28, 200, 249) 60%, rgb(27, 198, 248) 100%);" +
  "background-image: -webkit-linear-gradient(rgb(0, 122, 226) 0%, rgb(28, 200, 249) 60%, rgb(27, 198, 248) 100%);" +
  "background-image: -ms-linear-gradient(rgb(0, 122, 226) 0%, rgb(28, 200, 249) 60%, rgb(27, 198, 248) 100%);" +
  "font-family: SFUIDisplay-Light;margin: 0;" +
  "overflow: hidden;" +
  "}",
  input : "input " +
  "{" +
  "font-family: Neuron;" +
  "font-size: 24px;" +
  "}"

}


var style = document.createElement('style');
style.type = 'text/css';
var allCss = '';
var styleSheet = style.stylesheet;
for (key in css) {

  allCss += css[key];
  console.log(allCss);
}
//styleSheet.cssText = css.html;
style.appendChild(document.createTextNode(allCss));

document.getElementsByTagName("head")[0].appendChild(style);
console.log(css);

var g = 0;

