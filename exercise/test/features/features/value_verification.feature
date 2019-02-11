Feature: Verify the values appear in the page

  Scenario Outline: The object appears in the page or not
    Given User navigates to exercise link
    When Check the "<object>" in the page
    Then It should be indicated by "<result>"

    Examples:
      |object|result|
      |lbl_val_1|true|
      |lbl_val_2|true|
      |lbl_val_3|true|
      |lbl_val_4|true|
      |lbl_val_5|true|
      |lbl_ttl_val|true|
      |txt_val_1|true|
      |txt_val_2|true|
      |txt_val_3|true|
      |txt_val_4|true|
      |txt_val_5|true|
      |txt_ttl_val|true|

    Scenario: Verify the count of the values is right
      Given User navigates to exercise link
      When Check the count of values
      Then The count should be 6

  Scenario: The count of the values should be greater than 0
    Given User navigates to exercise link
    When Check the count of values
    Then The count of values should be greater than 0

  Scenario: Verify total balance is correct
    Given User navigates to exercise link
    When Calculate the total balance of the values
    Then Balance should match the balance listed

  Scenario: The values are formatted as currencies
    Given User navigates to exercise link
    When Check the value format
    Then The values are formatted as currencies



