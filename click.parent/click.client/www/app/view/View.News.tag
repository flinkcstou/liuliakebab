<view-news id="viewNewsId" class="view-news riot-tags-main-container">
  <div class="view-news-page-header">
    <p class="view-news-name-title">НОВОСТИ</p>
    <div id="closeButton" role="button" aria-label="{window.languages.Close}" ontouchend="closeNewsTouchEnd()"
         class="view-news-close-button view-news-icon-container"></div>
  </div>
  <div class="view-news-container" id="newsMainContainerId" onscroll="newsScrollFunction()">
    <div class="view-news-item" each="{i in newsArray}"
         id="newsContainerId{i.news_id}"
         ontouchstart="newsTouchStart()"
         ontouchend="newsTouchEnd({i.news_id})">
      <div
        id="newsImageHolderId{i.news_id}"
        class="view-news-item-image">
        <img id="newsImageId{i.news_id}"
             class="view-news-item-image"
              style="opacity: 0;">
      </div>
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
        <div hidden="{!i.url}" class="view-news-item-link view-news-footer-item-container"
             ontouchend="followLink(&quot;{i.url}&quot;, {i.news_id})" id="{i.news_id}">
          <p style="margin: auto" class="horizontal-centering">
            {window.languages.ViewNewsFollowLink}
          </p>
        </div>
        <div class="view-news-footer-item-container">
          <p class="view-news-item-date horizontal-centering">
            {i.datetime}
          </p>
        </div>
        <div class="view-news-footer-item-container"
             ontouchstart="onLikeTouchStart()"
             ontouchend="onLikeTouchEnd({i.news_id})"
        >
          <div class="view-news-item-info-container">
            <div class="view-news-item-info-container ">
              <div id="like_{i.news_id}"
                class="{view-news-icon-container:true, view-news-item-icon-like: true, view-news-item-icon-liked: i.like_status}">
              </div>
            </div>
            <div class="view-news-item-info-container">
              <p class="horizontal-centering view-news-item-icon-title">
                {convertCount(i.likes_count)}
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
                {convertCount(i.views_count)}
              </p>
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
    var likeTouchStartX, likeTouchStartY, likeTouchEndX, likeTouchEndY;
    var isLikeClick = false;
    var pageNumber = 2;

    const phoneNumber = localStorage.getItem('click_client_phoneNumber');
    const loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
    const sessionKey = loginInfo.session_key;


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
      if(isLikeClick) return;
      touchStartY = event.changedTouches[0].pageY;
      console.log('View.News.tag.onNewsTouchStart()');
    };

    followLink = function (LinkToNews, newsId) {
      console.log("Link to news", LinkToNews);
      increaseNewsViewCount(newsId);
      window.open(LinkToNews, '_system', 'location=no');
    };

    convertCount = function(count) {
      var result = count;
      if(count < 1000) {
        result = round(count, 0);
      } else if(count >= 1000 && count < 1000000) {
        result = round(count / 1000, 0) + 'K';
      } else if(count >= 1000000) {
        result = round(count / 1000000, 0) + 'M';
      }
      return result;
    };

    function round(value, decimals) {
      return Number(Math.round(value+'e'+decimals)+'e-'+decimals);
    }

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
        increaseNewsViewCount(newsId);
      } else {
        article.style.marginBottom = "0";
        article.style.height = "0";
        arrow.style.transform = "rotate(0)";
      }

      scope.update();
    }

    function increaseNewsViewCount(newsId) {
      if(!newsId) return;

      var tapedNews = getNewsById(newsId);
      tapedNews.views_count++;

      window.api.call({
        method: 'news.view.count',
        input: {
          phone_num: phoneNumber,
          session_key: sessionKey,
          news_id: newsId
        },
        scope: scope,
        onSuccess: function (response) {
          console.log('View.News.tag.newsTouchEnd.increaseNewsViewCount.onSuccess()', response);
          const error = response[0][0].error;
          const viewsCount = response[1][0].views_count;

          console.log(error, viewsCount);
          if(error == 0 && tapedNews) {
            tapedNews.views_count = viewsCount;
            scope.update();
          }

        },
        onFail: function (api_status, api_status_message, data) {
        },
        onTimeOut: function () {
        },
        onEmergencyStop: function () {
        }
      }, 30000);
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
              const newsImgHolderTag = document.getElementById('newsImageHolderId' + scope.newsArray[i].news_id);
              const newsImgTag = document.getElementById('newsImageId' + scope.newsArray[i].news_id);
              newsImgTag.setAttribute('src', scope.newsArray[i].news_image);
              newsImgTag.onload = function() {
                newsImgTag.style.opacity = 1;
              };
              newsImgTag.onerror = function () {
                console.error('View.News.tag.showNewsFunction.newsImgTag.onerror()', response);
                newsImgTag.setAttribute('hidden', true);
                newsImgHolderTag.setAttribute('hidden', true);
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

    onLikeTouchStart = function() {
      console.log('View.News.tag.onLikeTouchStart()');
      isLikeClick = true;
      likeTouchStartX = event.changedTouches[0].pageY;
      likeTouchStartY = event.changedTouches[0].pageY;
    };

    onLikeTouchEnd = function(newsId) {
      console.log('View.News.tag.onLikeTouchEnd()', newsId);
      likeTouchEndX = event.changedTouches[0].pageY;
      likeTouchEndY = event.changedTouches[0].pageY;

      const isTap = (Math.abs(likeTouchStartX - likeTouchEndX) <= 20 && Math.abs(likeTouchStartY - likeTouchEndY) <= 20);
      if(!isTap) return;

      var tapedNews = getNewsById(newsId);
      if(!tapedNews) return;

      if(!tapedNews.like_status) {
       likeNews(tapedNews);
      } else {
        unlikeNews(tapedNews);
      }
      isLikeClick = false;
    };

    function likeNews(news) {
      const likeIcon = document.getElementById('like_' + news.news_id);
      likeIcon.classList.remove('view-news-item-icon-liked');
      news.like_status = 1;
      news.likes_count++;

      window.api.call({
        method: 'news.like',
        input: {
          phone_num: phoneNumber,
          session_key: sessionKey,
          news_id: news.news_id
        },
        scope: scope,
        onSuccess: function (response) {
          console.log('View.News.tag.onLikeTouchEnd.news.like.onSuccess()', response);
        },
        onFail: function (api_status, api_status_message, data) {
        },
        onTimeOut: function () {
        },
        onEmergencyStop: function () {
        }
      }, 30000);

      scope.update();
    }

    function unlikeNews(news) {
      const likeIcon = document.getElementById('like_' + news.news_id);
      likeIcon.classList.add('view-news-item-icon-liked');
      news.like_status = 0;
      news.likes_count--;

      window.api.call({
        method: 'news.unlike',
        input: {
          phone_num: phoneNumber,
          session_key: sessionKey,
          news_id: news.news_id
        },
        scope: scope,
        onSuccess: function (response) {
          console.log('View.News.tag.onLikeTouchEnd.news.unlike.onSuccess()', response);
        },
        onFail: function (api_status, api_status_message, data) {
        },
        onTimeOut: function () {
        },
        onEmergencyStop: function () {
        }
      }, 30000);

      scope.update();
    }

    function getNewsById(newsId) {
      for(var i in scope.newsArray) {
        if(scope.newsArray[i].news_id == newsId) {
          return scope.newsArray[i];
        }
      }
      return null;
    }

  </script>
</view-news>
