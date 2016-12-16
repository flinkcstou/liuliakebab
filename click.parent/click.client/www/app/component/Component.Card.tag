<component-card class="card" style="background-image: url({opts.background}); left:{260*opts.countcard+60}px">

  <div class="card-bank-name-url" style="background-image: url({opts.url})"></div>
  <div class="card-bank-name" style="background-image: url({opts.bankname})"></div>
  <div class="card-salary-title">{opts.name}</div>
  <div class="card-balance">{opts.salary}</div>
  <div class="card-currency">{opts.currency}</div>
  <div class="card-number card-number-part-one">{opts.numberpartone}</div>
  <p class="card-number number-stars">****&nbsp&nbsp&nbsp****</p>
  <div class="card-number card-number-part-two">{opts.numberparttwo}</div>


  <script>
    var scope = this;
  console.log(opts.numberpartone)

  </script>
</component-card>