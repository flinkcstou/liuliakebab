<view-contact>

  <div class="view-contact-page-title">
    <p class="view-contact-name-title">{titleName}</p>
    <div id="backButton" ontouchend="goToBack()" class="view-contact-back-button"></div>
  </div>

  <div class="view-contact">
    <div class="view-contact-info-title">
      <div class="view-contact-info-icon" style="background-image: url({contactPhoto})">{firstLetter}</div>
      <p class="view-contact-info-text">{firstName} {secondName}</p>
    </div>
    <div class="view-contact-pay-transfer-container" ontouchstart="contactPayTouchStart()"
         ontouchend="contactPayTouchEnd()">
      <div class="view-contact-pay-icon"></div>
      <p class="view-contact-pay-title">{window.languages.ViewContactPay}</p>
      <div class="view-contact-open-icon"></div>
    </div>
    <div class="view-contact-pay-transfer-container" ontouchstart="contactTransferTouchStart()"
         ontouchend="contactTransferTouchEnd()">
      <div class="view-contact-transfer-icon"></div>
      <p class="view-contact-transfer-title">{window.languages.ViewContactTransfer}</p>
      <div class="view-contact-open-icon"></div>
    </div>
  </div>

  <div class="view-contact-select-container" id="contactSelectContainerId">

    <div class="view-contact-page-title">
      <div class="view-contact-select-x-button" ontouchend="closeContactPickTouchEnd()"></div>
    </div>

    <div class="view-contact-select-info-title">
      <div class="view-contact-info-icon" style="background-image: url({contactPhoto})">{firstLetter}</div>
      <p class="view-contact-info-text">{firstName} {secondName}</p>
    </div>
    <p class="view-contact-select-choose-title">{window.languages.ViewContactChooseNumber}</p>

    <div class="view-contact-select-phone-container">
      <div class="view-contact-select-phone-number-container" each="{i in arrayOfNumbers}"
           ontouchend="choosePhoneNumberTouchEnd({i.value})">
        <p class="view-contact-select-phone-number">+{i.value}</p>
      </div>
    </div>
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>
    var scope = this;

    this.on('mount', function () {

    })
    //REFRESH OBJECT TRANSFER VIEW
    viewTransfer.check = false;
    viewTransfer.phoneNumber = '';
    viewTransfer.cardNumber = '';
    viewTransfer.type = 2;

    console.log(opts.object.phoneNumbers)
    scope.firstName = opts.object.contactFname;
    scope.secondName = opts.object.contactLname;
    scope.contactPhoto = opts.object.contactPhoto;
    scope.firstLetter = opts.object.firstLetter;
    scope.arrayOfNumbers = opts.object.phoneNumbers[0];

    if (scope.arrayOfNumbers) {

      for (var i in scope.arrayOfNumbers) {
        console.log('I', i)
        console.log('I', scope.arrayOfNumbers[i])
        var number = scope.arrayOfNumbers[i].value
        var maskOne = /[0-9]/g;

        var digits = scope.arrayOfNumbers[i].value.match(maskOne);
        var phone = '';
        for (var j in digits) {
          phone += digits[j]
        }
//        phone = phone.substring(phone.length - 9, phone.length);

        scope.arrayOfNumbers[i].value = phone;

//        for(var j = 0; j < number.length; j++){
//
//        }
      }
    }

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-contact') {
      history.arrayOfHistory.push(
        {
          "view": 'view-contact',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    scope.titleName = window.languages.ViewContactTitle;

    var goToPay = false;
    var goToTransfer = false;

    var payTouchStart, payTouchEnd;

    contactPayTouchStart = function () {
      payTouchStart = event.changedTouches[0].pageY
      event.preventDefault()
      event.stopPropagation()
    }

    contactPayTouchEnd = function () {
      event.preventDefault()
      event.stopPropagation()

      payTouchEnd = event.changedTouches[0].pageY

      if (Math.abs(payTouchStart - payTouchEnd) <= 20) {
        goToPay = true;
        goToTransfer = false;

        if (scope.arrayOfNumbers) {

          if (scope.arrayOfNumbers.length > 1) {
            contactSelectContainerId.style.display = 'block'
          }
          else {
            var id = window.mOperators[phone.substring(0, 2)]
            viewPay.chosenServiceId = id;
            scope.arrayOfNumbers[0].value = scope.arrayOfNumbers[0].value.substring(scope.arrayOfNumbers[0].value.length - 9, scope.arrayOfNumbers[0].value.length);

            console.log('ID', id)
            if (id) {
              riotTags.innerHTML = "<view-service-page>";
              riot.mount("view-service-page", {number: scope.arrayOfNumbers[0].value});
            }
            else {
              scope.clickPinError = false;
              scope.errorNote = 'Вы не можете оплатить за этот номер';
              scope.showError = true;
              riot.update();
            }

          }
        }
      }

    }

    choosePhoneNumberTouchEnd = function (number) {
      event.preventDefault()
      event.stopPropagation()
      console.log('NUMBER', number)
      number = number.toString();

      var maskOne = /[0-9]/g;

      var digits = number.match(maskOne);
      var phone = '';
      for (var i in digits) {
        phone += digits[i]
      }
      phone = phone.substring(phone.length - 9, phone.length);


      if (goToPay) {
        var id = window.mOperators[phone.substring(0, 2)]
        if (id) {
          viewPay.chosenServiceId = id;

          console.log('ID', id)

          riotTags.innerHTML = "<view-service-page>";
          riot.mount("view-service-page", {number: phone});
        }
        else {
          scope.clickPinError = false;
          scope.errorNote = 'Вы не можете оплатить за этот номер';
          scope.showError = true;
          riot.update();
        }
      }
      else {
        riotTags.innerHTML = "<view-transfer>";
        riot.mount('view-transfer', {number: phone});
      }
    }


    var transferTouchStart, transferTouchEnd;

    contactTransferTouchStart = function () {
      transferTouchStart = event.changedTouches[0].pageY
      event.preventDefault()
      event.stopPropagation()
    }

    contactTransferTouchEnd = function () {
      event.preventDefault()
      event.stopPropagation()

      transferTouchEnd = event.changedTouches[0].pageY

      if (Math.abs(transferTouchStart - transferTouchEnd) <= 20) {
        goToPay = false;
        goToTransfer = true;

        if (scope.arrayOfNumbers) {

          if (scope.arrayOfNumbers.length > 1) {
            contactSelectContainerId.style.display = 'block'
          }
          else {

            scope.arrayOfNumbers[0].value = scope.arrayOfNumbers[0].value.substring(scope.arrayOfNumbers[0].value.length - 9, scope.arrayOfNumbers[0].value.length);
            riotTags.innerHTML = "<view-transfer>";
            riot.mount('view-transfer', {number: scope.arrayOfNumbers[0].value});
          }
        }
      }

    }

    closeContactPickTouchEnd = function () {
      event.preventDefault()
      event.stopPropagation()

      contactSelectContainerId.style.display = 'none'
    }

    goToBack = function () {
      event.preventDefault()
      event.stopPropagation()
      onBackKeyDown()
    }


  </script>
</view-contact>