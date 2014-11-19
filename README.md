# lita-ey-tools

[![Gem Version](https://badge.fury.io/rb/lita-ey-tools.svg)](http://badge.fury.io/rb/lita-ey-tools)
[![Build Status](https://travis-ci.org/carlosparamio/lita-ey-tools.png?branch=master)](https://travis-ci.org/carlosparamio/lita-ey-tools)
[![Code Climate](https://codeclimate.com/github/carlosparamio/lita-ey-tools.png)](https://codeclimate.com/github/carlosparamio/lita-ey-tools)
[![Coverage Status](https://coveralls.io/repos/carlosparamio/lita-ey-tools/badge.png)](https://coveralls.io/r/carlosparamio/lita-ey-tools)

**lita-ey-tools** is a handler for [Lita](http://lita.io/) that provides some EngineYard tools.

## Installation

Add lita-ey-tools to your Lita instance's Gemfile:

``` ruby
gem "lita-ey-tools"
```

Don't forget to include your EngineYard API key on the lita_config.rb file:

``` ruby
  config.handlers.ey.api_token = "YOUR_EY_API_TOKEN"
  config.handlers.ey.apps = {
    "my_app_name_for_lita" => {
      "ey_name" => "my_app_name_at_ey",
      "app_dir" => "/data/myapp/current",
      "envs" => {
        "test" => {
          ey_name: "my_app_testing",
          auth_group: "devs",
          default_branch: "develop",
          app_url: "test.myapp.com",
          db_name: "db_name",
          db_host: "db.hostname.com",
          db_user: "db_user",
          db_password: "db_password"
        },
        "stage" => {
          ey_name: "my_app_staging",
          auth_group: "testers",
          default_branch: "stage"
          app_url: "stage.myapp.com",
          db_name: "db_name",
          db_host: "db.hostname.com",
          db_user: "db_user",
          db_password: "db_password"
        },
        "production" => {
          ey_name: "my_app_production",
          auth_group: "devops",
          default_branch: "master"
          app_url: "www.myapp.com",
          db_name: "db_name",
          db_host: "db.hostname.com",
          db_user: "db_user",
          db_password: "db_password"
        }
      }
    }
  }
```

## Usage

```
You: @Lita ey dbdump <app> <env>
```

## See also

[lita-ey-info](http://github.com/carlosparamio/lita-ey-info)
[lita-ey-deploy](http://github.com/carlosparamio/lita-ey-deploy)

## License

[MIT](http://opensource.org/licenses/MIT)
