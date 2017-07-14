<view-contact class="riot-tags-main-container">

  <div class="view-contact-page-title">
    <p class="view-contact-name-title">{titleName}</p>
    <div id="backButton" ontouchstart="goToBackStart()" ontouchend="goToBackEnd()" class="view-contact-back-button"></div>
  </div>

  <div class="view-contact">
    <div class="view-contact-info-title">
      <div class="view-contact-info-icon" style="background-image: url({contactPhoto})">{firstLetter}</div>
      <p class="view-contact-info-text">{firstName} {secondName}</p>
    </div>
    <div id="payButtonId" class="view-contact-pay-transfer-container" ontouchstart="contactPayTouchStart()"
         ontouchend="contactPayTouchEnd()">
      <div class="view-contact-pay-icon"></div>
      <p class="view-contact-pay-title">{window.languages.ViewContactPay}</p>
      <div class="view-contact-open-icon"></div>
    </div>
    <div id="transferButtonId" class="view-contact-pay-transfer-container" ontouchstart="contactTransferTouchStart()"
         ontouchend="contactTransferTouchEnd()">
      <div class="view-contact-transfer-icon"></div>
      <p class="view-contact-transfer-title">{window.languages.ViewContactTransfer}</p>
      <div class="view-contact-open-icon"></div>
    </div>
    <div id="delButtonId" class="view-contact-pay-delete-container" ontouchstart="contactDeleteTouchStart()"
         ontouchend="contactDeleteTouchEnd()">
      <div class="view-contact-delete-icon"></div>
      <p class="view-contact-transfer-title">{window.languages.ViewContactDeleteNumber}</p>
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
           ontouchstart="choosePhoneNumberTouchStart()" ontouchend="choosePhoneNumberTouchEnd({i.value})">
        <p class="view-contact-select-phone-number">+{i.value}</p>
      </div>
    </div>
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <component-confirm if="{confirmShowBool}" confirmnote="{confirmNote}"
                     confirmtype="{confirmType}"></component-confirm>

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
    scope.contactId = opts.object.id;

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

      payButtonId.style.backgroundColor = 'rgba(231,231,231,0.5)'

      event.preventDefault()
      event.stopPropagation()
    }

    contactPayTouchEnd = function () {
      event.preventDefault()
      event.stopPropagation()

      payButtonId.style.backgroundColor = 'transparent'

      payTouchEnd = event.changedTouches[0].pageY

      if (Math.abs(payTouchStart - payTouchEnd) <= 20) {
        goToPay = true;
        goToTransfer = false;

        if (scope.arrayOfNumbers) {

          if (scope.arrayOfNumbers.length > 1) {
            contactSelectContainerId.style.display = 'block'
          }
          else {
            scope.arrayOfNumbers[0].value = scope.arrayOfNumbers[0].value.substring(scope.arrayOfNumbers[0].value.length - 9, scope.arrayOfNumbers[0].value.length)
            var id = window.mOperators[scope.arrayOfNumbers[0].value.substring(0, 2)]
            console.log('OPERATOR', scope.arrayOfNumbers[0].value.substring(0, 2))
            console.log('ID', id)
            opts.chosenServiceId = id;
            scope.arrayOfNumbers[0].value = scope.arrayOfNumbers[0].value.substring(scope.arrayOfNumbers[0].value.length - 9, scope.arrayOfNumbers[0].value.length);
            opts.number = scope.arrayOfNumbers[0].value;

            console.log('ID', id)
            if (id) {
              riotTags.innerHTML = "<view-service-page-new>";
              riot.mount("view-service-page-new", opts);

              scope.unmount()
            }
            else {
              scope.clickPinError = false;
              scope.errorNote = 'Вы не можете оплатить за этот номер';
              scope.showError = true;
              scope.update();
            }

          }
        }
      }

    }

    var contactChooseTouchStartX, contactChooseTouchStartY, contactChooseTouchEndX, contactChooseTouchEndY;
    choosePhoneNumberTouchStart = function () {
      event.preventDefault()
      event.stopPropagation()

      contactChooseTouchStartX = event.changedTouches[0].pageX
      contactChooseTouchStartY = event.changedTouches[0].pageY

    }

    choosePhoneNumberTouchEnd = function (number) {
      event.preventDefault()
      event.stopPropagation()

      contactChooseTouchEndX = event.changedTouches[0].pageX
      contactChooseTouchEndY = event.changedTouches[0].pageY


      if (Math.abs(contactChooseTouchStartX - contactChooseTouchEndX) <= 20 && Math.abs(contactChooseTouchStartY - contactChooseTouchEndY) <= 20) {
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


            console.log('ID', id)

            console.log('OPERATOR', phone.substring(0, 2))
            console.log('ID', id)

            opts.chosenServiceId = id;
            opts.number = phone;

            riotTags.innerHTML = "<view-service-page-new>";
            riot.mount("view-service-page-new", opts);

            scope.unmount()
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = 'Вы не можете оплатить за этот номер';
            scope.showError = true;
            scope.update();
          }
        }
        else {
          riotTags.innerHTML = "<view-transfer>";
          riot.mount('view-transfer', {number: phone});

          scope.unmount()
        }
      }
    }


    var contactDeleteTouchStartX, contactDeleteTouchStartY, contactDeleteTouchEndX, contactDeleteTouchEndY;
    contactDeleteTouchStart = function () {
      event.preventDefault()
      event.stopPropagation()

      delButtonId.style.backgroundColor = 'rgba(231,231,231,0.5)'

      contactDeleteTouchStartX = event.changedTouches[0].pageX
      contactDeleteTouchStartY = event.changedTouches[0].pageY
    }

    contactDeleteTouchEnd = function () {
      event.preventDefault()
      event.stopPropagation()

      delButtonId.style.backgroundColor = 'transparent'

      contactDeleteTouchEndX = event.changedTouches[0].pageX
      contactDeleteTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(contactDeleteTouchStartX - contactDeleteTouchEndX) <= 20 && Math.abs(contactDeleteTouchStartY - contactDeleteTouchEndY) <= 20) {
        var arrayOfContacts = JSON.parse(localStorage.getItem('contactList'))

        var question = 'Подтвердите удаление из списка'
        scope.confirmShowBool = true;
        scope.confirmNote = question;
        scope.confirmType = 'local';
        scope.update()
        scope.result = function (bool) {
          if (bool) {
            for (var i = 0; i < arrayOfContacts.length; i++) {
              if (arrayOfContacts[i].id == scope.contactId) {
                arrayOfContacts.splice(i, 1);
              }
            }
            localStorage.setItem('contactList', JSON.stringify(arrayOfContacts))
            onBackKeyDown()
            return
          }
        };


      }
    }


    var transferTouchStart, transferTouchEnd;

    contactTransferTouchStart = function () {
      transferTouchStart = event.changedTouches[0].pageY
      event.preventDefault()
      event.stopPropagation()

      transferButtonId.style.backgroundColor = 'rgba(231,231,231,0.5)'
    }

    contactTransferTouchEnd = function () {
      event.preventDefault()
      event.stopPropagation()

      transferButtonId.style.backgroundColor = 'transparent'

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

            scope.unmount()
          }
        }
      }

    }

    closeContactPickTouchEnd = function () {
      event.preventDefault()
      event.stopPropagation()

      contactSelectContainerId.style.display = 'none'
    }

    var goBackButtonStartX, goBackButtonEndX, goBackButtonStartY, goBackButtonEndY;

    goToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(0.7)'

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;

    };

    goToBackEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(1)'

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {
        onBackKeyDown()
        scope.unmount()
      }
    };


  </script>
</view-contact>