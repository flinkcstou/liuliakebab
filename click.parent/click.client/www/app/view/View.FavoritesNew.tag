<view-favorites-new>
  <div class="riot-tags-main-container">
    <div class="pay-page-title">
      <p class="pay-name-title">{titleName}</p>
      <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
      <div id="rightButton" ontouchend="addFavorite()" class="settings-friend-help-add-button"></div>
    </div>

    <div class="view-favorites-container">
      <div class="view-favorites-block-containter" each="{j in favPaymentsList}">
        <div id="p{j.service.id}" class="view-favorites-block-inner-containter"
             ontouchend="openFavoritePayment(this.id)">
          <div class="view-favorites-icon"
               style="background-image: url({j.service.image})"></div>
          <div class="view-favorites-info-container">
            <p class="view-favorites-info-name">{j.service.name}</p>
            <div class="view-favorites-info-balance">{j.params.amountText}</div>
            <div class="view-favorites-info-currency-field">сум</div>
            <p class="view-favorites-info-number">{(j.params.firstFieldId==1)? ("+" + window.languages.CodeOfCountry +"
              "+j.params.firstFieldText):(j.params.firstFieldText)}</p>
          </div>
        </div>
        <div id="{j.service.id}" class="view-favorites-delete-icon" ontouchend="removeFromFavorites(this.id)"></div>
      </div>
    </div>


  </div>

  <script>
    var scope = this;
    this.titleName = 'ИЗБРАННОЕ';
    scope.favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-favorites-new') {
      history.arrayOfHistory.push(
        {
          "view": 'view-favorites-new',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    componentMenu.check = false;

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
      scope.unmount()
    };

    addFavorite = function () {
      event.preventDefault();
      event.stopPropagation();
      opts.mode = 'ADDFAVORITE';
      riotTags.innerHTML = "<view-pay>";
      riot.mount("view-pay", opts);
      scope.unmount()
    }

    if (scope.favoritePaymentsList) {
//      console.log("favorite list", scope.favoritePaymentsList);
      scope.favPaymentsList = [];
      for (var i in scope.favoritePaymentsList) {
        if (scope.favPaymentsList.length < 4) {
          if (scope.favoritePaymentsList[i].params.firstFieldId == '1') {
            var firstField = scope.favoritePaymentsList[i].params.firstFieldText.toString();
            console.log(scope.favoritePaymentsList[i].params)
            if (scope.favoritePaymentsList[i].params && scope.favoritePaymentsList[i].params.amountText)
              scope.favoritePaymentsList[i].params.amountText = window.amountTransform(scope.favoritePaymentsList[i].params.amountText.toString())
            if (firstField.length == 9) {
              firstField = firstField.substr(0, 2) + ' ' + firstField.substr(2, 3) + ' ' + firstField.substr(5, 2) + ' ' +
                firstField.substr(7, 2);
            }
            scope.favoritePaymentsList[i].params.firstFieldText = firstField;
          }
          scope.favPaymentsList.push(scope.favoritePaymentsList[i]);
        }

        else break;
      }
//      console.log("favorites=", scope.favPaymentsList);
      scope.update(scope.favPaymentsList);
    }

    openFavoritePayment = function (id) {
      event.stopPropagation();

      console.log("id=", id);
      id = id.substring(1, id.length);
      console.log("id2=", id);

      for (var i in scope.favoritePaymentsList) {
        if (scope.favoritePaymentsList[i].service.id == id) {
          console.log("scope.favoritePaymentsList[i].service.id", scope.favoritePaymentsList[i].service.id);
          console.log("open favorite ", scope.favoritePaymentsList[i]);
//          viewPay.chosenServiceId = id;

          viewPayConfirm.isInFavorites = true;
          if (modeOfApp.offlineMode) {

            var firstFieldText = inputVerification.spaceDeleter(scope.favoritePaymentsList[i].params.firstFieldText);
            var amountText = inputVerification.spaceDeleter(scope.favoritePaymentsList[i].params.amountText);
            var formtype = scope.favoritePaymentsList[i].params.formtype;
            var communalParam = scope.favoritePaymentsList[i].params.communalParam;
            var firstFieldId = scope.favoritePaymentsList[i].params.firstFieldId;


            var ussdQuery = scope.favoritePaymentsList[i].ussd;

            if (formtype == 1) {
              if (firstFieldText) {
                ussdQuery = ussdQuery.replace('{param}', firstFieldText);
              }
              else {
                ussdQuery = ussdQuery.replace('*{param}', firstFieldText);
              }
              ussdQuery = ussdQuery.replace('{option}', firstFieldId);
              ussdQuery = ussdQuery.replace('{amount}', amountText);
              ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1)
              console.log(ussdQuery)
            }

            if (formtype == 2) {
              ussdQuery = ussdQuery.replace('{param}', firstFieldText);
              ussdQuery = ussdQuery.replace('{amount}', amountText);
              ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1)
              console.log(ussdQuery)
            }

            if (formtype == 3) {
              ussdQuery = ussdQuery.replace('{communal_para}', communalParam);
              ussdQuery = ussdQuery.replace('{param}', firstFieldText);
              ussdQuery = ussdQuery.replace('{amount}', amountText);
              ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1)
              console.log(ussdQuery)
            }

            if (formtype == 4) {
              ussdQuery = ussdQuery.replace('{param}', firstFieldText);
              ussdQuery = ussdQuery.replace('{amount}', amountText);
              ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1)
              console.log(ussdQuery)
            }


            console.log(ussdQuery)

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
          this.riotTags.innerHTML = "<view-service-pincards-new>";
          riot.mount('view-service-pincards-new', scope.favoritePaymentsList[i].params);

          scope.unmount()

        }
      }

    };

    removeFromFavorites = function (id) {
      console.log("Id to remove=", id);
      var favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));
      console.log(favoritePaymentsList);
      for (var i in favoritePaymentsList)
        if (favoritePaymentsList[i].service.id == id) {
          favoritePaymentsList.splice(i, 1);
          console.log(favoritePaymentsList);
          localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));
          scope.update(scope.favPaymentsList);
        }

      event.stopPropagation();
      riotTags.innerHTML = "<view-favorites-new>";
      riot.mount("view-favorites-new");

      scope.unmount()
    }


  </script>
</view-favorites-new>
