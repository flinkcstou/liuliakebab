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
    <component-search></component-search>
    <script>
        //TODO: OPTIMIZE THIS PAGE SLOW DOWNLOADING CATEGORIES AND SERVICES
        var scope = this;
        scope.checkOfSearch = false;
        this.titleName = window.languages.ViewPayTitleName;

        if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-pay') {
            history.arrayOfHistory.push(
                    {
                        "view": 'view-pay',
                        "params": ''
                    }
            );
            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
        }

        scope.categoryList = JSON.parse(localStorage.getItem("click_client_payCategoryList"));
        scope.serviceList = JSON.parse(localStorage.getItem("click_client_payServiceList"));
        scope.serviceNamesMap = JSON.parse(localStorage.getItem("click_client_payServiceNamesMap"));
        scope.servicesMapByCategory = JSON.parse(localStorage.getItem("click_client_servicesMapByCategory"));
        scope.servicesMap = JSON.parse(localStorage.getItem("click_client_servicesMap"));
        //        scope.servicesParams = JSON.parse(localStorage.getItem("click_client_servicesParams"));
        scope.servicesParamsMapOne = JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"));


        var phoneNumber = localStorage.getItem('click_client_phoneNumber');
        scope.operatorKey = phoneNumber.substr(3, 2);
        phoneNumber = phoneNumber.substring(3, phoneNumber.length);

        var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;

        goToBack = function () {
            event.preventDefault();
            event.stopPropagation();
            onBackKeyDown()
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
//                        var image = new Image();
//                        var j = 0, icon;
//                        var changeBool = false;
                        for (var i in result[1]) {
                            scope.categoryList.push(result[1][i]);
                            scope.categoryNamesMap[result[1][i].id] = result[1][i].name;
//                            icon = scope.categoryList[j].icon;
//                            console.log("j=", j, ",icon=", icon);
//                            image.src = "resources/icons/ViewPay/category" + icon.substr(icon.lastIndexOf('/'));
//                            console.log(image.src);
//                            scope.categoryList[j].icon = image.src;
//                            image.onerror = function () {
//                                console.log("error!!!");
//                                console.log(scope.categoryList);
//                                console.log(j);
//                                console.log(icon);
//                                changeBool = true;
//                                console.log(changeBool);
//
//                            }
//                            image.onload = function () {
//                                console.log("load!!!");
//                            }
//                            image.success = function () {
//                                console.log("success!!!");
//                            }
//
//                            console.log(changeBool);
//                            j++;

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

        scope.onTouchStartOfCategory = onTouchStartOfCategory = function () {
            event.stopPropagation();
            onTouchStartY = event.changedTouches[0].pageY;
        }

        scope.onTouchEndOfCategory = onTouchEndOfCategory = function (id) {
            event.stopPropagation();

            onTouchEndY = event.changedTouches[0].pageY;
//      console.log(onTouchEndY)


            if (Math.abs(onTouchStartY - onTouchEndY) <= 20 ||  scope.checkOfSearch) {
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
//                            var image = new Image();
//                            var j = 0, icon;
                            var firstService, firstIndex, j = 0;
                            for (var i in result[1]) {
                                if (result[1][i].category_id == 1) {
                                    if (result[1][i].id == window.mOperators[scope.operatorKey] && j == 0) {
                                        break;
                                    }
                                    if (j == 0) {
                                        firstIndex = i;
                                        firstService = result[1][i];
                                    }
                                    j++;
                                    if (result[1][i].id == window.mOperators[scope.operatorKey]) {
                                        result[1][firstIndex] = result[1][i];
                                        result[1][i] = firstService;
                                    }
                                }
                            }
                            for (var i in result[1]) {
                                console.log("service id=", result[1][i].id, ", element:", result[1][i]);

                                scope.serviceNamesMap[result[1][i].id] = result[1][i].name;
                                scope.serviceList.push(result[1][i]);
//                                icon = scope.serviceList[j].image;
//                                console.log("j=", j, ",icon=", icon);
//                                image.src = "resources/icons/ViewPay/service" + icon.substr(icon.lastIndexOf('/'));
//                                console.log(image.src);
//                                if (image.onerror) {
//                                    console.log("no image");
//                                }
//                                else scope.serviceList[j].image = image.src;
//                                j++;

                                if (!scope.servicesMapByCategory[result[1][i].category_id]) {
                                    scope.servicesMapByCategory[result[1][i].category_id] = [];
                                    if (result[1][i].category_id == 1 && result[1][i].id == window.mOperators[scope.operatorKey]) {
                                        result[1][i].name = 'Мой номер';
                                        result[1][i].image = 'resources/icons/ViewPay/myphone.png';
                                    }
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
                    localStorage.setItem('click_client_payServiceNamesMap', JSON.stringify(scope.serviceNamesMap));
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
                                console.log("1. service id=", result[1][i].service_id, "element:", result[1][i]);
                                if (!scope.servicesParamsMapOne[result[1][i].service_id]) {
                                    scope.servicesParamsMapOne[result[1][i].service_id] = [];
                                    scope.servicesParamsMapOne[result[1][i].service_id].push(result[1][i]);
                                }
                                else
                                    scope.servicesParamsMapOne[result[1][i].service_id].push(result[1][i]);


                            }
                        if (result[2])
                            for (var i in result[2]) {
                                console.log("2. service id=", result[2][i].service_id, "element:", result[2][i]);
                                if (!scope.servicesParamsMapTwo[result[2][i].service_id]) {
                                    scope.servicesParamsMapTwo[result[2][i].service_id] = [];
                                    scope.servicesParamsMapTwo[result[2][i].service_id].push(result[2][i]);
                                }
                                else
                                    scope.servicesParamsMapTwo[result[2][i].service_id].push(result[2][i]);

                            }
                        if (result[3])
                            for (var i in result[3]) {
                                console.log("3. service id=", result[3][i].service_id, "element:", result[3][i]);
                                if (!scope.servicesParamsMapThree[result[3][i].service_id]) {
                                    scope.servicesParamsMapThree[result[3][i].service_id] = [];
                                    scope.servicesParamsMapThree[result[3][i].service_id].push(result[3][i]);
                                }
                                else
                                    scope.servicesParamsMapThree[result[3][i].service_id].push(result[3][i]);

                            }
//                        if (result[4])
//                            for (var i in result[4]) {
////                                console.log("4. service id=", result[4][i].service_id, "element:", result[4][i]);
//                                if (!scope.servicesParamsMapFour[result[4][i].service_id]) {
//                                    scope.servicesParamsMapFour[result[4][i].service_id] = [];
//                                    scope.servicesParamsMapFour[result[4][i].service_id].push(result[4][i]);
//                                }
//                                else
//                                    scope.servicesParamsMapFour[result[4][i].service_id].push(result[4][i]);
//                            }
//                        localStorage.setItem('click_client_servicesParams', JSON.stringify(result));
                        localStorage.setItem('click_client_servicesParamsMapOne', JSON.stringify(scope.servicesParamsMapOne));
                        localStorage.setItem('click_client_servicesParamsMapTwo', JSON.stringify(scope.servicesParamsMapTwo));
                        localStorage.setItem('click_client_servicesParamsMapThree', JSON.stringify(scope.servicesParamsMapThree));
//                        localStorage.setItem('click_client_servicesParamsMapFour', JSON.stringify(scope.servicesParamsMapFour));

                    }
                },

                onFail: function (api_status, api_status_message, data) {
                    console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                    console.error(data);
                }
            });
        }


        scope.onTouchStartOfService = onTouchStartOfService = function () {
            event.stopPropagation();
            onTouchStartY = event.changedTouches[0].pageY;
        }

        scope.onTouchEndOfService = onTouchEndOfService = function (id) {
            console.log(' scope.checkOfSearch', scope.checkOfSearch)
            event.stopPropagation();
            onTouchEndY = event.changedTouches[0].pageY;

            if (Math.abs(onTouchStartY - onTouchEndY) <= 20 ||  scope.checkOfSearch) {
                viewPay.chosenServiceId = id;
                event.stopPropagation();

                localStorage.setItem('chosenServiceId', id);
                riotTags.innerHTML = "<view-service-page>";
                riot.mount("view-service-page");
            }
        }


    </script>
</view-pay>
