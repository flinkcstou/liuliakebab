<view-news id="viewNewsId" class="view-news">
  <div class="view-news-page-title">
    <p class="view-news-name-title">УВЕДОМЛЕНИЯ</p>
    <div id="closeButton" ontouchend="closeNewsTouchEnd()" class="view-news-right-button"></div>
  </div>

  <div class="view-news-container">

    <div class="view-news-block-of-all" each="{i in newsArray}">

      <div id="newsImageId{i.news_id}" hidden="true"
           class="view-news-block-image" style="background-image: url({i.news_image})"></div>

      <div class="view-news-block" shorttext="{i.content_short}" opened="false" title="{i.news_content}"
           id="newsContainerId{i.news_id}"
           ontouchstart="newsTouchStart()"
           ontouchend="newsTouchEnd(this.id, 'newsTextId' + {i.news_id}, this.title, document.getElementById(this.id).getAttribute('shorttext'), 'newsImageId'+{i.news_id})">
        <p class="view-news-block-title">{i.news_title}</p>
        <p id="newsTextId{i.news_id}" class="view-news-block-text">{i.content_short}</p>

        <p class="view-news-block-date">{i.datetime}</p>
        <div style="display: none" class="view-news-block-readmore-container">Подробнее
          <div class="view-news-block-readmore-icon"></div>
        </div>
      </div>
    </div>
    <div class="view-news-block-space"></div>
  </div>

  <script>
    var scope = this;
    scope.newsArray = []

    this.on('mount', function () {

    })


    closeNewsTouchEnd = function () {
      event.preventDefault()
      event.stopPropagation()

      onBackKeyDown()
      scope.unmount()
    }

    var touchStartY, touchEndY;

    newsTouchStart = function () {
      touchStartY = event.changedTouches[0].pageY;
    }

    newsTouchEnd = function (containerId, textId, longText, shortText, imageId) {
      event.preventDefault()
      event.stopPropagation()

      touchEndY = event.changedTouches[0].pageY;


      if (Math.abs(touchStartY - touchEndY) <= 20) {

        if (JSON.parse(document.getElementById(containerId).getAttribute('opened')) === false) {
          document.getElementById(containerId).setAttribute('opened', true)
          document.getElementById(imageId).style.display = 'block'
          document.getElementById(containerId).style.height = 'auto';
          document.getElementById(textId).innerHTML = longText;
        }
        else {
          document.getElementById(containerId).style.height = '27%';
          document.getElementById(imageId).style.display = 'false'
          document.getElementById(imageId).style.display = 'none'
          document.getElementById(textId).innerHTML = shortText;
          document.getElementById(containerId).setAttribute('opened', false)
        }

        riot.update()
      }
      else
        return
    }

    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    if (info)
      var sessionKey = info.session_key;

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
              if (result[1][i].news_image) {
                result[1][i].image_exist = true;
              }
              else {
                result[1][i].image_exist = false;
              }
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
