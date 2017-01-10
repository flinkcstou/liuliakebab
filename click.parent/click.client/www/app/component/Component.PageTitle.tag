<component-page-title class="page-title">
    <p class="name-title">{opts.title}</p>
    <div id="backButton" ontouchstart="touchStartTitle()"
         class="{back-button: opts.backbutton}">

    </div>
    <div id="rightButton" type="button" class="{settings-button: opts.rightbutton}"></div>

    <script>
        var scope = this;
        touchStartTitle = function () {
            event.preventDefault();
            event.stopPropagation();

            this.riotTags.innerHTML = "<view-main-page>";
            riot.mount('view-main-page');
        }
    </script>
</component-page-title>