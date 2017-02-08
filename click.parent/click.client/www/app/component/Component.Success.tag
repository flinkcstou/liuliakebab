<component-success id="componentSuccessId" class="component-success">
    <p class="success-operation-success-message">{opts.operationmessage}</p>
        <div class="success-success-icon"></div>

    <div class="success-next-button-inner-container" ontouchend="closeSuccessMessageForm()">
        <p class="success-next-button-label">{window.languages.ComponentSuccessNext}</p>
    </div>

    <script>
        var scope = this;

        closeSuccessMessageForm = function () {
            componentSuccessId.style.display = 'none';
        }
    </script>
</component-success>