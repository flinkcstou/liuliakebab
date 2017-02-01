<view-transfer-steptwo>
    <div class="transfer-page-title">
        <p class="transfer-name-title">{titleName}</p>
        <div id="backButton" ontouchend="goToBack()" class="{transfer-back-button: backbuttoncheck}"></div>
        <div id="rightButton" type="button" class="{transfer-i-button: rightbuttoncheck}"></div>
    </div>

    <div class="transfertwo-body-container">
        <div class="transfertwo-menus-container">
            <p id="cardLabelId" class="transfertwo-menu-name-label" ontouchend="card()">
                {window.languages.ViewTransferTwoSum}</p>
        </div>

        <div class="transfertwo-contact-phone-field">
            <p class="transfertwo-contact-text-field">{window.languages.ViewTransferTwoTax}</p>
            <input value="{sumValue}" class="transfertwo-contact-number-input-part" id="sumValueId" autofocus="true"
                   type="tel"/>
        </div>

        <div class="transfertwo-next-button-inner-container" ontouchend="goToTransferThree()">
            <p class="transfertwo-next-button-label">{window.languages.ViewTransferTwoNext}</p>
        </div>

        <div class="transfertwo-comment-container">
            <textarea id="commentTextId" maxlength="255" class="transfertwo-comment-input"
                      type="text" placeholder={comment}></textarea>
        </div>

    </div>


    <script>

        scope = this;
        scope.backbuttoncheck = true;
        scope.rightbuttoncheck = false;
        scope.comment = 'комментарий';
        var bufferForSum;
        var defaultAccount;
        var cards = JSON.parse(localStorage.getItem('click_client_cards'));
        for (var i in cards) {
            if (cards[i].default_account === true)
                defaultAccount = cards[i];
        }

        var transferTitle
        var objectForTransfer = opts[0];

        if (objectForTransfer.type == 1) {
            transferTitle = objectForTransfer.name.substring(0, 4) + ' **** ' + objectForTransfer.name.substring(15, objectForTransfer.name.length)
        }
        else
            transferTitle = objectForTransfer.name

        this.titleName = window.languages.ViewTransferTwoTitle + ' +' + transferTitle;

        if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-transfer-steptwo') {
            history.arrayOfHistory.push(
                    {
                        "view": 'view-transfer-steptwo',
                        "params": opts
                    }
            );
            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
        }

        goToBack = function () {
            event.preventDefault();
            event.stopPropagation();
            onBackKeyDown()
        }

        goToTransferThree = function () {
            event.preventDefault()
            event.stopPropagation()
            if(sumValueId.value < 5000){
                alert('Минимальная сумма 5 000')
                return;
            }
            if(sumValueId.value > 5000000){
                alert('Максимальная сумма 5 000 000')
                return;
            }
            var sum = {"sum": sumValueId.value};
            var comment = {"comment": commentTextId.value};

            this.riotTags.innerHTML = "<view-transfer-stepthree>";
            riot.mount('view-transfer-stepthree', [objectForTransfer, sum, comment]);
        }


    </script>
</view-transfer-steptwo>
