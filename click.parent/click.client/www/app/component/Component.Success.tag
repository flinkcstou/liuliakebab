<component-success id="componentSuccessId" class="component-success">
    <p class="success-operation-success-message">{opts.operationmessage}</p>
    <div class="success-success-icon"></div>

    <div class="success-next-button-inner-container" ontouchend="closeSuccessMessageForm()">
        <p class="success-next-button-label">{window.languages.ComponentSuccessNext}</p>
    </div>

    <script>
        var scope = this;

        closeSuccessMessageForm = function () {
            event.preventDefault();
            event.stopPropagation();
            componentSuccessId.style.display = 'none';
            history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - 3)
            console.log(history.arrayOfHistory)
            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

            console.log('viewpage',opts.viewpage)


            riotTags.innerHTML = "<" + opts.viewpage + ">";
            riot.mount(opts.viewpage);
        }
    </script>
</component-success>