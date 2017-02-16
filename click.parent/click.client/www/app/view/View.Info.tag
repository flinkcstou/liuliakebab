<view-info class="view-info">
    <div class="view-info-title-container">
        <div class="view-info-back-button" ontouchstart="onTouchEndBack()"></div>
    </div>

    <div class="view-info-balance-container">
        <p class="view-info-balance-label">{window.languages.ViewInfoBalanceTitle}</p>
        <div class="view-info-card-balance-currency-container">
            <p if="{!modeOfflineMode.check}" class="view-info-card-balance">{fullBalanceCopy}</p>
            <p if="{!modeOfflineMode.check}" class="view-info-card-currency">сум</p>

            <a if="{modeOfflineMode.check}" class="offline-card-balance"
               ontouchstart="offlineBalanceInfoTrue()">Получить баланс</a>
        </div>
        <div class="view-info-bag-icon"></div>
        <div if="{attention && !modeOfflineMode.check}" class="view-info-attention-icon"></div>
        <div if="{!modeOfflineMode.check}" class="view-info-reload-icon" ontouchend="reloadBalanceTouchEnd()"></div>
    </div>

    <div class="view-info-my-finance-container">
        <div class="view-info-my-finance-icon"></div>
        <div class="view-info-open-icon"></div>
        <p class="view-info-my-finance-title">{window.languages.ViewInfoMyFinanceTitle}</p>
    </div>

    <div class="view-info-reports-container">
        <div class="view-info-reports-icon"></div>
        <div class="view-info-open-icon"></div>
        <p class="view-info-reports-title">{window.languages.ViewInfoReportsTitle}</p>
    </div>

    <div class="view-info-operations-title">
        <p class="view-info-operations-label">{window.languages.ViewInfoLastOperations}</p>
    </div>

    <div class="view-info-operations-container">

        <div class="view-info-operations-icon" each="{i in lastOperationContainer}"
             style="left:{leftOfOperations*i.count + 50}px; background-image: url({i.image})">

            <div class="view-info-operation-info-container">
                <p class="view-info-operation-info-name">{i.service_name}</p>
                <p class="view-info-operation-info-balance">{i.amount}</p>
                <p class="view-info-operation-info-balance">{}</p>
                <p class="view-info-operation-info-number">+{i.cntrg_info_param2}</p>
                <p class="view-info-operation-info-date">{i.created}</p>
            </div>

        </div>

    </div>

    <script>
        var scope = this;
        var defaultAccount;
        scope.attention = false;
        scope.fullBalance = 0;

        var cards = JSON.parse(localStorage.getItem('click_client_cards'));
        var getAccountsCards = JSON.parse(localStorage.getItem('click_client_accountInfo'));
        console.log('getAccountsCards', getAccountsCards)
        for (var i in cards) {
            if (cards[i].default_account === true)
                defaultAccount = cards[i];
        }

        this.on('mount', function () {

            if (!modeOfflineMode.check) {
                console.log('scope.fullBalance', scope.fullBalance)
            }
        })

        reloadBalanceTouchEnd = function () {
            scope.fullBalance = 0;
            scope.fullBalanceCopy = '';
            writeBalance()
        }

        writeBalance = function () {
            var j = 0;
            for (var i = 0; i < getAccountsCards.length; i++) {
                window.api.call({
                    method: 'get.balance',
                    input: {
                        session_key: sessionKey,
                        phone_num: phoneNumber,
                        account_id: getAccountsCards[i].id,
                        card_num_hash: getAccountsCards[i].card_num_hash,
                        card_num_crypted: getAccountsCards[i].card_num_crypted
                    },
                    //TODO: DO CARDS
                    scope: this,
                    onSuccess: function (result) {
                        if (result[0][0].error == 0) {
                            if (result[1][0]) {
                                console.log('getAccountsCards[j].currency_name', getAccountsCards[j].currency_name)
                                console.log('defaultAccount.currency', defaultAccount.currency)
                                if (getAccountsCards[j].currency_name.trim() == defaultAccount.currency.trim()) {
                                    scope.fullBalance = parseInt(scope.fullBalance);
                                    scope.fullBalance += result[1][0].balance;
                                    scope.fullBalanceCopy = scope.fullBalance;

                                    scope.fullBalanceCopy = scope.fullBalanceCopy.toFixed(0).toString();

                                    if (scope.fullBalanceCopy.length == 7) {
                                        scope.fullBalanceCopy = scope.fullBalanceCopy.substring(0, 1) + ' ' +
                                                scope.fullBalanceCopy.substring(1, 4) + ' ' + scope.fullBalanceCopy.substring(4, scope.fullBalanceCopy.length)
                                    }

                                    if (scope.fullBalanceCopy.length == 6) {
                                        scope.fullBalanceCopy = scope.fullBalanceCopy.substring(0, 3) + ' ' +
                                                scope.fullBalanceCopy.substring(3, scope.fullBalanceCopy.length)

                                    }

                                    if (scope.fullBalanceCopy.length == 5) {
                                        scope.fullBalanceCopy = scope.fullBalanceCopy.substring(0, 2) + ' ' +
                                                scope.fullBalanceCopy.substring(2, scope.fullBalanceCopy.length)

                                    }

                                    if (scope.fullBalanceCopy.length == 4) {
                                        scope.fullBalanceCopy = scope.fullBalanceCopy.substring(0, 1) + ' ' +
                                                scope.fullBalanceCopy.substring(1, scope.fullBalanceCopy.length)

                                    }
                                    riot.update(scope.fullBalanceCopy);
                                }
                                else
                                    scope.attention = true;

                                j++;

                            }
                        }
                        else
                            alert(result[0][0].error_note);
                    },

                    onFail: function (api_status, api_status_message, data) {
                        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                        console.error(data);
                    }
                });
            }

        }
        writeBalance();

        offlineBalanceInfoTrue = function () {
            event.preventDefault()
            event.stopPropagation();
            modeOfflineMode.balance = true;

            if (device.platform == "Android") {
                phonedialer.dial(
                        "*111*3%23",
                        function (err) {
                            if (err == "empty") alert("Unknown phone number");
                            else alert("Dialer Error:" + err);
                        },
                        function (success) {
                        }
                );
            }
            if(device.platform == "iOS"){
                window.open('*111%23')
            }
        }


        if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-info') {
            history.arrayOfHistory.push(
                    {
                        "view": 'view-info',
                        "params": ''
                    }
            );
            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
        }

        scope.leftOfOperations = 470 * widthK;
        scope.lastOperationContainer = [];

        onTouchEndBack = function () {
            event.preventDefault();
            event.stopPropagation();

            this.riotTags.innerHTML = '<view-main-page>';
            riot.mount('view-main-page');

        }
        var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
        var phoneNumber = localStorage.getItem('click_client_phoneNumber');

        window.api.call({
            method: 'get.payment.list',
            input: {
                session_key: sessionKey,
                phone_num: phoneNumber,
            },

            scope: this,

            onSuccess: function (result) {
                if (result[0][0].error == 0) {
                    var j = 0;
                    for (var i in result[1]) {
                        if (result[1][i].state == 0) {
                            result[1][i].count = j;

                            result[1][i].amount = result[1][i].amount.toString();

                            if (result[1][i].amount.length == 7) {
                                result[1][i].amount = result[1][i].amount.substring(0, 1) + ' ' +
                                        result[1][i].amount.substring(1, 4) + ' ' + result[1][i].amount.substring(4, result[1][i].amount.length)

                            }

                            if (result[1][i].amount.length == 6) {
                                result[1][i].amount = result[1][i].amount.substring(0, 3) + ' ' +
                                        result[1][i].amount.substring(3, result[1][i].amount.length)

                            }

                            if (result[1][i].amount.length == 5) {
                                result[1][i].amount = result[1][i].amount.substring(0, 2) + ' ' +
                                        result[1][i].amount.substring(2, result[1][i].amount.length)

                            }

                            if (result[1][i].amount.length == 4) {
                                result[1][i].amount = result[1][i].amount.substring(0, 1) + ' ' +
                                        result[1][i].amount.substring(1, result[1][i].amount.length)

                            }
                            scope.lastOperationContainer.push(result[1][i])

                            j++;
                        }
                    }
//                    console.log('scope.lastOperationContainer', scope.lastOperationContainer)
                    riot.update(scope.lastOperationContainer)
                    console.log('scope.lastOperationContainer', scope.lastOperationContainer);
                }
                else
                    alert(result[0][0].error_note)

            },

            onFail: function (api_status, api_status_message, data) {
                console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                console.error(data);
            }
        });

    </script>
</view-info>