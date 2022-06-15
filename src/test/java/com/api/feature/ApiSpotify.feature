Feature: API test on Spotify
  Background:
    * def urlHome = 'https://open.spotify.com/'
    * def userToken = 'Bearer BQBISjXEzIC78AObOnGLA8XWGb9TOQYTGc6swLWGSj8dXBi6GRZth4iXTHewqTxtu2d_kctE7BfNv3waGuwQANa57n0DpfP7NnAHszH8QEJIa76loQz4h-wcwGBadeznk_A_hu7X3h20OIua4xhEjgbXHIIRDgzRQTDcgrQ-zO1NC6SspdR4JTvWdAzH7Z2Oo392Smlt3yha-ZgPhwXdfrljjJ6igGaJQK769OZ4cSrfsfo5c0XzrOfupaKTLOSKTZl-hIz0iQc5CSuTvUJcOPdqP-CfPJfvP_oxoMnTNQMZLMBa6Ob05Q'
    * def userId = '313mcnuwl23p4hytj7b76om4sswm'
    * def requestBody =
    """
    {
  "name": "Bohemian Rhapsody Challenge",
  "description": "MentorLabs Challenge için listeye şarkı ekleme",
  "public": false
}
    """

  Scenario: Spotify PlayList User Get Api
    Given url 	'https://api.spotify.com/v1'
    And path '/me'
    And header Authorization = 'Bearer BQC4ioRQWottOEWzoU2nR_aFuKONnkKkoOk1BobLLkkfDB1IoByCx9r0HHB0iTU0xJLOLT1AKq091wKwKhYMykfcOD0qvG5wKQ7iLq__kD-hygffdEy0MUGekRdM6lPi5WAJJ9ctdVdVrBYuThQ3bP9hlumzs46L9XkC2ulQQfhxyQhvzAiRrIptOjSvQG60nWn5_BwN9r34sclVAGcf5MNrUsUAMcPBdM83ncBrbPWxPH9GWIlQw5RnoK2yOv5LL_CsOPpTorRYHnw'
    When method get
    Then status 200

    @Playlist
    Scenario: Create PlayList post Api
      Given url 'https://api.spotify.com/v1'
      And path '/users/'+ userId+ '/playlists'
      And header Authorization = userToken
      And header Content-Type = 'application/json'
      And request requestBody
      When method post
      Then def playlistId = response.id

      @Song
      Scenario: Search song get Api
        Given url 'https://api.spotify.com/v1'
        And path '/search'
        And header Authorization = userToken
        And header Content-Type = 'application/json'
        And param q = 'Bohemian Rhapsody'
        And param type = 'track'
        When method get
        Then def songUri = response.tracks.items[1].uri

        Scenario: Add song post Api
          * def playlistScenario = call read('ApiSpotify.feature@Playlist')
          * def playlistId = playlistScenario.playlistId

          * def songScenario = call read('ApiSpotify.feature@Song')
          * def songUri = songScenario.songUri

          Given url 'https://api.spotify.com/v1'
          And path '/playlists/' +playlistId+ '/tracks'
          And header Authorization = userToken
          And header Content-Type = 'application/json'
          And request {"uris": [#(songUri)]}
          And method post
