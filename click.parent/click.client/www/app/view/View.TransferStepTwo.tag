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
            <input class="transfertwo-contact-number-input-part" id="sumValueId"  onmouseup="sumMouseUp()"
                   type="tel" onkeyup="sumKeyUp()"/>
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


        this.on('mount', function () {
            sumValueId.value = 0 + ' ' + defaultAccount.currency
        })


        var scope = this,
                transferTitle,
                objectForTransfer = opts[0],
                defaultAccount,
                mask = /[0-9]/g,
                checkFirst = false;

        sumMouseUp = function () {
            event.preventDefault()
            event.stopPropagation()
            if(!checkFirst) {
                sumValueId.value = defaultAccount.currency
                checkFirst = true;
            }
            console.log(sumValueId.value);
            if (sumValueId.value.match(mask) != null) {
                sumValueId.selectionStart = sumValueId.value.match(mask).length
                sumValueId.selectionEnd = sumValueId.value.match(mask).length
            } else {
                sumValueId.selectionStart = 0
                sumValueId.selectionEnd = 0
            }
        }

        sumKeyUp = function () {
            console.log(event.target.value.match(mask))
            sumValueId.value = sumValueId.value.substring(0,event.target.value.match(mask).length) + defaultAccount.currency

            if (sumValueId.value.match(mask) != null) {
                sumValueId.selectionStart = sumValueId.value.match(mask).length
                sumValueId.selectionEnd = sumValueId.value.match(mask).length
            } else {
                sumValueId.selectionStart = 0
                sumValueId.selectionEnd = 0
            }
        }

        scope.backbuttoncheck = true;
        scope.rightbuttoncheck = false;
        scope.comment = 'комментарий';

        var cards = JSON.parse(localStorage.getItem('click_client_cards'));
        for (var i in cards) {
            if (cards[i].default_account === true)
                defaultAccount = cards[i];
        }


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
            if (sumValueId.value < 5000) {
                alert('Минимальная сумма 5 000')
                return;
            }
            if (sumValueId.value > 5000000) {
                alert('Максимальная сумма 5 000 000')
                return;
            }
            var sum = {"sum": sumValueId.value};
            var comment = {"comment": commentTextId.value};

            riotTags.innerHTML = "<view-transfer-stepthree>";
            riot.mount('view-transfer-stepthree', [objectForTransfer, sum, comment]);
        }


    </script>
</view-transfer-steptwo>
