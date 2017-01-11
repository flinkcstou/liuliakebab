<view-pay class="view-pay">

  <div class="page-title">
    <p class="pay-name-title">{titleName}</p>
    <div id="backButton" ontouchstart="touchStartTitle()"
         class="{back-button: backbuttoncheck}">
    </div>
    <div id="rightButton" type="button" class="{search-button: rightbuttoncheck}"></div>
  </div>

  <div class="pay-category-container">
    <ul style="list-style:none; padding: 0; margin: 0;">
      <li each="{i in categoryList}">
        <div class="pay-service-block-containter" id="{i.id}" ontouchend="toggle(this.id)">
          <div class="pay-category-icon" style="background-image: url({i.icon})"></div>
          <div class="pay-category-name-field">{i.name}</div>
          <div class="pay-icon-tick" id="tick{i.id}"></div>
          <ul class="pay-services-block" if="{index == i.id && show}" style="list-style:none">
            <li class="pay-service-containter" each="{j in currentList}">
              <div class="pay-service-icon" style="background-image: url({j.image})"></div>
              <div class="pay-service-name-field">{j.name}</div>
            </li>
          </ul>
        </div>
      </li>
    </ul>
  </div>


  <script>

    var scope = this;
    touchStartTitle = function () {
      event.preventDefault();
      event.stopPropagation();

      this.riotTags.innerHTML = "<view-main-page>";
      riot.mount('view-main-page');
    }

    this.titleName = 'ОПЛАТА';


    history.arrayOfHistory.push('view-pay');
    sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

    scope = this;
    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = true;
    scope.categoryList = JSON.parse(localStorage.getItem("click_client_payCategoryList"));
    scope.serviceList = JSON.parse(localStorage.getItem("click_client_payServiceList"));
    scope.servicesMap = JSON.parse(localStorage.getItem("click_client_servicesMap"));

    var phoneNumber = localStorage.getItem('click_client_phoneNumber');
    phoneNumber = phoneNumber.substring(3, phoneNumber.length);
    console.log('PHONE NUMBER ', phoneNumber);
    var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;


    if (!scope.categoryList) {
      scope.categoryList = [];
      window.api.call({
        method: 'get.service.category.list',
        input : {
          session_key: sessionKey,
          phone_num  : phoneNumber
        },
        scope : this,

        onSuccess: function (result) {
          if (result[0][0].error == 0)
            if (result[1][0])
              for (var i in result[1]) {
                console.log('category ID ', result[1][i].id, ', category name= ', result[1][i].name);
                scope.categoryList.push(result[1][i]);
              }
          riot.update(scope.categoryList);

          scope.id = 0;
          console.log('array category list', scope.categoryList)
          localStorage.setItem('click_client_payCategoryList', JSON.stringify(scope.categoryList));
        },
        onFail   : function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })
    }

    scope.index = -1;
    scope.show = false;


    toggle = function (id) {

      if (scope.index == id) {
        scope.index = -1;
      } else {
        scope.index = id;
      }

      scope.currentList = scope.servicesMap[id];
      console.log("currentList", scope.currentList);


      if (!scope.currentList) {
        scope.show = false;
      } else {
        scope.show = true;
        document.getElementById("tick" + id).style.backgroundImage = "url(resources/icons/ViewPay/catopen.png)";
      }

      if (scope.index == id && scope.show) {
        document.getElementById("tick" + id).style.backgroundImage = "url(resources/icons/ViewPay/catclose.png)";
      }


      riot.update(scope.index);
      riot.update(scope.currentList);
      riot.update(scope.show);
    };


    if (!(scope.serviceList && scope.servicesMap)) {
      scope.serviceList = [];
      scope.servicesMap = {};
      window.api.call({
        method: 'get.service.list',
        input : {
          session_key: sessionKey,
          phone_num  : phoneNumber
        },
        scope : this,

        onSuccess: function (result) {
          if (result[0][0].error == 0)
            if (result[1][0])
              for (var i in result[1]) {
                console.log('service ID ', result[1][i].id, ', service name= ', result[1][i].name, ', category id= ', result[1][i].category_id);
                scope.serviceList.push(result[1][i]);
                if (!scope.servicesMap[result[1][i].category_id]) {
                  scope.servicesMap[result[1][i].category_id] = [];
                  scope.servicesMap[result[1][i].category_id].push(result[1][i]);
                }
                else {
                  scope.servicesMap[result[1][i].category_id].push(result[1][i]);
                }

              }

          riot.update(scope.serviceList)

          console.log('array service list', scope.serviceList)
          localStorage.setItem('click_client_payServiceList', JSON.stringify(scope.serviceList));
          localStorage.setItem('click_client_servicesMap', JSON.stringify(scope.servicesMap));
        },
        onFail   : function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })
    }

    window.api.call({
      method: 'get.service.parameters.list',
      input : {
        session_key: sessionKey,
        phone_num  : phoneNumber
      },

      scope: this,

      onSuccess: function (result) {
        console.log("get Parameters list!!! ", result);
      },

      onFail: function (api_status, api_status_message, data) {
        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        console.error(data);
      }
    });


    console.log("categories ", scope.categoryList)
    console.log("services ", scope.serviceList)
    console.log("services map", scope.servicesMap)


  </script>
</view-pay>
