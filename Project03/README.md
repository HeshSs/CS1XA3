# CS 1XA3 Project03 - Salehh6

## Usage

Install pre-existing conda environment with

    conda env create -f environment.yml

List of current environments

    conda info --envs

Activate environment

    conda activate djangoenv

Run locally with

    python manage.py runserver localhost:8000

Run on mac1xa3.ca with

    python manage.py runserver localhost:10086

Run on mac1xa3.ca on the background with

    python manage.py runserver localhost:10086 &

Log in with:
| User    | Password   |
|---------|------------|
| hishmat | hello54321 |
| MyTest  | notfunny   |
| MyGirl  | funnier21  |
| MyBoy   | funny321   |

Make migrations

    python manage.py makemigrations
    python manage.py migrate

Kill server

    killall python

## Objective 01

Description:
- This feature is displayed in signup.djhtml which is rendered by
signup_view.
- It makes a POST Request when the user tries to create a new user ands sends it to /e/salehh6/signup/ and signup_view handles it and creates a new UserInfo in the database.
Exceptions:
- If the form at /e/salehh6/signup/ is half empty and the user tries to submit it, it redirects the user back to signup.djhtml with a error message.

## Objective 02

Description:

* TODO

Exceptions:

* TODO

## Objective 03

Description:

* TODO

Exceptions:

* TODO

## Objective 04

Description:

* TODO

Exceptions:

* TODO

## Objective 05

Description:

* TODO

Exceptions:

* TODO

## Objective 06

Description:

* TODO

Exceptions:

* TODO

## Objective 07

Description:

* TODO

Exceptions:

* TODO

## Objective 08

Description:

* TODO

Exceptions:

* TODO

## Objective 09

Description:

* TODO

Exceptions:

* TODO

## Objective 10

Description:

* TODO

Exceptions:

* TODO

## Objective 11

Description:

* TODO

Exceptions:

* TODO
