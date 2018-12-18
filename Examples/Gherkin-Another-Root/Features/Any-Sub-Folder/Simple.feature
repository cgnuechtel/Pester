Feature: Hello World

    Scenario: Say hello world to any person
        Given I meet any person
        When I say 'hello world'
        Then the answer is 42
