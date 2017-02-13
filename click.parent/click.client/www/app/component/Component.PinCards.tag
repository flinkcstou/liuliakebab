<component-pincards>

    <div class="pincard-allcards-container">
        <div class="pincard-card-container" each="{i in cardsArray}" ontouchend="chooseCard(this.id)"
             id="{i.card_id}" if="{i.access == 2}">
            <div class="pincard-card-logo-container" if="{i.salary>0}"
                 style="background-image: url({i.url})"></div>
            <div class="pincard-card-logo-container" if="{i.salary<=0}"
                 style="opacity:0.3; filter: grayscale(100%);background-image: url({i.url})"></div>
            <div class="pincard-card-info-container">
                <p class="pincard-card-info-text-one">{i.name}</p>
                <p class="pincard-card-info-text-two" if="{i.salary>0}">{i.salary} {i.currency}</p>
                <p class="pincard-card-info-text-two" style="color: #EB604D" if="{i.salary<=0}">
                    0 {i.currency}</p>
                <p class="pincard-card-info-text-three">{i.numberPartOne} **** {i.numberPartTwo}</p>
            </div>
            <div id="check{i.card_id}"
                 class="{pincard-card-uncheckmark: 'check'+i.card_id != checkedId, pincard-card-checkmark:'check'+i.card_id == checkedId}">
            </div>
        </div>
    </div>

    <script>
        var scope = this;

        scope.cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
        scope.checked = false;

        console.log(' scope.cardsArray', scope.cardsArray)

        for (var i in scope.cardsArray) {
            if (scope.cardsArray[i].chosenCard == true && scope.cardsArray[i].access == 2) {
                scope.checkedId = "check" + scope.cardsArray[i].card_id;
            }
        }


        chooseCard = function (id) {
            scope.checkedId = "check" + id;
            riot.update(scope.checkedId);

            for (var i in scope.cardsArray) {
                if (scope.cardsArray[i].card_id == id && scope.cardsArray[i].access == 2) {
                    scope.cardsArray[i].chosenCard = true;

                }
                else
                    scope.cardsArray[i].chosenCard = false;
            }

            localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsArray))
            riot.update(scope.cardsArray)

        }


    </script>
</component-pincards>