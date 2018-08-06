# line_server

## Configuration
Line Server Application that has one route.
Users request specific lines of text in a given immutable file.
The file used in the example is lib/assets/medium_text.
To setup local caching: `rails dev:cache`

##Local Setup

Route: GET localhost:3000/api/v1/lines/:id
Sample request: GET http://localhost:3000/api/v1/lines/332809
Response:
```
{
  "status": "ok",
  "line_number": 332809,
  "line_text": "This is some text.\n"
}
```