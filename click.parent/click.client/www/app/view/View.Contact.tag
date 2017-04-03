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
    <div class="view-contact-pay-transfer-container" ontouchend="contactPayTouchEnd()">
      <div class="view-contact-pay-icon"></div>
      <p class="view-contact-pay-title">{window.languages.ViewContactPay}</p>
      <div class="view-contact-open-icon"></div>
    </div>
    <div class="view-contact-pay-transfer-container" ontouchend="contactTransferTouchEnd()">
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

  <script>
    var scope = this;

    this.on('mount', function () {

    })
    console.log(opts.object.phoneNumbers)
    scope.firstName = opts.object.contactFname;
    scope.secondName = opts.object.contactLname;
    scope.contactPhoto = opts.object.contactPhoto;
    scope.firstLetter = opts.object.firstLetter;
    scope.arrayOfNumbers = opts.object.phoneNumbers[0];

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

    contactPayTouchEnd = function () {
      event.preventDefault()
      event.stopPropagation()

      goToPay = true;
      goToTransfer = false;

      if (scope.arrayOfNumbers) {
        if (scope.arrayOfNumbers.length > 1) {
          contactSelectContainerId.style.display = 'block'
        }
        else {
          riotTags.innerHTML = "<view-pay>";
          riot.mount('view-pay');
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
        riotTags.innerHTML = "<view-pay>";
        riot.mount('view-pay');
      }
      else {
        riotTags.innerHTML = "<view-transfer>";
        riot.mount('view-transfer', {number: phone});
      }
    }

    contactTransferTouchEnd = function () {
      event.preventDefault()
      event.stopPropagation()

      goToPay = false;
      goToTransfer = true;

      if (scope.arrayOfNumbers) {

        var maskOne = /[0-9]/g;

        var digits = scope.arrayOfNumbers[0].value.match(maskOne);
        var phone = '';
        for (var i in digits) {
          phone += digits[i]
        }
        phone = phone.substring(phone.length - 9, phone.length);

        if (scope.arrayOfNumbers.length > 1) {
          contactSelectContainerId.style.display = 'block'
        }
        else {
          riotTags.innerHTML = "<view-transfer>";
          riot.mount('view-transfer', {number: phone});
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