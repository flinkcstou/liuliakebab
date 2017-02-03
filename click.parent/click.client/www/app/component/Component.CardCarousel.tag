<component-card-carousel>

    <div id="containerCard" class="card-carousel" ontouchend="endTouchCarousel()" ontouchmove="moveTouchCarousel()"
         ontouchstart="startTouchCarousel()">
        <div id="cards" class="cards">
            <component-card each="{i in cardsarray}"
                            countcard="{i.countCard}"
                            name="{i.name}" salary="{i.salary}" currency="{i.currency}"
                            numberpartone="{i.numberPartOne}"
                            numberparttwo="{i.numberPartTwo}"
                            bankname="{i.bankName}" url="{i.url}"
                            background="{i.background}"></component-card>
        </div>
    </div>

    <script>

        this.on('mount', function () {
            var firstCardNumber = JSON.parse(localStorage.getItem('cardNumber'))
            cards.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
            cards.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
            cards.style.transform = "translate3d(" + (-firstCardNumber * 540) * widthK + 'px' + ", 0, 0)";
            cards.style.webkitTransform = "translate3d(" + (-firstCardNumber * 540) * widthK + 'px' + ", 0, 0)";

            writeBalance();
        })


        writeBalance = function () {
            for (var i = 0; i < getAccountsCards.length; i++) {
                window.api.call({
                    method: 'get.balance',
                    input: {
                        session_key: sessionKey,
                        phone_num: phoneNumber,
                        account_id: getAccountsCards[i].id,
                        card_num_hash: getAccountsCards[i].card_num_hash,
                        card_num_crypted: getAccountsCards[i].card_num_crypted
                    },
                    //TODO: DO CARDS
                    scope: this,
                    onSuccess: function (result) {
                        if (result[0][0].error == 0) {
                            if (result[1][0]) {

                                cardsarray[result[1][0].account_id].salary = result[1][0].balance;
                                localStorage.setItem('click_client_cards', JSON.stringify(cardsarray));
                                riot.update();
                            }
                        }
                        else
                            alert(result[0][0].error_note);
                    },

                    onFail: function (api_status, api_status_message, data) {
                        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                        console.error(data);
                    }
                });
            }
        }

        var scope = this;
        var getAccountsCards = JSON.parse(localStorage.getItem('click_client_accountInfo'));

        var phoneNumber = localStorage.getItem("click_client_phoneNumber");
        var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
        var sessionKey = info.session_key;

        var carouselTouchStartX, carouselTouchEndX;
        cardsarray = JSON.parse(localStorage.getItem("click_client_cards"));

        if (!cardsarray) {
            cardsarray = {};
        }


        var card;
        var cardNumber = JSON.parse(localStorage.getItem('cardNumber'));


        if (!cardNumber) {
            cardNumber = 0;
        }


        var pos = 0;
        var count = localStorage.getItem('click_client_countCard');
        var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
        if (!count)
            count = 0;


        startTouchCarousel = function () {
            carouselTouchStartX = event.changedTouches[0].pageX;
            left = -((540 * cardNumber) * widthK) - carouselTouchStartX;
            delta = left;
        }

        endTouchCarousel = function () {
            event.preventDefault();
            event.stopPropagation();
            carouselTouchEndX = event.changedTouches[0].pageX;
            if (Math.abs(carouselTouchStartX - carouselTouchEndX) > 20) {
                changePosition();
            }
            else if (!viewMainPage.myCards) {
                pos = (cardNumber) * 540 * widthK;
                var sendChosenCardId;
                for (var i in cardsarray) {
                    if (cardsarray[i].countCard == cardNumber) {
                        cardsarray[i].chosenCard = true;
                        sendChosenCardId = cardsarray[i].card_id
                        localStorage.setItem('click_client_cards', JSON.stringify(cardsarray));
                    }
                    else {
                        cardsarray[i].chosenCard = false;
                    }
                }
                riotTags.innerHTML = "<view-my-cards>";
                riot.mount("view-my-cards", [sendChosenCardId]);
                this.cards.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
                this.cards.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
                this.cards.style.transform = "translate3d(" + (-pos) + 'px' + ", 0, 0)";
                this.cards.style.webkitTransform = "translate3d(" + (-pos) + 'px' + ", 0, 0)";
            }
            else
                changePosition()
        }

        moveTouchCarousel = function () {
            event.preventDefault();
            event.stopPropagation();
            this.cards.style.transition = '0s';
            this.cards.style.webkitTransition = '0s';
            this.cards.style.transform = "translate3d(" + (event.changedTouches[0].pageX + delta ) + 'px' + ", 0, 0)";
            this.cards.style.webkitTransform = "translate3d(" + (event.changedTouches[0].pageX + delta ) + 'px' + ", 0, 0)";
        }

        addCard(getAccountsCards)
        {
            var numberOfCardPartOne;
            var numberOfCardPartTwo;
            var typeOfCard;

            if (count == 0)
                for (var i = 0; i < getAccountsCards.length; i++) {


                    if (getAccountsCards[i].access == 0) break;
                    if (loginInfo.default_account == getAccountsCards[i].id)
                        var defaultAccount = true;
                    else
                        defaultAccount = false;

                    if (getAccountsCards[i].acc_abs.trim() == 'SMARTV')
                        typeOfCard = 'resources/icons/cards/typeOfCards/uzcard.png';
                    if (getAccountsCards[i].acc_abs.trim() == 'DUET')
                        typeOfCard = 'resources/icons/cards/typeOfCards/duet.png';

                    numberOfCardPartOne = getAccountsCards[i].accno[0] + getAccountsCards[i].accno[1]
                            + getAccountsCards[i].accno[2] + getAccountsCards[i].accno[3]
                    numberOfCardPartTwo = getAccountsCards[i].accno[getAccountsCards[i].accno.length - 4] + getAccountsCards[i].accno[getAccountsCards[i].accno.length - 3] + +getAccountsCards[i].accno[getAccountsCards[i].accno.length - 2] + getAccountsCards[i].accno[getAccountsCards[i].accno.length - 1];

                    card = {
                        card_id: getAccountsCards[i].id,
                        bankName: typeOfCard,
                        name: getAccountsCards[i].description,
                        salary: '',
                        currency: getAccountsCards[i].currency_name.trim(),
                        numberPartOne: numberOfCardPartOne,
                        numberPartTwo: numberOfCardPartTwo,
                        url: getAccountsCards[i].image_url,
                        background: getAccountsCards[i].background_url,
                        countCard: count,
                        chosenCard: false,
                        default_account: defaultAccount,
                        access: getAccountsCards[i].access
                    };


                    cardsarray[getAccountsCards[i].id] = card;
                    console.log(cardsarray)

                    localStorage.setItem("click_client_cards", JSON.stringify(cardsarray));

                    count++;
                    localStorage.setItem('click_client_countCard', count);
                    riot.mount("component-card");
                }
        }
        if (localStorage.getItem('click_client_accountInfo'))
            scope.addCard(getAccountsCards);

        function changePosition() {

            if (carouselTouchEndX < carouselTouchStartX && cardNumber < count - 1) {
                ++cardNumber;
                this.cards.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
                this.cards.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
                this.cards.style.transform = "translate3d(" + (-cardNumber * 540) * widthK + 'px' + ", 0, 0)";
                this.cards.style.webkitTransform = "translate3d(" + (-cardNumber * 540) * widthK + 'px' + ", 0, 0)";

            }

            if (carouselTouchEndX > carouselTouchStartX && cardNumber == 0) {
                this.cards.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
                this.cards.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
                this.cards.style.transform = "translate3d(" + (-cardNumber * 540) * widthK + 'px' + ", 0, 0)";
                this.cards.style.webkitTransform = "translate3d(" + (-cardNumber * 540) * widthK + 'px' + ", 0, 0)";
            }

            if (carouselTouchEndX < carouselTouchStartX && cardNumber == count - 1) {
                this.cards.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
                this.cards.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
                this.cards.style.transform = "translate3d(" + (-cardNumber * 540) * widthK + 'px' + ", 0, 0)";
                this.cards.style.webkitTransform = "translate3d(" + (-cardNumber * 540) * widthK + 'px' + ", 0, 0)";

            }

            if (carouselTouchEndX > carouselTouchStartX && cardNumber > 0) {
                --cardNumber;
                this.cards.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
                this.cards.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
                this.cards.style.transform = "translate3d(" + (-cardNumber * 540) * widthK + 'px' + ", 0, 0)";
                this.cards.style.webkitTransform = "translate3d(" + (-cardNumber * 540) * widthK + 'px' + ", 0, 0)";
            }

            localStorage.setItem('cardNumber', cardNumber);

            if (viewMainPage.myCards) {
                for (var i in cardsarray) {
                    if (cardsarray[i].countCard == cardNumber)
                        var sendChosenCardId = cardsarray[i].card_id
                }
                scope.parent.cardInformation(sendChosenCardId);
            }
        }


    </script>
</component-card-carousel>

