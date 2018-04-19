<view-favorites-new>
  <div class="riot-tags-main-container">
    <div class="page-title">
      <p class="name-title">{titleName}</p>
      <div id="favouriteBackButtonId" ontouchend="favouriteGoToBackEnd()" ontouchstart="onTouchStartOfBack()"
           class="back-button" role="button" aria-label="{window.languages.Back}"></div>
      <div id="favouriteRightButtonId" ontouchend="addFavorite()" ontouchstart="onTouchStartOfAddSign()"
           class="add-button" role="button"
           aria-label="{window.languages.ViewFavoriteAriaLabelAddOperation}"></div>
      <div class="title-bottom-border">
      </div>
    </div>

    <div class="view-favorites-container" if="{favoriteListShow}">
      <div class="view-favorites-block-containter" each="{j in favoritePaymentsList}">
        <div id="p{j.id}" class="view-favorites-block-inner-containter"
             ontouchstart="openFavoritePaymentStart(this.id)"
             ontouchend="openFavoritePaymentEnd(this.id)">
          <div class="view-favorites-icon"
               style="background-image: url({j.service.image})"></div>
          <div class="view-favorites-info-container">
            <p class="view-favorites-info-name">{j.params.favoriteName ?j.params.favoriteName: j.service.name}</p>
            <div class="view-favorites-info-balance">{j.params.amountText}</div>
            <div class="view-favorites-info-currency-field">сум</div>
            <p class="view-favorites-info-number">{(j.params.firstFieldId==1)? ("+" + window.languages.CodeOfCountry +"
              "+j.params.firstFieldText):(j.params.chosenPrefixId? (j.params.chosenPrefixName+j.params.firstFieldText):
              j.params.firstFieldText)}</p>
          </div>
        </div>
        <div id="e{j.id}" class="view-favorites-edit-icon"
             ontouchstart="onTouchStartOfEditFavorite()"
             ontouchend="editFavoritePayment(this.id)" role="button"
             aria-label="{window.languages.ViewFavoriteAriaLabelEditOperation}"></div>
        <div id="{j.id}" class="view-favorites-delete-icon"
             ontouchstart="onTouchStartOfRemoveFavorite()"
             ontouchend="removeFromFavorites(this.id)" role="button"
             aria-label="{window.languages.ViewFavoriteAriaLabelRemoveOperation}"></div>
      </div>
    </div>

    <div class="view-favorites-container" if="{!favoriteListShow}">
      <div class="empty-list-container">
        <div class="empty-list-upper-container">
          <div class="empty-list-upper-icon"
               style="background-image: url('resources/icons/ViewFavorite/favorites_empty.png');background-size: 64%;background-position-x: 50%;"></div>
        </div>
        <div class="empty-list-lower-container">
          <p class="empty-list-lower-title-text">{window.languages.ViewFavoriteEmptyTitleText}</p>
          <p class="empty-list-lower-body-text">{window.languages.ViewFavoriteEmptyBodyText}</p>
        </div>
      </div>

    </div>


  </div>

  <script>
    var scope = this;
    this.titleName = window.languages.ViewFavoriteBodyTitleText;
    scope.favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));
    var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');
    if (loginInfo)
      var sessionKey = loginInfo.session_key;
    scope.favoriteListShow = true;
    componentMenu.check = false;
    var backStartY, backStartX, backEndY, backEndX;
    var addSignStartY, addSignStartX, addSignEndY, addSignEndX;
    var openFavouriteStarX, openFavouriteStarY, openFavouriteEndX, openFavouriteEndY;
    var editFavoriteStartY, editFavoriteStartX, editFavoriteEndY, editFavoriteEndX;
    var removeFavoriteStartY, removeFavoriteStartX, removeFavoriteEndY, removeFavoriteEndX;

    opts = {};

    window.saveHistory('view-favorites-new', opts);

    scope.onTouchStartOfBack = onTouchStartOfBack = function () {
      event.stopPropagation();

      if (favouriteBackButtonId) {
        favouriteBackButtonId.style.webkitTransform = 'scale(0.7)'
      }

      backStartY = event.changedTouches[0].pageY;
      backStartX = event.changedTouches[0].pageX;
    };

    favouriteGoToBackEnd = function () {
      event.stopPropagation();

      favouriteBackButtonId.style.webkitTransform = 'scale(1)';

      backEndY = event.changedTouches[0].pageY;
      backEndX = event.changedTouches[0].pageX;

      if (Math.abs(backStartY - backEndY) <= 20 && Math.abs(backStartX - backEndX) <= 20) {
        event.preventDefault();
        event.stopPropagation();
        onBackKeyDown();
        scope.unmount();
      }
    };

    scope.onTouchStartOfAddSign = onTouchStartOfAddSign = function () {
      event.stopPropagation();

      favouriteRightButtonId.style.webkitTransform = 'scale(0.7)';

      addSignStartY = event.changedTouches[0].pageY;
      addSignStartX = event.changedTouches[0].pageX;
    };

    addFavorite = function () {
      event.stopPropagation();

      favouriteRightButtonId.style.webkitTransform = 'scale(1)';

      addSignEndY = event.changedTouches[0].pageY;
      addSignEndX = event.changedTouches[0].pageX;

      if (Math.abs(addSignStartY - addSignEndY) <= 20 && Math.abs(addSignStartX - addSignEndX) <= 20) {
        event.preventDefault();
        event.stopPropagation();
        opts.mode = 'ADDFAVORITE';
        riotTags.innerHTML = "<view-pay>";
        riot.mount("view-pay", opts);
        scope.unmount()
      }
    };

    if (scope.favoritePaymentsList) {
      for (var i in scope.favoritePaymentsList) {

        if (scope.favoritePaymentsList[i].params.firstFieldId == '1') {
          var firstField = scope.favoritePaymentsList[i].params.firstFieldText.toString();
          console.log(scope.favoritePaymentsList[i].params)
          if (firstField.length == 9) {
            firstField = firstField.substr(0, 2) + ' ' + firstField.substr(2, 3) + ' ' + firstField.substr(5, 2) + ' ' +
              firstField.substr(7, 2);
          }
          scope.favoritePaymentsList[i].params.firstFieldText = firstField;
        }

        if (scope.favoritePaymentsList[i].service.form_type == 4 && scope.favoritePaymentsList[i].service.disable_cache && modeOfApp.onlineMode && !modeOfApp.demoVersion) {

          window.api.call({
            method: 'get.service.parameters',
            stopSpinner: false,
            input: {
              session_key: sessionKey,
              phone_num: phoneNumber,
              service_id: scope.favoritePaymentsList[i].service.id
            },

            scope: this,

            onSuccess: function (result) {
              window.stopSpinner();
              if (result[0][0].error == 0) {
                if (result[5])
                  for (var i in result[5]) {
                    console.log("1");
                    if (result[5][i].service_id == scope.favoritePaymentsList[i].service.id) {
                      console.log("qwerty=", result[5][i].sum_cost);
                      scope.favoritePaymentsList[i].params.amountText = window.amountTransform(result[5][i].sum_cost.toString())
                      scope.update(scope.favoritePaymentsList);
                      break;
                    }
                  }
              }
            },

            onFail: function (api_status, api_status_message, data) {
              console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
              console.error(data);
            }
          });

        } else if (scope.favoritePaymentsList[i].params.amountText)
          scope.favoritePaymentsList[i].params.amountText = window.amountTransform(scope.favoritePaymentsList[i].params.amountText.toString())

      }
      if (scope.favoritePaymentsList.length == 0) scope.favoriteListShow = false;

      scope.update(scope.favoritePaymentsList);
    } else {
      scope.favoriteListShow = false;
      scope.update();
    }


    openFavoritePaymentStart = function (id) {
      event.stopPropagation();

      openFavouriteStarX = event.changedTouches[0].pageX;
      openFavouriteStarY = event.changedTouches[0].pageY;
    };

    openFavoritePaymentEnd = function (id) {
      event.stopPropagation();

      openFavouriteEndX = event.changedTouches[0].pageX;
      openFavouriteEndY = event.changedTouches[0].pageY;

      if (Math.abs(openFavouriteStarX - openFavouriteEndX) <= 20 && Math.abs(openFavouriteStarY - openFavouriteEndY) <= 20) {

        document.getElementById(id).style.backgroundColor = 'rgba(231,231,231,0.5)';

        setTimeout(function () {
          document.getElementById(id).style.backgroundColor = 'transparent';

          id = id.substring(1, id.length);

          for (var i in scope.favoritePaymentsList) {
            if (scope.favoritePaymentsList[i].id == id) {

              scope.favoritePaymentsList[i].params.favoriteId = scope.favoritePaymentsList[i].id;

              if (modeOfApp.offlineMode) {

                var firstFieldText = inputVerification.spaceDeleter(scope.favoritePaymentsList[i].params.firstFieldText);
                var amountText = inputVerification.spaceDeleter(scope.favoritePaymentsList[i].params.amountText);
                var formtype = scope.favoritePaymentsList[i].params.formtype;
                var communalParam = scope.favoritePaymentsList[i].params.communalParam;
                var firstFieldId = scope.favoritePaymentsList[i].params.firstFieldId;


                var ussdQuery = scope.favoritePaymentsList[i].ussd;
                if (ussdQuery === null) {
                  scope.clickPinError = false;
                  scope.errorNote = ("Сервис временно недоступен!");
                  scope.showError = true;
                  scope.update();
                  return
                }

                if (formtype == 1) {
                  if (firstFieldText) {
                    ussdQuery = ussdQuery.replace('{param}', firstFieldText);
                  }
                  else {
                    ussdQuery = ussdQuery.replace('*{param}', firstFieldText);
                  }
                  ussdQuery = ussdQuery.replace('{option}', firstFieldId);
                  ussdQuery = ussdQuery.replace('{amount}', amountText);
                  ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);
                  console.log(ussdQuery)
                }

                if (formtype == 2) {
                  ussdQuery = ussdQuery.replace('{param}', firstFieldText);
                  ussdQuery = ussdQuery.replace('{amount}', amountText);
                  ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);
                  console.log(ussdQuery)
                }

                if (formtype == 3) {
                  ussdQuery = ussdQuery.replace('{communal_para}', communalParam);
                  ussdQuery = ussdQuery.replace('{param}', firstFieldText);
                  ussdQuery = ussdQuery.replace('{amount}', amountText);
                  ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);
                  console.log(ussdQuery)
                }

                if (formtype == 4) {
                  ussdQuery = ussdQuery.replace('{param}', firstFieldText);
                  ussdQuery = ussdQuery.replace('{amount}', amountText);
                  ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);
                  console.log(ussdQuery)
                }

                phonedialer.dial(
//              "*880*1*" + opts.id + "*" + parseInt(amountForPayTransaction) + "%23",
                  ussdQuery + "%23",
                  function (err) {
                    if (err == "empty") {
                      scope.clickPinError = false;
                      scope.errorNote = ("Unknown phone number");
                      scope.showError = true;
                      scope.update();
                    }
                    else console.log("Dialer Error:" + err);
                  },
                  function (success) {
                  }
                );
                return
              }

              if (scope.favoritePaymentsList[i].service.additional_information_type == 3) {
                localStorage.setItem('click_client_infoCacheEnabled', null)
                this.riotTags.innerHTML = "<view-service-info-new>";
                riot.mount('view-service-info-new', scope.favoritePaymentsList[i].params);
                scope.unmount()
              } else {
                this.riotTags.innerHTML = "<view-service-pincards-new>";
                riot.mount('view-service-pincards-new', scope.favoritePaymentsList[i].params);
                scope.unmount()
              }

            }
          }
        }, 100);
      }

    };


    scope.onTouchStartOfEditFavorite = onTouchStartOfEditFavorite = function () {
      event.stopPropagation();
      editFavoriteStartY = event.changedTouches[0].pageY;
      editFavoriteStartX = event.changedTouches[0].pageX;
    };

    editFavoritePayment = function (id) {
      event.stopPropagation();

      editFavoriteEndY = event.changedTouches[0].pageY;
      editFavoriteEndX = event.changedTouches[0].pageX;

      if (Math.abs(editFavoriteStartY - editFavoriteEndY) <= 20 && Math.abs(editFavoriteStartX - editFavoriteEndX) <= 20) {

        id = id.substring(1, id.length);

        for (var i in scope.favoritePaymentsList) {
          if (scope.favoritePaymentsList[i].id == id) {

            scope.favoritePaymentsList[i].params.mode = 'ADDFAVORITE';
            scope.favoritePaymentsList[i].params.favoriteId = scope.favoritePaymentsList[i].id;

            this.riotTags.innerHTML = "<view-service-page-new>";
            riot.mount('view-service-page-new', scope.favoritePaymentsList[i].params);

            scope.unmount()

          }
        }
      }
    };


    scope.onTouchStartOfRemoveFavorite = onTouchStartOfRemoveFavorite = function () {
      event.stopPropagation();
      removeFavoriteStartY = event.changedTouches[0].pageY;
      removeFavoriteStartX = event.changedTouches[0].pageX;
    };

    removeFromFavorites = function (id) {
      event.stopPropagation();

      removeFavoriteEndY = event.changedTouches[0].pageY;
      removeFavoriteEndX = event.changedTouches[0].pageX;

      if (Math.abs(removeFavoriteStartY - removeFavoriteEndY) <= 20 && Math.abs(removeFavoriteStartX - removeFavoriteEndX) <= 20) {


        var favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));
        var favoritePaymentsListForApi = JSON.parse(localStorage.getItem('favoritePaymentsListForApi'));

        for (var i in favoritePaymentsList)
          if (favoritePaymentsList[i].id == id) {
            favoritePaymentsList.splice(i, 1);
            if (favoritePaymentsList.length == 0) scope.favoriteListShow = false;

            for (var j in favoritePaymentsListForApi)
              if (favoritePaymentsListForApi[j].id == id) {
                favoritePaymentsListForApi.splice(j, 1);
                break;
              }

            window.api.call({
              method: 'delete.favourite',
              input: {
                session_key: sessionKey,
                phone_num: phoneNumber,
                wishlist_data: [{"id": id, "type": 1}]
              },

              scope: this,

              onSuccess: function (result) {

                if (result[0][0].error == 0) {

                  console.log("SUCCESSFULLY deleted")

                }
                else {
                  scope.clickPinError = false;
                  scope.showError = true;
                  scope.errorNote = result[0][0].error_note;
                  scope.update();
                  console.log(result[0][0].error_note);
                }
              },

              onFail: function (api_status, api_status_message, data) {
                console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                console.error(data);
              }
            });

            localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));
            localStorage.setItem('favoritePaymentsListForApi', JSON.stringify(favoritePaymentsListForApi));
            break;
          }

        event.stopPropagation();
        riotTags.innerHTML = "<view-favorites-new>";
        riot.mount("view-favorites-new");

        scope.unmount()
      }
    }


  </script>
</view-favorites-new>
