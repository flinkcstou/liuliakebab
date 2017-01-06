<component-page-title class="page-title">
    <p class="name-title">{opts.title}</p>
    <div id="backButton" type="button" ontouchstart="touchStartTitle()"
         class="{back-button: opts.backbutton}">

    </div>
    <input id="rightButton" type="button" class="hide {right-button: opts.rightbutton}">

    <script>
        var scope = this;
        touchStartTitle = function () {
            this.riotTags.innerHTML = "<view-main-page>";
            riot.mount('view-main-page');
        }
    </script>
</component-page-title>