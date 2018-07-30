<view-news id="viewNewsId" class="view-news riot-tags-main-container">
  <div class="view-news-page-header">
    <p class="view-news-name-title">НОВОСТИ</p>
    <div id="closeButton" role="button" aria-label="{window.languages.Close}" ontouchend="closeNewsTouchEnd()"
         class="view-news-right-button"></div>
  </div>

  <div class="view-news-container" id="newsMainContainerId" onscroll="newsScrollFunction()">

    <div class="view-news-item" each="{i in newsArray}"
         id="newsContainerId{i.news_id}"
         ontouchstart="newsTouchStart()"
         ontouchend="newsTouchEnd({newsArray.indexOf(i)}, 'newsContainerId{i.news_id}', 'newsArticleId{i.news_id}')">

      <img id="newsImageId{i.news_id}"
           class="view-news-item-image"
           exist="{i.image_exist}">

      <div class="view-news-item-content" shorttext="{i.content_short}"
           opened="false" title="{i.news_content}">

        <p class="view-news-item-title">{i.news_title}</p>
        <p id="newsArticleId{i.news_id}" class="view-news-item-article"></p>
      </div>

      <div class="view-news-item-footer">

        <div hidden="{!i.url}" class="view-news-item-link"
             ontouchend="followLink(&quot;{i.url}&quot;)" id="{i.news_id}">
            {window.languages.ViewNewsFollowLink}
        </div>

        <p class="view-news-item-date">{i.datetime}</p>

        <div class="view-news-item-detail-container">

        </div>


        <div class="view-news-item-more-less-container">
          <div if="{!i.isOpened}" class="view-news-item-more"></div>
          <div if="{i.isOpened}" class="view-news-item-less"></div>
        </div>

      </div>

    </div>


    </div>
    <div class="view-news-block-space"></div>
  </div>

  <script>
    var scope = this;
    scope.newsArray = [];
    scope.newsOpened = false;
    var touchStartY, touchEndY;
    var openImage = false;
    var pageNumber = 2;

    scope.on('mount', function () {
      console.log("MOUNT NEWS");
    });

    openNews = function (news) {
      console.log("View.News.tag.openNews():", news);

      var containerId = "newsContainerId" + news.news_id;
      var textId = "newsTextId" + news.news_id;
      var longText = news.news_content;
      var newsId = news.news_id;

      for (var i in scope.newsArray) {
        if (scope.newsArray[i].news_id === newsId) {
          scope.newsArray[i].opened = true;
        }
      }

      document.getElementById(containerId).style.paddingBottom = 100 * widthK + 'px';
      document.getElementById(containerId).setAttribute('opened', true);
      document.getElementById(containerId).style.height = 'auto';
      document.getElementById(textId).innerHTML = longText;

      scope.update();
    };

    closeNewsTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      if (sessionStorage.getItem("push_news")) {
        sessionStorage.setItem("push_news", false)
      }

      const authorized = JSON.parse(localStorage.getItem('click_client_authorized'));
      const settingsBlock = JSON.parse(localStorage.getItem('settings_block'));
      const onResume = JSON.parse(localStorage.getItem('onResume'));
      const sessionBroken = JSON.parse(localStorage.getItem('session_broken'));

      console.log('View.News.tag.closeNewsTouchEnd():', authorized, settingsBlock, onResume, sessionBroken);

      if ((!authorized && !modeOfApp.demoVersion) || sessionBroken || (settingsBlock === true && onResume)) {
        riotTags.innerHTML = "<view-authorization>";
        riot.mount('view-authorization');
        return
      }

      history.arrayOfHistory = JSON.parse(sessionStorage.getItem('history'));

      if (history.arrayOfHistory[history.arrayOfHistory.length - 2].view === "view-main-page") {
        history.arrayOfHistory[history.arrayOfHistory.length - 2].params = {};
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
      }

      onBackKeyDown();
      scope.unmount()
    };

    newsScrollFunction = function () {
      if ((newsMainContainerId.scrollHeight - newsMainContainerId.scrollTop) == newsMainContainerId.offsetHeight) {
        scope.showNewsFunction(pageNumber);
        pageNumber++;
      }
    };

    newsTouchStart = function () {
      touchStartY = event.changedTouches[0].pageY;
    };

    followLink = function (LinkToNews) {
      console.log("Link to news", LinkToNews);
      window.open(LinkToNews, '_system', 'location=no');
    };

    newsTouchEnd = function (newsIndex, containerId, articleId) {
      console.log('View.News.tag.newsTouchEnd():', newsIndex, containerId, articleId);

      event.preventDefault();
      event.stopPropagation();

      touchEndY = event.changedTouches[0].pageY;

      const clickedNews = scope.newsArray[newsIndex];
      if(!clickedNews) return; // existence check

      const article = document.getElementById(articleId);
      const content = clickedNews.isOpened ? '' : scope.newsArray[newsIndex].news_content;

      if (Math.abs(touchStartY - touchEndY) <= 20) {

        article.innerHTML = content;
        clickedNews.isOpened = !clickedNews.isOpened;

        scope.update();
      }
    };

    scope.showNewsFunction = function (pageNumber) {
      console.log("View.News.tag.showNewsFunction(): ", pageNumber);

      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var signString = hex_md5(phoneNumber.substring(0, 5) + "CLICK" + phoneNumber.substring(phoneNumber.length - 7, phoneNumber.length));
      var timeOutTimerNews = 0;

      window.startSpinner();

      window.api.call({
        method: 'get.news',
        input: {
          phone_num: phoneNumber,
          sign_string: signString,
          page_number: pageNumber

        },

        scope: this,

        onSuccess: function (response) {
          console.log('View.News.tag.showNewsFunction.onSuccess()', response);
          window.clearTimeout(timeOutTimerNews);

          const error = response[0][0].error;
          const errorNote = response[0][0].error_note;
          const responseNews= response[1];

          if (error === 0) {
            for (var i = 0; i < responseNews.length; i++) {
              responseNews[i].isOpened = false;
              scope.newsArray.push(responseNews[i]);
            }

            scope.update();

            // We need to load img  immediately. If you have better solution, you are welcome
            for (var i = 0; i < scope.newsArray.length; i++) {
              const newsImgTag = document.getElementById('newsImageId' + scope.newsArray[i].news_id);
              newsImgTag.setAttribute('src', scope.newsArray[i].news_image);
              newsImgTag.onerror = function () {
                console.log('View.News.tag.showNewsFunction.newsImgTag.onerror()', response);
                newsImgTag.setAttribute('hidden', true);
              }
            }

          }
          else {
            window.common.alert.show("componentAlertId", {
              parent: scope,
              errornote: errorNote,
              viewpage: 'view-main-page'
            });

            scope.update();
          }

        },

        onFail: function (api_status, api_status_message, data) {
          console.error('View.News.tag.showNewsFunction.onFail()', api_status, api_status_message, data);

          window.clearTimeout(timeOutTimerNews);
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: api_status_message,
            viewpage: 'view-main-page'
          });

          scope.update();
        },
        onTimeOut: function () {
          console.log('View.News.tag.showNewsFunction.onTimeOut()');

          timeOutTimerNews = setTimeout(function () {
            window.writeLog({
              reason: 'Timeout',
              method: 'get.news',
            });

            window.common.alert.show("componentAlertId", {
              parent: scope,
              errornote: window.languages.WaitingTimeExpiredText,
              viewpage: 'view-main-page'
            });

            scope.update();
            window.stopSpinner();

          }, 30000);

          console.log('View.News.tag.showNewsFunction.onTimeOut() | creating timeOut', timeOutTimerNews);
        },
        onEmergencyStop: function () {
          console.error('View.News.tag.showNewsFunction.onEmergencyStop()');
          window.clearTimeout(timeOutTimerNews);
        }
      }, 30000);
    }

  </script>
</view-news>
