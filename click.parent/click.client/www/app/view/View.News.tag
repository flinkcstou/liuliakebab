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
         ontouchend="newsTouchEnd({i.news_id})">
      <img id="newsImageId{i.news_id}"
           class="view-news-item-image"
           exist="{i.image_exist}">
      <div class="view-news-item-content" shorttext="{i.content_short}"
           opened="false" title="{i.news_content}">
        <p class="view-news-item-title">
          {i.news_title}
        </p>
        <p id="newsArticleId{i.news_id}" class="view-news-item-article">
          {i.news_content}
        </p>
      </div>
      <div class="view-news-item-footer">
        <div>
          <div hidden="{!i.url}" class="view-news-item-link view-news-footer-item-container"
               ontouchend="followLink(&quot;{i.url}&quot;)" id="{i.news_id}">
            <p style="margin: auto" class="horizontal-centering">
              {window.languages.ViewNewsFollowLink}
            </p>
          </div>
          <div class="view-news-footer-item-container">
            <p class="view-news-item-date horizontal-centering">
              {i.datetime}
            </p>
          </div>
          <div class="view-news-footer-item-container">
            <div class="view-news-item-info-container">
              <div class="view-news-item-info-container ">
                <div class="view-news-icon-container view-news-item-icon-like">
                </div>
              </div>
              <div class="view-news-item-info-container">
                <p class="horizontal-centering view-news-item-icon-title">
                  200
                </p>
              </div>
            </div>
            <div class="view-news-item-info-container">
              <div class="view-news-item-info-container ">
                <div class="view-news-icon-container view-news-item-icon-view">
                </div>
              </div>
              <div class="view-news-item-info-container horizontal-centering">
                <p class="horizontal-centering view-news-item-icon-title">
                  1.4k
                </p>
              </div>
            </div>
          </div>
        </div>
        <div style="float: right;">
          <div id="newsArrowIcon{i.news_id}" class="view-news-item-icon-more view-news-icon-container"></div>
        </div>
      </div>
    </div>
  </div>
  <div class="view-news-block-space">
  </div>
  <script>
    var scope = this;
    scope.newsArray = [];
    scope.newsOpened = false;
    var touchStartY, touchEndY;
    var pageNumber = 2;

    console.error(scope.newsArray);

    scope.on('mount', function () {
      console.log("MOUNT NEWS");
    });

    scope.getNewsById = function (newsId) {
      for (var i in scope.newsArray) {
        if (scope.newsArray[i].news_id === newsId) {
          return scope.newsArray[i];
        }
      }
    };

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
      stopEventPropagation();

      if (sessionStorage.getItem("push_news")) {
        sessionStorage.setItem("push_news", false)
      }

      if (isUserAuthorized()) {
        console.log('View.News.tag.closeNewsTouchEnd()');
        mountTo('view-authorization');
        return
      }

      checkAndReloadMainPageParams();
      unmount();
    };

    function unmount() {
      onBackKeyDown();
      scope.unmount();
    }

    function isUserAuthorized() {
      const authorized = JSON.parse(localStorage.getItem('click_client_authorized'));
      const settingsBlock = JSON.parse(localStorage.getItem('settings_block'));
      const onResume = JSON.parse(localStorage.getItem('onResume'));
      const sessionBroken = JSON.parse(localStorage.getItem('session_broken'));

      return (!authorized && !modeOfApp.demoVersion) || sessionBroken || (settingsBlock === true && onResume)
    }

    function mountTo(viewName) {
      riotTags.innerHTML = "<" + viewName + ">";
      riot.mount(viewName);
    }

    function checkAndReloadMainPageParams() {
      history.arrayOfHistory = JSON.parse(sessionStorage.getItem('history'));
      if (history.arrayOfHistory[history.arrayOfHistory.length - 2].view === "view-main-page") {
        history.arrayOfHistory[history.arrayOfHistory.length - 2].params = {};
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
      }
    }

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

    newsTouchEnd = function (newsId) {
      console.log('View.News.tag.newsTouchEnd()');

      stopEventPropagation();

      touchEndY = event.changedTouches[0].pageY;

      if (Math.abs(touchStartY - touchEndY) <= 20) {
        console.log('View.News.tag.newsTouchEnd - Success !');
        onClickNews(newsId);
      }
    };

    function onClickNews(newsId) {

      const article = getArticle(newsId);
      const arrow = getArrow(newsId);

      scope.getNewsById(newsId).isOpened = !scope.getNewsById(newsId).isOpened;

      if (scope.getNewsById(newsId).isOpened) {
        article.style.marginBottom = "5%";
        article.style.height = "auto";
        arrow.style.transform = "rotate(180deg)";
      } else {
        article.style.marginBottom = "0";
        article.style.height = "0";
        arrow.style.transform = "rotate(0)";
      }

      scope.update();
    }

    function getArticle(newsId) {
      return document.getElementById("newsArticleId" + newsId)
    }

    function getArrow(newsId) {
      return document.getElementById("newsArrowIcon" + newsId)
    }

    function stopEventPropagation() {
      event.preventDefault();
      event.stopPropagation();
    }

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

        scope: scope,

        onSuccess: function (response) {
          console.log('View.News.tag.showNewsFunction.onSuccess()', response);
          window.clearTimeout(timeOutTimerNews);

          const error = response[0][0].error;
          const errorNote = response[0][0].error_note;
          const responseNews = response[1];

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
                console.error('View.News.tag.showNewsFunction.newsImgTag.onerror()', response);
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
              method: 'get.news'
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
    };

  </script>
</view-news>
