<view-add-friend>
  <div>
    <div class="pay-page-title">
      <p class="pay-name-title">{titleName}</p>
      <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
    </div>
    <div class="settings-container">

    </div>

  </div>
  <div class="settings-add-friend-add-container">
    <p class="settings-add-friend-add-title">Имя друга</p>
  </div>
  <div class="settings-add-friend-contact-phone-field">
    <p class="settings-add-friend-contact-text-field">{window.languages.ViewSettingsAddFriendPhoneNumberTitle}</p>
    <p class="settings-add-friend-contact-number-first-part">+{window.languages.CodeOfCountry}</p>
    <input onchange="contactPhoneBlurAndChange()" onfocus="contactPhoneBlurAndChange()"
           id="contactPhoneNumberId"
           class="transfer-contact-number-input-part" type="tel"
           maxlength="9" onkeyup="searchContacts()"/>
  </div>

  <div class="settings-add-friend-contact-from-native-container">
    <div class="settings-add-friend-contact-phone-icon" ontouchend="pickContactFromNative()"></div>
    <p class="settings-add-friend-contact-from-native-title">Выбрать из контактов</p>
  </div>

  <script>
    var scope = this;
    this.titleName = window.languages.ViewSettingsAddFriendTitleName;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-add-friend') {
      history.arrayOfHistory.push(
        {
          "view": 'view-add-friend',
          "params": ''
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
    };


  </script>
</view-add-friend>
