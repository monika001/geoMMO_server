FORMAT: 1A
HOST: http://geommo.herokuapp.com/api/v1

# geommo

# Group User
User related resources

## User [/user/]
User can manage himself

### Get current user [GET]
Retrieve a current user. Users cannot access different users.
+ Request

    + Header

            Authorization: Token token="6t/aXgpL+pL96jdG1QtDfA=="


+ Response 200 (application/json)

    + Body

            {
                "user":
                {
                    "id": 1,
                    "email": "sample@email.co",
                    "first_name": "Sample",
                    "last_name": "Sample"
                }
            }

+ Response 401 (application/json)

    + Body

            {
                "errors": [ "user is not authorized" ]
            }

### Create an user [POST]
Register a user.

+ Request (application/json)

        {
            "user":
            {
                "email": "sample@email.co",
                "password": "samplePassword",
                "password_confirmation": "samplePassword"
            }
        }

+ Response 201 (application/json)

    + Header

            "Location": "api/v1/user/"

    + Body

            {
                "user":
                {
                    "id": 1,
                    "email": "sample@email.co"
                }
            }

+ Response 422 (application/json)

    + Body

            {
                "errors": [ "email has already been taken" ]
            }

### Update an user [PUT]
Update an existing user.

+ Request (application/json)

    + Header

            Authorization: Token token="6t/aXgpL+pL96jdG1QtDfA=="

    + Body

            {
                "user":
                {
                    "password": "samplePassword",
                    "password_confirmation": "samplePassword"
                }
            }

+ Response 204 (application/json)

+ Response 401 (application/json)

    + Body

            {
                "errors": [ "user is not authorized" ]
            }

+ Response 422 (application/json)

    + Body

            {
                "errors": [ "email has already been taken" ]
            }

### Destroy a current user [DELETE]
Delete given user

+ Request (application/json)

    + Header

            Authorization: Token token="6t/aXgpL+pL96jdG1QtDfA=="

+ Response 204 (application/json)

+ Response 401 (application/json)

    + Body

            {
                "errors": [ "user is not authorized" ]
            }

+ Response 422 (application/json)

    + Body

            {
                "errors": [ "user cannot be deleted" ]
            }

## Session [/session]
Session management for user

### Log in user [POST]
Log in registered user

+ Request (application/json)

    + Body

            {
                "session":
                {
                    "email": "sample@email.co",
                    "password": "samplePassword"
                }
            }

+ Response 200 (application/json)

    + Body

            {
                "session":
                {
                    "token": "JNwBb3qhCAZCWtTHeJReOA=="
                }
            }

+ Response 422 (application/json)

    + Body

            {
                "errors": [ "invalid email or password" ]
            }

### Log out user [DELETE]
Log out a user, form session

+ Request (application/json)

    + Header

            Authorization: Token token="6t/aXgpL+pL96jdG1QtDfA=="

+ Response 204 (application/json)

+ Response 401 (application/json)

    + Body

            {
                "errors": [ "user is not authorized" ]
            }

+ Response 422 (application/json)

    + Body

            {
                "errors": [ "user cannot be deleted" ]
            }
