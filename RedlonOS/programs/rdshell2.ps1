# Define the Reddit username
$user = "Ill_Specialist_5594" # Replace with the actual Reddit username

# Reddit API URLs
$posts_url = "https://www.reddit.com/user/$user/submitted.json?limit=1"
$comments_url = "https://www.reddit.com/user/$user/comments.json?limit=1"

# Fetch most recent post
$posts_response = Invoke-RestMethod -Uri $posts_url -Headers @{ "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/91.0.4472.124 Safari/537.36" }

# Fetch most recent comment
$comments_response = Invoke-RestMethod -Uri $comments_url -Headers @{ "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/91.0.4472.124 Safari/537.36" }

# Extract the title and URL of the most recent post
$recent_post = $posts_response.data.children[0].data
$post_title = $recent_post.title
$post_url = "https://www.reddit.com" + $recent_post.permalink
$post_created = $recent_post.created

# Extract the comment and URL of the most recent comment
$recent_comment = $comments_response.data.children[0].data
$comment_text = $recent_comment.body
$comment_url = "https://www.reddit.com" + $recent_comment.permalink
$comment_created = $recent_comment.created

# Convert Unix timestamp to DateTime by adding the seconds to the Unix epoch (1970-01-01)
$unix_epoch = [System.DateTime]::Parse("1970-01-01 00:00:00")
$post_created_date = $unix_epoch.AddSeconds($post_created)
$comment_created_date = $unix_epoch.AddSeconds($comment_created)

# Display the recent post and comment with formatted dates
Write-Host "Most Recent Post:"
Write-Host "Title: $post_title"
Write-Host "URL: $post_url"
Write-Host "Posted: $post_created_date"
Write-Host ""
Write-Host "Most Recent Comment:"
Write-Host "Text: $comment_text"
Write-Host "URL: $comment_url"
Write-Host "Posted: $comment_created_date"
