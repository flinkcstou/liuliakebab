<component-card class="card" style="background-image: url({backgroundImage}); left:{leftOfCard}px">

    <div class="card-bank-name-url" style="background-image: url({opts.url})"></div>
    <div class="card-bank-name" style="background-image: url({opts.bankname})"></div>
    <div class="card-salary-title">{opts.name}</div>

    <div class="card-balance-currency-container">
        <p if="{!modeOfflineMode.check}" class="card-balance">{opts.salary}</p>
        <p if="{!modeOfflineMode.check && opts.salary}" class="card-currency">{opts.currency}</p>

        <a href="tel:*880*2%23" if="{modeOfflineMode.check}" class="offline-card-balance"
           onmousedown="offlineBalanceTrue()">Получить баланс</a>
    </div>

    <div class="card-number">
        <div class="card-number-part-one">{opts.numberpartone}</div>
        <p class="number-stars">**** ****</p>
        <div class="card-number-part-two">{opts.numberparttwo}</div>
    </div>

    <script>
        modeOfflineMode.balance = false;

        var scope = this;
        scope.backgroundImage = '';
        console.log(modeOfflineMode.check)
        scope.leftOfCard = (540 * opts.countcard + 100) * widthK;
        if (opts.background == 'https://merchant.click.uz/static/content/app/background/card0.png') {
            scope.backgroundImage = 'resources/icons/cards/card2.png';
        }

        if (opts.background == 'https://merchant.click.uz/static/content/app/background/card1.png') {
            scope.backgroundImage = 'resources/icons/cards/card1.png';
        }

        offlineBalanceTrue = function () {
            event.preventDefault()
            event.stopPropagation();
            modeOfflineMode.balance = true;
        }
        //        offlineBalanceFalse = function () {
        //            event.preventDefault()
        //            event.stopPropagation();
        //            modeOfflineMode.balance = false;
        //        }


    </script>
</component-card>