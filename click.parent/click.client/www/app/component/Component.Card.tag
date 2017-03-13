<component-card class="card"
                style="background-image: url({opts.background}); color: rgb({opts.fontcolor}); left:{leftOfCard}px">

  <div class="card-bank-name-url" style="background-image: url({opts.url})"></div>
  <div class="card-bank-name" style="background-image: url({opts.bankname})"></div>
  <div class="card-salary-title">{opts.name}</div>

  <div class="card-balance-currency-container">
    <p if="{!modeOfApp.offlineMode}" class="card-balance">{opts.salary}</p>
    <p if="{!modeOfApp.offlineMode && opts.salary}" class="card-currency">{opts.currency}</p>

    <a if="{modeOfApp.offlineMode}" class="offline-card-balance"
       ontouchstart="offlineBalanceTrueTouchStart()" ontouchend="offlineBalanceTrueTouchEnd()"
       ontouchmove="offlineBalanceTrueTouchMove()">Получить баланс</a>
  </div>

  <div class="card-number">
    <div class="card-number-part-one">{opts.numberpartone}</div>
    <p class="number-stars">**** ****</p>
    <div class="card-number-part-two">{opts.numberparttwo}</div>
  </div>

  <script>
    modeOfApp.offlineMode.balance = false;

    var scope = this;
    scope.leftOfCard = (540 * opts.countcard + 100) * widthK;

    scope.on("mount", function () {

      console.log("ASD_scope.leftOfCard", scope.leftOfCard);
    });

    offlineBalanceTrueTouchStart = function () {
      event.stopPropagation();
      event.preventDefault();
      modeOfApp.offlineMode.balance = true;

      if (device.platform == "Android") {
        phonedialer.dial(
            "*880*2%23",
            function (err) {
              if (err == "empty") alert("Unknown phone number");
              else console.log("Dialer Error:" + err);
            },
            function (success) {
            }
        );
      }
    }

    offlineBalanceTrueTouchEnd = function () {
      event.stopPropagation();
      event.preventDefault();
    }
    offlineBalanceTrueTouchMove = function () {
      event.stopPropagation();
      event.preventDefault();
    }


  </script>
</component-card>