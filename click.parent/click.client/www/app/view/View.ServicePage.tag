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


    <div class="servicepage-body-container" if="{formType==1}">
        <div class="servicepage-fields-dropdown" if="{dropDownOn}" ontouchend="openDropDown()" id="firstFieldChoiceId">
            <p class="servicepage-dropdown-text-field">{chosenFieldName}</p></div>
        <div class="servicepage-first-field" id="firstField">
            <p class="servicepage-text-field">{chosenFieldName}</p>
            <p class="servicepage-number-first-part" if="{phoneFieldBool}">+{window.languages.CodeOfCountry}</p>
            <input class="{servicepage-number-input-part: phoneFieldBool, servicepage-number-input-part-two: !phoneFieldBool && isNumber,
                           servicepage-number-input-part-three: !phoneFieldBool && !isNumber}"
                   type="{inputType}"
                   id="firstFieldInput"
                   maxlength="{inputMaxLength}" onfocus="bordersColor()"
                   value="{defaultNumber}"/>
            <div class="servicepage-phone-icon" if="{phoneFieldBool}"></div>
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


    <div class="servicepage-body-container" if="{formType==2}">
        <div class="servicepage-pincards-container" each="{i in pincardIds}">
            <div class="servicepage-pincard-title">{pincardsMap[i][0].name}</div>
            <div class="servicepage-pincard-nominal-container" each="{j in pincardsMap[i]}"
                 ontouchend="goToPinCardViewFromTwo()">
                <p class="servicepage-pincard-nominal-value">{j.nominal} сум</p>
                <div class="servicepage-pincard-choose-arrow"></div>
            </div>
        </div>
    </div>
    <script>
        if (history.arrayOfHistory[history.arrayOfHistory.length - 1] != 'view-service-page') {
            history.arrayOfHistory.push('view-service-page');
            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
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
        //        scope.servicesParamsMapTwo = JSON.parse(localStorage.getItem("click_client_servicesParamsMapTwo"));


        scope.service = scope.servicesMap[viewPay.chosenServiceId][0];
        scope.defaultAmount = !viewServicePage.amountText ? 0 : viewServicePage.amountText;
        scope.defaultNumber = !viewServicePage.phoneText ? null : viewServicePage.phoneText;

        this.titleName = scope.service.name;
        this.serviceIcon = scope.service.image;
        this.categoryName = scope.categoryNamesMap[viewPay.categoryId];
        scope.formType = scope.service.form_type;
        console.log("formType=" + this.formType);
        viewServicePage.formType = this.formType;
        scope.fieldArray = scope.servicesParamsMapOne[viewPay.chosenServiceId];
        console.log("fieldArray=", scope.fieldArray);


        if (scope.formType == 1) {
            if (scope.fieldArray) {
                this.dropDownOn = scope.fieldArray.length > 1;
                console.log("fiedArray length bool=", this.dropDownOn);
                scope.chosenFieldName = scope.fieldArray[0].title;
                scope.phoneFieldBool = scope.fieldArray[0].parameter_id == "1";
                if (this.dropDownOn) {
                    scope.chosenFieldParamId = scope.fieldArray[0].parameter_id;
                    scope.oldFieldParamId = scope.fieldArray[1].parameter_id;
                }
                if (scope.fieldArray[0].input_type == '1') {
                    scope.inputType = 'tel';
                    scope.inputMaxLength = scope.fieldArray[0].max_len.length;
                    scope.isNumber = true;
                }
                else if (scope.fieldArray[0].input_type == '2') {
                    scope.inputType = 'text';
                    scope.inputMaxLength = scope.fieldArray[0].max_len;
                    scope.isNumber = false;
                }
                this.amountLength = ("" + scope.service.max_pay_limit).length;
            }
        }


        if (scope.formType == 2) {
            scope.servicesParamsMapThree = JSON.parse(localStorage.getItem("click_client_servicesParamsMapThree"));
            console.log(scope.servicesParamsMapThree);
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
            document.getElementById('text' + scope.oldFieldParamId).style.color = '#8a8a8a';
            document.getElementById(scope.chosenFieldParamId).style.backgroundColor = '#0084E6';
            document.getElementById('text' + scope.chosenFieldParamId).style.color = 'white';
        }

        chooseFirstField = function (id) {
            this.blockFirstFieldId.style.display = 'none';
            console.log("chosen param id=", +id);
            for (var i = 0; i < scope.fieldArray.length; i++) {
                console.log("parame_id=", scope.fieldArray[i].parameter_id);
                if (scope.fieldArray[i].parameter_id == id) {
                    scope.chosenFieldName = scope.fieldArray[i].title;
                    scope.phoneFieldBool = scope.fieldArray[i].parameter_id == "1";
                    if (scope.fieldArray[i].input_type == '1') {
                        scope.inputType = 'tel';
                        scope.inputMaxLength = scope.fieldArray[0].max_len.length;
                        scope.isNumber = true;
                    }
                    else if (scope.fieldArray[i].input_type == '2') {
                        scope.inputType = 'text';
                        scope.inputMaxLength = scope.fieldArray[0].max_len;
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
            viewServicePage.phoneText = firstFieldInput.value;
            viewServicePage.amountText = amount.value;

            event.preventDefault();
            event.stopPropagation();
            this.riotTags.innerHTML = "<view-service-pincards>";
            riot.mount('view-service-pincards');
        }

        goToPinCardViewFromTwo = function () {
            viewServicePage.amountText = amount.value;
            event.preventDefault();
            event.stopPropagation();
            this.riotTags.innerHTML = "<view-service-pincards>";
            riot.mount('view-service-pincards');
        }


    </script>
</view-service-page>
