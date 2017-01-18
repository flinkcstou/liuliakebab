<view-pay>
  <div id="viewPayId" class="view-pay" disabled="{false}">
    <div class="page-title">
      <p class="pay-name-title">{titleName}</p>
      <div id="backButton" ontouchend="goToMainPage()"
           class="{back-button: backbuttoncheck}">
      </div>
      <div id="rightButton" type="button" class="{search-button: rightbuttoncheck}" ontouchend="search()"></div>
    </div>

    <div class="pay-category-container">
      <ul style="list-style:none; padding: 0; margin: 0; overflow: hidden;">
        <li each="{i in categoryList}" style="overflow: hidden;">
          <div class="pay-service-block-containter" id="{i.id}" ontouchstart="onTouchStart()"
               ontouchend="onTouchEnd(this.id)">
            <div class="pay-category-icon" style="background-image: url({i.icon})"></div>
            <div class="pay-category-name-field">{i.name}
            </div>
            <div class="pay-icon-tick" id="tick{i.id}"></div>
            <ul class="pay-services-block" if="{index == i.id && show}" style="list-style:none">
              <li class="pay-service-containter" each="{j in currentList}" id="{j.id}"
                  ontouchend="goToServiceView(this.id)">
                <div class="pay-service-icon" style="background-image: url({j.image})">
                  <div class="pay-service-name-field">{j.name}</div>
                </div>
              </li>
            </ul>
          </div>
        </li>
      </ul>
    </div>
  </div>

  <div id="blockSearchId" class="component-search">
    <div class="search-title-container">
      <div class="search-search-icon"></div>
      <p class="search-title-name">ВЫБОР КАТЕГОРИИ</p>
      <div class="search-cancel-icon" ontouchend="searchCancelEnd()"></div>
    </div>
    <div id="searchContainerId" class="search-container">
      <input id="searchInputId" class="search-input" onfocus="searchSuggestion()" onkeyup="searchSuggestion()"/>

      <div class="search-suggestion-container">

        <div id="suggestionOneId" class="search-suggestion-field-one" ontouchend="suggestionFieldOne()">

          <p class="search-part-of-suggestion">{onePartOne}<mark>{onePartTwo}</mark>{onePartThree}</p>
        </div>

        <div id="suggestionTwoId" class="search-suggestion-field-two" ontouchend="suggestionFieldTwo()">

          <p class="search-part-of-suggestion">{twoPartOne}<mark>{twoPartTwo}</mark>{twoPartThree}</p>
        </div>

        <div id="suggestionThreeId" class="search-suggestion-field-three" ontouchend="suggestionFieldThree()">

          <p class="search-part-of-suggestion">{threePartOne}<mark>{threePartTwo}</mark>{threePartThree}</p>
        </div>

        <div id="suggestionFourId" class="search-suggestion-field-four" ontouchend="suggestionFieldFour()">
          <p class="search-part-of-suggestion">{fourPartOne}<mark>{fourPartTwo}</mark>{fourPartThree}</p>
        </div>
      </div>

    </div>
  </div>

  <script>
    var scope = this;

    goToMainPage = function () {
      event.preventDefault();
      event.stopPropagation();

      this.riotTags.innerHTML = "<view-main-page>";
      riot.mount('view-main-page');
    }

    search = function () {
      event.preventDefault();
      event.stopPropagation();
      this.blockSearchId.style.display = 'block';
      scope.searchInputId.autofocus = true;
      if (scope.categoryList)
        arrayOfConnectedSuggestion = scope.categoryList.concat(scope.serviceList);
    }

    searchCancelEnd = function () {
      event.preventDefault();
      event.stopPropagation();
      this.blockSearchId.style.display = 'none';
      scope.searchWord = '';
    }

    searchSuggestion = function () {
      var j = 0;
      var check = false;
      event.preventDefault();
      event.stopPropagation();

      if (event.keyCode != 16 && event.keyCode != 18)
        scope.searchWord = event.target.value.toLowerCase();

      scope.suggestionOne = {};
      scope.suggestionTwo = {};
      scope.suggestionThree = {};
      scope.suggestionFour = {};
      console.log(arrayOfConnectedSuggestion)
      for (var i = 0; i < arrayOfConnectedSuggestion.length; i++) {
        if (arrayOfConnectedSuggestion[i].name.toLowerCase().search(scope.searchWord) != -1) {


          check = true;
          if (j == 3) {

            scope.indexOfFind = arrayOfConnectedSuggestion[i].name.toLowerCase().search(scope.searchWord);

            scope.suggestionOneId.style.display = 'block';
            scope.suggestionTwoId.style.display = 'block';
            scope.suggestionThreeId.style.display = 'block';
            scope.suggestionFourId.style.display = 'block';

            scope.suggestionFour.name = arrayOfConnectedSuggestion[i].name;

            scope.suggestionFour.id = arrayOfConnectedSuggestion[i].id;

            if (arrayOfConnectedSuggestion[i].form_type) {
              scope.suggestionFour.form_type = arrayOfConnectedSuggestion[i].form_type;
            }

            scope.fourPartOne = scope.suggestionFour.name.substring(0, scope.indexOfFind);
            scope.fourPartTwo = scope.suggestionFour.name.substring(scope.indexOfFind, scope.searchWord.length + scope.fourPartOne.length );
            scope.fourPartThree = scope.suggestionFour.name.substring(scope.fourPartTwo.length + scope.fourPartOne.length, scope.suggestionFour.name.length);

          }
          if (j == 2) {

            scope.indexOfFind = arrayOfConnectedSuggestion[i].name.toLowerCase().search(scope.searchWord);

            scope.suggestionOneId.style.display = 'block';
            scope.suggestionTwoId.style.display = 'block';
            scope.suggestionThreeId.style.display = 'block';
            scope.suggestionFourId.style.display = 'none';

            scope.suggestionThree.name = arrayOfConnectedSuggestion[i].name;

            scope.suggestionThree.id = arrayOfConnectedSuggestion[i].id;

            if (arrayOfConnectedSuggestion[i].form_type) {
              scope.suggestionThree.form_type = arrayOfConnectedSuggestion[i].form_type;
            }

            scope.threePartOne = scope.suggestionThree.name.substring(0, scope.indexOfFind);
            scope.threePartTwo = scope.suggestionThree.name.substring(scope.indexOfFind, scope.searchWord.length + scope.threePartOne.length );
            scope.threePartThree = scope.suggestionThree.name.substring(scope.threePartTwo.length + scope.threePartOne.length, scope.suggestionThree.name.length);

          }
          if (j == 1) {
            scope.indexOfFind = arrayOfConnectedSuggestion[i].name.toLowerCase().search(scope.searchWord);

            scope.suggestionOneId.style.display = 'block';
            scope.suggestionTwoId.style.display = 'block';
            scope.suggestionThreeId.style.display = 'none';
            scope.suggestionFourId.style.display = 'none';

            scope.suggestionTwo.name = arrayOfConnectedSuggestion[i].name;

            scope.suggestionTwo.id = arrayOfConnectedSuggestion[i].id;

            if (arrayOfConnectedSuggestion[i].form_type) {
              scope.suggestionTwo.form_type = arrayOfConnectedSuggestion[i].form_type;
            }

            scope.twoPartOne = scope.suggestionTwo.name.substring(0, scope.indexOfFind);
            scope.twoPartTwo = scope.suggestionTwo.name.substring(scope.indexOfFind, scope.searchWord.length + scope.twoPartOne.length );
            scope.twoPartThree = scope.suggestionTwo.name.substring(scope.twoPartTwo.length + scope.twoPartOne.length, scope.suggestionTwo.name.length);

          }
          if (j == 0) {
            scope.indexOfFind = arrayOfConnectedSuggestion[i].name.toLowerCase().search(scope.searchWord);

            scope.suggestionOneId.style.display = 'block';
            scope.suggestionTwoId.style.display = 'none';
            scope.suggestionThreeId.style.display = 'none';
            scope.suggestionFourId.style.display = 'none';

            scope.suggestionOne.name = arrayOfConnectedSuggestion[i].name;

            scope.suggestionOne.id = arrayOfConnectedSuggestion[i].id;

            if (arrayOfConnectedSuggestion[i].form_type) {
              scope.suggestionOne.form_type = arrayOfConnectedSuggestion[i].form_type;
            }

            scope.onePartOne = scope.suggestionOne.name.substring(0, scope.indexOfFind);
            scope.onePartTwo = scope.suggestionOne.name.substring(scope.indexOfFind, scope.searchWord.length + scope.onePartOne.length );
            scope.onePartThree = scope.suggestionOne.name.substring(scope.onePartTwo.length + scope.onePartOne.length, scope.suggestionOne.name.length);

          }
          j++;

          console.log("indexOfFind", scope.indexOfFind)


          console.log('scope.partOne',scope.onePartOne, 'scope.partTwo',scope.onePartTwo,'scope.partThree', scope.onePartThree)
        }

        riot.update();
        if (j == 4)
          return
      }

      if (!check) {
        scope.suggestionOneId.style.display = 'none';
        scope.suggestionTwoId.style.display = 'none';
        scope.suggestionThreeId.style.display = 'none';
        scope.suggestionFourId.style.display = 'none';
      }
    }

    suggestionFieldOne = function () {
      event.preventDefault();
      event.stopPropagation();
      console.log('work', scope.suggestionOne);

    }

    suggestionFieldTwo = function () {
      event.preventDefault();
      event.stopPropagation();
      console.log('work', scope.suggestionTwo);

    }

    suggestionFieldThree = function () {
      event.preventDefault();
      event.stopPropagation();
      console.log('work', scope.suggestionThree);

    }

    suggestionFieldFour = function () {
      event.preventDefault();
      event.stopPropagation();
      console.log('work', scope.suggestionFour);

    }

    this.titleName = 'ОПЛАТА';


    history.arrayOfHistory.push('view-pay');
    sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

    scope = this;
    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = true;
    scope.categoryList = JSON.parse(localStorage.getItem("click_client_payCategoryList"));
    scope.serviceList = JSON.parse(localStorage.getItem("click_client_payServiceList"));
    scope.servicesMapByCategory = JSON.parse(localStorage.getItem("click_client_servicesMapByCategory"));
    scope.servicesMap = JSON.parse(localStorage.getItem("click_client_servicesMap"));
    scope.servicesParams = JSON.parse(localStorage.getItem("click_client_servicesParams"));

    //VARIABLES FOR SEARCHING
    var arrayOfConnectedSuggestion = [];
    var bufferArray = [];
    scope.searchWord = '';

    var phoneNumber = localStorage.getItem('click_client_phoneNumber');
    phoneNumber = phoneNumber.substring(3, phoneNumber.length);
    console.log('PHONE NUMBER ', phoneNumber);
    var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;


    if (!scope.categoryList) {
      scope.categoryList = [];
      scope.categoryNamesMap = {};
      window.api.call({
        method: 'get.service.category.list',
        input : {
          session_key: sessionKey,
          phone_num  : phoneNumber
        },
        scope : this,

        onSuccess: function (result) {
          if (result[0][0].error == 0)
            if (result[1][0])
              for (var i in result[1]) {
                console.log('category ID ', result[1][i].id, ', category name= ', result[1][i].name);
                scope.categoryList.push(result[1][i]);
                scope.categoryNamesMap[result[1][i].id] = result[1][i].name;

              }
          riot.update(scope.categoryList);

          scope.id = 0;
          console.log('array category list', scope.categoryList)

          localStorage.setItem('click_client_payCategoryList', JSON.stringify(scope.categoryList));
          localStorage.setItem('click_client_categoryNamesMap', JSON.stringify(scope.categoryNamesMap));
        },
        onFail   : function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })
    }

    scope.index = -1;
    scope.show = false;
    var onTouchStartY;
    var onTouchEndY;
    var count = 1;

    onTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();
      if (this.viewPayId.disabled == true) return;

      onTouchStartY = event.changedTouches[0].pageY;

    }

    onTouchEndOfCategory = function (id) {
      event.preventDefault();
      event.stopPropagation();
      if (this.viewPayId.disabled == true) return;

      onTouchEndY = event.changedTouches[0].pageY;
      console.log(onTouchEndY)


      if (Math.abs(onTouchStartY - onTouchEndY) <= 10) {
        if (scope.index == id) {
          scope.index = -1;
        } else {
          if (scope.index != -1)
            document.getElementById("tick" + scope.index).style.backgroundImage = "url(resources/icons/ViewPay/catopen.png)";
          scope.index = id;
        }

//        for (var i = 0; i < scope.servicesMapByCategory[id].length; i++) {
//          scope.servicesMapByCategory[id][i].count = count;
//          console.log('CHECKS ',scope.servicesMapByCategory[id][i])
//          count++;
//        }
        scope.currentList = scope.servicesMapByCategory[id];
        count = 1;
        console.log("currentList", scope.currentList);


        if (!scope.currentList) {
          scope.show = false;
        } else {
          scope.show = true;
          document.getElementById("tick" + id).style.backgroundImage = "url(resources/icons/ViewPay/catopen.png)";
        }

        if (scope.index == id && scope.show) {
          document.getElementById("tick" + id).style.backgroundImage = "url(resources/icons/ViewPay/catclose.png)";
          viewPay.categoryId = id;
        }
        console.log(scope.show)


        riot.update(scope.index);
        riot.update(scope.currentList);
        riot.update(scope.show);
      }
    };

    if (!(scope.serviceList && scope.servicesMapByCategory && scope.servicesMap)) {
      scope.serviceList = [];
      scope.servicesMapByCategory = {};
      scope.servicesMap = {};
      window.api.call({
        method: 'get.service.list',
        input : {
          session_key: sessionKey,
          phone_num  : phoneNumber
        },
        scope : this,

        onSuccess: function (result) {
          if (result[0][0].error == 0)
            if (result[1][0])
              for (var i in result[1]) {

                scope.serviceList.push(result[1][i]);
                if (!scope.servicesMapByCategory[result[1][i].category_id]) {
                  scope.servicesMapByCategory[result[1][i].category_id] = [];
                  scope.servicesMapByCategory[result[1][i].category_id].push(result[1][i]);
                }
                else {
                  scope.servicesMapByCategory[result[1][i].category_id].push(result[1][i]);
                }
                if (!scope.servicesMap[result[1][i].id + '']) {
                  scope.servicesMap[result[1][i].id + ''] = [];
                  scope.servicesMap[result[1][i].id + ''].push(result[1][i]);
                }
                else {
                  scope.servicesMap[result[1][i].id + ''].push(result[1][i]);
                }

              }


          //riot.update(scope.serviceList)

          //console.log('array service list', scope.serviceList)
          localStorage.setItem('click_client_payServiceList', JSON.stringify(scope.serviceList));
          localStorage.setItem('click_client_servicesMapByCategory', JSON.stringify(scope.servicesMapByCategory));
          localStorage.setItem('click_client_servicesMap', JSON.stringify(scope.servicesMap));
        },
        onFail   : function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })
    }

    if (!scope.servicesParams) {
      scope.servicesParams = [];
      scope.servicesParamsMapOne = {};
      scope.servicesParamsMapTwo = {};
      scope.servicesParamsMapThree = {};
      scope.servicesParamsMapFour = {};
      window.api.call({
        method: 'get.service.parameters.list',
        input : {
          session_key: sessionKey,
          phone_num  : phoneNumber
        },

        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error == 0) {
            if (result[1])
              for (var i in result[1]) {
                if (!scope.servicesParamsMapOne[result[1][i].service_id]) {
                  scope.servicesParamsMapOne[result[1][i].service_id] = [];
                  scope.servicesParamsMapOne[result[1][i].service_id].push(result[1][i]);
                }
                else
                  scope.servicesParamsMapOne[result[1][i].service_id].push(result[1][i]);


              }
            if (result[2])
              for (var i in result[2]) {
                if (!scope.servicesParamsMapTwo[result[2][i].service_id]) {
                  scope.servicesParamsMapTwo[result[2][i].service_id] = [];
                  scope.servicesParamsMapTwo[result[2][i].service_id].push(result[2][i]);
                }
                else
                  scope.servicesParamsMapTwo[result[2][i].service_id].push(result[2][i]);

              }
            if (result[3])
              for (var i in result[3]) {
                if (!scope.servicesParamsMapThree[result[3][i].service_id]) {
                  scope.servicesParamsMapThree[result[3][i].service_id] = [];
                  scope.servicesParamsMapThree[result[3][i].service_id].push(result[3][i]);
                }
                else
                  scope.servicesParamsMapThree[result[3][i].service_id].push(result[3][i]);

              }
            if (result[4])
              for (var i in result[4]) {
                if (!scope.servicesParamsMapFour[result[4][i].service_id]) {
                  scope.servicesParamsMapFour[result[4][i].service_id] = [];
                  scope.servicesParamsMapFour[result[4][i].service_id].push(result[4][i]);
                }
                else
                  scope.servicesParamsMapFour[result[4][i].service_id].push(result[4][i]);

              }
            localStorage.setItem('click_client_servicesParams', JSON.stringify(result));
            localStorage.setItem('click_client_servicesParamsMapOne', JSON.stringify(scope.servicesParamsMapOne));
            localStorage.setItem('click_client_servicesParamsMapTwo', JSON.stringify(scope.servicesParamsMapTwo));
            localStorage.setItem('click_client_servicesParamsMapThree', JSON.stringify(scope.servicesParamsMapThree));
            localStorage.setItem('click_client_servicesParamsMapFour', JSON.stringify(scope.servicesParamsMapFour));

          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }


    goToServiceView = function (id) {
      viewPay.chosenServiceId = id;
      event.preventDefault();
      event.stopPropagation();
      if (this.viewPayId.disabled == true) return;
      localStorage.setItem('chosenServiceId', id);
      event.preventDefault();
      event.stopPropagation();
      this.riotTags.innerHTML = "<view-service-page>";
      riot.mount("view-service-page");
    }


    console.log("categories ", scope.categoryList)
    //console.log("services ", scope.serviceList)
    console.log("serviceParams", scope.servicesParams)


  </script>
</view-pay>
