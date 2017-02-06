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
            <p class="servicepage-dropdown-text-field">{chosenFieldName}</p></div>
        <div class="servicepage-first-field" id="firstField">
            <p class="servicepage-text-field">{chosenFieldPlaceholder}</p>
            <p class="servicepage-number-first-part" if="{phoneFieldBool}">+{window.languages.CodeOfCountry}</p>
            <input class="{servicepage-number-input-part: phoneFieldBool, servicepage-number-input-part-two: !phoneFieldBool && isNumber,
                           servicepage-number-input-part-three: !phoneFieldBool && !isNumber}"
                   type="{inputType}"
                   id="firstFieldInput"
                   maxlength="{inputMaxLength}" onfocus="bordersColor()"
                   value="{defaultNumber}"/>
            <div class="servicepage-phone-icon" if="{phoneFieldBool}" ontouchend="searchContact()"></div>
        </div>

        <div class="servicepage-second-dropdown-field" if="{formType==3}" ontouchend="openDropDownTwo()">
            <p class="servicepage-dropdown-text-field">{chosenFieldNameTwo}</p>
        </div>

        <div class="{servicepage-amount-field: !dropDownOn, servicepage-amount-field-two: dropDownOn}"
             id="amountField">
            <p class="servicepage-text-field">{window.languages.ViewServicePageAmountTextLabel}</p>
            <input class="servicepage-amount-input" type="tel" maxlength="{amountLength}" value="{defaultAmount}"
                   id="amount"
                   onfocus="eraseAmountDefault()"/>
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
                 ontouchend="chooseDropdownField(this.id)">
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
        scope.defaultAmount = !viewServicePage.amountText ? 0 : viewServicePage.amountText;
        scope.defaultNumber = !viewServicePage.phoneText ? null : viewServicePage.phoneText;

        this.titleName = scope.service.name;
        this.serviceIcon = scope.service.image;
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
                scope.chosenFieldPlaceholder = scope.fieldArray[0].placeholder;
                scope.phoneFieldBool = scope.fieldArray[0].parameter_id == "1";
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
            if (scope.formType == 3 && scope.servicesParamsMapTwo[scope.service.id]) {
                scope.firstLevelArray = [];
                scope.secondLevelMap = {};
                scope.chosenFieldNameTwo = scope.servicesParamsMapTwo[scope.service.id][0].name;

                for (var i = 0; i < scope.servicesParamsMapTwo[scope.service.id].length; i++) {
                    if (scope.servicesParamsMapTwo[scope.service.id][i].parent == 0) {
                        scope.firstLevelArray.push(scope.servicesParamsMapTwo[scope.service.id][i]);
                        console.log("Elem in Arr=", scope.servicesParamsMapTwo[scope.service.id][i]);
                    } else {
                        if (!scope.secondLevelMap[scope.servicesParamsMapTwo[scope.service.id][i].parent]) {
                            scope.secondLevelMap[scope.servicesParamsMapTwo[scope.service.id][i].parent] = [];
                            scope.secondLevelMap[scope.servicesParamsMapTwo[scope.service.id][i].parent].push(scope.servicesParamsMapTwo[scope.service.id][i]);
                            console.log("Parent id=", scope.servicesParamsMapTwo[scope.service.id][i].parent);
                        }
                        else {
                            console.log("Parent id=", scope.servicesParamsMapTwo[scope.service.id][i].parent);
                            scope.secondLevelMap[scope.servicesParamsMapTwo[scope.service.id][i].parent].push(scope.servicesParamsMapTwo[scope.service.id][i]);
                        }
                    }
                }
                scope.chosenFieldParamIdTwo = scope.firstLevelArray[0].id;
                scope.oldFieldParamIdTwo = scope.firstLevelArray[1].id;
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
            console.log("id=", scope.chosenFieldParamIdTwo);
            document.getElementById(scope.oldFieldParamIdTwo).style.backgroundColor = 'white';
            document.getElementById('text' + scope.oldFieldParamIdTwo).style.color = '#515151';
            document.getElementById(scope.chosenFieldParamIdTwo).style.backgroundColor = '#0084E6';
            document.getElementById('text' + scope.chosenFieldParamIdTwo).style.color = 'white';
        }

        chooseFirstField = function (id) {
            this.blockFirstFieldId.style.display = 'none';
            console.log("chosen param id=", +id);
            for (var i = 0; i < scope.fieldArray.length; i++) {
                console.log("parame_id=", scope.fieldArray[i].parameter_id);
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
                    console.log("new title", scope.chosenFieldName);
                    scope.oldFieldParamId = scope.chosenFieldParamId;
                    scope.chosenFieldParamId = id;
                    firstFieldInput.value = '';
                    riot.update(scope.chosenFieldName);
                    riot.update(scope.phoneFieldBool);
                    break;
                }
            }
        }

        chooseDropdownField = function (id) {
            this.blockFirstDropdownId.style.display = 'none';
            console.log("chosen param id=", +id);
            for (var i = 0; i < scope.firstLevelArray.length; i++) {
                console.log("param_id=", scope.firstLevelArray[i].id);
                if (scope.firstLevelArray[i].id == id) {
                    scope.chosenFieldNameTwo = scope.firstLevelArray[i].name;

                    console.log("new title", scope.chosenFieldNameTwo);
                    scope.oldFieldParamIdTwo = scope.chosenFieldParamIdTwo;
                    scope.chosenFieldParamIdTwo = id;

                    riot.update(scope.chosenFieldNameTwo);
                    break;
                }
            }
        }

        eraseAmountDefault = function () {
            amountField.style.borderBottom = 5 * widthK + 'px solid #01cfff';
            firstField.style.borderBottom = 5 * widthK + 'px solid lightgrey';
            if (amount.value == '0')
                amount.value = null;
        }

        bordersColor = function () {
            firstField.style.borderBottom = 5 * widthK + 'px solid #01cfff';
            amountField.style.borderBottom = 5 * widthK + 'px solid lightgrey';
        }

        goToPinCardView = function () {
            console.log("bndfvhj = ", firstFieldInput.value.length < 9);
            console.log(scope.phoneFieldBool);

            if (scope.phoneFieldBool && firstFieldInput.value.length < 9) {
                alert("Введите валидный номер телефона");
                return;
            }
            if (document.getElementById('amount').value < scope.service.min_pay_limit) {
                alert("Сумма должна быть больше " + scope.service.min_pay_limit);
                return;
            }
            if (document.getElementById('amount').value > scope.service.max_pay_limit) {
                alert("Сумма должна быть меньше " + scope.service.max_pay_limit);
                return;
            }
            var formtype = {"formtype": scope.formType};
            var firstFieldId = {"firstFieldId": scope.chosenFieldParamId};
            var firstFieldText = {"firstFieldText": firstFieldInput.value};
            var cardTypeId = {"cardTypeId": null};
            var amountText = {"amountText": amount.value};

            viewServicePage.phoneText = firstFieldInput.value;
            viewServicePage.amountText = amount.value;


            event.preventDefault();
            event.stopPropagation();
            this.riotTags.innerHTML = "<view-service-pincards>";
            riot.mount('view-service-pincards', [formtype, firstFieldId, firstFieldText, cardTypeId, amountText]);
        }

        goToPinCardViewFromTwo = function (nominal, cardId) {
            console.log("Nominal=", nominal, "cardId=", cardId);

            var formtype = {"formtype": scope.formType};
            var firstFieldId = {"firstFieldId": null};
            var firstFieldText = {"firstFieldText": null};
            var cardTypeId = {"cardTypeId": cardId};
            var amountText = {"amountText": nominal};

            event.preventDefault();
            event.stopPropagation();
            this.riotTags.innerHTML = "<view-service-pincards>";
            riot.mount('view-service-pincards', [formtype, firstFieldId, firstFieldText, cardTypeId, amountText]);
        }


    </script>
</view-service-page>
