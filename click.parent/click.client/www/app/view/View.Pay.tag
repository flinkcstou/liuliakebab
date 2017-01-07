<view-pay class="view-pay">
    <component-page-title title="{titleName}" backbutton="{backbuttoncheck}" rightbutton="{rightbuttoncheck}">
    </component-page-title>

    <div class="pay-service-container">
        <div class="pay-service-block-containter" each="{i in categoryList}" id="{scope.id++}"
             ontouchend="touchendfunction(id)">
            <div class="pay-service-icon" style="background-image: url({i.icon})"></div>
            <div class="pay-service-name-field">{i.name}</div>

        </div>
    </div>


    <script>
        this.titleName = 'ОПЛАТА';

        history.arrayOfHistory.push('view-pay');
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

        scope = this;
        scope.backbuttoncheck = true;
        scope.rightbuttoncheck = true;
        scope.categoryList = JSON.parse(localStorage.getItem("click_client_payCategoryList"));
        scope.serviceList = [];
        scope.id = 0;
        scope.chosenId = 0;

        if (!scope.maxid) {
            scope.maxid = scope.id;
            alert("max id", scope.maxid);
        }


        if (!scope.categoryList) {
            alert("empty");
            scope.categoryList = [];
            window.api.call({
                method: 'get.service.category.list',
                input: {
                    session_key: sessionKey,
                    phone_num: phoneNumber
                },
                scope: this,

                onSuccess: function (result) {
                    console.log('result[1]', result[1]);
                    if (result[0][0].error == 0)
                        if (result[1][0])
                            for (var i in result[1]) {
                                console.log('category ID ', result[1][i].id, ', category name= ', result[1][i].name);
                                scope.categoryList.push(result[1][i]);
                            }
                    riot.update(scope.categoryList);

                    scope.id = 0;
                    console.log('array category list', scope.categoryList)
                    console.log("first element", scope.categoryList[0].name)
                    localStorage.setItem('click_client_payCategoryList', JSON.stringify(scope.categoryList));
                },
                onFail: function (api_status, api_status_message, data) {
                    console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                    console.error(data);
                }
            })
        }

        touchendfunction = function (id) {


            //TODO: CHANGE document.getElementById to this.schosenId
            //TODO: Example: document.getElementById(scope.chosenId).style.backgroundColor - this or scope this.chosenId.style.backgroundColor
            //TODO: CHANGE name of function touchendfunction to touchEndFunction (Each new word starts in UpperCase)
            console.log(id);
            console.log("New=", (Number(id) + 2).toString());
            console.log("max id", scope.maxid);
            if (document.getElementById((Number(id) + 2).toString()) != null) {
                alert(permit);
                console.log(document.getElementById((Number(id) + 2).toString()).offsetTop + 100 + "px");
                console.log("clicked=" + id);
                riot.update();
                if (scope.chosenId)
                    document.getElementById(scope.chosenId).style.backgroundColor = 'red';
                scope.chosenId = (Number(id) + 2).toString();
            }
        }


        var phoneNumber = localStorage.getItem('click_client_phoneNumber');
        phoneNumber = phoneNumber.substring(3, phoneNumber.length);
        console.log('PHONE NUMBER ', phoneNumber);
        var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;


        window.api.call({
            method: 'get.service.list',
            input: {
                session_key: sessionKey,
                phone_num: phoneNumber
            },
            scope: this,

            onSuccess: function (result) {
                console.log('result[1]', result[1]);
                if (result[0][0].error == 0)
                    if (result[1][0])
                        var j = 0;
                for (var i in result[1]) {
                    console.log('service ID ', result[1][i].id, ', service name= ', result[1][i].name);
                    scope.serviceList.push(result[1][i]);
                }

                riot.update(scope.serviceList)

                console.log('array service list', scope.serviceList)
            },
            onFail: function (api_status, api_status_message, data) {
                console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                console.error(data);
            }
        })


    </script>
</view-pay>
