<component-page-title class="page-title">
  <p class="name-title">{opts.title}</p>
  <input id="backButton" type="button" class="{back-button: opts.backbutton}">
  <input id="rightButton" type="button" class="{right-button: opts.rightbutton}">

  <script>
    console.log(opts.backbutton);
    console.log(this.backButton);
  </script>
</component-page-title>