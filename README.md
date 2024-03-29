# Rails Engine

[![Contributors][contributors-shield]][contributors-url]
[![Issues][issues-shield]][issues-url]
[![Stargazers][stars-shield]][stars-url]
[![Forks][forks-shield]][forks-url]

## Welcome to Rails Engine: A hand-rolled RESTful JSON API

### [Schema](https://dbdesigner.page.link/GJiEhJGfXZSc8YUY7)
<p align="center">
  <img src="https://user-images.githubusercontent.com/58891447/132774822-db17c2f6-c8cf-46dd-9ce0-9ac1796fea87.png" alt="rails_engine_db_schema"/>
</p>

Find the project spec [here](https://backend.turing.edu/module3/projects/rails_engine/)

## Table of Contents

- [Overview](#overview)
- [Tools Utilized](#framework)
- [Contributors](#contributors)
- [Sample Endpoints](#sample-endpoints)
- [Project Configurations](#setup)


------

### <ins>Overview</ins>

[Rails Engine](https://github.com/tvaroglu/rails-engine) is a 7 day, 1 person project, during Mod 3 of 4 for Turing School's Back End Engineering Program.

The challenge was to build a fully functional [JSON API 1.0 spec](https://jsonapi.org/)-compliant REST API that exposes endpoints for multiple resources from a relational database, modeling a true back-end framework that could be consumed by an entirely separate front-end framework.

Learning goals and areas of focus consisted of:

- Exposing a RESTful JSON API
- Using serializers to format JSON responses
- Testing API exposure, including edge case coverage and error handling
- Writing SQL statements without the assistance of an ORM

[Technical Requirements](https://backend.turing.edu/module3/projects/rails_engine/requirements)

#### <ins>Framework</ins>
<p>
  <img src="https://img.shields.io/badge/Ruby%20On%20Rails-b81818.svg?&style=flat&logo=rubyonrails&logoColor=white" />
</p>

#### Languages
<p>
  <img src="https://img.shields.io/badge/Ruby-CC0000.svg?&style=flaste&logo=ruby&logoColor=white" />
  <img src="https://img.shields.io/badge/ActiveRecord-CC0000.svg?&style=flaste&logo=rubyonrails&logoColor=white" />
  <img src="https://img.shields.io/badge/SQL-CC0000.svg?&style=flaste&logo=SQL&logoColor=white" />
</p>

#### Tools
<p>
  <img src="https://img.shields.io/badge/Atom-66595C.svg?&style=flaste&logo=atom&logoColor=white" />  
  <img src="https://img.shields.io/badge/Git-F05032.svg?&style=flaste&logo=git&logoColor=white" />
  <img src="https://img.shields.io/badge/GitHub-181717.svg?&style=flaste&logo=github&logoColor=white" />
  </br>
  <img src="https://img.shields.io/badge/Postman-f74114.svg?&style=flat&logo=postman&logoColor=white" />
  <img src="https://img.shields.io/badge/Heroku-430098.svg?&style=flaste&logo=heroku&logoColor=white" />
  <img src="https://img.shields.io/badge/PostgreSQL-4169E1.svg?&style=flaste&logo=postgresql&logoColor=white" />
</p>

#### Gems
<p>
  <img src="https://img.shields.io/badge/rspec-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/pry-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />  
  <img src="https://img.shields.io/badge/simplecov-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />  
  <img src="https://img.shields.io/badge/factory--bot-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
  </br>
  <img src="https://img.shields.io/badge/faker-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />  
  <img src="https://img.shields.io/badge/database--cleaner-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/rubocop-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
</p>

#### Development Principles
<p>
  <img src="https://img.shields.io/badge/OOP-b81818.svg?&style=flaste&logo=OOP&logoColor=white" />
  <img src="https://img.shields.io/badge/TDD-b87818.svg?&style=flaste&logo=TDD&logoColor=white" />
  <img src="https://img.shields.io/badge/MVC-b8b018.svg?&style=flaste&logo=MVC&logoColor=white" />
  <img src="https://img.shields.io/badge/REST-33b818.svg?&style=flaste&logo=REST&logoColor=white" />  
</p>

### <ins>Contributors</ins>

👤  **Taylor Varoglu**
- Github: [Taylor Varoglu](https://github.com/tvaroglu)
- LinkedIn: [Taylor Varoglu](https://www.linkedin.com/in/taylorvaroglu/)

<!-- MARKDOWN LINKS & IMAGES -->

[contributors-shield]: https://img.shields.io/github/contributors/tvaroglu/rails-engine.svg?style=flat
[contributors-url]: https://github.com/tvaroglu/rails-engine/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/tvaroglu/rails-engine.svg?style=flat
[forks-url]: https://github.com/tvaroglu/rails-engine/network/members
[stars-shield]: https://img.shields.io/github/stars/tvaroglu/rails-engine.svg?style=flat
[stars-url]: https://github.com/tvaroglu/rails-engine/stargazers
[issues-shield]: https://img.shields.io/github/issues/tvaroglu/rails-engine.svg?style=flat
[issues-url]: https://github.com/tvaroglu/rails-engine/issues

## <ins>Sample Endpoints</ins>
`GET` Merchants
  * <span>Get All Merchants: `{{base_url}}/api/v1/merchants`</span>
    * Optional `query params` for pagination:
        * `?per_page=<integer>`
        * `?page=<integer>`
  * <span>Get Merchant by Id: `{{base_url}}/api/v1/merchants/{{id}}`</span>
  * <span>Get Merchant by Name: `{{base_url}}/api/v1/merchants/find?name={{search_param}}`</span>
    * REQUIRED `query params` for search:
        * `?name=<string>`
  * <span>Get Merchant's Items: `{{base_url}}/api/v1/merchants/{{id}}/items`</span>
  * <span>Get Top Merchants by Items Sold:`{{base_url}}/api/v1/merchants/most_items?quantity={{search_param}}`</span>
    * REQUIRED `query params` for search:
        * `?quantity=<integer>`

`GET` Items
  * <span>Get All Items: `{{base_url}}/api/v1/items`</span>
    * Optional `query params` for pagination:
        * `?per_page=<integer>`
        * `?page=<integer>`
  * <span>Get Item by Id: `{{base_url}}/api/v1/items/{{id}}`</span>
  * <span>Get Item by Name: `{{base_url}}/api/v1/items/find_all?name={{search_param}}`</span>
    * REQUIRED `query params` for search:
        * `?name=<string>`
  * <span>Get Item's Merchant: `{{base_url}}/api/v1/items/{{id}}/merchant`</span>

`GET` Revenue
  * <span>Get Merchants Ranked by Revenue: `{{base_url}}/api/v1/revenue/merchants?quantity={{search_param}}`</span>
    * REQUIRED `query params` for search:
        * `?quantity=<integer>`
  * <span>Get Revenue for a Merchant: `{{base_url}}/api/v1/revenue/merchants/{{id}}`</span>
  * <span>Get Items Ranked by Revenue: `{{base_url}}/api/v1/revenue/items`</span>
    * Optional `query params` for search:
        * `?quantity=<integer>`


## <ins>Setup</ins>

This project requires Ruby 2.7.2 and Rails 5.2.6.

* Fork this repository
* Install gems and set up your database:
    * `bundle`
    * `rails db:{drop,create,migrate,seed}`
    * `rails db:schema:dump`
* Run the test suite with `bundle exec rspec -fd`
* Run your development server with `rails s`


### Project Configurations

* Ruby version
    ```bash
    $ ruby -v
    ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [x86_64-darwin20]
    ```

* [System dependencies](https://github.com/tvaroglu/rails-engine/blob/main/Gemfile)
    ```bash
    $ rails -v
    Rails 5.2.6
    ```

* Database creation
    ```bash
    $ rails db:{drop,create,migrate,seed}
    ...
    $ rails db:schema:dump
    ```

* How to run the test suite
    ```bash
    $ bundle exec rspec -fd
    ```

* [Local Deployment](http://localhost:3000), for testing:
    ```bash
    $ rails s
    => Booting Puma
    => Rails 5.2.6 application starting in development
    => Run `rails server -h` for more startup options
    Puma starting in single mode...
    * Version 3.12.6 (ruby 2.7.2-p137), codename: Llamas in Pajamas
    * Min threads: 5, max threads: 5
    * Environment: development
    * Listening on tcp://localhost:3000
    Use Ctrl-C to stop
    ```
