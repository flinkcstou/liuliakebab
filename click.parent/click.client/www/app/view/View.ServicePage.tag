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
            <p class="servicepage-number-first-part" if="{phoneFieldBool}">+998</p>
            <input class="servicepage-number-input-part" type="tel"
                   maxlength="9" onfocus="bordersColor()"
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
                <p class="servicepage-dropdown-text-field" style="left: 8%">{i.title}</p>
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
        this.formType = scope.service.form_type;
        viewServicePage.formType = this.formType;
        scope.fieldArray = scope.servicesParamsMapOne[viewPay.chosenServiceId];


        if (this.formType == 1) {
            this.dropDownOn = scope.fieldArray.length > 1;
            console.log("fiedArray length bool=", this.dropDownOn);
            if (!this.dropDownOn) {
                this.chosenFieldName = scope.fieldArray[0].title;
                this.phoneFieldBool = scope.fieldArray[0].parameter_id == "1";
            }
            else {
                this.chosenFieldName = scope.fieldArray[0].title;
            }
            this.amountLength = ("" + scope.service.max_pay_limit).length;
//            console.log("fieldArray", fieldArray);
        }


        if (this.formType == 2) {
            scope.servicesParamsMapThree = JSON.parse(localStorage.getItem("click_client_servicesParamsMapThree"));
            console.log(scope.servicesParamsMapThree);
            scope.pincardsMap = {};
            scope.pincardIds = [];
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


        openDropDown = function () {
//            this.firstFieldChoiceId.style.display = 'none';
            this.blockFirstFieldId.style.display = 'block';

        }

        chooseFirstField = function (id) {
            this.blockFirstFieldId.style.display = 'none';
            console.log("chosen param id=", +id);
            for (var i = 0; i < scope.fieldArray.length; i++) {
                console.log("parame_id=", scope.fieldArray[i].parameter_id);
                if (scope.fieldArray[i].parameter_id == id) {
                    scope.chosenFieldName = scope.fieldArray[i].title;
                    console.log("new title", scope.chosenFieldName);
                    riot.update(scope.chosenFieldName);
                    break;
                }
            }

        }


        scope.focusedFieldId = -1;

        eraseAmountDefault = function () {
            document.getElementById('amountField').style.borderBottom = 5 * widthK + 'px solid #01cfff';
            if (scope.focusedFieldId != -1)
                document.getElementById("phoneField" + scope.focusedFieldId).style.borderBottom = 5 * widthK + 'px solid lightgrey';
            if (document.getElementById('amount').value == '0')
                document.getElementById('amount').value = null;
        }

        bordersColor = function () {
//            console.log("ID", id);
            if (scope.focusedFieldId != id && scope.focusedFieldId != -1) {
                firstField.style.borderBottom = 5 * widthK + 'px solid lightgrey';
//                console.log("as previous");
            }
            firstField.style.borderBottom = 5 * widthK + 'px solid #01cfff';
            amountField.style.borderBottom = 5 * widthK + 'px solid lightgrey';
            scope.focusedFieldId = id;
        }

        goToPinCardView = function () {
            if (scope.focusedFieldId == -1)
                scope.focusedFieldId = viewPay.chosenServiceId;

            if (document.getElementById(scope.focusedFieldId).value.length < 9) {
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
            viewServicePage.phoneText = document.getElementById(scope.focusedFieldId).value;
            viewServicePage.amountText = document.getElementById('amount').value;

            event.preventDefault();
            event.stopPropagation();
            this.riotTags.innerHTML = "<view-service-pincards>";
            riot.mount('view-service-pincards');
        }

        goToPinCardViewFromTwo = function () {
            viewServicePage.amountText = document.getElementById('amount').value;
            event.preventDefault();
            event.stopPropagation();
            this.riotTags.innerHTML = "<view-service-pincards>";
            riot.mount('view-service-pincards');
        }


    </script>
</view-service-page>
