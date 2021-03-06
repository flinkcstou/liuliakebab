<component-card class="card"
                id="{'cardNumber'+opts.countcard}"
                style="background-image: url({(opts.background)}); color: rgb({opts.fontcolor}); left:{(540 * opts.countcard + 100) * widthK}px"
                ontouchstart="cardTouchStart(this.id)" ontouchend="cardTouchEnd(this.id)">

  <div class="card-bank-name" style="background-image: url({opts.bankname})"></div>
  <div class="card-salary-title">{opts.name}</div>

  <div class="card-balance-currency-container" style="opacity: {opts.fontopacity};">
    <p if="{!modeOfApp.offlineMode}" class="card-balance">{(opts.salary) ? (opts.salary) : (opts.error_message)}<span
      class="card-balance-fractional">{(opts.salary_fractional) ? (opts.salary_fractional) : ''}</span></p>
    <p if="{!modeOfApp.offlineMode && opts.salary}" class="card-currency">{opts.currency}</p>

    <a if="{modeOfApp.offlineMode}" style="color: rgb({opts.fontcolor});" class="offline-card-balance"
       ontouchstart="offlineBalanceTrueTouchStart()" ontouchend="offlineBalanceTrueTouchEnd()"
       ontouchmove="offlineBalanceTrueTouchMove()">Получить баланс</a>
  </div>

  <div class="card-number">
    <div class="card-number-part-one">{opts.numberpartone}</div>
    <div class="card-number-middle-two">{opts.numbermiddletwo}</div>
    <p class="number-stars" if="{opts.numberpartone && opts.numberparttwo}">** ****</p>
    <div class="card-number-part-two">{opts.numberparttwo}</div>
  </div>

  <script>
    modeOfApp.offlineMode.balance = false;

    var scope = this;

    if (!opts.background) {
      console.log('QWEQ');
      opts.background = 'background-image: url(resources/icons/cards/all.png)';
      console.log('opts.background', opts.background);
      scope.update()
    }


    cardTouchStart = function (id) {

      //document.getElementById(id).style.webkitTransform = 'scale(0.8)'
    };

    cardTouchEnd = function (id) {
//      document.getElementById(id).style.webkitTransform = 'scale(1)'
    };

    offlineBalanceTrueTouchStart = function () {
      event.stopPropagation();
      event.preventDefault();

      modeOfApp.offlineMode.balance = true;

      if (device.platform == "Android") {
        phonedialer.dial(
          "*880*2%23",
          function (err) {
            if (err == "empty") {

              scope.clickPinError = false;
              scope.errorNote = "Unknown phone number";

              window.common.alert.show("componentAlertId", {
                clickpinerror: scope.clickPinError,
                errornote: scope.errorNote,
                parent: scope
              });
              scope.update();
            }
            else console.log("Dialer Error:" + err);
          },
          function (success) {
          }
        );
        return
      }
    };

    offlineBalanceTrueTouchEnd = function () {
      event.stopPropagation();
      event.preventDefault();
    };
    offlineBalanceTrueTouchMove = function () {
      event.stopPropagation();
      event.preventDefault();
    }


  </script>
</component-card>