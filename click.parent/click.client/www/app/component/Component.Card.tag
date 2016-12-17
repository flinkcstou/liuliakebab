<component-card class="card" style="background-image: url({opts.background}); left:{270*opts.countcard+50}px">

  <div class="card-bank-name-url" style="background-image: url({opts.url})"></div>
  <div class="card-bank-name" style="background-image: url({opts.bankname})"></div>
  <div class="card-salary-title">{opts.name}</div>

  <div class="card-balance-currency-container">
    <p class="card-balance">{opts.salary}</p>
    <p class="card-currency">{opts.currency}</p>
  </div>

  <div class="card-number">
  <div class="card-number-part-one">{opts.numberpartone}</div>
  <p class="number-stars">**** ****</p>
  <div class="card-number-part-two">{opts.numberparttwo}</div>
  </div>

  <script>
    var scope = this;
  console.log(opts.numberpartone)

  </script>
</component-card>