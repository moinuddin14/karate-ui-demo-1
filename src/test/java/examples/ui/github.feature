Feature: browser automation 1

  Background:
    # * configure driver = { type: 'chrome', showDriverLog: true }
    # * configure driverTarget = { docker: 'justinribeiro/chrome-headless', showDriverLog: true }
    # * configure driverTarget = { docker: 'ptrthomas/karate-chrome', showDriverLog: true }
    # * configure driver = { type: 'chromedriver', showDriverLog: true }
    # * configure driver = { type: 'geckodriver', showDriverLog: true }
    * configure driver = { type: 'safaridriver', showDriverLog: true }


  Scenario: try to login to github
    and then do a google search

    Given driver 'https://github.com/login'
    When driver.maximize()
    And waitFor('#login_field')
    And input('#login_field', 'dummy')
    And input('#password', 'world')
    When submit().click("input[name=commit]")
    And waitFor("//div[@id='js-flash-container']/div/div/text()")
    Then match html("#js-flash-container") contains 'Incorrect username or password.'

    Given driver 'https://google.com'
    * highlight('input[name=q]')
    And input("input[name=q]", 'karate dsl')
    And waitFor("input[name=btnK]")
    When submit().click("input[name=btnK]")
    And waitFor("//div[@id='rso']/div[1]/div/div/div/div[1]/a/h3/div")
    And submit().click("//div[@id='rso']/div[1]/div/div/div/div[1]/a/h3/div")
    Then match driver.url == 'https://github.com/intuit/karate'

    * def bytes = driver.screenshot()
    * karate.embed(bytes, 'image/png')