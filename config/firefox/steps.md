Steps to re-apply userChrome.css:

* Click the firefox menu button (3 bar button) and select Help -> Troubleshooting information
* Click on "Show in Finder" beside the `Profile folder` field
* Create or navigate to a folder called `chrome` inside the profile folder
* Copy the userChrome.css file to the `chrome` folder
* Go to page `about:config` and search for the value `userprof`
* Toggle ` toolkit.legacyUserProfileCustomizations.stylesheets`. This will instruct FF to look for the userChrome file.
* Restart your firefox and verify your setttings.
* Profit!
