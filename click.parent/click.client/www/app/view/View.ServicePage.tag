<view-service-page class="view-service-page">
    <div class="page-title" style="border-style: none;">
        <p class="servicepage-title">{titleName}</p>
        <p class="servicepage-category-field">{categoryName}</p>
        <div ontouchstart="touchStartTitle()"
             class="servicepage-button-back">
        </div>
        <div type="button" class="servicepage-service-icon"
             style="background-image: url({serviceIcon})"></div>
    </div>

    <div class="servicepage-body-container" if="{formType==1}">
        <div class="servicepage-phone-field" each="{i in fieldArray}">
            <p class="servicepage-text-field">{i.title}</p>
            <input type="text" value="+998" id="phone"></input>
            <div class="servicepage-phone-icon"></div>
        </div>
        <div class="servicepage-amount-field">
            <p class="servicepage-text-field">Сумма оплаты</p>
            <input type="number" value="0" id="amount"></input>
            <div class="servicepage-amount-icon"></div>
        </div>
        <div class="servicepage-button-enter" ontouchend="choosePinCard()">
            <div class="button-enter-label">ДАЛЕЕ</div>
        </div>
    </div>
    <script>

        var scope = this;
        touchStartTitle = function () {
            event.preventDefault();
            event.stopPropagation();

            this.riotTags.innerHTML = "<view-pay>";
            riot.mount('view-pay');
        }

        history.arrayOfHistory.push('view-pay');
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));

        scope.servicesMap = JSON.parse(localStorage.getItem("click_client_servicesMap"));
        scope.categoryNamesMap = JSON.parse(localStorage.getItem("click_client_categoryNamesMap"));
        console.log("services map =", scope.servicesMap);
        scope.servicesParamsMapOne = JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"));
        scope.servicesParamsMapTwo = JSON.parse(localStorage.getItem("click_client_servicesParamsMapTwo"));
        //var serviceId = localStorage.getItem('chosenServiceId');
        console.log("service id=", viewPay.chosenServiceId);

        scope.service = scope.servicesMap[viewPay.chosenServiceId][0];

        console.log("Service data: ", scope.service);
        console.log("category id ", viewPay.categoryId);
        console.log("Map One", scope.servicesParamsMapOne);
        console.log("Map Two", scope.servicesParamsMapTwo);
        console.log("category name =", scope.categoryNamesMap[viewPay.categoryId]);


        this.titleName = scope.service.name;
        this.serviceIcon = scope.service.image;
        this.categoryName = scope.categoryNamesMap[viewPay.categoryId];
        this.formType = scope.service.form_type;
        this.fieldName = scope.servicesParamsMapOne[viewPay.chosenServiceId][0].title;
        this.fieldArray = scope.servicesParamsMapOne[viewPay.chosenServiceId];
        console.log("form type", scope.formType);


        choosePinCard = function () {
            viewServicePage.phoneText = document.getElementById('phone').value;
            viewServicePage.amountText = document.getElementById('amount').value;
            event.preventDefault();
            event.stopPropagation();
            this.riotTags.innerHTML = "<view-service-pincards>";
            riot.mount('view-service-pincards');
        }


    </script>
</view-service-page>
