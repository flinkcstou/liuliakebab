<component-category-search id="blockSearchId" class="component-search">
  <div class="search-title-container">
    <div class="search-search-icon"></div>
    <p class="search-title-name">{window.languages.ComponentCategorySearchTitle}</p>
    <div class="search-cancel-icon" ontouchend="searchCancelEnd()"></div>
  </div>
  <div id="searchContainerId" class="search-container">
    <input autofocus="true" id="searchInputId" class="search-input" onkeyup="searchSuggestion()"/>
    <div class="search-suggestion-container">
      <div id="suggestionOneId" class="search-suggestion-field-one" ontouchstart="suggestionFieldOneTouchStart()"
           ontouchend="suggestionFieldOneTouchEnd()">
        <p class="search-part-of-suggestion">{onePartOne}
          <mark class="search-selected-field-color">{onePartTwo}</mark>
          {onePartThree}
        </p>
      </div>
      <div id="suggestionTwoId" class="search-suggestion-field-two" ontouchstart="suggestionFieldTwoTouchStart()"
           ontouchend="suggestionFieldTwoTouchEnd()">
        <p class="search-part-of-suggestion">{twoPartOne}
          <mark class="search-selected-field-color">{twoPartTwo}</mark>
          {twoPartThree}
        </p>
      </div>
      <div id="suggestionThreeId" class="search-suggestion-field-three" ontouchstart="suggestionFieldThreeTouchStart()"
           ontouchend="suggestionFieldThreeTouchEnd()">
        <p class="search-part-of-suggestion">{threePartOne}
          <mark class="search-selected-field-color">{threePartTwo}</mark>
          {threePartThree}
        </p>
      </div>
      <div id="suggestionFourId" class="search-suggestion-field-four" ontouchstart="suggestionFieldFourTouchStart()"
           ontouchend="suggestionFieldFourTouchEnd()">
        <p class="search-part-of-suggestion">{fourPartOne}
          <mark class="search-selected-field-color">{fourPartTwo}</mark>
          {fourPartThree}
        </p>
      </div>
    </div>
  </div>

  <script>
    var scope = this;

    //VARIABLES FOR SEARCHING
    var arrayOfConnectedSuggestion = [];
    var bufferArray = [];
    scope.searchWord = '';
    scope.parent.checkOfSearch = false;

    scope.categoryList = JSON.parse(localStorage.getItem("click_client_payCategoryList")) ? JSON.parse(localStorage.getItem("click_client_payCategoryList")) : (offlinePayCategoryList);
    scope.serviceList = JSON.parse(localStorage.getItem("click_client_payServiceList")) ? JSON.parse(localStorage.getItem("click_client_payServiceList")) : (offlinePayServiceList);

    search = function () {
      event.preventDefault();
      event.stopPropagation();
      blockSearchId.style.display = 'block';
      if (scope.categoryList)
        arrayOfConnectedSuggestion = scope.categoryList.concat(scope.serviceList);

    }

    searchCancelEnd = function () {
      event.preventDefault();
      event.stopPropagation();
      blockSearchId.style.display = 'none';
      if (device.platform != 'BrowserStand')
        StatusBar.backgroundColorByHexString("#007AE2");
      scope.searchWord = '';
      searchInputId.autofocus = false;
    }

    searchSuggestion = function () {

      var countOfSuggestionWord = 0;
      var check = false;
      event.preventDefault();
      event.stopPropagation();

      if (event.keyCode != 16 && event.keyCode != 18)
        scope.searchWord = event.target.value.toLowerCase();

      scope.suggestionOne = {};
      scope.suggestionTwo = {};
      scope.suggestionThree = {};
      scope.suggestionFour = {};

      if (scope.searchWord.length != 0)
        arrayOfConnectedSuggestion.filter(function (wordOfFunction) {

          var index = wordOfFunction.name.toLowerCase().indexOf(scope.searchWord);
          if (index != -1 && countOfSuggestionWord <= 4) {

            check = true;
            if (countOfSuggestionWord == 3) {

              suggestionOneId.style.display = 'block';
              suggestionTwoId.style.display = 'block';
              suggestionThreeId.style.display = 'block';
              suggestionFourId.style.display = 'block';

              scope.suggestionFour.name = wordOfFunction.name;

              scope.suggestionFour.id = wordOfFunction.id;

              if (wordOfFunction.form_type) {
                scope.suggestionFour.form_type = wordOfFunction.form_type;
              }

              scope.fourPartOne = scope.suggestionFour.name.substring(0, index);
              scope.fourPartTwo = scope.suggestionFour.name.substring(index, scope.searchWord.length + scope.fourPartOne.length);
              scope.fourPartThree = scope.suggestionFour.name.substring(scope.fourPartTwo.length + scope.fourPartOne.length, scope.suggestionFour.name.length);

              scope.update();
            }
            if (countOfSuggestionWord == 2) {

              suggestionOneId.style.display = 'block';
              suggestionTwoId.style.display = 'block';
              suggestionThreeId.style.display = 'block';
              suggestionFourId.style.display = 'none';

              scope.suggestionThree.name = wordOfFunction.name;

              scope.suggestionThree.id = wordOfFunction.id;

              if (wordOfFunction.form_type) {
                scope.suggestionThree.form_type = wordOfFunction.form_type;
              }

              scope.threePartOne = scope.suggestionThree.name.substring(0, index);
              scope.threePartTwo = scope.suggestionThree.name.substring(index, scope.searchWord.length + scope.threePartOne.length);
              scope.threePartThree = scope.suggestionThree.name.substring(scope.threePartTwo.length + scope.threePartOne.length, scope.suggestionThree.name.length);

              scope.update();

            }
            if (countOfSuggestionWord == 1) {

              suggestionOneId.style.display = 'block';
              suggestionTwoId.style.display = 'block';
              suggestionThreeId.style.display = 'none';
              suggestionFourId.style.display = 'none';

              scope.suggestionTwo.name = wordOfFunction.name;
              scope.suggestionTwo.id = wordOfFunction.id;

              if (wordOfFunction.form_type) {
                scope.suggestionTwo.form_type = wordOfFunction.form_type;
              }

              scope.twoPartOne = scope.suggestionTwo.name.substring(0, index);
              scope.twoPartTwo = scope.suggestionTwo.name.substring(index, scope.searchWord.length + scope.twoPartOne.length);
              scope.twoPartThree = scope.suggestionTwo.name.substring(scope.twoPartTwo.length + scope.twoPartOne.length, scope.suggestionTwo.name.length);

              scope.update();

            }
            if (countOfSuggestionWord == 0) {

              suggestionOneId.style.display = 'block';
              suggestionTwoId.style.display = 'none';
              suggestionThreeId.style.display = 'none';
              suggestionFourId.style.display = 'none';

              scope.suggestionOne.name = wordOfFunction.name;
              scope.suggestionOne.id = wordOfFunction.id;

              if (wordOfFunction.form_type) {
                scope.suggestionOne.form_type = wordOfFunction.form_type;
              }

              scope.onePartOne = scope.suggestionOne.name.substring(0, index);
              scope.onePartTwo = scope.suggestionOne.name.substring(index, scope.searchWord.length + scope.onePartOne.length);
              scope.onePartThree = scope.suggestionOne.name.substring(scope.onePartTwo.length + scope.onePartOne.length, scope.suggestionOne.name.length);

              scope.update();
            }
            if (countOfSuggestionWord == 3)
              return

            countOfSuggestionWord++;
          }
          else {
            if (!check) {
              suggestionOneId.style.display = 'none';
              suggestionTwoId.style.display = 'none';
              suggestionThreeId.style.display = 'none';
              suggestionFourId.style.display = 'none';
            }
            return
          }


        })
    }

    var suggestionOneTouchStartX,
      suggestionOneTouchStartY,
      suggestionOneTouchEndX,
      suggestionOneTouchEndY;

    suggestionFieldOneTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      suggestionOneTouchStartX = event.changedTouches[0].pageX;
      suggestionOneTouchStartY = event.changedTouches[0].pageY;

    }


    suggestionFieldOneTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      suggestionOneTouchEndX = event.changedTouches[0].pageX;
      suggestionOneTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(suggestionOneTouchStartX - suggestionOneTouchEndX) <= 20 && Math.abs(suggestionOneTouchStartY - suggestionOneTouchEndY) <= 20) {

        searchInputId.autofocus = false;
        blockSearchId.style.display = 'none';
        scope.parent.checkOfSearch = true;
        scope.update(scope.parent.checkOfSearch)

        if (scope.suggestionOne.form_type) {
          scope.parent.onTouchEndOfService(scope.suggestionOne.id)
        }
        else
          scope.parent.onTouchEndOfCategory(scope.suggestionOne.id);
      }
    }

    var suggestionTwoTouchStartX,
      suggestionTwoTouchStartY,
      suggestionTwoTouchEndX,
      suggestionTwoTouchEndY;

    suggestionFieldTwoTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      suggestionTwoTouchStartX = event.changedTouches[0].pageX;
      suggestionTwoTouchStartY = event.changedTouches[0].pageY;

    }

    suggestionFieldTwoTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      suggestionTwoTouchEndX = event.changedTouches[0].pageX;
      suggestionTwoTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(suggestionTwoTouchStartX - suggestionTwoTouchEndX) <= 20 && Math.abs(suggestionTwoTouchStartY - suggestionTwoTouchEndY) <= 20) {

        searchInputId.autofocus = false;
        blockSearchId.style.display = 'none';
        scope.parent.checkOfSearch = true;
        scope.update(scope.parent.checkOfSearch)
        if (scope.suggestionTwo.form_type) {
          scope.parent.onTouchEndOfService(scope.suggestionTwo.id)
        }
        else
          scope.parent.onTouchEndOfCategory(scope.suggestionTwo.id);
      }
    }

    var suggestionThreeTouchStartX,
      suggestionThreeTouchStartY,
      suggestionThreeTouchEndX,
      suggestionThreeTouchEndY;

    suggestionFieldThreeTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      suggestionThreeTouchStartX = event.changedTouches[0].pageX;
      suggestionThreeTouchStartY = event.changedTouches[0].pageY;

    }


    suggestionFieldThreeTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      suggestionThreeTouchEndX = event.changedTouches[0].pageX;
      suggestionThreeTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(suggestionThreeTouchStartX - suggestionThreeTouchEndX) <= 20 && Math.abs(suggestionThreeTouchStartY - suggestionThreeTouchEndY) <= 20) {


        searchInputId.autofocus = false;
        blockSearchId.style.display = 'none';
        scope.parent.checkOfSearch = true;
        scope.update(scope.parent.checkOfSearch)
        if (scope.suggestionThree.form_type) {
          scope.parent.onTouchEndOfService(scope.suggestionThree.id)
        }
        else
          scope.parent.onTouchEndOfCategory(scope.suggestionThree.id);
      }
    }

    var suggestionFourTouchStartX,
      suggestionFourTouchStartY,
      suggestionFourTouchEndX,
      suggestionFourTouchEndY;

    suggestionFieldFourTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      suggestionFourTouchStartX = event.changedTouches[0].pageX;
      suggestionFourTouchStartY = event.changedTouches[0].pageY;

    }

    suggestionFieldFourTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      suggestionFourTouchEndX = event.changedTouches[0].pageX;
      suggestionFourTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(suggestionFourTouchStartX - suggestionFourTouchEndX) <= 20 && Math.abs(suggestionFourTouchStartY - suggestionFourTouchEndY) <= 20) {

        searchInputId.autofocus = false;
        blockSearchId.style.display = 'none';
        scope.parent.checkOfSearch = true;
        scope.update(scope.parent.checkOfSearch)

        if (scope.suggestionFour.form_type) {
          scope.parent.onTouchEndOfService(scope.suggestionFour.id)
        }
        else
          scope.parent.onTouchEndOfCategory(scope.suggestionFour.id);
      }
    }

  </script>
</component-category-search>