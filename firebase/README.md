# linkwithcredential-blocking (firebase)

beforeCreate should NOT be called when migrating an anonymous account to a registered account with email/password.
This firebase project only contains the "beforeCreate" blocking function and the index file used to initialise the function.

# emulators vs live

This bug only happens on live servers. Regardless, emulators for auth and function have been set up.