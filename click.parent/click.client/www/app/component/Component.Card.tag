<component-card class="card" style="background-image: url({opts.background}); left:{leftOfCard}px">

    <div class="card-bank-name-url" style="background-image: url({opts.url})"></div>
    <div class="card-bank-name" style="background-image: url({opts.bankname})"></div>
    <div class="card-salary-title">{opts.name}</div>

    <div class="card-balance-currency-container">
        <p if="{!modeOfflineMode.check}" class="card-balance">{opts.salary}</p>
        <p if="{!modeOfflineMode.check && opts.salary}" class="card-currency">{opts.currency}</p>

        <a if="{modeOfflineMode.check}" class="offline-card-balance"
           ontouchstart="offlineBalanceTrue()">Получить баланс</a>
    </div>

    <div class="card-number">
        <div class="card-number-part-one">{opts.numberpartone}</div>
        <p class="number-stars">**** ****</p>
        <div class="card-number-part-two">{opts.numberparttwo}</div>
    </div>

    <script>
        modeOfflineMode.balance = false;
        console.log('backgroundImage', opts.background)

        var scope = this;
        scope.leftOfCard = (540 * opts.countcard + 100) * widthK;

        offlineBalanceTrue = function () {
            event.preventDefault()
            event.stopPropagation();
            modeOfflineMode.balance = true;

            phonedialer.dial(
                    "*111%23",
                    function (err) {
                        if (err == "empty") alert("Unknown phone number");
                        else alert("Dialer Error:" + err);
                    },
                    function (success) {
                        alert('Dialing succeeded');
                    }
            );

        }


    </script>
</component-card>