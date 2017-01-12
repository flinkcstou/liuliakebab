<view-service-page class="view-service-page">

    <div class="page-title">
        <p class="pay-name-title">{titleName}</p>
        <p class="servicepage-category-field">{categoryName}</p>
        <div id="backButton" ontouchstart="touchStartTitle()"
             class="back-button">
        </div>
        <div id="rightButton" type="button" class="search-button" style="background-image: url({serviceIcon})"></div>
    </div>


    <script>

        var scope = this;
        touchStartTitle = function () {
            event.preventDefault();
            event.stopPropagation();

            this.riotTags.innerHTML = "<view-pay>";
            riot.mount('view-pay');
        }

        scope.servicesMap = JSON.parse(localStorage.getItem("servicesMap"));
        var serviceId = localStorage.getItem('chosenServiceId');
        scope.service = scope.servicesMap[serviceId][0];


        this.titleName = scope.service.name;
        this.serviceIcon = scope.service.image;


    </script>
</view-service-page>
