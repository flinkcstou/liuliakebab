<component-category-search id="blockSearchId" class="component-search">
  <div class="search-title-container">
    <div class="search-search-icon"></div>
    <p class="search-title-name">{window.languages.ComponentCategorySearchTitle}</p>
    <div class="search-cancel-icon" ontouchend="searchCancelEnd()"></div>
  </div>
  <div id="searchContainerId" class="search-container">
    <input autofocus="true" id="searchInputId" class="search-input" onkeyup="searchSuggestion()"/>
    <div class="search-suggestion-container">
      <div id="suggestionOneId" class="search-suggestion-field-one" ontouchend="suggestionFieldOne()">
        <p class="search-part-of-suggestion">{onePartOne}
          <mark class="search-selected-field-color">{onePartTwo}</mark>
          {onePartThree}
        </p>
      </div>
      <div id="suggestionTwoId" class="search-suggestion-field-two" ontouchend="suggestionFieldTwo()">
        <p class="search-part-of-suggestion">{twoPartOne}
          <mark class="search-selected-field-color">{twoPartTwo}</mark>
          {twoPartThree}
        </p>
      </div>
      <div id="suggestionThreeId" class="search-suggestion-field-three" ontouchend="suggestionFieldThree()">
        <p class="search-part-of-suggestion">{threePartOne}
          <mark class="search-selected-field-color">{threePartTwo}</mark>
          {threePartThree}
        </p>
      </div>
      <div id="suggestionFourId" class="search-suggestion-field-four" ontouchend="suggestionFieldFour()">
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


    suggestionFieldOne = function () {
      searchInputId.autofocus = false;
      event.preventDefault();
      event.stopPropagation();
      blockSearchId.style.display = 'none';
      scope.parent.checkOfSearch = true;
      scope.update(scope.parent.checkOfSearch)

      if (scope.suggestionOne.form_type) {
        scope.parent.onTouchEndOfService(scope.suggestionOne.id)
      }
      else
        scope.parent.onTouchEndOfCategory(scope.suggestionOne.id);
    }

    suggestionFieldTwo = function () {
      searchInputId.autofocus = false;
      event.preventDefault();
      event.stopPropagation();
      blockSearchId.style.display = 'none';
      scope.parent.checkOfSearch = true;
      scope.update(scope.parent.checkOfSearch)
      if (scope.suggestionTwo.form_type) {
        scope.parent.onTouchEndOfService(scope.suggestionTwo.id)
      }
      else
        scope.parent.onTouchEndOfCategory(scope.suggestionTwo.id);
    }


    suggestionFieldThree = function () {
      searchInputId.autofocus = false;
      event.preventDefault();
      event.stopPropagation();
      blockSearchId.style.display = 'none';
      scope.parent.checkOfSearch = true;
      scope.update(scope.parent.checkOfSearch)
      if (scope.suggestionThree.form_type) {
        scope.parent.onTouchEndOfService(scope.suggestionThree.id)
      }
      else
        scope.parent.onTouchEndOfCategory(scope.suggestionThree.id);
    }


    suggestionFieldFour = function () {
      searchInputId.autofocus = false;
      event.preventDefault();
      event.stopPropagation();
      blockSearchId.style.display = 'none';
      scope.parent.checkOfSearch = true;
      scope.update(scope.parent.checkOfSearch)

      if (scope.suggestionFour.form_type) {
        scope.parent.onTouchEndOfService(scope.suggestionFour.id)
      }
      else
        scope.parent.onTouchEndOfCategory(scope.suggestionFour.id);
    }

  </script>
</component-category-search>