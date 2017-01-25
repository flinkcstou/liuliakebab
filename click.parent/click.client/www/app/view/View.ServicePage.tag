<view-service-page class="view-service-page">
    <div class="page-title" style="border-style: none;">
        <p class="servicepage-title">{titleName}</p>
        <p class="servicepage-category-field">{categoryName}</p>
        <div ontouchend="touchStartTitle()"
             class="servicepage-button-back">
        </div>
        <div type="button" class="servicepage-service-icon"
             style="background-image: url({serviceIcon})"></div>
    </div>

    <div class="servicepage-body-container" if="{formType==1}">
        <div class="servicepage-phone-field" each="{i in fieldArray}" id="phoneField{i.service_id}">
            <p class="servicepage-text-field">{i.title}</p>
            <p class="servicepage-number-first-part">+998</p>
            <input class="servicepage-number-input-part" type="tel"
                   maxlength="9"
                   id="{i.service_id}" onfocus="bordersColor(this.id)"
                   value="{defaultNumber}"/>
            <div class="servicepage-phone-icon"></div>
        </div>
        <div class="servicepage-amount-field" id="amountField">
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
    <div class="servicepage-body-container" if="{formType==2}">
        <div class="servicepage-pincards-container" each="{i in pincardIds}">
            <div class="servicepage-pincard-title">{pincardsMap[i][0].name}</div>
            <div class="servicepage-pincard-nominal-container" each="j in pincardsMap[i]">
                <p class="servicepage-pincard-nominal-value">{j.nominal} сум</p>
                <div class="servicepage-pincard-choose-arrow"></div>
            </div>
        </div>
    </div>
    <script>
        if(history.arrayOfHistory[history.arrayOfHistory.length - 1] != 'view-service-page') {
            history.arrayOfHistory.push('view-service-page');
            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
        }

        var scope = this;
        touchStartTitle = function () {
            viewServicePage.phoneText = null;
            viewServicePage.amountText = null;
            event.preventDefault();
            event.stopPropagation();
            onBackKeyDown()
        }

        scope.servicesMap = JSON.parse(localStorage.getItem("click_client_servicesMap"));
        scope.categoryNamesMap = JSON.parse(localStorage.getItem("click_client_categoryNamesMap"));
        scope.servicesParamsMapOne = JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"));
        //        scope.servicesParamsMapTwo = JSON.parse(localStorage.getItem("click_client_servicesParamsMapTwo"));


        scope.service = scope.servicesMap[viewPay.chosenServiceId][0];
        scope.defaultAmount = !viewServicePage.amountText ? 0 : viewServicePage.amountText;
        scope.defaultNumber = !viewServicePage.phoneText ? null : viewServicePage.phoneText;

        this.titleName = scope.service.name;
        this.serviceIcon = scope.service.image;
        this.categoryName = scope.categoryNamesMap[viewPay.categoryId];
        this.formType = scope.service.form_type;

        if (this.formType == 1) {
            this.fieldName = scope.servicesParamsMapOne[viewPay.chosenServiceId][0].title;
            this.fieldArray = scope.servicesParamsMapOne[viewPay.chosenServiceId];
            this.amountLength = ("" + scope.service.max_pay_limit).length;
        }
        if (this.formType == 2) {
            scope.servicesParamsMapThree = JSON.parse(localStorage.getItem("click_client_servicesParamsMapThree"));
//            console.log(scope.servicesParamsMapThree);
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
//            console.log("pincardsMap", scope.pincardsMap);
//            console.log("pincardIds", scope.pincardIds);

        }

        //console.log(this.fieldArray);
//        console.log("form type", scope.formType);

        scope.focusedFieldId = -1;

        eraseAmountDefault = function () {
            document.getElementById('amountField').style.borderBottom = 5 * widthK + 'px solid #01cfff';
            if (scope.focusedFieldId != -1)
                document.getElementById("phoneField" + scope.focusedFieldId).style.borderBottom = 5 * widthK + 'px solid lightgrey';
            if (document.getElementById('amount').value == '0')
                document.getElementById('amount').value = null;
        }

        bordersColor = function (id) {
//            console.log("ID", id);
            if (scope.focusedFieldId != id && scope.focusedFieldId != -1) {
                document.getElementById("phoneField" + scope.focusedFieldId).style.borderBottom = 5 * widthK + 'px solid lightgrey';
//                console.log("as previous");
            }
            document.getElementById("phoneField" + id).style.borderBottom = 5 * widthK + 'px solid #01cfff';
            document.getElementById('amountField').style.borderBottom = 5 * widthK + 'px solid lightgrey';
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


    </script>
</view-service-page>
