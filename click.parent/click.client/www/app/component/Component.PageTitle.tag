<component-page-title class="page-title">
    <p class="name-title">{opts.title}</p>
    <div id="backButton" ontouchend="touchStartTitle()"
         class="{back-button: opts.backbutton}">

    </div>
    <div id="rightButton" type="button" class="{settings-button: opts.rightbutton}"></div>

    <script>
        var scope = this;
        touchStartTitle = function () {
            event.preventDefault();
            event.stopPropagation();
            onBackKeyDown()
        }
    </script>
</component-page-title>