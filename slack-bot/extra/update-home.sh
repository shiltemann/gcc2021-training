BOT_USER_TOKEN=xoxb-
USER_ID=U01F7TAQXNG

curl -X POST -d@extra/home.json -H "Content-type: application/json" -H "Authorization: Bearer $BOT_USER_TOKEN"  https://slack.com/api/views.publish
