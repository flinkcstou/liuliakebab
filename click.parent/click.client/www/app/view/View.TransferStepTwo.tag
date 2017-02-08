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
            <input maxlength="13" class="transfertwo-contact-number-input-part" id="sumValueId" onmouseup="sumMouseUp()"
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
            if(viewTransferStepTwo.sum.length > 0){
                sumValueId.value = viewTransferStepTwo.sum;
                checkFirst = true;
            }
            else
            sumValueId.value = 0 + ' ' + defaultAccount.currency
        })


        var scope = this,
                transferTitle,
                objectForTransfer = opts[0],
                defaultAccount,
                maskOne = /[0-9]/g,
                maskTwo = /[0-9' ']/g,
                checkFirst = false,
                sumForTransfer = 0;

        sumMouseUp = function () {
            event.preventDefault()
            event.stopPropagation()
            if (!checkFirst) {
                sumValueId.value = ' ' + defaultAccount.currency
                checkFirst = true;
            }
            if (sumValueId.value.match(maskOne) != null && sumValueId.value.match(maskOne).length != null) {
                sumValueId.selectionStart = sumValueId.value.match(maskTwo).length
                sumValueId.selectionEnd = sumValueId.value.match(maskTwo).length
            } else {
                sumValueId.selectionStart = 0
                sumValueId.selectionEnd = 0
            }
        }

        sumKeyUp = function () {
            if (event.keyCode == 8) {
                sumForTransfer = sumForTransfer.substring(0, sumForTransfer.length - 1)
            }

            if (sumValueId.value.match(maskTwo) != null && sumValueId.value.match(maskTwo).length != null) {

                sumValueId.value = sumValueId.value.substring(0, event.target.value.match(maskTwo).length) + defaultAccount.currency
                sumValueId.selectionStart = sumValueId.value.match(maskTwo).length - 1
                sumValueId.selectionEnd = sumValueId.value.match(maskTwo).length - 1

                sumForTransfer = sumValueId.value.substring(0, sumValueId.value.match(maskTwo).length);
                sumForTransfer = sumForTransfer.replace(new RegExp(' ', 'g'), '');

                if (sumForTransfer.length == 4) {
                    sumValueId.value = sumForTransfer.substring(0, 1) + ' ' + sumForTransfer.substring(1, sumForTransfer.length) + ' ' + defaultAccount.currency
                    sumValueId.selectionStart = sumValueId.value.match(maskTwo).length - 1
                    sumValueId.selectionEnd = sumValueId.value.match(maskTwo).length - 1
                }

                if (sumForTransfer.length == 5) {
                    sumValueId.value = sumForTransfer.substring(0, 2) + ' ' + sumForTransfer.substring(2, sumForTransfer.length) + ' ' + defaultAccount.currency
                    sumValueId.selectionStart = sumValueId.value.match(maskTwo).length - 1
                    sumValueId.selectionEnd = sumValueId.value.match(maskTwo).length - 1
                }

                if (sumForTransfer.length == 6) {
                    sumValueId.value = sumForTransfer.substring(0, 3) + ' ' + sumForTransfer.substring(3, sumForTransfer.length) + ' ' + defaultAccount.currency
                    sumValueId.selectionStart = sumValueId.value.match(maskTwo).length - 1
                    sumValueId.selectionEnd = sumValueId.value.match(maskTwo).length - 1
                }

                if (sumForTransfer.length == 7) {
                    sumValueId.value = sumForTransfer.substring(0, 1) + ' ' + sumForTransfer.substring(1, 4) + ' ' +
                            sumForTransfer.substring(4, sumForTransfer.length) + ' ' + defaultAccount.currency
                    sumValueId.selectionStart = sumValueId.value.match(maskTwo).length - 1
                    sumValueId.selectionEnd = sumValueId.value.match(maskTwo).length - 1
                }

                if (sumForTransfer.length == 8) {
                    sumValueId.value = sumForTransfer.substring(0, 2) + ' ' + sumForTransfer.substring(2, 5) + ' ' +
                            sumForTransfer.substring(5, sumForTransfer.length) + ' ' + defaultAccount.currency
                    sumValueId.selectionStart = sumValueId.value.match(maskTwo).length - 1
                    sumValueId.selectionEnd = sumValueId.value.match(maskTwo).length - 1
                }


            } else {
                sumValueId.selectionStart = 0
                sumValueId.selectionEnd = 0
            }

            viewTransferStepTwo.sum = sumValueId.value;

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

        if (objectForTransfer.type == 2)
            this.titleName = window.languages.ViewTransferTwoTitle + ' +' + transferTitle;
        else
            this.titleName = window.languages.ViewTransferTwoTitle + ' ' + transferTitle;;

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
            if (sumForTransfer < 5000) {
                alert('Минимальная сумма 5 000')
                return;
            }
            if (sumForTransfer > 5000000) {
                alert('Максимальная сумма 5 000 000')
                return;
            }
            var sum = {"sum": sumForTransfer};
            var comment = {"comment": commentTextId.value};

            riotTags.innerHTML = "<view-transfer-stepthree>";
            riot.mount('view-transfer-stepthree', [objectForTransfer, sum, comment]);
        }


    </script>
</view-transfer-steptwo>
