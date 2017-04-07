<view-favorites>
  <div>
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
            <div class="view-favorites-info-balance">{j.opts[5].amountText}</div>
            <div class="view-favorites-info-currency-field">сум</div>
            <p class="view-favorites-info-number">{j.opts[2].firstFieldText}</p>
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

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-favorites') {
      history.arrayOfHistory.push(
        {
          "view": 'view-favorites',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    componentMenu.check= false;

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
    };

    addFavorite = function () {
      event.preventDefault();
      event.stopPropagation();
      riotTags.innerHTML = "<view-pay>";
      riot.mount("view-pay", ['ADDFAVORITE']);
    }

    if (scope.favoritePaymentsList) {
//      console.log("favorite list", scope.favoritePaymentsList);
      scope.favPaymentsList = [];
      for (var i in scope.favoritePaymentsList) {
        if (scope.favPaymentsList.length < 4) {
          if (scope.favoritePaymentsList[i].opts[1].firstFieldId == '1') {
            var firstField = scope.favoritePaymentsList[i].opts[2].firstFieldText.toString();

            if (firstField.length == 9) {
              firstField = '+' + window.languages.CodeOfCountry + ' ' + firstField.substr(0, 2) + ' ' + firstField.substr(2, 3) + ' ' + firstField.substr(5, 2) + ' ' +
                firstField.substr(7, 2);
            }
            scope.favoritePaymentsList[i].opts[2].firstFieldText = firstField;
          }
          scope.favPaymentsList.push(scope.favoritePaymentsList[i]);
        }

        else break;
      }
//      console.log("favorites=", scope.favPaymentsList);
      riot.update(scope.favPaymentsList);
    }

    openFavoritePayment = function (id) {
      event.stopPropagation();

      console.log("id=", id);
      id = id.substring(1, id.length);
      console.log("id2=", id);
      for (var i in scope.favoritePaymentsList) {
        if (scope.favoritePaymentsList[i].service.id == id) {
          console.log("gnrf", scope.favoritePaymentsList[i].opts);
          viewPay.chosenServiceId = id;
          viewServicePage.firstFieldTitle = scope.favoritePaymentsList[i].firstFieldTitle;
          viewPayConfirm.isInFavorites = true;
          event.stopPropagation();
          this.riotTags.innerHTML = "<view-service-pincards>";
          riot.mount('view-service-pincards', scope.favoritePaymentsList[i].opts);

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
          riot.update(scope.favPaymentsList);
        }

      event.stopPropagation();
      riotTags.innerHTML = "<view-favorites>";
      riot.mount("view-favorites");
    }


  </script>
</view-favorites>
