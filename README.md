# README

* Environments
    * GH_BASIC_CLIENT_ID - Client ID 
    * GH_BASIC_SECRET_ID - Client Secret

* Login with Github (home_controller.rb):
    * HTTParty is used as a HTTP client
    * On callback user will be created/updated in database
    * access_token and user_id stored in session for simplicity (it's not secure)


* Bonus part (bonus_controller.rb):
    * Nokogiri is used to change the index.html
    * 'update_repo' action to add/remove snippets from repo
    * 'bonus_modified_page' action returns the index.html from repo with snippets
    
