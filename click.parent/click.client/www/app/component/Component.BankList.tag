<component-bank-list id="componentBankListId" class="component-bank-list">
  <div class="page-title" style="border: none;">
    <p class="component-banklist-name-title">{window.languages.ViewBankListTitleName}</p>
    <div id="rightButton" type="button" class="component-banklist-close-button" ontouchend="closeComponent()"></div>
  </div>

  <div class="component-banklist-container">
    <div class="component-banklist-card" each="{i in bankList}">

      <div class="component-banklist-bank-logo" style="background-image: url({i.image});"></div>

      <div class="component-banklist-bank-limit-container">
        <div class="component-banklist-bank-limit-text">{window.languages.ViewBankListLimitText}</div>
        <div class="component-banklist-bank-limit">{i.amount}</div>
        <div class="component-banklist-bank-limit-currency">{window.languages.ViewBankListLimitForMonthText}</div>
      </div>

    </div>
  </div>

  <script>
    //THIS COMPONENT IS NOT IN USE
    var scope = this;

//    if (JSON.parse(localStorage.getItem("click_client_p2p_bank_list"))) {
//      scope.bankList = JSON.parse(localStorage.getItem("click_client_p2p_bank_list"));
//      console.log("bank list", scope.bankList);
//      riot.update(scope.bankList);
//    }


    closeComponent = function () {
      event.preventDefault();
      event.stopPropagation();
      componentBankListId.style.display = 'none';
    }

  </script>
</component-bank-list>