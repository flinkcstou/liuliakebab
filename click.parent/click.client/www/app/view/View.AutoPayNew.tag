<view-auto-pay-new class="riot-tags-main-container">
  <div class="page-title">
    <p class="name-title">{titleName}</p>
    <div id="autoPayBackButtonId" role="button" aria-label="{window.languages.Back}" ontouchstart="onTouchStartOfBack()"
         ontouchend="goToBack()"
         class="back-button"></div>
    <div id="rightButton" role="button" aria-label="{window.languages.ViewAutoPayVoiceOverAdd}"
         ontouchstart="onTouchStartOfAddSign()" ontouchend="addAutoPay()"
         class="add-button"></div>
    <div class="title-bottom-border">
    </div>
  </div>

  <div class="view-autopay-container" if="{autopayListShow}">
    <div class="view-autopay-block-containter" each="{j in autopayList}">
      <div id="{j.id}" class="view-autopay-block-inner-containter" ontouchstart="onTouchStartOfAutoPayment(this.id)"
           ontouchend="onTouchEndOfAutoPayment(this.id)">
        <div class="view-autopay-icon" style="background-image: url({j.service_icon});"></div>
        <div class="view-autopay-info-container">
          <p class="view-autopay-info-name">{j.title}</p>
          <div class="view-autopay-info-balance">{j.amount}</div>
          <div class="view-autopay-info-currency-field">сум</div>
          <p class="view-autopay-info-condition">{j.condition_text}</p>
          <p class="view-autopay-info-number">{j.cntrg_param2}</p>
        </div>
      </div>
      <div class="view-autopay-next-icon"></div>
    </div>
  </div>

  <div class="view-autopay-container" if="{!autopayListShow}">
    <div class="empty-list-upper-container">
      <div class="empty-list-upper-icon"
           style="background-image: url('resources/icons/ViewAutoPay/autopayment_empty.png');background-size: 64%;background-position-x: 43%;"></div>
    </div>
    <div class="empty-list-lower-container">
      <p class="empty-list-lower-title-text">{window.languages.ViewAutoPayEmptyTitleText}</p>
      <p class="empty-list-lower-body-text">{window.languages.ViewAutoPayEmptyBodyText}</p>
    </div>
  </div>

  <script>

    this.titleName = window.languages.ViewAutoPayTitleName;

    window.saveHistory('view-auto-pay-new', opts);

    var backStartY, backStartX, backEndY, backEndX;

    scope.onTouchStartOfBack = onTouchStartOfBack = function () {
      event.stopPropagation();

      autoPayBackButtonId.style.webkitTransform = 'scale(0.7)'

      backStartY = event.changedTouches[0].pageY;
      backStartX = event.changedTouches[0].pageX;
    };


    goToBack = function () {
      event.stopPropagation();

      autoPayBackButtonId.style.webkitTransform = 'scale(1)'

      backEndY = event.changedTouches[0].pageY;
      backEndX = event.changedTouches[0].pageX;

      if (Math.abs(backStartY - backEndY) <= 20 && Math.abs(backStartX - backEndX) <= 20) {
        viewServicePage.phoneText = null;
        viewServicePage.amountText = null;
        localStorage.setItem('autoPayData', null);
        event.preventDefault();
        event.stopPropagation();
        onBackKeyDown();
        scope.unmount()
      }
    };

    var addSignStartY, addSignStartX, addSignEndY, addSignEndX;

    scope.onTouchStartOfAddSign = onTouchStartOfAddSign = function () {
      event.stopPropagation();

      rightButton.style.webkitTransform = 'scale(0.7)'

      addSignStartY = event.changedTouches[0].pageY;
      addSignStartX = event.changedTouches[0].pageX;
    };

    addAutoPay = function () {
      event.stopPropagation();

      rightButton.style.webkitTransform = 'scale(1)'

      addSignEndY = event.changedTouches[0].pageY;
      addSignEndX = event.changedTouches[0].pageX;

      if (Math.abs(addSignStartY - addSignEndY) <= 20 && Math.abs(addSignStartX - addSignEndX) <= 20) {
        event.preventDefault();
        event.stopPropagation();
        opts.mode = 'ADDAUTOPAY';
        riotTags.innerHTML = "<view-pay>";
        riot.mount("view-pay", opts);
        scope.unmount()
      }
    };

    componentMenu.check = false;
    scope = this;
    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = true;
    scope.autopayListShow = true;


    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    scope.servicesMap = (modeOfApp.onlineMode) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    scope.servicesParamsMapOne = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) : (offlineServicesParamsMapOne);
    localStorage.setItem('autoPayData', null);
    if (info)
      var sessionKey = info.session_key;


    scope.autopayList = [];
    window.api.call({
      method: 'autopay.list',
      input: {
        phone_num: phoneNumber,
        session_key: sessionKey
      },

      scope: this,

      onSuccess: function (result) {
        if (result[0][0].error == 0) {

          for (var i in result[1]) {

            result[1][i].service_title = scope.servicesMap[result[1][i].service_id][0].name;
            result[1][i].service_icon = scope.servicesMap[result[1][i].service_id][0].image;
            result[1][i].form_type = scope.servicesMap[result[1][i].service_id][0].form_type;

            if (result[1][i].type && result[1][i].autopay_type == 1) {
              if (result[1][i].type == 2) {
                result[1][i].condition_text = window.languages.ViewAutoPayMethodScheduleWeekDaysArray[(result[1][i].week_day) - 1].v + ", " +
                  result[1][i].paytime;
              } else if (result[1][i].type == 3) {
                result[1][i].condition_text = result[1][i].month_day + ", " +
                  result[1][i].paytime;
              } else if (result[1][i].type == 4) {
                result[1][i].condition_text = window.languages.ViewAutoPayEveryMonthLastDayTextTwo + ", " +
                  result[1][i].paytime;
              }
            } else if (result[1][i].autopay_type == 2) {
//                console.log("autopay type 2");
              for (var j in scope.servicesMap[result[1][i].service_id][0].autopay_available_steps)
                if (scope.servicesMap[result[1][i].service_id][0].autopay_available_steps[j].step_value == result[1][i].step) {
                  result[1][i].condition_text = window.languages.ViewAutoPayAfterMinimumBalansText + scope.servicesMap[result[1][i].service_id][0].autopay_available_steps[j].step_title;
//                    console.log("STep title=", scope.servicesMap[result[1][i].service_id][0].autopay_available_steps[j].step_title);
                  break;
                }
            }
//              console.log("ss", result[1][i].service_title, ", dd", result[1][i].service_icon);
            scope.autopayList.push(result[1][i]);
          }
//            console.log("L=", result[1]);
//            scope.autopayList = result[1];
          console.log("Autopay list", scope.autopayList);
          if (scope.autopayList.length == 0) scope.autopayListShow = false;
          scope.update();
          localStorage.setItem('click_client_autopayList', JSON.stringify(scope.autopayList));
        }
        else
          alert(result[0][0].error_note);
      },

      onFail: function (api_status, api_status_message, data) {
        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        console.error(data);
      }
    });

    onTouchStartOfAutoPayment = function (id) {
      event.stopPropagation();

      document.getElementById(id).style.backgroundColor = 'rgba(231,231,231,0.5)'

      autoPayOnTouchStartY = event.changedTouches[0].pageY;
      autoPayOnTouchStartX = event.changedTouches[0].pageX;
    }


    onTouchEndOfAutoPayment = function (id) {
      event.stopPropagation();

      document.getElementById(id).style.backgroundColor = 'transparent'

      autoPayOnTouchEndY = event.changedTouches[0].pageY;
      autoPayOnTouchEndX = event.changedTouches[0].pageX;
//      console.log(onTouchEndY)


      if (Math.abs(autoPayOnTouchStartY - autoPayOnTouchEndY) <= 20 && Math.abs(autoPayOnTouchStartX - autoPayOnTouchEndX) <= 20) {
        console.log("autoPayment ID to open=", id);
        for (var i in scope.autopayList) {
          if (scope.autopayList[i].id == id) {
            scope.autoPayData = {};
            scope.autoPayData.id = id;
            scope.autoPayData.service_id = scope.autopayList[i].service_id;
            scope.autoPayData.name = scope.autopayList[i].name;// autoPayNameInput.value;
            scope.autoPayData.autopay_type = scope.autopayList[i].autopay_type; //1;
            scope.autoPayData.amount = scope.autopayList[i].amount; //scope.chosenAmount;
            scope.autoPayData.isNew = false;
            scope.autoPayData.cntrg_phone_num = scope.autopayList[i].cntrg_param2; //firstFieldInput.value;
            scope.autoPayData.condition_text = scope.autopayList[i].condition_text;

            opts.chosenServiceId = scope.autopayList[i].service_id;
            opts.amountText = scope.autopayList[i].amount;
            opts.formtype = scope.autopayList[i].form_type;

            opts.firstFieldId = scope.servicesParamsMapOne[opts.chosenServiceId][0].parameter_id;
            opts.firstFieldTitle = scope.servicesParamsMapOne[opts.chosenServiceId][0].title;
//            console.log("opts.firstFieldId=", opts.firstFieldId);
//            console.log("scope.servicesParamsMapOne[opts.chosenServiceId]=", scope.servicesParamsMapOne[opts.chosenServiceId]);

            opts.firstFieldText = scope.autopayList[i].cntrg_param2;

//              viewServicePage.phoneText = scope.autopayList[i].cntrg_param2;
            opts.isInFavorites = false;
            opts.communalParam = scope.autopayList[i].cntrg_param5;
            opts.internetPackageParam = scope.autopayList[i].cntrg_param5;
            opts.cardTypeId = scope.autopayList[i].cntrg_param5;


            if (scope.autopayList[i].autopay_type == 2) {

              scope.autoPayData.step = scope.autopayList[i].step;//chosenStep;
              scope.autoPayData.title = window.languages.ViewAutoPayMethodEventText;
              localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));

            } else if (scope.autopayList[i].autopay_type == 1) {
              scope.autoPayData.title = window.languages.ViewAutoPayMethodSchedulerText;
              localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));
            }

            opts.payByCard = true;
            opts.chosenCardId = scope.autopayList[i].account_id;
            opts.mode = 'ADDAUTOPAY';

            this.riotTags.innerHTML = "<view-pay-confirm-new>";
            riot.mount('view-pay-confirm-new', opts);
            scope.unmount()

          }
        }
      }
    };


  </script>
</view-auto-pay-new>
