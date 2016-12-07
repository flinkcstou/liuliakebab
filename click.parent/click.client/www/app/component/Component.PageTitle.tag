<component-page-title class="page-title">
  <p class="name-title">{opts.title}</p>
  <input id="backButton" value="BACK" type="button" ontouchstart="touchStartTitle()" class="{back-button: opts.backbutton}">
  <input id="rightButton" type="button" class="{right-button: opts.rightbutton}">

  <script>
    var scope = this;
    touchStartTitle = function(){
      this.riotTags.innerHTML = "<view-main-page>";
      riot.mount('view-main-page');
    }
  </script>
</component-page-title>