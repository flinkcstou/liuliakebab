<view-favorites>
  <div>
    <div class="pay-page-title">
      <p class="pay-name-title">{titleName}</p>
      <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
      <div id="rightButton" ontouchend="addFavorite()" class="settings-friend-help-add-button"></div>
    </div>

    <div class="view-favorites-container">
      <div class="view-favorites-block-containter" each="{j in favPaymentsList}">
        <div class="view-favorites-icon"
             style="background-image: url({j.service.image})"></div>
        <div class="view-favorites-info-container">
          <p class="view-favorites-info-name">{j.service.name}</p>
          <div class="view-favorites-info-balance">{j.opts[0][5].amountText}</div>
          <div class="view-favorites-info-currency-field">сум</div>
          <p class="view-favorites-info-number">{j.opts[0][2].firstFieldText}</p>
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
          "params": ''
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
    };

    addFavorite = function () {
      event.preventDefault();
      event.stopPropagation();
      riotTags.innerHTML = "<view-pay>";
      riot.mount("view-pay");
    }

    if (scope.favoritePaymentsList) {
      console.log("favorite list", scope.favoritePaymentsList);
      scope.favPaymentsList = [];
      for (var i in scope.favoritePaymentsList) {
        if (scope.favPaymentsList.length < 4)
          scope.favPaymentsList.push(scope.favoritePaymentsList[i]);
        else break;
      }
      riot.update(scope.favPaymentsList);
    }

    removeFromFavorites = function (id) {
      console.log("Id to remove=", id);
      var favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));
      console.log(favoritePaymentsList);
      for (var i in favoritePaymentsList)
        if (favoritePaymentsList[i].service.id == id) {
          console.log("i=", i);
          favoritePaymentsList.splice(i, 1);
          console.log(favoritePaymentsList);
          localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));
          riot.update(scope.favPaymentsList);
        }
      riot.update();
    }


  </script>
</view-favorites>
