# firebase_anon_bug

This flutter project accompanies the `firebase` folder to reproduce the bug listed here: https://github.com/firebase/flutterfire/issues/12473

## Reproducing the error

* Create an anonymous account.
* Enter username & password to upgrade anonymous account to registered.
* Error: `beforeCreate` trigger fires on live deployment (beforeCreate trigger does not fire with Firebase emulator). 