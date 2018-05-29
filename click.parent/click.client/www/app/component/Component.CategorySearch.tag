<component-category-search id="blockSearchId" class="component-search">
  <div class="search-title-container">
    <div id="searchButtonId" class="search-search-icon"></div>
    <p class="search-title-name">{window.languages.ComponentCategorySearchTitle}</p>
    <div id="closeSearchButtonId" class="search-cancel-icon" role="button" aria-label="{window.languages.Close}"
         ontouchstart="searchCancelStart()" ontouchend="searchCancelEnd()"></div>
  </div>
  <div id="searchContainerId" class="search-container">
    <input autofocus="true" id="searchInputId" class="search-input" onkeyup="searchSuggestion()"/>
    <div class="search-suggestion-container">
      <div class="search-suggestion-field-one" each="{i in suggestions}" ontouchstart="suggestionFieldOneTouchStart()"
           ontouchend="suggestionFieldOneTouchEnd()">
        <p class="search-part-of-suggestion">{i.name}
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


    var searchButtonStartX, searchButtonEndX, searchButtonStartY, searchButtonEndY;

    searchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      console.log('scope.parent', scope.parent);


      rightButton.style.webkitTransform = 'scale(0.8)';

      searchButtonStartX = event.changedTouches[0].pageX;
      searchButtonStartY = event.changedTouches[0].pageY;


    };

    searchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      rightButton.style.webkitTransform = 'scale(1)';

      searchButtonEndX = event.changedTouches[0].pageX;
      searchButtonEndY = event.changedTouches[0].pageY;

      if ((Math.abs(searchButtonStartX - searchButtonEndX) <= 20 && Math.abs(searchButtonStartY - searchButtonEndY) <= 20)) {

        blockSearchId.style.display = 'block';
        if (scope.categoryList)
          arrayOfConnectedSuggestion = scope.categoryList.concat(scope.serviceList);

        if (device.platform == 'Android') {
          setTimeout(function () {
            searchInputId.focus()
          }, 0)
        }
        else {
          searchInputId.autofocus;
          searchInputId.focus()
        }
      }

    };

    var xButtonStartX, xButtonEndX, xButtonStartY, xButtonEndY;

    searchCancelStart = function () {
      event.preventDefault();
      event.stopPropagation();

      console.log("Search Cancel Start");
      console.log("Search Cancel Start", event.changedTouches[0].pageX);
      console.log("Search Cancel Start", event.changedTouches[0].pageY);

      closeSearchButtonId.style.webkitTransform = 'scale(0.8)';

      xButtonStartX = event.changedTouches[0].pageX;
      xButtonStartY = event.changedTouches[0].pageY;
    };

    searchCancelEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      console.log("Search Cancel End");
      console.log("Search Cancel End", event.changedTouches[0].pageX);
      console.log("Search Cancel End", event.changedTouches[0].pageY);

      closeSearchButtonId.style.webkitTransform = 'scale(1)';

      xButtonEndX = event.changedTouches[0].pageX;
      xButtonEndY = event.changedTouches[0].pageY;

      if ((Math.abs(xButtonStartX - xButtonEndX) <= 20 && Math.abs(xButtonStartY - xButtonEndY) <= 20)) {
        blockSearchId.style.display = 'none';
        scope.searchWord = '';
        searchInputId.autofocus = false;
      }
    };

    searchSuggestion = function () {

      event.preventDefault();
      event.stopPropagation();

      if (event.keyCode != 16 && event.keyCode != 18)
        scope.searchWord = event.target.value.toLowerCase();

      scope.suggestions = [];

      if (scope.searchWord.length != 0)
        arrayOfConnectedSuggestion.filter(function (wordOfFunction) {

          var index = wordOfFunction.name.toLowerCase().indexOf(scope.searchWord);
          if (index != -1) {
            console.log("found ", wordOfFunction);
            scope.suggestions.push(wordOfFunction);
          }
        });

      scope.update();
    };

    var suggestionOneTouchStartX,
      suggestionOneTouchStartY,
      suggestionOneTouchEndX,
      suggestionOneTouchEndY;

    suggestionFieldOneTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      suggestionOneTouchStartX = event.changedTouches[0].pageX;
      suggestionOneTouchStartY = event.changedTouches[0].pageY;

    };


    suggestionFieldOneTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      suggestionOneTouchEndX = event.changedTouches[0].pageX;
      suggestionOneTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(suggestionOneTouchStartX - suggestionOneTouchEndX) <= 20 && Math.abs(suggestionOneTouchStartY - suggestionOneTouchEndY) <= 20) {

        searchInputId.autofocus = false;
        blockSearchId.style.display = 'none';
        scope.parent.checkOfSearch = true;
        scope.update(scope.parent.checkOfSearch);

        if (scope.suggestionOne.form_type) {
          scope.parent.onTouchEndOfService(scope.suggestionOne.id)
        }
        else
          scope.parent.onTouchEndOfCategory(scope.suggestionOne.id);
      }
    };

    var suggestionTwoTouchStartX,
      suggestionTwoTouchStartY,
      suggestionTwoTouchEndX,
      suggestionTwoTouchEndY;

    suggestionFieldTwoTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      suggestionTwoTouchStartX = event.changedTouches[0].pageX;
      suggestionTwoTouchStartY = event.changedTouches[0].pageY;

    };

    suggestionFieldTwoTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      suggestionTwoTouchEndX = event.changedTouches[0].pageX;
      suggestionTwoTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(suggestionTwoTouchStartX - suggestionTwoTouchEndX) <= 20 && Math.abs(suggestionTwoTouchStartY - suggestionTwoTouchEndY) <= 20) {

        searchInputId.autofocus = false;
        blockSearchId.style.display = 'none';
        scope.parent.checkOfSearch = true;
        scope.update(scope.parent.checkOfSearch);
        if (scope.suggestionTwo.form_type) {
          scope.parent.onTouchEndOfService(scope.suggestionTwo.id)
        }
        else
          scope.parent.onTouchEndOfCategory(scope.suggestionTwo.id);
      }
    };

    var suggestionThreeTouchStartX,
      suggestionThreeTouchStartY,
      suggestionThreeTouchEndX,
      suggestionThreeTouchEndY;

    suggestionFieldThreeTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      suggestionThreeTouchStartX = event.changedTouches[0].pageX;
      suggestionThreeTouchStartY = event.changedTouches[0].pageY;

    };


    suggestionFieldThreeTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      suggestionThreeTouchEndX = event.changedTouches[0].pageX;
      suggestionThreeTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(suggestionThreeTouchStartX - suggestionThreeTouchEndX) <= 20 && Math.abs(suggestionThreeTouchStartY - suggestionThreeTouchEndY) <= 20) {


        searchInputId.autofocus = false;
        blockSearchId.style.display = 'none';
        scope.parent.checkOfSearch = true;
        scope.update(scope.parent.checkOfSearch);
        if (scope.suggestionThree.form_type) {
          scope.parent.onTouchEndOfService(scope.suggestionThree.id)
        }
        else
          scope.parent.onTouchEndOfCategory(scope.suggestionThree.id);
      }
    };

    var suggestionFourTouchStartX,
      suggestionFourTouchStartY,
      suggestionFourTouchEndX,
      suggestionFourTouchEndY;

    suggestionFieldFourTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      suggestionFourTouchStartX = event.changedTouches[0].pageX;
      suggestionFourTouchStartY = event.changedTouches[0].pageY;

    };

    suggestionFieldFourTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      suggestionFourTouchEndX = event.changedTouches[0].pageX;
      suggestionFourTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(suggestionFourTouchStartX - suggestionFourTouchEndX) <= 20 && Math.abs(suggestionFourTouchStartY - suggestionFourTouchEndY) <= 20) {

        searchInputId.autofocus = false;
        blockSearchId.style.display = 'none';
        scope.parent.checkOfSearch = true;
        scope.update(scope.parent.checkOfSearch);

        if (scope.suggestionFour.form_type) {
          scope.parent.onTouchEndOfService(scope.suggestionFour.id)
        }
        else
          scope.parent.onTouchEndOfCategory(scope.suggestionFour.id);
      }
    }

  </script>
</component-category-search>