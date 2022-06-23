Feature: api arayüz senaryosu

  Background:
    * configure driver = { type: 'chromedriver', executable: 'Directory/resources/chromedriver.exe' }

    * def urlHome = 'https://open.spotify.com/'
    * def userToken = 'Bearer BQAqkmzp87baA30-VvkNS-6iN1OCzNM7DG_eYNNPhpYRpXdbx1S78SW1bsmBPpvFeb8nCY5kfsNOEt_8iWRQ-1GIWlmT6AUYi9Hzh_8QI-YAESJqBxbxKg1W5L5zlTBpVzIXbuXhCIzM7vwhcjzpvwLla1HgWnFfU6wJvrBLlDc5UhH57ajsxvtjx_khLu1R6rvu-11j4L9Jw4XVoiGoqohbmbxlxQcRzCGOov1RIj2q5gIuZiDqtbnWMK0k5R5cARWheDWOESU0OfwxT0RFD-cxiWwFsKP5h6jakccbY4so45po67cCWMrQpvbabVA'
    * def userId = '313mcnuwl23p4hytj7b76om4sswm'
    * def requestBody =
    """
    {
  "name": "MentorLabs Faz2 ",
  "description": "MentorLabs Challenge için listeye şarkı ekleme",
  "public": false
}
    """

    * def track =
   """
{
"uris": [
"spotify:track:3MrRksHupTVEQ7YbA0FsZK"
],
"position": 0
}
    """

  Scenario: Login Olma ve Çalma listesine şarkı ekleme
    Given driver 'https://open.spotify.com/'
    * maximize()
    When click("//div[@class='ButtonInner-sc-14ud5tc-0 iebPZv encore-inverted-light-set']")
    And delay(2000)
    And input("//input[@id='login-username']", 'testlericindeneme@gmail.com')
    And delay(2000)
    And input("//input[@id='login-password']", '1qa2ws3ed4rf5tg')
    And waitFor("//button[@id='login-button']").click()

    Given url 'https://api.spotify.com/v1'
    And path '/users/'+ userId+ '/playlists'
    And header Authorization = userToken
    And header Content-Type = 'application/json'
    And request requestBody
    When method post
    Then def playlistId = response.id


    Given url 'https://api.spotify.com/v1'
    And path '/users/'+ userId+ '/playlists'
    And header Authorization = userToken
    And header Content-Type = 'application/json'
    And request requestBody
    When method post
    Then def playlistId = response.id

    And path '/playlists/' +playlistId+ '/tracks'
    And header Authorization = userToken
    And header Content-Type = 'application/json'
    And request track
    And method post

    And refresh()
    And delay(5000)
    And click("//div[@class='AINMAUImkAYJd4ertQxy']")
    And delay(2000)
    And click("//div[@class='ButtonInner-sc-14ud5tc-0 gHYQaG encore-bright-accent-set']")
    And delay(10000)

    When url 'https://api.spotify.com/v1'
    And path  '/me/player/currently-playing'
    And header Authorization = userToken
    And header Content-Type = 'application/json'
    And print response
    When method get
    Then status 200
    * def response = karate.jsonPath(response,"$.['item'].['name']")
    And match response == 'The Final Countdown'
    Then print 'Song Matched'


