<view-pay>
    <div id="viewPayId" class="view-pay">
        <div class="pay-page-title">
            <p class="pay-name-title">{titleName}</p>
            <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
            <div id="rightButton" type="button" class="pay-search-button" ontouchend="search()"></div>
            <div style=""></div>
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
    <component-category-search></component-category-search>
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
        scope.servicesParams = JSON.parse(localStorage.getItem("click_client_servicesParams"));
        scope.servicesParamsMapOne = JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"));


        var phoneNumber = localStorage.getItem('click_client_phoneNumber');
        scope.operatorKey = phoneNumber.substr(3, 2);
        phoneNumber = phoneNumber.substring(3, phoneNumber.length);

        var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;

        goToBack = function () {
            event.preventDefault();
            event.stopPropagation();
            onBackKeyDown()
        };
        if (!scope.categoryList) {
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

                            if (device.platform != 'BrowserStand') {
                                window.requestFileSystem(window.TEMPORARY, 1000, function (fs) {

                                    for (var i in result[1]) {

                                        scope.categoryNamesMap[result[1][i].id] = result[1][i].name;
                                        var icon = result[1][i].icon;
                                        var filename = icon.substr(icon.lastIndexOf('/') + 1);
                                        alert("filename=" + filename);

                                        //alert('file system open: ' + fs.name);

                                        var newIconBool = getSampleFile;
                                        newIconBool(cordova.file.applicationDirectory, filename, icon, result[1][i], function (list) {
                                            if (result[1].length == list.length) {
                                                alert("save into localstorage");
                                                localStorage.setItem('click_client_payCategoryList', JSON.stringify(scope.categoryList));
                                                localStorage.setItem('click_client_categoryNamesMap', JSON.stringify(scope.categoryNamesMap));
                                            }

                                        });
                                    }
                                    riot.update(scope.categoryList);
                                }, onErrorLoadFs);
                            }
                            else {
                                for (var i in result[1]) {

                                    var icon = result[1][i].icon;
                                    var filename = icon.substr(icon.lastIndexOf('/') + 1);
                                    alert("filename=" + filename);

                                    scope.categoryList.push(result[1][i]);
                                    scope.categoryNamesMap[result[1][i].id] = result[1][i].name;
                                }
                                riot.update(scope.categoryList);
                                localStorage.setItem('click_client_payCategoryList', JSON.stringify(scope.categoryList));
                                localStorage.setItem('click_client_categoryNamesMap', JSON.stringify(scope.categoryNamesMap));
                            }
                        }

                    scope.id = 0;

                },
                onFail: function (api_status, api_status_message, data) {
                    console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                    console.error(data);
                }
            });
        }

        scope.index = -1;
        scope.show = false;
        var onTouchStartY;
        var onTouchEndY;
        var count = 1;

        scope.onTouchStartOfCategory = onTouchStartOfCategory = function () {
            event.stopPropagation();
            onTouchStartY = event.changedTouches[0].pageY;
        };

        scope.onTouchEndOfCategory = onTouchEndOfCategory = function (id) {
            event.stopPropagation();

            onTouchEndY = event.changedTouches[0].pageY;
//      console.log(onTouchEndY)


            if (Math.abs(onTouchStartY - onTouchEndY) <= 20 || scope.checkOfSearch) {
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
//                            if (device.platform != 'BrowserStand') {
//
//                                window.requestFileSystem(window.TEMPORARY, 1000, function (fs) {
                            for (var i in result[1]) {
                                if (result[1][i].is_visible == 1) {
                                    console.log("service id=", result[1][i].id, ", element:", result[1][i]);

                                    scope.serviceNamesMap[result[1][i].id] = result[1][i].name;
                                    scope.serviceList.push(result[1][i]);


//                                            icon = result[1][i].image;
//                                            alert("icon=", icon);
//                                            var filename = icon.substr(icon.lastIndexOf('/'));
//                                            alert(filename);
//
//                                            alert('file system open: ' + fs.name);
//
//                                            getSampleFile(cordova.file.applicationDirectory, filename);


                                    if (!scope.servicesMapByCategory[result[1][i].category_id]) {
                                        scope.servicesMapByCategory[result[1][i].category_id] = [];
                                        if (result[1][i].category_id == 1 && result[1][i].id == window.mOperators[scope.operatorKey]) {
                                            localStorage.setItem('myNumberOperatorId', result[1][i].id);
                                            localStorage.setItem('myNumberOperatorName', result[1][i].name);
                                            localStorage.setItem('myNumberOperatorImage', result[1][i].image);
                                            result[1][i].name = 'Мой номер';
                                            result[1][i].image = 'resources/icons/ViewPay/myphone.png';
                                            //console.log("ID=", viewServicePage.myNumberOperatorId, ",,,Name=", viewServicePage.myNumberOperatorName, ",,,Image=", viewServicePage.myNumberOperatorImage);
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
//                                }, onErrorLoadFs);
//                            }
                        }

                    localStorage.setItem('click_client_payServiceList', JSON.stringify(scope.serviceList));
                    localStorage.setItem('click_client_payServiceNamesMap', JSON.stringify(scope.serviceNamesMap));
                    localStorage.setItem('click_client_servicesMapByCategory', JSON.stringify(scope.servicesMapByCategory));
                    localStorage.setItem('click_client_servicesMap', JSON.stringify(scope.servicesMap));
                    servicesParamsInit();
                },
                onFail: function (api_status, api_status_message, data) {
                    console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                    console.error(data);
                }
            })
        }

        servicesParamsInit = function () {
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
        };


        scope.onTouchStartOfService = onTouchStartOfService = function () {
            event.stopPropagation();
            onTouchStartY = event.changedTouches[0].pageY;
        };

        scope.onTouchEndOfService = onTouchEndOfService = function (id) {
            console.log(' scope.checkOfSearch', scope.checkOfSearch)
            event.stopPropagation();
            onTouchEndY = event.changedTouches[0].pageY;

            if (Math.abs(onTouchStartY - onTouchEndY) <= 20 || scope.checkOfSearch) {
                viewPay.chosenServiceId = id;
                event.stopPropagation();

                localStorage.setItem('chosenServiceId', id);
                riotTags.innerHTML = "<view-service-page>";
                riot.mount("view-service-page");
            }
        };


        function getSampleFile(dirEntry, fileName, assetURL, object, callback) {
            var bool = false;

//            alert("name is=" + fileName);
            var xhr = new XMLHttpRequest();

            xhr.open('GET', cordova.file.applicationDirectory + 'www/resources/icons/ViewPay/category/' + fileName, true);
            xhr.responseType = 'blob';

            xhr.onload = function () {
                if (this.status == 200) {

                    var blob = new Blob([this.response], {type: 'image/png'});
                    alert("status 200 For " + fileName);
                    bool = false;
                    object.icon = cordova.file.applicationDirectory + 'www/resources/icons/ViewPay/category/' + fileName;
                    scope.categoryList.push(object);
                    callback(scope.categoryList);
                }
            };

            xhr.onerror = function () {
                alert("error for " + fileName);

                var convertFunction = convertFileToDataURLviaFileReader;

                convertFunction(assetURL, function (base64Img) {
                    alert("base64 length=" + base64Img.length);
                    // Split the base64 string in data and contentType
                    var block = base64Img.split(";");
                    // Get the content type
                    var dataType = block[0].split(":")[1];// In this case "image/png"
                    // get the real base64 content of the file
                    var realData = block[1].split(",")[1];// In this case "iVBORw0KGg...."

                    var folderpath = cordova.file.dataDirectory;

                    savebase64AsImageFile(folderpath, fileName, realData, dataType);
                    bool = true;
                    object.icon = cordova.file.dataDirectory + fileName;
                    scope.categoryList.push(object);
                    callback(scope.categoryList);
                });
                event.preventDefault();

            }
            xhr.send();
        }


        function savebase64AsImageFile(folderpath, filename, content, contentType) {
            // Convert the base64 string in a Blob
            var DataBlob = b64toBlob(content, contentType);

            console.log("Starting to write the file :3");

            window.resolveLocalFileSystemURL(folderpath, function (dir) {
                console.log("Access to the directory granted succesfully");
                dir.getFile(filename, {create: true, exclusive: false}, function (file) {
                    alert("File created succesfully.");
                    file.createWriter(function (fileWriter) {
                        ("Writing content to file");
                        fileWriter.write(DataBlob);
                    }, function () {
                        alert('Unable to save file in path ' + folderpath);
                    });
                });
            });
        }

        function b64toBlob(b64Data, contentType, sliceSize) {
            contentType = contentType || '';
            sliceSize = sliceSize || 512;

            var byteCharacters = atob(b64Data);
            var byteArrays = [];

            for (var offset = 0; offset < byteCharacters.length; offset += sliceSize) {
                var slice = byteCharacters.slice(offset, offset + sliceSize);

                var byteNumbers = new Array(slice.length);
                for (var i = 0; i < slice.length; i++) {
                    byteNumbers[i] = slice.charCodeAt(i);
                }

                var byteArray = new Uint8Array(byteNumbers);

                byteArrays.push(byteArray);
            }

            var blob = new Blob(byteArrays, {type: contentType});
            return blob;
        }

        function convertFileToDataURLviaFileReader(url, callback) {
            var xhr = new XMLHttpRequest();
            xhr.onload = function () {
                var reader = new FileReader();
                reader.onloadend = function () {
                    callback(reader.result);
                }
                reader.readAsDataURL(xhr.response);
            };
            xhr.open('GET', url);
            xhr.responseType = 'blob';
            xhr.send();
        }


        function onErrorLoadFs() {
            alert("OnErrorLoadFS");
        }

        //        if (device.platform != 'BrowserStand') {
        //
        //            window.requestFileSystem(window.TEMPORARY, 1000, function (fs) {
        //
        //                alert('file system open: ' + fs.name);
        //                var nameArr = ['1.png', '2.png', '123.png'];
        //
        //                for (var i = 0; i < nameArr.length; i++) {
        //                    getSampleFile(cordova.file.applicationDirectory, nameArr[i]);
        //                }
        //
        //            }, onErrorLoadFs);
        //        }


    </script>
</view-pay>
