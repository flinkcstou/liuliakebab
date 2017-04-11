<view-news id="viewNewsId" class="view-news">
  <div class="view-news-page-title">
    <p class="view-news-name-title">УВЕДОМЛЕНИЯ</p>
    <div id="backButton" ontouchend="goToBack()" class="view-news-back-button"></div>
  </div>

  <div class="view-news-container">

    <div class="view-news-block" each="{i in newsArray}">
      <p class="view-news-block-title">{i.news_title}</p>
      <p class="view-news-block-text">{i.content_short}</p>

      <p class="view-news-block-date">{i.datetime}</p>
      <div class="view-news-block-readmore-container">Подробнее
      <div class="view-news-block-readmore-icon"></div>
      </div>
    </div>
  </div>

  <script>
    var scope = this;
    scope.newsArray = []

    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    var sessionKey = info.session_key;

    var text = "Приятная новость в преддверии праздника Навруз для всех пользователей системы CLICK! С огромной радостью сообщаем, что"
    console.log('LENGTH', text.length)
    window.api.call({
      method: 'get.news',
      input: {
        phone_num: phoneNumber,
        session_key: sessionKey,

      },

      scope: this,

      onSuccess: function (result) {
        if (result[0][0].error == 0) {
          console.log("NEWS", result);
          for (var i in result[1]) {
            if (result[1][i].news_content_short.length > 120) {
              result[1][i].content_short = result[1][i].news_content_short.substring(0, 120) + '...';
            }
            scope.newsArray.push(result[1][i])
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


  </script>
</view-news>
