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

## Objective 01: Login and SingUp Pages

Description:

* This feature is displayed in signup.djhtml which is rendered by

signup_view.

* It makes a POST Request when the user tries to create a new user ands sends it to /e/salehh6/signup/ and signup_view handles it and creates a new UserInfo in the database.

Exceptions:

* If the form at /e/salehh6/signup/ is half empty and the user tries to submit it, it redirects the user back to signup.djhtml with a error message.

## Objective 02: User Profile and Interests

Description:

* This feature is displayed in the left_column of messages.djhtml, people.djhtml and account.djhtml and contains user's info (e.g.birthday, interests, etc.)

## Objective 03: Account Settings Page

Description:

* You can reach the Account Settings page by clicking on the top right icon.
* This feature is displayed in account.djhtml and is rendered by account_view.
* Handles POST Requests for changing the User Info and/or password.

Exceptions:

* Either of the forms can't be half empty, otherwise the form returns an error message.

## Objective 04: Displaying People List

Description:

* You can reach the People Page by clicking on the people icon on the top left corner.
* This feature is displayed in middle column of people.djhtml and rendered by people_view and shows the list of the people that the user is not friends with.
* When the page is loaded for the first time only one person is shown (if the person is not friends with that person)
* It handles AJAX POST from the static file people.js and shows more people when the More button is clicked.

## Objective 05: Sending Friend Requests

Description:

* This feature is displayed in the right column of people.djhtml and rendered by friend_request_view and shows the list of friend requests that the user has received.
* It handles POST request by the user and adds a new FriendRequest to the database.

## Objective 06: Accepting / Declining Friend Requests

Description:

* This feature is implemented on the Accept/Decline buttons for a friend request that was displayed in Objective 5
* When one of the buttons is clicked, a POST request is sent from people.js to  accept_decline_view with id of the username of that person
* When the request is accepted, both users are added as friends, otherwise the friend request is deleted.

## Objective 07: Displaying Friends List

Description:

* You can reach the List of Friends by clicking on the message icon on the top left corner.
* This feature is displayed in right column of messages.djhtml and rendered by messages_view and shows the list of the people that the user is friends with.

## Objective 08: Submitting Posts

Description:

* This feature is displayed in the middle column of Messages Page
* When the post button is clicked an AJAX POST is sent from messages.js to post_submit_view and a new Post is added to the database
* Page is reloaded when post is submitted successfully

Exceptions:
- 

## Objective 09: Displaying Post List

Description:

* TODO

Exceptions:

* TODO

## Objective 10: Liking Posts and Displaying Like Count

Description:

* TODO

Exceptions:

* TODO

## Objective 11: Create a Test Database

Description:

* TODO

Exceptions:

* TODO

