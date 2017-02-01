<view-transfer-stepthree>
    <div class="transfer-page-title">
        <p class="transfer-name-title">{titleName}</p>
        <div id="backButton" ontouchend="goToBack()" class="{transfer-back-button: backbuttoncheck}"></div>
        <div id="rightButton" type="button" class="{transfer-i-button: rightbuttoncheck}"></div>
    </div>

    <div class="transferthree-body-container">
        <div class="transferthree-menus-container">
            <p id="cardLabelId" class="transferthree-menu-name-label">{window.languages.ViewTransferThreeMenuTitle}</p>
        </div>
        <component-pincards></component-pincards>

        <div class="transferthree-next-button-inner-container" ontouchend="goToTransferFour()">
            <p class="transferthree-next-button-label">ДАЛЕЕ</p>
        </div>

    </div>


    <script>
        console.log(opts)
        var arrayForTransfer = [];
        arrayForTransfer.push(opts[0])
        arrayForTransfer.push(opts[1])
        arrayForTransfer.push(opts[2])
        console.log(arrayForTransfer)
        var transferTitle;

        var objectForTransfer = opts[0];

        if (objectForTransfer.type == 1) {
            transferTitle = objectForTransfer.name.substring(0, 4) + ' **** ' + objectForTransfer.name.substring(15, objectForTransfer.name.length)
        }
        else
            transferTitle = objectForTransfer.name;

        this.titleName = window.languages.ViewTransferThreeTitle + ' ' + transferTitle;

        if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-transfer-stepthree') {
            history.arrayOfHistory.push(
                    {
                        "view": 'view-transfer-stepthree',
                        "params": opts
                    }
            );
            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
        }
        var checkChosenCard = false;
        var chosenCard;

        goToBack = function () {
            event.preventDefault();
            event.stopPropagation();
            onBackKeyDown()
        }

        scope = this;
        scope.backbuttoncheck = true;
        scope.rightbuttoncheck = false;


        goToTransferFour = function () {
            var cards = JSON.parse(localStorage.getItem('click_client_cards'));
            event.preventDefault()
            event.stopPropagation()
            console.log(cards)
            for (var i in cards) {
                if (cards[i].chosenCard === true) {
                    console.log(cards[i])
                    checkChosenCard = true;
                    chosenCard = cards[i]
                    break;
                }
            }
            if (checkChosenCard) {
                arrayForTransfer.push(chosenCard)
                this.riotTags.innerHTML = "<view-transfer-stepfour>";
                riot.mount('view-transfer-stepfour', [arrayForTransfer]);
            }
            else
                alert('choose card')
        }


    </script>
</view-transfer-stepthree>
