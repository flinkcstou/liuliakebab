<view-news id="viewNewsId" class="view-news riot-tags-main-container">
  <div class="view-news-page-title">
    <p class="view-news-name-title">УВЕДОМЛЕНИЯ</p>
    <div id="closeButton" ontouchend="closeNewsTouchEnd()" class="view-news-right-button"></div>
  </div>

  <div class="view-news-container" id="newsMainContainerId" onscroll="newsScrollFunction()">

    <div class="view-news-block-of-all" each="{i in newsArray}">

      <div id="newsImageId{i.news_id}" hidden
           class="view-news-block-image" style="background-image: url({i.news_image})"></div>

      <div class="view-news-block" shorttext="{i.content_short}" opened="false" title="{i.news_content}"
           id="newsContainerId{i.news_id}"
           ontouchstart="newsTouchStart()"
           ontouchend="newsTouchEnd(this.id, 'newsTextId' + {i.news_id}, this.title, document.getElementById(this.id).getAttribute('shorttext'), 'newsImageId'+{i.news_id}, {i.news_id})">
        <p class="view-news-block-title">{i.news_title}</p>
        <p id="newsTextId{i.news_id}" class="view-news-block-text">{i.content_short}</p>

        <p class="view-news-block-date">{i.datetime}</p>
        <div if="{!i.opened}" class="view-news-block-readmore-container">Подробнее
          <div class="view-news-block-readmore-icon"></div>
        </div>
        <div if="{i.opened}" class="view-news-block-readmore-container">
          <div class="view-news-block-opened-icon"></div>
        </div>
      </div>
    </div>
    <div class="view-news-block-space"></div>
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>
    var scope = this;

    scope.newsArray = []
    scope.newsOpened = false;


    closeNewsTouchEnd = function () {
      event.preventDefault()
      event.stopPropagation()

      console.log('SCOPE NEW', scope)

      if(scope.parent.opts.view){

        if(sessionStorage.getItem("push_news")){
          sessionStorage.setItem("push_news", false)
        }
        riotTags.innerHTML = "<view-authorization>";
        riot.mount('view-authorization');
        return
      }

      onBackKeyDown()
      scope.unmount()
    }

    var pageNumber = 1;
    newsScrollFunction = function () {
      if ((newsMainContainerId.scrollHeight - newsMainContainerId.scrollTop) == newsMainContainerId.offsetHeight) {
        scope.showNewsFunction(pageNumber);
        pageNumber++;
      }

    }

    var touchStartY, touchEndY;
    var openImage = false;

    newsTouchStart = function () {

      touchStartY = event.changedTouches[0].pageY;
    }

    newsTouchEnd = function (containerId, textId, longText, shortText, imageId, newsId) {
      event.preventDefault()
      event.stopPropagation()
      console.log('News ARRAY', scope.newsArray)

      touchEndY = event.changedTouches[0].pageY;

//      console.log('NEWS ARRAY', newsArray)
//      console.log('NEWS ARRAY[i]', newsArray[i])


      if (Math.abs(touchStartY - touchEndY) <= 20) {

        if (JSON.parse(document.getElementById(containerId).getAttribute('opened')) === false) {
          for (var i in scope.newsArray) {
            console.log(scope.newsArray[i].news_id, newsId)
            if (scope.newsArray[i].news_id == newsId) {
              scope.newsArray[i].opened = true;
              if (scope.newsArray[i].image_exist === true) {
                openImage = true;
              }
              else {
                openImage = false;
              }
            }
          }

          document.getElementById(containerId).style.paddingBottom = 100 * widthK + 'px'
          document.getElementById(containerId).setAttribute('opened', true)
          if (openImage)
            document.getElementById(imageId).style.display = 'block'
          document.getElementById(containerId).style.height = 'auto';
          document.getElementById(textId).innerHTML = longText;
          console.log('document.getElementById(containerId)', document.getElementById(containerId).children)
//          scope.newsOpened = true;
        }
        else {
          for (var i in scope.newsArray) {
            if (scope.newsArray[i].news_id == newsId) {
              scope.newsArray[i].opened = false;
            }
          }
//          scope.newsOpened = false;
          document.getElementById(containerId).style.paddingBottom = '0px'
          document.getElementById(containerId).style.height = 330 * widthK + 'px';
          document.getElementById(imageId).style.display = 'false'
          document.getElementById(imageId).style.display = 'none'
          document.getElementById(textId).innerHTML = shortText;
          document.getElementById(containerId).setAttribute('opened', false)
        }

        console.log(scope.newsArray)
        scope.update()

      }
    }

    scope.showNewsFunction = function (pageNumber) {
      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var signString = hex_md5(phoneNumber.substring(0,5) + "CLICK" + phoneNumber.substring(phoneNumber.length - 7, phoneNumber.length))


      window.api.call({
        method: 'get.news',
        input: {
          phone_num: phoneNumber,
          sign_string: signString,
          page_number : pageNumber,

        },

        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error == 0) {
            console.log("NEWS", result);
            for (var i in result[1]) {
              result[1][i].opened = false;
              if (result[1][i].news_image) {
                result[1][i].image_exist = true;
              }
              else {
                result[1][i].image_exist = false;
              }
              if (result[1][i].news_content.length > 120) {
                console.log('result[1][i]', result[1][i])
                if (result[1][i].news_content_short)
                  result[1][i].content_short = result[1][i].news_content_short.substring(0, 120) + '...';
              }
              scope.newsArray.push(result[1][i])
            }
            console.log(" NEWS ARRAY WITH OPTIONS", result[1])
            scope.update()
          }
          else {
            scope.showError = true;
            scope.errorNote = result[0][0].error_note
            scope.update();
            console.log(result[0][0].error_note);
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }

  </script>
</view-news>
