<view-service-page class="view-service-page">
    <div class="pay-page-title" style="border-style: none;">
        <p class="servicepage-title">{titleName}</p>
        <p class="servicepage-category-field">{categoryName}</p>
        <div ontouchend="goToBack()"
             class="servicepage-button-back">
        </div>
        <div type="button" class="servicepage-service-icon"
             style="background-image: url({serviceIcon})"></div>
    </div>


    <div class="servicepage-body-container" if="{formType!=2}">
        <div class="servicepage-fields-dropdown" if="{dropDownOn}" ontouchend="openDropDown()" id="firstFieldChoiceId">
            <p class="servicepage-dropdown-text-field">{chosenFieldName}</p>
            <div class="servicepage-dropdown-icon"></div>
        </div>
        <div class="servicepage-first-field" id="firstField">
            <p class="servicepage-text-field">{chosenFieldName}</p>
            <p class="servicepage-number-first-part" if="{phoneFieldBool}">+{window.languages.CodeOfCountry}</p>
            <input class="{servicepage-number-input-part: phoneFieldBool, servicepage-number-input-part-two: !phoneFieldBool && isNumber,
                           servicepage-number-input-part-three: !phoneFieldBool && !isNumber}"
                   type="{inputType}"
                   id="firstFieldInput"
                   maxlength="{inputMaxLength}" onfocus="bordersColor()"
                   value="{defaultNumber}"/>
            <div class="servicepage-phone-icon" if="{phoneFieldBool}" ontouchend="searchContact()"></div>
        </div>

        <div class="servicepage-second-dropdown-field" if="{formType==3 && hasFirstLevel}"
             ontouchend="openDropDownTwo()">
            <p class="servicepage-dropdown-text-field">{chosenFieldNameTwo}</p>
            <div class="servicepage-dropdown-icon"></div>
        </div>

        <div class="servicepage-second-dropdown-field" if="{formType==3 && hasSecondLevel}"
             ontouchend="openDropDownThree()">
            <p class="servicepage-dropdown-text-field">{chosenFieldNameThree}</p>
            <div class="servicepage-dropdown-icon"></div>
        </div>

        <div class="{servicepage-amount-field: !dropDownOn, servicepage-amount-field-two: dropDownOn}"
             id="amountField">
            <p class="servicepage-text-field">{amountFieldTitle}</p>
            <input class="servicepage-amount-input" type="tel" value="{defaultAmount}" maxlength="13"
                   id="amount"
                   onmouseup="eraseAmountDefault()" onkeyup="sumForPay()"/>
            <div class="servicepage-amount-icon"></div>
        </div>


        <div class="servicepage-button-enter" ontouchend="goToPinCardView()">
            <div class="servicepage-button-enter-label">{window.languages.ViewServicePageEnterLabel}</div>
        </div>
    </div>


    <div id="blockFirstFieldId" class="component-first-field">
        <div class="servicepage-fields-dropdown-two">
            <p class="servicepage-dropdown-text-field" style="color: white;">{chosenFieldName}</p>
        </div>
        <div class="servicepage-dropdown-container">
            <div class="servicepage-dropdown-variant" each="{i in fieldArray}" id="{i.parameter_id}"
                 ontouchend="chooseFirstField(this.id)">
                <p id="text{i.parameter_id}" class="servicepage-dropdown-text-field" style="left: 8%">{i.title}</p>
            </div>
        </div>
    </div>

    <div id="blockFirstDropdownId" class="component-first-field">
        <div class="servicepage-fields-dropdown-two">
            <p class="servicepage-dropdown-text-field" style="color: white;">{chosenFieldNameTwo}</p>
        </div>
        <div class="servicepage-dropdown-container">
            <div class="servicepage-dropdown-variant" each="{i in firstLevelArray}" id="{i.id}"
                 ontouchstart="onTouchStartOfDropdownTwo()" ontouchend="onTouchEndOfDropdownTwo({i.id})">
                <p id="text{i.id}" class="servicepage-dropdown-text-field" style="left: 8%">{i.name}</p>
            </div>
        </div>
    </div>

    <div class="servicepage-body-container" if="{formType==2}">
        <div class="servicepage-pincards-container" each="{i in pincardIds}">
            <div class="servicepage-pincard-title">{pincardsMap[i][0].name}</div>
            <div class="servicepage-pincard-nominal-container" each="{j in pincardsMap[i]}"
                 ontouchend="goToPinCardViewFromTwo({j.nominal},{j.card_type_id})">
                <p class="servicepage-pincard-nominal-value">{j.nominal}</p>
                <div class="servicepage-pincard-choose-arrow"></div>
            </div>
        </div>
    </div>

    <div id="blockSecondDropdownId" class="component-first-field">
        <div class="servicepage-fields-dropdown-two">
            <p class="servicepage-dropdown-text-field" style="color: white;">{chosenFieldNameThree}</p>
        </div>
        <div class="servicepage-dropdown-container">
            <div class="servicepage-dropdown-variant" each="{i in secondLevelArray}" id="two{i.id}"
                 ontouchstart="onTouchStartOfDropdownThree()" ontouchend="onTouchEndOfDropdownThree({i.id})">
                <p id="texttwo{i.id}" class="servicepage-dropdown-text-field" style="left: 8%">{i.name}</p>
            </div>
        </div>
    </div>

    <component-contact-search></component-contact-search>
    <script>

        if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-service-page') {
            history.arrayOfHistory.push(
                    {
                        "view": 'view-service-page',
                        "params": ''
                    }
            );
            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
        }

        var scope = this;
        goToBack = function () {
            viewServicePage.phoneText = null;
            viewServicePage.amountText = null;
            event.preventDefault();
            event.stopPropagation();
            onBackKeyDown()
        }

        scope.servicesMap = JSON.parse(localStorage.getItem("click_client_servicesMap"));
        scope.categoryNamesMap = JSON.parse(localStorage.getItem("click_client_categoryNamesMap"));
        scope.servicesParamsMapOne = JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"));
        console.log(scope.servicesParamsMapOne)
        scope.servicesParamsMapTwo = JSON.parse(localStorage.getItem("click_client_servicesParamsMapTwo"));


        scope.service = scope.servicesMap[viewPay.chosenServiceId][0];

        if (viewPay.chosenServiceId == localStorage.getItem('myNumberOperatorId')) {
            this.titleName = localStorage.getItem('myNumberOperatorName');
            this.serviceIcon = localStorage.getItem('myNumberOperatorImage');
            viewServicePage.phoneText = localStorage.getItem('click_client_phoneNumber');
            viewServicePage.phoneText = viewServicePage.phoneText.substr(3, viewServicePage.phoneText.length - 3);
        } else {
            this.titleName = scope.service.name;
            this.serviceIcon = scope.service.image;
        }


        this.categoryName = scope.categoryNamesMap[viewPay.categoryId];
        scope.formType = scope.service.form_type;
        console.log("formType=" + this.formType);
        scope.fieldArray = scope.servicesParamsMapOne[viewPay.chosenServiceId];
        console.log("fieldArray=", scope.fieldArray);


        if (scope.formType != 2) {
            if (scope.fieldArray) {
                this.dropDownOn = scope.fieldArray.length > 1;
                console.log("fieldArray length bool=", this.dropDownOn);
                scope.chosenFieldName = scope.fieldArray[0].title;
                scope.amountFieldTitle = scope.service.lang_amount_title;
                scope.phoneFieldBool = scope.fieldArray[0].parameter_id == "1";
                if (scope.phoneFieldBool)
                    scope.defaultNumber = !viewServicePage.phoneText ? null : viewServicePage.phoneText;
                scope.defaultAmount = !viewServicePage.amountText ? 0 : viewServicePage.amountText;

                scope.inputMaxLength = scope.fieldArray[0].max_len;
                if (this.dropDownOn) {
                    scope.chosenFieldParamId = scope.fieldArray[0].parameter_id;
                    scope.oldFieldParamId = scope.fieldArray[1].parameter_id;
                }
                if (scope.fieldArray[0].input_type == '1') {
                    scope.inputType = 'tel';
                    scope.isNumber = true;
                }
                else if (scope.fieldArray[0].input_type == '2') {
                    scope.inputType = 'text';
                    scope.isNumber = false;
                }
                this.amountLength = ("" + scope.service.max_pay_limit).length;
            }
            scope.hasFirstLevel = false;
            if (scope.formType == 3 && scope.servicesParamsMapTwo[scope.service.id]) {
                scope.firstLevelArray = [];
                scope.secondLevelMap = {};
                scope.chosenFieldNameTwo = scope.servicesParamsMapTwo[scope.service.id][0].name;
                scope.hasSecondLevel = false;
                scope.hasFirstLevel = true;

                for (var i = 0; i < scope.servicesParamsMapTwo[scope.service.id].length; i++) {
                    if (scope.servicesParamsMapTwo[scope.service.id][i].parent == 0) {
                        scope.firstLevelArray.push(scope.servicesParamsMapTwo[scope.service.id][i]);
                    } else {
                        scope.hasSecondLevel = true;
                        if (!scope.secondLevelMap[scope.servicesParamsMapTwo[scope.service.id][i].parent]) {
                            scope.secondLevelMap[scope.servicesParamsMapTwo[scope.service.id][i].parent] = [];
                            scope.secondLevelMap[scope.servicesParamsMapTwo[scope.service.id][i].parent].push(scope.servicesParamsMapTwo[scope.service.id][i]);
                        }
                        else {
                            scope.secondLevelMap[scope.servicesParamsMapTwo[scope.service.id][i].parent].push(scope.servicesParamsMapTwo[scope.service.id][i]);
                        }
                    }
                }
                scope.chosenFieldParamIdTwo = scope.firstLevelArray[0].id;
//                scope.oldFieldParamIdTwo = scope.firstLevelArray[1].id;
                if (scope.hasSecondLevel && scope.secondLevelMap[scope.firstLevelArray[0].id]) {
                    scope.secondLevelArray = scope.secondLevelMap[scope.firstLevelArray[0].id];
//                    scope.chosenFieldParamIdThree = scope.secondLevelArray[0].id;
//                    scope.oldFieldParamIdThree = scope.secondLevelArray[1].id;
                }


            }
        }


        if (scope.formType == 2) {
            scope.servicesParamsMapThree = JSON.parse(localStorage.getItem("click_client_servicesParamsMapThree"));
            console.log("map THREE=", scope.servicesParamsMapThree);
            scope.pincardsMap = {};
            scope.pincardIds = [];
            console.log("scope.service.id=", scope.service.id);
            console.log("whole element=", scope.servicesParamsMapThree[scope.service.id]);
            if (scope.servicesParamsMapThree[scope.service.id]) {
                for (var i = 0; i < scope.servicesParamsMapThree[scope.service.id].length; i++) {
                    if (!scope.pincardsMap[scope.servicesParamsMapThree[scope.service.id][i].card_type_id]) {
                        scope.pincardIds.push(scope.servicesParamsMapThree[scope.service.id][i].card_type_id);
                        scope.pincardsMap[scope.servicesParamsMapThree[scope.service.id][i].card_type_id] = [];
                        scope.pincardsMap[scope.servicesParamsMapThree[scope.service.id][i].card_type_id].push(scope.servicesParamsMapThree[scope.service.id][i]);
                    }
                    else
                        scope.pincardsMap[scope.servicesParamsMapThree[scope.service.id][i].card_type_id].push(scope.servicesParamsMapThree[scope.service.id][i]);
                }
            }
        }


        openDropDown = function () {
            this.blockFirstFieldId.style.display = 'block';
            console.log("id=", scope.chosenFieldParamId);
            document.getElementById(scope.oldFieldParamId).style.backgroundColor = 'white';
            document.getElementById('text' + scope.oldFieldParamId).style.color = '#515151';
            document.getElementById(scope.chosenFieldParamId).style.backgroundColor = '#0084E6';
            document.getElementById('text' + scope.chosenFieldParamId).style.color = 'white';
        }

        openDropDownTwo = function () {
            this.blockFirstDropdownId.style.display = 'block';
            if (scope.oldFieldParamIdTwo) {
                document.getElementById(scope.oldFieldParamIdTwo).style.backgroundColor = 'white';
                document.getElementById('text' + scope.oldFieldParamIdTwo).style.color = '#515151';
            }
            if (scope.chosenFieldParamIdTwo) {
                document.getElementById(scope.chosenFieldParamIdTwo).style.backgroundColor = '#0084E6';
                document.getElementById('text' + scope.chosenFieldParamIdTwo).style.color = 'white';
            }
        }

        openDropDownThree = function () {
            if (scope.secondLevelArray) {
                this.blockSecondDropdownId.style.display = 'block';
                if (scope.oldFieldParamIdThree) {
                    document.getElementById('two' + scope.oldFieldParamIdThree).style.backgroundColor = 'white';
                    document.getElementById('texttwo' + scope.oldFieldParamIdThree).style.color = '#515151';
                }
                if (scope.chosenFieldParamIdThree) {
                    document.getElementById('two' + scope.chosenFieldParamIdThree).style.backgroundColor = '#0084E6';
                    document.getElementById('texttwo' + scope.chosenFieldParamIdThree).style.color = 'white';
                }
            }
        }

        chooseFirstField = function (id) {
            this.blockFirstFieldId.style.display = 'none';
            for (var i = 0; i < scope.fieldArray.length; i++) {
                if (scope.fieldArray[i].parameter_id == id) {
                    scope.chosenFieldName = scope.fieldArray[i].title;
                    scope.chosenFieldPlaceholder = scope.fieldArray[i].placeholder;
                    scope.phoneFieldBool = scope.fieldArray[i].parameter_id == "1";
                    scope.inputMaxLength = scope.fieldArray[i].max_len;
                    if (scope.fieldArray[i].input_type == '1') {
                        scope.inputType = 'tel';
                        scope.isNumber = true;
                    }
                    else if (scope.fieldArray[i].input_type == '2') {
                        scope.inputType = 'text';
                        scope.isNumber = false;
                    }
                    scope.oldFieldParamId = scope.chosenFieldParamId;
                    scope.chosenFieldParamId = id;
                    firstFieldInput.value = '';
                    riot.update(scope.chosenFieldName);
                    riot.update(scope.phoneFieldBool);
                    break;
                }
            }
        }

        scope.onTouchStartOfDropdownTwo = onTouchStartOfDropdownTwo = function () {
            event.stopPropagation();
            onTouchStartY = event.changedTouches[0].pageY;
        }

        scope.onTouchEndOfDropdownTwo = onTouchEndOfDropdownTwo = function (id) {
            event.stopPropagation();

            onTouchEndY = event.changedTouches[0].pageY;

            if (Math.abs(onTouchStartY - onTouchEndY) <= 20) {
                this.blockFirstDropdownId.style.display = 'none';
                for (var i = 0; i < scope.firstLevelArray.length; i++) {
                    if (scope.firstLevelArray[i].id == id) {
                        scope.chosenFieldNameTwo = scope.firstLevelArray[i].name;
                        scope.oldFieldParamIdTwo = scope.chosenFieldParamIdTwo;
                        scope.chosenFieldParamIdTwo = id;
                        if (scope.hasSecondLevel) {
                            scope.secondLevelArray = scope.secondLevelMap[id];
                            if (scope.oldFieldParamIdTwo != scope.chosenFieldParamIdTwo) {
                                scope.chosenFieldNameThree = '';
                                scope.oldFieldParamIdThree = null;
                                scope.chosenFieldParamIdThree = null;
//                                if (scope.secondLevelArray)
//                                    scope.chosenFieldParamIdThree = scope.secondLevelArray[0].id;
                                //scope.oldFieldParamIdThree = scope.secondLevelArray[1].id;
                            }
                        }
                        riot.update(scope.chosenFieldNameTwo);
                        riot.update(scope.secondLevelArray);
                        break;
                    }
                }
            }
        };


        scope.onTouchStartOfDropdownThree = onTouchStartOfDropdownThree = function () {
            event.stopPropagation();
            onTouchStartY = event.changedTouches[0].pageY;
        }

        scope.onTouchEndOfDropdownThree = onTouchEndOfDropdownThree = function (id) {
            event.stopPropagation();

            onTouchEndY = event.changedTouches[0].pageY;

            if (Math.abs(onTouchStartY - onTouchEndY) <= 20) {
                this.blockSecondDropdownId.style.display = 'none';
                for (var i = 0; i < scope.secondLevelArray.length; i++) {
                    if (scope.secondLevelArray[i].id == id) {
                        scope.chosenFieldNameThree = scope.secondLevelArray[i].name;
                        if (scope.chosenFieldParamIdThree)
                            scope.oldFieldParamIdThree = scope.chosenFieldParamIdThree;
                        scope.chosenFieldParamIdThree = id;

                        riot.update(scope.chosenFieldNameThree);
                        break;
                    }
                }
            }
        };

        this.on('mount', function () {
            console.log('viewServicePage.amountText', viewServicePage.amountText)
            if(viewServicePage.amountText)
            if (viewServicePage.amountText.length > 0) {
                amount.value = viewServicePage.amountText;
                checkFirst = true;
                amountForPayTransaction = viewServicePage.amountWithoutSpace;
            }
            else
                amount.value = 0 + ' ' + defaultAccount.currency
        })

        var maskOne = /[0-9]/g,
                maskTwo = /[0-9' ']/g,
                amountForPayTransaction,
                checkFirst = false,
                defaultAccount;

        var cards = JSON.parse(localStorage.getItem('click_client_cards'));
        for (var i in cards) {
            if (cards[i].default_account === true)
                defaultAccount = cards[i];
        }

        eraseAmountDefault = function () {
            event.preventDefault();
            event.stopPropagation();

            if (!checkFirst) {
                amount.value = ' ' + defaultAccount.currency
                checkFirst = true;
            }
            if (amount.value.match(maskOne) != null && amount.value.match(maskOne).length != null) {
                amount.selectionStart = amount.value.match(maskTwo).length
                amount.selectionEnd = amount.value.match(maskTwo).length
            } else {
                amount.selectionStart = 0
                amount.selectionEnd = 0
            }

            amountField.style.borderBottom = 5 * widthK + 'px solid #01cfff';
            firstField.style.borderBottom = 5 * widthK + 'px solid lightgrey';

        }

        sumForPay = function () {
            event.preventDefault();
            event.stopPropagation();

            if (event.keyCode == 8) {
                amountForPayTransaction = amountForPayTransaction.substring(0, amountForPayTransaction.length - 1)
            }

            if (amount.value.match(maskTwo) != null && amount.value.match(maskTwo).length != null) {

                amount.value = amount.value.substring(0, event.target.value.match(maskTwo).length) + defaultAccount.currency
                amount.selectionStart = amount.value.match(maskTwo).length - 1
                amount.selectionEnd = amount.value.match(maskTwo).length - 1

                amountForPayTransaction = amount.value.substring(0, amount.value.match(maskTwo).length);
                amountForPayTransaction = amountForPayTransaction.replace(new RegExp(' ', 'g'), '');

                if (amountForPayTransaction.length == 4) {
                    amount.value = amountForPayTransaction.substring(0, 1) + ' ' + amountForPayTransaction.substring(1, amountForPayTransaction.length) + ' ' + defaultAccount.currency
                    amount.selectionStart = amount.value.match(maskTwo).length - 1
                    amount.selectionEnd = amount.value.match(maskTwo).length - 1

                }

                if (amountForPayTransaction.length == 5) {
                    amount.value = amountForPayTransaction.substring(0, 2) + ' ' + amountForPayTransaction.substring(2, amountForPayTransaction.length) + ' ' + defaultAccount.currency
                    amount.selectionStart = amount.value.match(maskTwo).length - 1
                    amount.selectionEnd = amount.value.match(maskTwo).length - 1

                }

                if (amountForPayTransaction.length == 6) {
                    amount.value = amountForPayTransaction.substring(0, 3) + ' ' + amountForPayTransaction.substring(3, amountForPayTransaction.length) + ' ' + defaultAccount.currency
                    amount.selectionStart = amount.value.match(maskTwo).length - 1
                    amount.selectionEnd = amount.value.match(maskTwo).length - 1

                }

                if (amountForPayTransaction.length == 7) {
                    amount.value = amountForPayTransaction.substring(0, 1) + ' ' + amountForPayTransaction.substring(1, 4) + ' ' +
                            amountForPayTransaction.substring(4, amountForPayTransaction.length) + ' ' + defaultAccount.currency
                    amount.selectionStart = amount.value.match(maskTwo).length - 1
                    amount.selectionEnd = amount.value.match(maskTwo).length - 1

                }

                if (amountForPayTransaction.length == 8) {
                    amount.value = amountForPayTransaction.substring(0, 2) + ' ' + amountForPayTransaction.substring(2, 5) + ' ' +
                            amountForPayTransaction.substring(5, amountForPayTransaction.length) + ' ' + defaultAccount.currency
                    amount.selectionStart = amount.value.match(maskTwo).length - 1
                    amount.selectionEnd = amount.value.match(maskTwo).length - 1

                }


            } else {
                amount.selectionStart = 0
                amount.selectionEnd = 0
            }

            viewServicePage.amountText = amount.value;
            viewServicePage.amountWithoutSpace = amountForPayTransaction;

            console.log('AAAAAAA',  viewServicePage.amountText)

        }

        bordersColor = function () {
            firstField.style.borderBottom = 5 * widthK + 'px solid #01cfff';
            amountField.style.borderBottom = 5 * widthK + 'px solid lightgrey';
        }

        goToPinCardView = function () {
            console.log(scope.phoneFieldBool);

            if (scope.phoneFieldBool && firstFieldInput.value.length < 9) {
                alert("Введите валидный номер телефона");
                return;
            }
            if (amountForPayTransaction < scope.service.min_pay_limit) {
                alert("Сумма должна быть больше " + scope.service.min_pay_limit);
                return;
            }
            if (amountForPayTransaction > scope.service.max_pay_limit) {
                alert("Сумма должна быть меньше " + scope.service.max_pay_limit);
                return;
            }

            if (scope.formType == 3) {
                if (scope.hasSecondLevel)
                    var communalParam = {"communalParam": scope.chosenFieldParamIdThree};
                else
                    var communalParam = {"communalParam": scope.chosenFieldParamIdTwo};
            } else if (scope.formType == 1)
                var communalParam = {"communalParam": null};

            var formtype = {"formtype": scope.formType};
            var firstFieldId = {"firstFieldId": scope.chosenFieldParamId};
            var firstFieldText = {"firstFieldText": firstFieldInput.value};
            var cardTypeId = {"cardTypeId": null};
            var amountText = {"amountText": amountForPayTransaction};

            viewServicePage.firstFieldTitle = scope.chosenFieldName;
            viewServicePage.phoneText = firstFieldInput.value;



            event.preventDefault();
            event.stopPropagation();
            this.riotTags.innerHTML = "<view-service-pincards>";
            riot.mount('view-service-pincards', [formtype, firstFieldId, firstFieldText, cardTypeId, communalParam, amountText]);
        }

        goToPinCardViewFromTwo = function (nominal, cardId) {

            var formtype = {"formtype": scope.formType};
            var firstFieldId = {"firstFieldId": null};
            var firstFieldText = {"firstFieldText": null};
            var cardTypeId = {"cardTypeId": cardId};
            var communalParam = {"communalParam": null};
            var amountText = {"amountText": nominal};

            event.preventDefault();
            event.stopPropagation();
            this.riotTags.innerHTML = "<view-service-pincards>";
            riot.mount('view-service-pincards', [formtype, firstFieldId, firstFieldText, cardTypeId, communalParam, amountText]);
        }


    </script>
</view-service-page>
