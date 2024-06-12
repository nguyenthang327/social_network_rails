
$(document).ready(function() {
  const token = $('meta[name="csrf-token"]').attr('content');

  $(document).on('click', '.edit-post-link', function(event) {
    event.preventDefault();
    const postId = $(this).data('post-id');
  
    $('#editPostModal').modal('show');
    $.get('/posts/' + postId + '/edit', function(data) {
      $('#editPostForm').attr('action', '/posts/' + postId);
      $('#titlePostId').text(data.id);
      $('#post_title').val(data.title);
      $('#post_content').val(data.content);
      $('#editPostModal').modal('show');
    });
  });
  
  $('#saveChanges').on('click', function() {
    $('#editPostForm').submit();
  });

  $('.like-button').on('click', function(e) {
    e.preventDefault();
    const postId = $(this).data('post-id');
    const url = $(this).data('href');

    $.ajax({
      type: 'POST',
      url: url,
      dataType: 'json',
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', token);
      },
      success: function(data) {
        updateButton(data.liked, postId);
        updateCount(data.likes_count, postId);
      },
      error: function(xhr, status, error) {
        console.error('Error:', error);
      }
    });
  });

  function updateButton(liked, postId) {
    var button = $(`.like-button[data-post-id="${postId}"]`);
    if (liked) {
      button.removeClass('btn-outline-secondary').addClass('btn-outline-primary');
    } else {
      button.removeClass('btn-outline-primary').addClass('btn-outline-secondary');
    }
  }

  function updateCount(count, postId) {
    $(`.like-button[data-post-id="${postId}"] .like-count`).text(count);
  }

  $('.comment-form').on('submit', function(e) {
    e.preventDefault();
    const postId = $(this).data('post-id');
    const url = $(this).attr('action');

    $.ajax({
      type: 'POST',
      url: url,
      dataType: 'json',
      data: $(this).serialize(),
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', token);
      },
      success: function(data) {
        const commentList = $(`#comment-list-${postId}`);
        const newCommentHtml = `
          <li>
            <span class="fw-bold d-inline-block">${data.user.name}</span>: ${data.content}
          </li>
        `;
        commentList.append(newCommentHtml);
        $(`#comment-form_${postId}`).trigger("reset");
      },
      error: function(xhr, status, error) {
        console.error('Error:', error);
      }
    });
  });
});