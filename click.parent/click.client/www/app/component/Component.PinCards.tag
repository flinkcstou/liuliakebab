<component-pincards>

    <div class="pincard-allcards-container">
        <div class="pincard-card-container" each="{i in cardsArrayTwo}" ontouchend="chooseCard(this.id)"
             id="{i.card_id}">
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
            <div class="{pincard-card-uncheckmark: !i.chosenCard, pincard-card-checkmark: i.chosenCard}"
                 id="check{i.card_id}">
            </div>
        </div>
    </div>

    <script>
        var scope = this;

        var cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
        scope.cardsArrayTwo = [];

        for (var i in cardsArray) {
            if (cardsArray[i].access == 2) {
                scope.cardsArrayTwo.push(cardsArray[i]);
            }
        }
        console.log('AAAAAAAAAAAAAAa', cardsArray)
        riot.update(scope.cardsArrayTwo);


        scope.checked = false;

        chooseCard = function (id) {
            if (cardsArray[id]) {
                scope.checked = true;
                cardsArray[id].chosenCard = true;
            }

            localStorage.setItem('click_client_cards', JSON.stringify(cardsArray))
            riot.update(document.getElementById("check" + id))
        }


    </script>
</component-pincards>