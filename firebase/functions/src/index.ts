import admin from "firebase-admin";
admin.initializeApp({
  credential: admin.credential.applicationDefault(),
  projectId: process.env.GCLOUD_PROJECT,
});
admin.firestore().settings({ignoreUndefinedProperties: true});

import {beforeCreateFunc} from "./beforeCreate.js";
export const beforeCreate = beforeCreateFunc;
