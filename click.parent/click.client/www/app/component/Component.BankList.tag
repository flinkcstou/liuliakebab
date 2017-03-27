<component-bank-list id="componentBankListId" class="component-bank-list">
  <div class="page-title" style="border: none;">
    <p class="component-banklist-name-title">{titleName}</p>
    <div id="rightButton" type="button" class="close-button" ontouchend="closeComponent()"></div>
  </div>

  <div class="component-banklist-container">
    <div class="component-banklist-card" each="{i in bankList}"
         ontouchend="goToCardPage({i.card_id})">

      <div class="mycardlist-card-bank-name" style="background-image: url({i.image});"></div>
      <div class="mycardlist-card-salary-title">{i.bank_name}</div>

      <div class="mycardlist-card-balance-currency-container">
        <p class="mycardlist-card-balance">{i.code}</p>
        <p class="mycardlist-card-currency">{i.code}</p>
      </div>
    </div>
  </div>

  <script>
    var scope = this;
    this.titleName = window.languages.ViewBankListTitleName;

    scope.bankList = JSON.parse(localStorage.getItem("click_client_p2p_bank_list"));
    console.log("bank list", scope.bankList);
    riot.update(scope.bankList);

    closeComponent = function () {
      event.preventDefault();
      event.stopPropagation();
      componentBankListId.style.display = 'none';
    }

  </script>
</component-bank-list>