<view-news id="viewNewsId" class="view-news riot-tags-main-container">
  <div class="view-news-page-title">
    <p class="view-news-name-title">УВЕДОМЛЕНИЯ</p>
    <div id="closeButton" role="button" aria-label="{window.languages.Close}" ontouchend="closeNewsTouchEnd()"
         class="view-news-right-button"></div>
  </div>

  <div class="view-news-container" id="newsMainContainerId" onscroll="newsScrollFunction()">

    <div class="view-news-block-of-all" each="{i in newsArray}">

      <div id="newsImageId{i.news_id}"
           hidden
           class="view-news-block-image"
           exist="{i.image_exist}"
           style="background-image: url({i.news_image})"></div>

      <div class="{view-news-block:!i.url, view-news-block-with-link:i.url}" shorttext="{i.content_short}"
           opened="false" title="{i.news_content}"
           id="newsContainerId{i.news_id}"
           ontouchstart="newsTouchStart()"
           ontouchend="newsTouchEnd(this.id, 'newsTextId' + {i.news_id}, this.title, document.getElementById(this.id).getAttribute('shorttext'), 'newsImageId'+{i.news_id}, {i.news_id})">
        <p class="view-news-block-title">{i.news_title}</p>
        <p id="newsTextId{i.news_id}" class="view-news-block-text">{i.content_short}</p>
        <div hidden="{!i.url}" class="view-news-follow-link-container"
             ontouchend="followLink(&quot;{i.url}&quot;)" id="{i.news_id}">
          <div class="view-news-follow-link-text">{window.languages.ViewNewsFollowLink}</div>
          <div class="view-news-follow-link-arrow"></div>
        </div>
        <p class="view-news-block-date">{i.datetime}</p>
        <div if="{!i.opened}" class="view-news-block-readmore-container">{window.languages.ViewNewsDetails}
          <div class="view-news-block-readmore-icon"></div>
        </div>
        <div if="{i.opened}" class="view-news-block-readmore-container">
          <div class="view-news-block-opened-icon"></div>
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
      console.log("news to open", news);
      var containerId = "newsContainerId" + news.news_id;
      var textId = "newsTextId" + news.news_id;
      var longText = news.news_content;
      var shortText = news.content_short;
      var imageId = "newsImageId" + news.news_id;
      var newsId = news.news_id;


      console.log("This post is not opened and its id is", newsId);
      console.log("All posts", scope.newsArray);
      for (var i in scope.newsArray) {
        if (scope.newsArray[i].news_id === newsId) {
          scope.newsArray[i].opened = true;
        }
      }
      console.log(document.getElementById(imageId));
      if (document.getElementById(imageId))
        openImage = JSON.parse(document.getElementById(imageId).getAttribute('exist')) === true;
      document.getElementById(containerId).style.paddingBottom = 100 * widthK + 'px';
      document.getElementById(containerId).setAttribute('opened', true);
      if (openImage)
        document.getElementById(imageId).style.display = 'block';
      document.getElementById(containerId).style.height = 'auto';
      document.getElementById(textId).innerHTML = longText;

      scope.update();
    };

    closeNewsTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      console.log('SCOPE NEW', scope);

      if (sessionStorage.getItem("push_news")) {
        sessionStorage.setItem("push_news", false)
      }

      console.log("1 authorized=", JSON.parse(localStorage.getItem('click_client_authorized')));
      console.log("2 settings block=", JSON.parse(localStorage.getItem('settings_block')));
      console.log("3 onResume=", JSON.parse(localStorage.getItem('onResume')));
      console.log("4 session_broken=", JSON.parse(localStorage.getItem('session_broken')));//


      if ((!JSON.parse(localStorage.getItem('click_client_authorized')) && !modeOfApp.demoVersion) || JSON.parse(localStorage.getItem('session_broken')) || (JSON.parse(localStorage.getItem('settings_block')) === true && JSON.parse(localStorage.getItem('onResume')))) {

        console.log("AUTH MOUNT FROM NEWS");

        riotTags.innerHTML = "<view-authorization>";
        riot.mount('view-authorization');
        return
      }
      console.log("history=", history.arrayOfHistory);
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

    newsTouchEnd = function (containerId, textId, longText, shortText, imageId, newsId) {
      event.preventDefault();
      event.stopPropagation();

      touchEndY = event.changedTouches[0].pageY;

      if (Math.abs(touchStartY - touchEndY) <= 20) {
        if (JSON.parse(document.getElementById(containerId).getAttribute('opened')) === false) {
          console.log("This post is not opened and its id is", newsId);
          console.log("All posts", scope.newsArray);
          for (var i in scope.newsArray) {
            if (scope.newsArray[i].news_id === newsId) {
              scope.newsArray[i].opened = true;
            }
          }
          openImage = JSON.parse(document.getElementById(imageId).getAttribute('exist')) === true;
          document.getElementById(containerId).style.paddingBottom = 100 * widthK + 'px';
          document.getElementById(containerId).setAttribute('opened', true);
          if (openImage)
            document.getElementById(imageId).style.display = 'block';
          document.getElementById(containerId).style.height = 'auto';
          document.getElementById(textId).innerHTML = longText;
        }
        else {
          for (var i in scope.newsArray) {
            if (scope.newsArray[i].news_id === newsId) {
              scope.newsArray[i].opened = false;
            }
          }
          document.getElementById(containerId).style.paddingBottom = '0px';
          if (document.getElementById(containerId).className === "view-news-block")
            document.getElementById(containerId).style.height = 360 * widthK + 'px';
          else
            document.getElementById(containerId).style.height = 415 * widthK + 'px';
          document.getElementById(imageId).style.display = 'false';
          document.getElementById(imageId).style.display = 'none';
          document.getElementById(textId).innerHTML = shortText;
          document.getElementById(containerId).setAttribute('opened', false)
        }
        scope.update();
      }
    };

    scope.showNewsFunction = function (pageNumber, news_id) {
      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var signString = hex_md5(phoneNumber.substring(0, 5) + "CLICK" + phoneNumber.substring(phoneNumber.length - 7, phoneNumber.length));
      var timeOutTimerNews = 0;
      var newsToOpen;

      window.startSpinner();

      window.api.call({
        method: 'get.news',
        input: {
          phone_num: phoneNumber,
          sign_string: signString,
          page_number: pageNumber

        },

        scope: this,

        onSuccess: function (result) {
          console.log('Clearing timer onSuccess', timeOutTimerNews);
          window.clearTimeout(timeOutTimerNews);

          if (result[0][0].error === 0) {
            for (var i in result[1]) {
              result[1][i].opened = false;
              if (result[1][i].news_image) {
                result[1][i].image_exist = true;
              }
              else {
                result[1][i].image_exist = false;
              }
              if (result[1][i].news_content.length > 120) {
                if (result[1][i].news_content_short)
                  result[1][i].content_short = result[1][i].news_content_short.substring(0, 120) + '...';
              }

              if (news_id && news_id == result[1][i].news_id)
                newsToOpen = result[1][i];
              scope.newsArray.push(result[1][i])
            }
            scope.update();
            if (newsToOpen)
              openNews(newsToOpen);
          }
          else {
            console.log("view news error 1");
            window.common.alert.show("componentAlertId", {
              parent: scope,
              errornote: result[0][0].error_note,
              viewpage: 'view-main-page'
            });
            scope.update();
            console.log(result[0][0].error_note);
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.log('Clearing timer onFail', timeOutTimerNews);
          window.clearTimeout(timeOutTimerNews);
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: api_status_message,
            viewpage: 'view-main-page'
          });
          scope.update();
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        },
        onTimeOut: function () {
          timeOutTimerNews = setTimeout(function () {
            window.writeLog({
              reason: 'Timeout',
              method:'get.news',
            });
            window.common.alert.show("componentAlertId", {
              parent: scope,
              errornote: window.languages.WaitingTimeExpiredText,
              viewpage: 'view-main-page'
            });
            scope.update();
            window.stopSpinner();

          }, 30000);
          console.log('creating timeOut', timeOutTimerNews);
        },
        onEmergencyStop: function () {
          console.log('Clearing timer emergencyStop', timeOutTimerNews);
          window.clearTimeout(timeOutTimerNews);
        }
      }, 30000);
    }

  </script>
</view-news>
