<view-transfer-stepfour>
    <div class="transfer-page-title">
        <p class="transfer-name-title">{titleName}</p>
        <div id="backButton" ontouchend="goToBack()"
             class="{transfer-back-button: backbuttoncheck}">

        </div>
        <div id="rightButton" type="button" class="{transfer-i-button: rightbuttoncheck}"></div>
    </div>

    <div class="transferfour-body-container">
        <div class="transferfour-data-container">
            <div class="transferfour-phone-field" if="{viewServicePage.formType!=2}">
                <p class="transferfour-text-field">{window.languages.ViewTransferFourEnterPhone}</p>
                <p class="transferfour-phone-input"></p>
            </div>

            <div class="transferfour-field">
                <p class="transferfour-owner-field">{window.languages.ViewTransferFourOwner}</p>
                <p class="transferfour-owner-input"></p>
            </div>

            <div class="transferfour-field-sum">
                <p class="transferfour-amount-field">{window.languages.ViewTransferFourAmountOfPay}</p>
                <p class="transferfour-amount-input">{amountText} сум</p>
                <p class="transferfour-tax-field">{window.languages.ViewTransferFourTax}</p>
            </div>
            <div class="transferfour-field">
                <p class="transferfour-text-field">{window.languages.ViewTransferFourCategory}</p>
                <p class="transferfour-phone-input" style="text-decoration: underline"></p>
            </div>
            <div class="transferfour-card-field">
                <div class="transferfour-card-info-container">
                    <p class="transferfour-text-one">{window.languages.ViewTransferFourPayFromCard}</p>
                    <p class="transferfour-text-two">{cardName}</p>
                    <p class="transferfour-detail-text">{numberPartOne} **** {numberPartTwo}</p>
                    <p class="transferfour-detail-text">Доступно:{salary} {currency}</p>
                </div>
                <div class="transferfour-card-logo-container"
                     style="background-image: url({url})">
                </div>
            </div>
        </div>

        <div class="transferfour-bottom-container">
            <div class="transferfour-action-containter">
                <div class="transferfour-action-icon-one"
                     style="background-image: url('resources/icons/ViewService/addfavorite.png');"></div>
                <div class="transferfour-action-text">{window.languages.ViewTransferFourAddToFavouritePartOne}<br>{window.languages.ViewTransferFourAddToFavouritePartTwo}</div>
            </div>
            <div class="transferfour-button-enter" ontouchend="transferStep()">
                <p class="transferfour-button-enter-label">{window.languages.ViewTransferFourPay}</p>
            </div>
        </div>
    </div>

    <code-confirm id="blockCodeConfirmId" class="code-confirm">
        <div class="code-confirm-title-container">
            <p class="code-confirm-title-name">{window.languages.ComponentCodeConfirmTitle}</p>
            <div class="code-confirm-cancel-icon" ontouchend="confirmCodeCancelEnd()"></div>
        </div>
        <div class="code-confirm-code-container">
            <p class="code-confirm-code-text">8723</p>
            <p class="code-confirm-message-text">Передайте код получателю для завершения перевода</p>

            <div class="code-confirm-button-enter" ontouchend="transferStep()">
                <p class="code-confirm-button-enter-label">OK</p>
            </div>
        </div>
    </code-confirm>

    <script>
        if (history.arrayOfHistory[history.arrayOfHistory.length - 1] != 'view-transfer-stepfour') {
            history.arrayOfHistory.push('view-transfer-stepfour');
            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
        }

        var scope = this;
        scope.backbuttoncheck = true;
        scope.rightbuttoncheck = false;


        this.titleName = window.languages.ViewTransferFourTitle;


        transferStep = function () {
            blockCodeConfirmId.style.display = 'block';
        }

        confirmCodeCancelEnd = function () {
            blockCodeConfirmId.style.display = 'none';
        }
    </script>
</view-transfer-stepfour>
