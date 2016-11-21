<view-auto-pay>
  <h1>AUTO PAY VIEW</h1>
  <button onclick="{call}"> CALL</button>

  <script>
    call()
    {
      document.getElementById('riotTags').innerHTML = "<view-authorization></view-authorization> ";
      riot.mount('view-authorization');
    }

  </script>
</view-auto-pay>
