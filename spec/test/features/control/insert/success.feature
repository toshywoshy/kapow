Feature: Insert new routes in Kapow! server.
  Insert routes allow users to configure the server. New
  routes could be inserted at the begining or before any
  existing route of the routes list.

  Background:
    Given I have a Kapow! server whith the following routes:
      | method | url_pattern        | entrypoint | command                                          |
      | GET    | /listRootDir       | /bin/sh -c | ls -la / \| response /body                       |
      | GET    | /listDir/{dirname} | /bin/sh -c | ls -la /request/params/dirname \| response /body |

  Scenario: Insert a route at the beginning.
    A route can be inserted at the begining of the list
    by specifying an index 0 in the request.

      When I insert the route:
        | method | url_pattern  | entrypoint | command                    | index |
        | GET    | /listRootDir | /bin/sh -c | ls -la / \| response /body |     0 |
      Then I get ok as response code
      And I get "OK" as response phrase
      And I get the following entity as response body:
        | method | url_pattern  | entrypoint | command                    | index | id |
        | GET    | /listRootDir | /bin/sh -c | ls -la / \| response /body |     0 |  * |

  Scenario: Insert a route in the middle.
    A route can be inserted in the middle of the list
    by specifying an index less or equal to the last
    index in the request.

      When I insert the route:
        | method | url_pattern  | entrypoint | command                    | index |
        | GET    | /listRootDir | /bin/sh -c | ls -la / \| response /body |     1 |
      Then I get ok as response code
      And I get "OK" as response phrase
      And I get the following entity as response body:
        | method | url_pattern  | entrypoint | command                    | index | id |
        | GET    | /listRootDir | /bin/sh -c | ls -la / \| response /body |     1 |  * |