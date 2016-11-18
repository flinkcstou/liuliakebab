<component-bank-operations>
  <div class="bank-operations">
    <div class="bank-operation-button" onclick="{goToPayView}">
      <div class="bank-operation-icon operation-pay-icon">
      </div>
      <div class="bank-operation-label">ОПЛАТА</div>
    </div>

    <div class="bank-operation-button" onclick="{goToTransferView}">
      <div class="bank-operation-icon operation-transfer-icon">
      </div>
      <label class="bank-operation-label">ПЕРЕВОДЫ</label>
    </div>

    <div class="bank-operation-button" onclick="{goToAutoPayView}">
      <div class="bank-operation-icon operation-autopay-icon">
      </div>
      <label class="bank-operation-label">АВТОПЛАТЕЖ</label>
    </div>

    <div class="bank-operation-button" onclick="{goToMyFinanceView}">
      <div class="bank-operation-icon operation-myFinance-icon">
      </div>
      <label class="bank-operation-label">МОИ ФИНАНСЫ</label>
    </div>

    <div class="bank-operation-button" onclick="{goToReportView}">
      <div class="bank-operation-icon operation-report-icon">
      </div>
      <label class="bank-operation-label">ОТЧЁТ</label>
    </div>
  </div>

  <script>
    goToPayView(e)
    {
      document.getElementById('riotTags').innerHTML = "<view-pay></view-pay>";
      this.unmount();
      riot.mount('view-pay');
    }

    goToTransferView(e)
    {
      document.getElementById('riotTags').innerHTML = "<view-transfer></view-transfer>";
      this.unmount();
      riot.mount('view-transfer');
    }

    goToAutoPayView(e)
    {
      document.getElementById('riotTags').innerHTML = "<view-auto-pay></view-auto-pay>";
      this.unmount();
      riot.mount('view-auto-pay');
    }

    goToMyFinanceView(e)
    {
      document.getElementById('riotTags').innerHTML = "<view-my-finance></view-my-finance>";
      this.unmount();
      riot.mount('view-my-finance');
    }

    goToReportView(e)
    {
      document.getElementById('riotTags').innerHTML = "<view-report></view-report>";
      this.unmount();
      riot.mount('view-report');
    }
  </script>
</component-bank-operations>