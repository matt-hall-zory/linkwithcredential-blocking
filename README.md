# linkwithcredential-blocking

This is the MCVE to reproduce the firebase bug outlined here: https://github.com/firebase/flutterfire/issues/12473.
Note that this bug only happens when deployed live. Emulator behaves correctly.
`flutter` folder holds the flutter client able to create anonymous users, create email and password and trigger the bug.
`firebase` folder holds the firebase client with a blocking function for onCreate.
