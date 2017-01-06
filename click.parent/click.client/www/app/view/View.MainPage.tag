<view-main-page>
    <component-menu></component-menu>
    <div id="mainPageId" class="view-main-page">
        <component-toolbar></component-toolbar>
        <component-bank-operations></component-bank-operations>
        <component-service-carousel></component-service-carousel>
        <component-footer></component-footer>
        <component-card-carousel></component-card-carousel>
    </div>
    <script>

        var scope = this;
        localStorage.setItem('cardNumber', 0);
        history.arrayOfHistory.push('view-main-page');
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

        viewMainPage.myCards = false;

    </script>
</view-main-page>

