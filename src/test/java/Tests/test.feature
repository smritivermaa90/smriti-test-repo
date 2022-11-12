Feature: To test different scenarios for web service at https://www.purgomalum.com/ 
  
  Scenario: To verify that response returns input text as json 
    * def query = {text : "json text"}
    * print query.text
    Given url 'https://www.purgomalum.com/service/json'
    And params query
    When method GET
    Then status 200
    * print response
    * def jsonResponse = response
    * print jsonResponse.result
    * print jsonResponse
    * match jsonResponse.result == query.text
   
   Scenario: To verify that response returns input text as xml 
    * def query = {text : "xml text"}
    * print query.text
    Given url 'https://www.purgomalum.com/service/xml'
    And params query
    When method GET
    Then status 200
    * print response

    
    Scenario: To verify that response returns input text as plaintext 
    * def query = {text : "plain text"}
    * print query.text
    Given url 'https://www.purgomalum.com/service/plain'
    And params query
    When method GET
    Then status 200
    * print response
     * match response == query.text
   
    Scenario: To verify if text parameter contains any word matching profanity list.
    * def query = {text : "some text"}
    * print query.text
    Given url 'https://www.purgomalum.com/service/containsprofanity'
    And params query
    When method GET
    Then status 200
    * print response
   
    Scenario: To verify that any word in text parameter matching profanity list is removed
    * def query = {text : "this is some test input", add : "some"}
    * print query.text
    * print query.add
    Given url 'https://www.purgomalum.com/service/xml'
    And params query
    When method GET
    Then status 200
    * print response
    
    Scenario: To verify that any word in text parameter matching profanity list is replaced with data in fill_text parameter
    * def query = {text : "this is some test input", add : "some" , fill_text:"[replaced]"}
    * print query.text
    * print query.add
    * print query.fill_text
    Given url 'https://www.purgomalum.com/service/xml'
    And params query
    When method GET
    Then status 200
    * print response
    
    Scenario: To verify that any word in text parameter matching profanity list is replaced with asterisk, if fill_text parameter is blank
    * def query = {text : "this is some test input", add : "some" , fill_text:""}
    * print query.text
    * print query.add
    * print query.fill_text
    Given url 'https://www.purgomalum.com/service/json'
    And params query
    When method GET
    Then status 200
    * print response
  
    
    Scenario: To verify that every character of the word in text parameter matching profanity list is replaced with data in fill_char parameter
    * def query = {text : "this is some test input", add : "some" , fill_char:"="}
    * print query.text
    * print query.add
    * print query.fill_char
    Given url 'https://www.purgomalum.com/service/plain'
    And params query
    When method GET
    Then status 200
    * print response
    
    Scenario: To verify that every character of the word in text parameter matching profanity list is replaced with asterisk, if fill_char parameter is blank
    * def query = {text : "this is some test input", add : "some" , fill_char:""}
    * print query.text
    * print query.add
    * print query.fill_char
    Given url 'https://www.purgomalum.com/service/json'
    And params query
    When method GET
    Then status 200
    * print response
    
    Scenario: To verify that error message is obtained in response when required parameter text is not provided
    Given url 'https://www.purgomalum.com/service/json'
    When method GET
    Then status 200
    * print response
    * match response.error == '#notnull'
    
    Scenario: To verify that error message is obtained in response when data in add parameter exceeds max length 
    * def query = {text : "some text", add:"some, is, curiously, long, list, of, words, to, be, added, in, the, profanity, list"}
    * print query.text
    * print query.add
    Given url 'https://www.purgomalum.com/service/json'
    And params query
    When method GET
    Then status 200
    * print response
    * match response.error == '#notnull'
    
    Scenario: To verify that error message is obtained in response when invalid data is passed in add parameter 
    * def query = {text : "some text", add:"some, is, @"}
    * print query.text
    * print query.add
    Given url 'https://www.purgomalum.com/service/json'
    And params query
    When method GET
    Then status 200
    * print response
    * match response.error == '#notnull'
    
    
    Scenario: To verify that error message is obtained in response when invalid data is passed in fill_text parameter
    * def query = {text : "this is some test input", add : "some" , fill_text:"@@@,," }
    * print query.text
    * print query.add
    * print query.fill_text
    Given url 'https://www.purgomalum.com/service/json'
    And params query
    When method GET
    Then status 200
    * print response
    * match response.error == '#notnull'
    
    
    
    
    Scenario: To verify error message is obtained in response when data in fill_text parameter exceeds max length
    * def query = {text : "some text", fill_text:"this is curiously long replacement text {{{*_))|!~}}[]~[]||'!==-"}
    * print query.text
    Given url 'https://www.purgomalum.com/service/json'
    And params query
    When method GET
    Then status 200
    * print response
    * match response.error == '#notnull'
  
    
    Scenario: To verify that error message is obtained in response when invalid data is passed in fill_char parameter
    * def query = {text : "this is some test input", add : "some" , fill_char:"@" }
    * print query.text
    * print query.add
    * print query.fill_char
    Given url 'https://www.purgomalum.com/service/json'
    And params query
    When method GET
    Then status 200
    * print response
    * match response.error == '#notnull'
    
   
    