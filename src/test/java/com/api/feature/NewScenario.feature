Feature: Spotify üzerinden yeni senaryo yazdırma

  Background:
    * configure driver = { type: 'chromedriver', executable: 'Directory/resources/chromedriver.exe' }


    * def urlHome = 'https://open.spotify.com/'
    * def userToken = 'Bearer BQCkssJ7GagjQmkSn_CZwBNAGBC2SNbcc0KvqYijwUcUNy7inekwzhj123zjMZINROqPAKMQml8TzyjgFHvwO6Cs5NcArBsv5eSrrlCVjUozldlMhklA6oQlevffpEzKMWY6Db8nStfoQJeNspZf3FytalbLX9nAIYoxnM2lx0owe8raEym9RU-h1F8tIEDHBOopP1cpIKn0Yx42BgnbmzIRYy6gRK22W8v4j5ZKWLQtPtNWmrGA9vg5XSZyQOAKiLMkbsuPeFlRFfMGi9IA-CTnjqb8RL-srEbOeBdP6AT0dQ-1WC4YhseuY_j4VAY'
    * def userId = '313mcnuwl23p4hytj7b76om4sswm'

    * def requestBody =
    """
    {
  "name": "New Scenario ",
  "description": "Yeni senaryo için listeye şarkı ekleme",
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

    And path '/playlists/'+playlistId+'/tracks'
    And header Authorization = userToken
    And header Content-Type = 'application/json'
    And request track
    And method post
#şarkı çal
    And refresh()
    And delay(5000)
    And click("//div[@class='AINMAUImkAYJd4ertQxy']")
    And delay(2000)
    And click("//div[@class='ButtonInner-sc-14ud5tc-0 gHYQaG encore-bright-accent-set']")
    And delay(2000)
    And scroll("//button[@class='Button-y0gtbx-0 jjUWAm']")
    And delay(2000)
    * def elements = locateAll("//button[@data-testid='add-to-playlist-button']")
    And delay(2000)
    * elements[2].click()
    And delay(2000)
    * elements[3].click()
    And delay(2000)
    And click("//a[@href='/search']")
    And delay(2000)
    And input("//input[@class='Type__TypeElement-goli3j-0 ebHsEf QO9loc33XC50mMRUCIvf']", 'the empire of the sun')
    And delay(2000)
    And click("//button[@class='Fm7C3gdh5Lsc9qSXrQwO tGKwoPuvNBNK3TzCS5OH']")
    And delay(2000)
    And click("//div[@class='hOWUEV7wHgfYPPLcnNXt']")
    And delay(2000)
    And click("//button[@data-testid='user-widget-dropdown-logout']")
    And delay(3000)





