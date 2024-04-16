import functions from "firebase-functions";
/**
 * Before creating an auth record, this function is called
 * We NEVER allow creation of auth records via this call - we must always block them
 * Accounts can only ever be migrated from anonymous accounts
 * https://firebase.google.com/docs/functions/beta/auth-blocking-events
 */
// eslint-disable-next-line @typescript-eslint/no-unused-vars
export const beforeCreateFunc = functions.auth.user().beforeCreate(async (user, context) => {
  functions.logger.info(`beforeCreate function called \n${JSON.stringify(user)}\n${JSON.stringify(context)}`);

  // beforeCreate is ALWAYS blocked.
  // if this is not blocked then "orphan" auth records are created whenever a user tries to sign in with an account that doesn't exist
  // auth records are always anonymous first then LINKED to a Google Account/Password, etc.

  throw new functions.auth.HttpsError("failed-precondition", "beforeCreate is always blocked");
});
