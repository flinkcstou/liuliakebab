<component-edit-text>

  <div>

    <p>
      {title}
    </p>
    <label>
      <input id='inputId'
             type='{opts.input_type}'
             maxlength='{opts.maxlength}'
             autofocus='{opts.autofocus}'/>
    </label>

  </div>

  <script>

    const self = this;

    self.title = checkText(opts.title);

    function checkText(text) {
      return text === null ? '' : text;
    }

    self.getInputText = function getInputText() {
      return '345345';
    }

  </script>

</component-edit-text>