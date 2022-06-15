Feature: Spotify sitesinde Login olma ve çalma listesine şarkı ekleme
  işlem adımlarının yürütüldüğü otomasyondur.

  Background:
   * configure driver = { type: 'chromedriver', executable: 'Directory/resources/chromedriver.exe' }

  Scenario: Login Olma ve Çalma listesine şarkı ekleme
    Given driver 'https://open.spotify.com/'
    * maximize()
    When delay(2000)
    And click("//div[@class='ButtonInner-sc-14ud5tc-0 iebPZv encore-inverted-light-set']")
    And click("//input[@id='login-username']")
    And input("//input[@id='login-username']", 'testlericindeneme@gmail.com')
    And click("//input[@id='login-password']")
    And input("//input[@id='login-password']", '1qa2ws3ed4rf5tg')
    And click("//button[@id='login-button']")
    And click("//*[@class='Type__TypeElement-goli3j-0 eHCcSU J4xXuqyaJnnwS6s2p3ZB standalone-ellipsis-one-line']")
    And click("//button[@class='T0anrkk_QA4IAQL29get']")
    And click("//span[@class='Type__TypeElement-goli3j-0 ebHsEf ellipsis-one-line PDPsYDh4ntfQE3B4duUI' and text()='Ayrıntıları düzenle']")
    And click("//input[@data-testid='playlist-edit-details-name-input']")
    And clear("//input[@data-testid='playlist-edit-details-name-input']")
    And input("//input[@data-testid='playlist-edit-details-name-input']", 'MentorLabs Challange')
    And click("//button[@data-testid='playlist-edit-details-save-button']")
    And click("//input[@class='Type__TypeElement-goli3j-0 ebHsEf l42JW4EP_5CU1Ba7jYIc']")
    And input("//input[@class='Type__TypeElement-goli3j-0 ebHsEf l42JW4EP_5CU1Ba7jYIc']", 'Daft Punk')
    And click("//button[@class='Button-y0gtbx-0 jjUWAm']")
    And click("//div[@class='ButtonInner-sc-14ud5tc-0 gHYQaG encore-bright-accent-set']")
    And delay(10000)
    And waitFor().click()



