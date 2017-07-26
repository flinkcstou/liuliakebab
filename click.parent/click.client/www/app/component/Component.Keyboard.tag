<component-keyboard>
  <div class="keyboard-container">

    <div class="keyboard-field-one">
      <div id="oneButtonId" class="keyboard-buttons keyboard-button-one" value="1"
           ontouchend="componentKeyboard.returnValue(getAttribute('value'), this.id)"
           ontouchstart="componentKeyboard.returnStartValue(this.id)"><p class="keyboard-buttons-label">
        1</p></div>
      <div id="twoButtonId" class="keyboard-buttons keyboard-button-two" value="2"
           ontouchend="componentKeyboard.returnValue(getAttribute('value'), this.id)"
           ontouchstart="componentKeyboard.returnStartValue(this.id)"><p class="keyboard-buttons-label">
        2</p></div>
      <div id="threeButtonId" class="keyboard-buttons keyboard-button-three" value="3"
           ontouchend="componentKeyboard.returnValue(getAttribute('value'), this.id)"
           ontouchstart="componentKeyboard.returnStartValue(this.id)"><p
        class="keyboard-buttons-label">3</p></div>
    </div>

    <div class="keyboard-field-two">
      <div id="fourButtonId" class="keyboard-buttons keyboard-button-four" value="4"
           ontouchend="componentKeyboard.returnValue(getAttribute('value'), this.id)"
           ontouchstart="componentKeyboard.returnStartValue(this.id)"><p
        class="keyboard-buttons-label">4</p></div>
      <div id="fiveButtonId" class="keyboard-buttons keyboard-button-five" value="5"
           ontouchend="componentKeyboard.returnValue(getAttribute('value'), this.id)"
           ontouchstart="componentKeyboard.returnStartValue(this.id)"><p
        class="keyboard-buttons-label">5</p></div>
      <div class="keyboard-buttons keyboard-button-six" value="6"
           id="sixButtonId" ontouchend="componentKeyboard.returnValue(getAttribute('value'), this.id)"
           ontouchstart="componentKeyboard.returnStartValue(this.id)"><p class="keyboard-buttons-label">
        6</p></div>
    </div>

    <div class="keyboard-field-three">
      <div id="sevenButtonId" class="keyboard-buttons keyboard-button-seven" value="7"
           ontouchend="componentKeyboard.returnValue(getAttribute('value'), this.id)"
           ontouchstart="componentKeyboard.returnStartValue(this.id)"><p
        class="keyboard-buttons-label">7</p></div>
      <div id="eightButtonId" class="keyboard-buttons keyboard-button-eight" value="8"
           ontouchend="componentKeyboard.returnValue(getAttribute('value'), this.id)"
           ontouchstart="componentKeyboard.returnStartValue(this.id)"><p
        class="keyboard-buttons-label">8</p></div>
      <div id="nineButtonId" class="keyboard-buttons keyboard-button-nine" value="9"
           ontouchend="componentKeyboard.returnValue(getAttribute('value'), this.id)"
           ontouchstart="componentKeyboard.returnStartValue(this.id)"><p
        class="keyboard-buttons-label">9</p></div>
    </div>
    <div class="keyboard-field-four">
      <div id="fingerPrintButtonId" class="keyboard-buttons keyboard-space" if="{opts.fingerprint == true}"
           ontouchend="componentKeyboard.returnValue(getAttribute('value'), this.id)"
           ontouchstart="componentKeyboard.returnStartValue(this.id)"
           value="space"></div>
      <div id="zeroButtonId" class="keyboard-buttons keyboard-button-zero" value="0"
           ontouchend="componentKeyboard.returnValue(getAttribute('value'), this.id)"
           ontouchstart="componentKeyboard.returnStartValue(this.id)"><p
        class="keyboard-buttons-label">0</p></div>
      <div id="xButtonId" class="keyboard-buttons keyboard-button-x" value="x"
           ontouchend="componentKeyboard.returnValue(getAttribute('value'), this.id)"
           ontouchstart="componentKeyboard.returnStartValue(this.id)"><p class="keyboard-buttons-label"></p>
      </div>
    </div>
  </div>

  <script>
    var scope = this;

    console.log("KEYBOARD OPTS", opts)

    this.on('mount', function () {
      scope.update()
    })

  </script>
</component-keyboard>