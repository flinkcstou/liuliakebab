<component-page-title class="page-title">
  <p class="name-title">{opts.title}</p>
  <div id="backButton" ontouchstart="touchStartTitle()"
       class="{back-button: opts.backbutton}">

  </div>

  <script>
    var scope = this;
    touchStartTitle = function () {
      this.riotTags.innerHTML = "<view-main-page>";
      riot.mount('view-main-page');
    }
  </script>
</component-page-title>