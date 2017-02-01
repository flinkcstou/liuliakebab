<view-info class="view-info">
    <div class="view-info-title-container">
        <div class="view-info-back-button" ontouchend="onTouchEndBack()"></div>
    </div>

    <div class="view-info-balance-container">
        <p class="view-info-balance-label">{window.languages.ViewInfoBalanceTitle}</p>
        <div class="card-balance-currency-container">
            <p class="view-info-card-balance"></p>
            <p class="card-currency"></p>
        </div>
        <div class="view-info-bag-icon"></div>
        <div class="view-info-reload-icon"></div>
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
             style="left:{leftOfOperations*i.count + 50}px;">

            <div class="view-info-operation-info-container">
                <p class="view-info-operation-info-name">{i.service_name}</p>
                <p class="view-info-operation-info-balance">{i.amount}</p>
                <p class="view-info-operation-info-number">+{i.cntrg_info_param2}</p>
                <p class="view-info-operation-info-date">{i.created}</p>
            </div>

        </div>

    </div>

    <script>
        var scope = this;

        if (device.platform != 'BrowserStand')
            StatusBar.backgroundColorByHexString("#ffffff");

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

                        scope.lastOperationContainer.push(result[1][i])
                        scope.lastOperationContainer[i].count = j;
                        j++;
                    }
//                    console.log('scope.lastOperationContainer', scope.lastOperationContainer)
                    riot.update(scope.lastOperationContainer)
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