<view-pay>
    <div id="viewPayId" class="view-pay">
        <div class="pay-page-title">
            <p class="pay-name-title">{titleName}</p>
            <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
            <div id="rightButton" type="button" class="pay-search-button" ontouchend="search()"></div>
        </div>
        <div class="pay-category-container">
            <ul style="list-style:none; padding: 0; margin: 0; overflow: hidden;">
                <li each="{i in categoryList}" style="overflow: hidden;">
                    <div class="pay-service-block-containter" id="{i.id}" ontouchstart="onTouchStartOfCategory()"
                         ontouchend="onTouchEndOfCategory(this.id)">
                        <div class="pay-category-icon" style="background-image: url({i.icon})"></div>
                        <div class="pay-category-name-field">{i.name}
                        </div>
                        <div class="pay-icon-tick" id="tick{i.id}"></div>
                        <ul class="pay-services-block" if="{index == i.id && show}" style="list-style:none">
                            <li class="pay-service-containter" each="{j in currentList}">
                                <div class="pay-service-icon" style="background-image: url({j.image})" id="{j.id}"
                                     ontouchend="onTouchEndOfService(this.id)" ontouchstart="onTouchStartOfService()">
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
            <p class="search-title-name">{window.languages.ComponentSearchTitle}</p>
            <div class="search-cancel-icon" ontouchend="searchCancelEnd()"></div>
        </div>
        <div id="searchContainerId" class="search-container">
            <input id="searchInputId" class="search-input" onkeyup="searchSuggestion()"/>
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
    </div>
    <script>
        //TODO: OPTIMIZE THIS PAGE SLOW DOWNLOADING CATEGORIES AND SERVICES
        var scope = this;
        this.titleName = window.languages.ViewPayTitleName;

        if (history.arrayOfHistory[history.arrayOfHistory.length - 1] != 'view-pay') {
            history.arrayOfHistory.push('view-pay');
            sessionStorage.
            setItem('history', JSON.stringify(history.arrayOfHistory))
        }
        scope.categoryList = JSON.parse(localStorage.getItem("click_client_payCategoryList"));
        scope.serviceList = JSON.parse(localStorage.getItem("click_client_payServiceList"));
        scope.servicesMapByCategory = JSON.parse(localStorage.getItem("click_client_servicesMapByCategory"));
        scope.servicesMap = JSON.parse(localStorage.getItem("click_client_servicesMap"));
        scope.servicesParams = JSON.parse(localStorage.getItem("click_client_servicesParams"));

        //VARIABLES FOR SEARCHING
        var arrayOfConnectedSuggestion = [];
        var bufferArray = [];
        scope.searchWord = '';
        var checkOfSearch = false;

        var phoneNumber = localStorage.getItem('click_client_phoneNumber');
        phoneNumber = phoneNumber.substring(3, phoneNumber.length);
        //console.log('PHONE NUMBER ', phoneNumber);
        var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;

        goToBack = function () {
            event.preventDefault();
            event.stopPropagation();
            onBackKeyDown()
        }

        search = function () {
            event.preventDefault();
            event.stopPropagation();
            this.blockSearchId.style.display = 'block';
            searchInputId.autofocus = true;
            if (scope.categoryList)
                arrayOfConnectedSuggestion = scope.categoryList.concat(scope.serviceList);
            if (device.platform != 'BrowserStand')
                StatusBar.backgroundColorByHexString("#353340");
        }

        searchCancelEnd = function () {
            event.preventDefault();
            event.stopPropagation();
            this.blockSearchId.style.display = 'none';
            scope.searchWord = '';
            Keyboard.hide();
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

                        riot.update(scope.fourPartOne);
                        riot.update(scope.fourPartTwo);
                        riot.update(scope.fourPartThree);

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

                        riot.update(scope.threePartOne);
                        riot.update(scope.threePartTwo);
                        riot.update(scope.threePartThree);

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

                        riot.update(scope.twoPartOne);
                        riot.update(scope.twoPartTwo);
                        riot.update(scope.twoPartThree);

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

                        riot.update(scope.onePartOne);
                        riot.update(scope.onePartTwo);
                        riot.update(scope.onePartThree);
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
            Keyboard.hide();
            event.preventDefault();
            event.stopPropagation();
            this.blockSearchId.style.display = 'none';
            checkOfSearch = true;
            if (scope.suggestionOne.form_type) {
                onTouchEndOfService(scope.suggestionOne.id)
            }
            else
                onTouchEndOfCategory(scope.suggestionOne.id);
        }

        suggestionFieldTwo = function () {
            Keyboard.hide();
            event.preventDefault();
            event.stopPropagation();
            this.blockSearchId.style.display = 'none';
            checkOfSearch = true;
            if (scope.suggestionTwo.form_type) {
                onTouchEndOfService(scope.suggestionTwo.id)
            }
            else
                onTouchEndOfCategory(scope.suggestionTwo.id);
        }


        suggestionFieldThree = function () {
            Keyboard.hide();
            event.preventDefault();
            event.stopPropagation();
            this.blockSearchId.style.display = 'none';
            checkOfSearch = true;
            if (scope.suggestionThree.form_type) {
                onTouchEndOfService(scope.suggestionThree.id)
            }
            else
                onTouchEndOfCategory(scope.suggestionThree.id);
        }


        suggestionFieldFour = function () {
            Keyboard.hide();
            event.preventDefault();
            event.stopPropagation();
            this.blockSearchId.style.display = 'none';
            checkOfSearch = true;
            if (scope.suggestionFour.form_type) {
                onTouchEndOfService(scope.suggestionFour.id)
            }
            else
                onTouchEndOfCategory(scope.suggestionFour.id);
        }

        //        if (!scope.categoryList) {
        scope.categoryList = [];
        scope.categoryNamesMap = {};
        window.api.call({
            method: 'get.service.category.list',
            input: {
                session_key: sessionKey,
                phone_num: phoneNumber
            },
            scope: this,

            onSuccess: function (result) {
                if (result[0][0].error == 0)
                    if (result[1][0]) {
                        var image = new Image();
                        var j = 0, icon;
                        var changeBool = false;
                        for (var i in result[1]) {
                            scope.categoryList.push(result[1][i]);
                            scope.categoryNamesMap[result[1][i].id] = result[1][i].name;
                            icon = scope.categoryList[j].icon;
                            console.log("j=", j, ",icon=", icon);
                            image.src = "resources/icons/ViewPay/category" + icon.substr(icon.lastIndexOf('/'));
                            console.log(image.src);
                            scope.categoryList[j].icon = image.src;
                            image.onerror = function () {
                                console.log("error!!!");
                                console.log(scope.categoryList);
                                console.log(j);
                                console.log(icon);
                                changeBool = true;
                                console.log(changeBool);

                            }
                            image.onload = function () {
                                console.log("load!!!");
                            }
                            image.success = function () {
                                console.log("success!!!");
                            }

                            console.log(changeBool);

//                            if (image.onerror()) {
//                                console.log("no image");
//                            }
//                            if (image.onload()) {
//                                scope.categoryList[j].icon = image.src;
//                                console.log("image exists");
//                            }
                            j++;

                        }
                    }
                riot.update(scope.categoryList);

                scope.id = 0;

                localStorage.setItem('click_client_payCategoryList', JSON.stringify(scope.categoryList));
                localStorage.setItem('click_client_categoryNamesMap', JSON.stringify(scope.categoryNamesMap));
            },
            onFail: function (api_status, api_status_message, data) {
                console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                console.error(data);
            }
        })
        //        }

        scope.index = -1;
        scope.show = false;
        var onTouchStartY;
        var onTouchEndY;
        var count = 1;

        onTouchStartOfCategory = function () {
            event.stopPropagation();
            onTouchStartY = event.changedTouches[0].pageY;
        }

        onTouchEndOfCategory = function (id) {
            event.stopPropagation();

            onTouchEndY = event.changedTouches[0].pageY;
//      console.log(onTouchEndY)


            if (Math.abs(onTouchStartY - onTouchEndY) <= 20 || checkOfSearch) {
                if (scope.index == id) {
                    scope.index = -1;
                } else {
                    if (scope.index != -1)
                        document.getElementById("tick" + scope.index).style.backgroundImage = "url(resources/icons/ViewPay/catopen.png)";
                    scope.index = id;
                }

                scope.currentList = scope.servicesMapByCategory[id];
                count = 1;


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


                riot.update(scope.index);
                riot.update(scope.currentList);
                riot.update(scope.show);
            }
        };

        if (!(scope.serviceList && scope.servicesMapByCategory && scope.servicesMap)) {
            scope.serviceList = [];
            scope.servicesMapByCategory = {};
            scope.servicesMap = {};
            scope.serviceNamesMap = {};
            window.api.call({
                method: 'get.service.list',
                input: {
                    session_key: sessionKey,
                    phone_num: phoneNumber
                },
                scope: this,

                onSuccess: function (result) {
                    if (result[0][0].error == 0)
                        if (result[1][0]) {
                            var image = new Image();
                            var j = 0, icon;
                            for (var i in result[1]) {
//                                console.log("service id=", result[1][i].id, ", element:", result[1][i]);

                                scope.serviceNamesMap[result[1][i].id] = result[1][i].name;
                                scope.serviceList.push(result[1][i]);
                                icon = scope.serviceList[j].image;
                                console.log("j=", j, ",icon=", icon);
                                image.src = "resources/icons/ViewPay/service" + icon.substr(icon.lastIndexOf('/'));
                                console.log(image.src);
                                if (image.onerror) {
                                    console.log("no image");
                                }
                                else scope.serviceList[j].image = image.src;
                                j++;
                                if (!scope.servicesMapByCategory[result[1][i].category_id]) {
                                    scope.servicesMapByCategory[result[1][i
                                            ].category_id] = [];
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
                        }


                    localStorage.setItem('click_client_payServiceList', JSON.stringify(scope.serviceList));
                    localStorage.setItem('click_client_servicesMapByCategory', JSON.stringify(scope.servicesMapByCategory));
                    localStorage.setItem('click_client_servicesMap', JSON.stringify(scope.servicesMap));
                },
                onFail: function (api_status, api_status_message, data) {
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
                input: {
                    session_key: sessionKey,
                    phone_num: phoneNumber
                },

                scope: this,

                onSuccess: function (result) {
                    if (result[0][0].error == 0) {
                        if (result[1])
                            for (var i in result[1]) {
//                                console.log("1. service id=", result[1][i].service_id, "element:", result[1][i]);
                                if (!scope.servicesParamsMapOne[result[1][i].service_id]) {
                                    scope.servicesParamsMapOne[result[1][i].service_id] = [];
                                    scope.servicesParamsMapOne[result[1][i].service_id].push(result[1][i]);
                                }
                                else
                                    scope.servicesParamsMapOne[result[1][i].service_id].push(result[1][i]);


                            }
                        if (result[2])
                            for (var i in result[2]) {
//                                console.log("2. service id=", result[2][i].service_id, "element:", result[2][i]);
                                if (!scope.servicesParamsMapTwo[result[2][i].service_id]) {
                                    scope.servicesParamsMapTwo[result[2][i].service_id] = [];
                                    scope.servicesParamsMapTwo[result[2][i].service_id].push(result[2][i]);
                                }
                                else
                                    scope.servicesParamsMapTwo[result[2][i].service_id].push(result[2][i]);

                            }
                        if (result[3])
                            for (var i in result[3]) {
//                                console.log("3. service id=", result[3][i].service_id, "element:", result[3][i]);
                                if (!scope.servicesParamsMapThree[result[3][i].service_id]) {
                                    scope.servicesParamsMapThree[result[3][i].service_id] = [];
                                    scope.servicesParamsMapThree[result[3][i].service_id].push(result[3][i]);
                                }
                                else
                                    scope.servicesParamsMapThree[result[3][i].service_id].push(result[3][i]);

                            }
                        if (result[4])
                            for (var i in result[4]) {
//                                console.log("4. service id=", result[4][i].service_id, "element:", result[4][i]);
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


        onTouchStartOfService = function () {
            event.stopPropagation();
            onTouchStartY = event.changedTouches[0].pageY;
        }

        onTouchEndOfService = function (id) {
            event.stopPropagation();
            onTouchEndY = event.changedTouches[0].pageY;

            if (Math.abs(onTouchStartY - onTouchEndY) <= 20 || checkOfSearch) {
                viewPay.chosenServiceId = id;
                event.stopPropagation();

                localStorage.setItem('chosenServiceId', id);
                this.riotTags.innerHTML = "<view-service-page>";
                riot.mount("view-service-page");
            }
        }

        checkImage = function (icon) {
            alert("ttt");
            console.log("icon=", icon);

        }
    </script>
</view-pay>
