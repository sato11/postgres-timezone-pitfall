# postgres-timezone-pitfall
See how postgres' embedded function `current_timestamp` (or `current_date` equivalently) refers to database instance's timezone, which might be inconsistent with your application's timezone. For example, when you're using Amazon RDS, [the timezone of the database is UTC by default, and you're not advised to change it](https://aws.amazon.com/premiumsupport/knowledge-center/rds-change-time-zone). Everything is fine as long as you stick to UTC as your application's timezone, but otherwise, you will have to be cautious when manipulating timestamp values. You are not advised to use postgres' `current_timastamp` function in such circumstances, as it might betray your application's logic.

In our sample implementation, we have two simple queries, namely:

1. `SELECT current_timestamp ;`, and
1. `SELECT :current_timestamp: ;`, where `:current_timestamp:` is provided programatically.

Given the database server uses UTC and the application server JST, the queries above will generate the following outputs, respectively:

1. 2020-09-01 00:00:00 +0000
1. 2020-09-01 09:00:00 +0900

Troubles are coming to life when you are inserting these values uncautiously into any column whose type is `timezone without timezone`. It is recommended that you use the latter option unless you understand the outcome to the full extent.

## Usage
```
% docker-compose build .
% docker-compose run app bundle exec rake db:create
% docker-compose run app bundle exec rake db:migrate
% docker-compose run app
```
