# Rails App must not be running for this to work
echo "Deletes Local DB and pulls the one from Heroku"
sleep 5
dropdb confessions_development
heroku pg:pull DATABASE_URL confessions_development
