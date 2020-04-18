/* ********************************************************************************************
   | Handle Submitting Posts - called by $('#post-button').click(submitPost)
   ********************************************************************************************
   */
function spResponse(data, status) {
    if (status == 'success') {
        // reload page to update like count
        location.reload();
    } else {
        alert('failed to submit post ' + status);
    }
}

function submitPost(event) {
    // Objective 8: send contents of post-text via AJAX Post to post_submit_view (reload page upon success)

    // Get the text from the <p> with id = post-text
    let postContent = document.getElementById("post-text").textContent;
    let json_data = { 'postContent': postContent };

    let url_path = post_submit_url;

    // AJAX post
    $.post(url_path,
        json_data,
        spResponse);
}

/* ********************************************************************************************
   | Handle Liking Posts - called by $('.like-button').click(submitLike)
   ********************************************************************************************
   */
  function slResponse(data, status) {
    if (status == 'success') {
        // reload page to update like count
        location.reload();
    }
    else {
        alert('failed to like post' + status);
    }
}

function submitLike(event) {
    // Objective 10: send post-n id via AJAX POST to like_view (reload page upon success)

        // the id of the current button, should be post-id
        let postID = event.target.id;
        let json_data = { 'postID': postID };
        // globally defined in messages.djhtml using i{% url 'social:like_view' %}
        let url_path = like_post_url;
    
        // AJAX post
        $.post(url_path,
            json_data,
            slResponse);
}

/* ********************************************************************************************
   | Handle Requesting More Posts - called by $('#more-button').click(submitMore)
   ********************************************************************************************
   */
function moreResponse(data, status) {
    if (status == 'success') {
        // reload page to display new Post
        location.reload();
    }
    else {
        alert('failed to request more posts' + status);
    }
}

function submitMore(event) {
    // submit empty data
    let json_data = {};
    // globally defined in messages.djhtml using i{% url 'social:more_post_view' %}
    let url_path = more_post_url;

    // AJAX post
    $.post(url_path,
        json_data,
        moreResponse);
}

/* ********************************************************************************************
   | Document Ready (Only Execute After Document Has Been Loaded)
   ********************************************************************************************
   */
$(document).ready(function () {
    // handle post submission
    $('#post-button').click(submitPost);
    // handle likes
    $('.like-button').click(submitLike);
    // handle more posts
    $('#more-button').click(submitMore);
});
