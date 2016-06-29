Feature: Reset WordPress sidebars

  Scenario: Reset sidebar
    Given a WP install

    When I run `wp theme install twentysixteen --activate`
    Then STDOUT should not be empty

    When I run `wp widget list sidebar-1 --format=count`
    Then STDOUT should be:
      """
      6
      """

    When I run `wp widget reset sidebar-1`
    And I run `wp widget list sidebar-1 --format=count`
    Then STDOUT should be:
      """
      0
      """

    When I try `wp widget reset`
    Then STDERR should be:
      """
      Error: Please specify one or more sidebars, or use --all.
      """

    When I try `wp widget reset sidebar-1`
    Then STDERR should be:
      """
      Warning: 'sidebar-1' is already empty.
      """

    When I try `wp widget reset non-existing-sidebar-id`
    Then STDERR should be:
      """
      Warning: Invalid sidebar: non-existing-sidebar-id
      """

    When I run `wp widget add calendar sidebar-1 --title="Calendar"`
    Then STDOUT should not be empty
    And I run `wp widget list sidebar-1 --format=count`
    Then STDOUT should be:
      """
      1
      """

    When I run `wp widget add search sidebar-2 --title="Quick Search"`
    Then STDOUT should not be empty
    And I run `wp widget list sidebar-2 --format=count`
    Then STDOUT should be:
      """
      1
      """

    When I run `wp widget reset sidebar-1 sidebar-2`
    And I run `wp widget list sidebar-1 --format=count`
    Then STDOUT should be:
      """
      0
      """
    And I run `wp widget list sidebar-2 --format=count`
    Then STDOUT should be:
      """
      0
      """

  Scenario: Reset all sidebars
    Given a WP install

    When I run `wp theme install twentysixteen --activate`
    Then STDOUT should not be empty

    When I run `wp widget add calendar sidebar-1 --title="Calendar"`
    Then STDOUT should not be empty
    When I run `wp widget add search sidebar-2 --title="Quick Search"`
    Then STDOUT should not be empty
    When I run `wp widget add text sidebar-3 --title="Text"`
    Then STDOUT should not be empty

    When I run `wp widget reset --all`
    And I run `wp widget list sidebar-1 --format=count`
    Then STDOUT should be:
      """
      0
      """
    And I run `wp widget list sidebar-2 --format=count`
    Then STDOUT should be:
      """
      0
      """
    And I run `wp widget list sidebar-3 --format=count`
    Then STDOUT should be:
      """
      0
      """
