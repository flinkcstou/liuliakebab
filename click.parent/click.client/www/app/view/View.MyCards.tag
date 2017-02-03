<view-my-cards class="view-my-cards">
    <component-page-title title="{titleName}" backbutton="{backbuttoncheck}" rightbutton="{rightbuttoncheck}">
    </component-page-title>
    <div class="my-cards-carousel">
        <component-card-carousel>
        </component-card-carousel>
    </div>

    <div class="my-cards-button-container">
        <div class="my-cards-button-field my-cards-button-field-transfer">
            <div class="my-cards-button-icon my-cards-button-icon-transfer">
            </div>

            <div class="my-cards-button-label">{window.languages.ViewMyCardTransfer}
            </div>
        </div>

        <div class="my-cards-button-field my-cards-button-field-payment">
            <div class="my-cards-button-icon my-cards-button-icon-payment">
            </div>

            <div class="my-cards-button-label" ontouchend="goToPayView()">{window.languages.ViewMyCardPay}
            </div>
        </div>

        <div class="my-cards-button-field my-cards-button-field-report">
            <div class="my-cards-button-icon my-cards-button-icon-report">
            </div>

            <div class="my-cards-button-label">{window.languages.ViewMyCardReports}
            </div>
        </div>
    </div>

    <div class="my-cards-button-block-card">
        <div class="my-cards-button-icon my-cards-button-icon-block"></div>
        <div class="my-cards-button-block-card-label">{window.languages.ViewMyCardBlock}</div>
    </div>

    <div class="my-cards-last-operations">
        <div class="my-cards-last-operations-container-label">
            <p class="my-cards-last-operations-label">{window.languages.ViewMyCardLastOperations}</p>

            <div id="lastOperationContainerId" class="my-cards-last-operations-container">
                <div class="my-cards-last-operations-info" each="{i in arrayOfOperationsByAccount}"
                     style="top: {i.count*top}px">
                    <div class="my-cards-operation-amount">- {i.amount}</div>
                    <div class="my-cards-operation-currency">сум</div>
                    <div class="my-cards-firm-name">{i.service_name}</div>
                    <div class="my-cards-operation-date">{i.created}</div>
                </div>
            </div>

        </div>


    </div>


    <script>
        if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-my-cards') {
            history.arrayOfHistory.push(
                    {
                        "view": 'view-my-cards',
                        "params": opts
                    }
            );
            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
        }

        var scope = this,
                sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key,
                phoneNumber = localStorage.getItem('click_client_phoneNumber');


        if (opts[0])
            scope.cardId = opts[0];


        scope.top = 160 * widthK;
        viewMyCards.check = true;
        viewMainPage.myCards = true;
        scope.backbuttoncheck = true;
        scope.rightbuttoncheck = true;
        scope.cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));


        this.titleName = window.languages.ViewMyCardTitleName;


        scope.card = scope.cardsArray[scope.cardId];
        console.log('scope.cardId',scope.cardId)
        console.log('scope.card',scope.card)


        scope.arrayOfOperationsByAccount = [];

        scope.cardInformation = cardInformation = function (cardIdFromCarousel) {
            event.preventDefault();
            event.stopPropagation();

            scope.card = JSON.parse(localStorage.getItem('click_client_cards'))[cardIdFromCarousel];
            scope.arrayOfOperationsByAccount = [];
            console.log(scope.card)

            window.api.call({
                method: 'get.payments.by.account',
                input: {
                    session_key: sessionKey,
                    phone_num: phoneNumber,
                    account_id: scope.card.card_id
                },

                onSuccess: function (result) {
                    if (result[0][0].error == 0) {
                        if (result[1][0]) {
                            var j = 0;
                            for (var i in result[1]) {
                                if (result[1][i].account_id == scope.card.card_id && result[1][i].state == 0) {
                                    result[1][i].count = j;
                                    j++;
                                    scope.arrayOfOperationsByAccount.push(result[1][i]);
                                }
                            }
                            this.lastOperationContainerId.style.height = j * 160 * widthK + 'px';
                            riot.update(scope.arrayOfOperationsByAccount)
                        }
                    }
                    else
                        alert(result[0][0].error_note)

                },

                onFail: function (api_status, api_status_message, data) {
                    console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                    console.error(data);
                }
            });
        }

        scope.cardInformation(scope.cardId);

        goToPayView = function () {
            for (var i = 0; i < scope.cardsArray.length; i++) {
                scope.cardsArray[i].chosenCard = false;
                if (scope.cardsArray[i].card_id == scope.card.card_id) {
                    scope.cardsArray[i].chosenCard = true;
                }
            }
            localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsArray));

            event.preventDefault();
            event.stopPropagation();

            riotTags.innerHTML = "<view-pay>";
            riot.mount('view-pay');
        }

    </script>
</view-my-cards>