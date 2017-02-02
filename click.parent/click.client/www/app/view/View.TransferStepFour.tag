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
                <p class="transferfour-text-field">{cardOrPhone}</p>
                <p class="transferfour-phone-input">{plus}{objectTypeForTransfer.name}</p>
            </div>

            <div id="ownerContainerId" class="transferfour-owner-container" if="{cardType}">
                <p class="transferfour-owner-field">{window.languages.ViewTransferFourOwner}</p>
                <p class="transferfour-owner-input"></p>
            </div>

            <div class="transferfour-field-sum">
                <p class="transferfour-amount-field">{window.languages.ViewTransferFourAmountOfPay}</p>
                <p class="transferfour-amount-input">{objectSumForTransfer.sum} {objectCardForTransfer.currency}</p>
                <p class="transferfour-tax-field">{window.languages.ViewTransferFourTax}</p>
            </div>
            <div id="categoryContainerId" class="transferfour-category-container">
                <p class="transferfour-text-field">{window.languages.ViewTransferFourCategory}</p>
                <p class="transferfour-phone-input" style="text-decoration: underline"></p>
            </div>
            <div class="transferfour-card-field">
                <div class="transferfour-card-info-container">
                    <p class="transferfour-text-one">{window.languages.ViewTransferFourTransferInformation}</p>
                    <p class="transferfour-text-two">{objectCardForTransfer.name}</p>
                    <p class="transferfour-detail-text">{objectCardForTransfer.numberPartOne} ****
                        {objectCardForTransfer.numberPartTwo}</p>
                    <p class="transferfour-detail-text">Доступно:{objectCardForTransfer.salary}
                        {objectCardForTransfer.currency}</p>
                </div>
                <div class="transferfour-card-logo-container"
                     style="background-image: url({objectCardForTransfer.url})">
                </div>
            </div>
        </div>

        <div class="transferfour-bottom-container">
            <div class="transferfour-action-containter">
                <div class="transferfour-action-icon-one"
                     style="background-image: url('resources/icons/ViewService/addfavorite.png');"></div>
                <div class="transferfour-action-text">{window.languages.ViewTransferFourAddToFavouritePartOne}<br>{window.languages.ViewTransferFourAddToFavouritePartTwo}
                </div>
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
            <p class="code-confirm-code-text">{secretCode}</p>
            <p class="code-confirm-message-text">Передайте код получателю для завершения перевода</p>

            <div class="code-confirm-button-enter" ontouchend="closeSecretCodePage()">
                <p class="code-confirm-button-enter-label">OK</p>
            </div>
        </div>
    </code-confirm>

    <script>
        if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-transfer-stepfour') {
            history.arrayOfHistory.push(
                    {
                        "view": 'view-transfer-stepfour',
                        "params": opts
                    }
            );
            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
        }

        var scope = this;
        scope.backbuttoncheck = true;
        scope.rightbuttoncheck = false;

        scope.objectTypeForTransfer = opts[0][0];
        if (scope.objectTypeForTransfer.type == 1) {
            scope.cardType = true;
            scope.plus = '';
        }
        else {
            scope.phoneType = false;
            scope.plus = '+';
        }


        scope.objectSumForTransfer = opts[0][1];
        scope.objectComment = opts[0][2];
        scope.objectCardForTransfer = opts[0][3];



        var transferTitle;

        var objectForTransfer = opts[0][0];


        if (objectForTransfer.type == 1) {
            transferTitle = objectForTransfer.name.substring(0, 4) + ' **** ' + objectForTransfer.name.substring(15, objectForTransfer.name.length)
            scope.cardOrPhone = window.languages.ViewTransferFourEnterCard;
        }
        else {
            transferTitle = objectForTransfer.name;
            scope.cardOrPhone = window.languages.ViewTransferFourEnterPhone;
        }


        this.titleName = window.languages.ViewTransferFourTitle + ' +' + transferTitle;


        transferStep = function () {

            var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
            var phoneNumber = localStorage.getItem('click_client_phoneNumber');

            window.api.call({
                method: 'p2p.payment',
                input: {
                    session_key: sessionKey,
                    phone_num: phoneNumber,
                    account_id: scope.objectCardForTransfer.card_id,
                    receiver_data: scope.objectTypeForTransfer.name.replace(/\s/g, ''),
                    amount: parseInt(scope.objectSumForTransfer.sum),
                    type: scope.objectTypeForTransfer.type,
                    transaction_id: parseInt(Date.now() / 1000)
//                                card_number: cardNumberForTransfer.replace(/\s/g, ''),

                },

                scope: this,

                onSuccess: function (result) {
                    if (result[0][0].error == 0) {
                        console.log("result of TRANSFER ", result);
                        if (result[1][0]) {
                            if (result[1][0].secret_code && scope.objectTypeForTransfer.type == 2) {
                                blockCodeConfirmId.style.display = 'block';
                                scope.secretCode = result[1][0].secret_code;
                                riot.update(scope.secretCode);
                            }
                            if(result[1][0].secret_code == 0){
                                alert('Перевод на карту прошел успешно')
                            }
                        }
                    }
                    else {
                        alert(result[0][0].error_note)
                    }
                },

                onFail: function (api_status, api_status_message, data) {
                    console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                    console.error(data);
                }
            });
        }

        closeSecretCodePage = function () {
            blockCodeConfirmId.style.display = 'none';
        }
    </script>
</view-transfer-stepfour>
