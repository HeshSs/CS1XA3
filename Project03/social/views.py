from django.http import HttpResponse, HttpResponseNotFound
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.forms import AuthenticationForm, UserCreationForm, PasswordChangeForm
from django.contrib.auth import authenticate, login, logout, update_session_auth_hash
from django.contrib import messages

from . import models


def messages_view(request):
    """Private Page Only an Authorized User Can View, renders messages page
       Displays all posts and friends, also allows user to make new posts and like posts
    Parameters
    ---------
      request: (HttpRequest) - should contain an authorized user
    Returns
    --------
      out: (HttpResponse) - if user is authenticated, will render private.djhtml
    """
    if request.user.is_authenticated:
        user_info = models.UserInfo.objects.get(user=request.user)

        # Objective 9: query for posts (HINT only return posts needed to be displayed)
        # number of posts to show
        request.session['show_post'] = request.session.get('show_post', 1)
        show_post = int(request.session.get('show_post', 1))

        posts = list(models.Post.objects.all().order_by('-timestamp'))

        posts = posts[:show_post]

        # Objective 10: check if user has liked post, attach as a new attribute to each post

        liked_posts = dict()
        for post in posts:
            if (post.likes.filter(user=user_info).exists()):
                liked_posts[post] = True
            else:
                liked_posts[post] = False
            #print(liked_posts.get(post))
        
        posts = liked_posts

        context = {'user_info': user_info, 'posts': posts}
        return render(request, 'messages.djhtml', context)

    request.session['failed'] = True
    return redirect('login:login_view')


def account_view(request):
    """Private Page Only an Authorized User Can View, allows user to update
       their account information (i.e UserInfo fields), including changing
       their password
    Parameters
    ---------
      request: (HttpRequest) should be either a GET or POST
    Returns
    --------
      out: (HttpResponse)
                 GET - if user is authenticated, will render account.djhtml
                 POST - handle form submissions for changing password, or User Info
                        (if handled in this view)
    """

    # Objective 3: Create Forms and Handle POST to Update Password / UserInfo
    if request.user.is_authenticated:
        user_info = models.UserInfo.objects.get(user=request.user)

        if request.method == 'POST':
            password_form = PasswordChangeForm(request.user, request.POST)
            user_form = models.ModifyInfoForm(request.POST)

            # Password change
            if password_form.is_valid():
                user = password_form.save()
                update_session_auth_hash(request, user)
                return redirect('social:account_view')

            # User Info change
            if user_form.is_valid():

                # Update user info
                user_info.employment = user_form.cleaned_data.get('employment')
                user_info.location = user_form.cleaned_data.get('location')
                user_info.birthday = user_form.cleaned_data.get('birthday')

                # Save interests
                L = user_form.cleaned_data.get('interests').split(",")
                interests = list()
                for i in L:
                    interest = models.Interest(label=i)
                    interest.save()
                    interests.append(interest)
                user_info.interests.add(*interests)

                # Save all data
                user_info.save()

        else:
            password_form = PasswordChangeForm(request.user)
            user_form = models.ModifyInfoForm()

        context = {'user_info': user_info,
                   'password_change_form': password_form, 'user_info_form': user_form}
        return render(request, 'account.djhtml', context)

    request.session['failed'] = True
    return redirect('login:login_view')


def people_view(request):
    """Private Page Only an Authorized User Can View, renders people page
       Displays all users who are not friends of the current user and friend requests
    Parameters
    ---------
      request: (HttpRequest) - should contain an authorized user
    Returns
    --------
      out: (HttpResponse) - if user is authenticated, will render people.djhtml
    """
    if request.user.is_authenticated:
        user_info = models.UserInfo.objects.get(user=request.user)

        # Objective 4: create a list of all users who aren't friends to the current user (and limit size)
        # number of people to show
        request.session['show'] = request.session.get('show', 1)
        show = int(request.session.get('show', 1))

        # People that the current user is not friends with
        all_people = []
        users = models.UserInfo.objects.all()
        for user in users:
            if user not in user_info.friends.all() and user != user_info:
                all_people.append(user)

        all_people = all_people[:show]

        # Objective 5: create a list of all friend requests to current user
        all_requests = models.FriendRequest.objects.all()
        friend_requests = []

        for friend_request in all_requests:
            if friend_request.to_user == user_info:
                friend_requests.append(friend_request)

        context = {'user_info': user_info,
                   'all_people': all_people,
                   'friend_requests': friend_requests}

        return render(request, 'people.djhtml', context)

    request.session['failed'] = True
    return redirect('login:login_view')


def like_view(request):
    '''Handles POST Request recieved from clicking Like button in messages.djhtml,
       sent by messages.js, by updating the corrresponding entry in the Post Model
       by adding user to its likes field
    Parameters
        ----------
          request : (HttpRequest) - should contain json data with attribute postID,
                                a string of format post-n where n is an id in the
                                Post model

        Returns
        -------
          out : (HttpResponse) - queries the Post model for the corresponding postID, and
                             adds the current user to the likes attribute, then returns
                             an empty HttpResponse, 404 if any error occurs
    '''
    postIDReq = request.POST.get('postID')
    if postIDReq is not None:
        # remove 'post-' from postID and convert to int
        # Objective 10: parse post id from postIDReq
        postID = int(postIDReq[5:])

        if request.user.is_authenticated:
            # Objective 10: update Post model entry to add user to likes field
            user_info = models.UserInfo.objects.get(user=request.user)
            posts = list(models.Post.objects.all().order_by('-timestamp'))

            # Get the post with given post ID
            post = posts[postID]

            # Like the post if the current user hasn't liked it yet.
            if (not post.likes.filter(user=user_info).exists()):
                post.likes.add(user_info)

            # return status='success'
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('like_view called without postID in POST')


def post_submit_view(request):
    '''Handles POST Request recieved from submitting a post in messages.djhtml by adding an entry
       to the Post Model
    Parameters
        ----------
          request : (HttpRequest) - should contain json data with attribute postContent, a string of content

        Returns
        -------
          out : (HttpResponse) - after adding a new entry to the POST model, returns an empty HttpResponse,
                             or 404 if any error occurs
    '''
    postContent = request.POST.get('postContent')
    if postContent is not None:
        if request.user.is_authenticated:

            # Objective 8: Add a new entry to the Post model
            # Post info
            user_info = models.UserInfo.objects.get(user=request.user)
            post = models.Post(owner=user_info, content=postContent)

            # Save post
            post.save()

            # return status='success'
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('post_submit_view called without postContent in POST')


def more_post_view(request):
    '''Handles POST Request requesting to increase the amount of Post's displayed in messages.djhtml
    Parameters
        ----------
          request : (HttpRequest) - should be an empty POST

        Returns
        -------
          out : (HttpResponse) - should return an empty HttpResponse after updating hte num_posts sessions variable
    '''
    if request.user.is_authenticated:
        # update the # of posts dispalyed

        # Objective 9: update how many posts are displayed/returned by messages_view
        request.session['show_post'] = int(
            request.session.get('show_post')) + 1

        # return status='success'
        return HttpResponse()

    return redirect('login:login_view')


def more_ppl_view(request):
    '''Handles POST Request requesting to increase the amount of People displayed in people.djhtml
    Parameters
        ----------
          request : (HttpRequest) - should be an empty POST

        Returns
        -------
          out : (HttpResponse) - should return an empty HttpResponse after updating the num ppl sessions variable
    '''
    if request.user.is_authenticated:
        # update the # of people dispalyed

        # Objective 4: increment session variable for keeping track of num ppl displayed
        request.session['show'] = int(request.session.get('show')) + 1

        # return status='success'
        return HttpResponse()

    return redirect('login:login_view')


def friend_request_view(request):
    '''Handles POST Request recieved from clicking Friend Request button in people.djhtml,
       sent by people.js, by adding an entry to the FriendRequest Model
    Parameters
        ----------
          request : (HttpRequest) - should contain json data with attribute frID,
                                a string of format fr-name where name is a valid username

        Returns
        -------
          out : (HttpResponse) - adds an etnry to the FriendRequest Model, then returns
                             an empty HttpResponse, 404 if POST data doesn't contain frID
    '''
    frID = request.POST.get('frID')
    if frID is not None:
        # remove 'fr-' from frID
        username = frID[3:]

        # Objective 5: add new entry to FriendRequest
        if request.user.is_authenticated:
            from_user_info = models.UserInfo.objects.get(user=request.user)
            user = models.User.objects.get(username=username)
            to_user_info = models.UserInfo.objects.get(user=user)

            friend_request = models.FriendRequest(
                from_user=from_user_info, to_user=to_user_info)

            if (not models.FriendRequest.objects.filter(from_user=from_user_info, to_user=to_user_info).exists()):
                friend_request.save()

            # return status='success'
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('friend_request_view called without frID in POST')


def accept_decline_view(request):
    '''Handles POST Request recieved from accepting or declining a friend request in people.djhtml,
       sent by people.js, deletes corresponding FriendRequest entry and adds to users friends relation
       if accepted
    Parameters
        ----------
          request : (HttpRequest) - should contain json data with attribute decision,
                                a string of format A-name or D-name where name is
                                a valid username (the user who sent the request)

        Returns
        -------
          out : (HttpResponse) - deletes entry to FriendRequest table, appends friends in UserInfo Models,
                             then returns an empty HttpResponse, 404 if POST data doesn't contain decision
    '''
    data = request.POST.get('decision')
    if data is not None:
        # Objective 6: parse decision from data
        decision = data[0]
        username = data[2:]

        if request.user.is_authenticated:
            # Objective 6: delete FriendRequest entry and update friends in both Users
            from_user_info = models.UserInfo.objects.get(user=request.user)
            user = models.User.objects.get(username=username)
            to_user_info = models.UserInfo.objects.get(user=user)

            # Delete the friend request
            models.FriendRequest.objects.get(
                from_user=to_user_info, to_user=from_user_info).delete()

            # Add the users as friends if friend request was accepted
            if decision == 'A':
                from_user_info.friends.add(to_user_info)
                to_user_info.friends.add(from_user_info)

            # return status='success'
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('accept-decline-view called without decision in POST')
