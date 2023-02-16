const functions = require("firebase-functions");
const stripe = require("stripe")('sk_test_51MXufcIXmdKwNYjDzpHrTwv42aY8LErRVMtLgYyFS79jzbXnuFgEvyFBV0XO7vms9VgQo8zLIEPWFPBS6M3xgJTM00N4hMsZ8H');
const admin = require('firebase-admin');
admin.initializeApp();

const createOrGetCustomerId = async function (userId) {
    const userDoc = await admin.firestore().collection('users').doc(userId).get();
    const userData = userDoc.data();
    if (userData.customerId != null && userData.customerId != '') {
        return userData.customerId;
    }
    const customer = await stripe.customers.create({
        name: userData.name
    });

    return customer.id;
}

const removeDuplicates = function arrayUnique(array) {
    var a = array.concat();
    for (var i = 0; i < a.length; ++i) {
        for (var j = i + 1; j < a.length; ++j) {
            if (a[i] === a[j])
                a.splice(j--, 1);
        }
    }
    return a;
}

exports.StripePayEndPointMethodIdJoinGroup = functions.https.onRequest(async (req, res) => {
    const { groupCode, userId } = req.body.data;

    const groupDoc = await admin.firestore().collection('groups').where('groupCode', "==", groupCode).get();
    const groupData = groupDoc.docs[0].data();

    const reward = groupData.reward * 100;
    const currency = groupData.groupCurrencyCode;
    const customerId = createOrGetCustomerId(userId);

    try {
        const paymentIntent = await stripe.paymentIntents.create({
            amount: reward,
            currency: currency,
            customer: customerId,
            automatic_payment_methods: {
                enabled: true,
            },
            setup_future_usage: 'off_session',
        });
        return res.send({
            data: {
                clientSecret: paymentIntent.client_secret,
                paymentIntentId: paymentIntent.id,
                reward: reward,
            }
        });
    } catch (e) {
        return res.send({ data: { clientSecret: '', error: e.message } });
    }
});

exports.StripePayEndPointMethodIdCreateGroup = functions.https.onRequest(async (req, res) => {
    const { userId, groupReward, groupCurrency } = req.body.data;

    const reward = groupReward * 100;
    const currency = groupCurrency;
    const customerId = createOrGetCustomerId(userId);

    try {
        const paymentIntent = await stripe.paymentIntents.create({
            amount: reward,
            currency: currency,
            customer: customerId,
            automatic_payment_methods: {
                enabled: true,
            },
            setup_future_usage: 'off_session',
        });
        return res.send({
            data: {
                clientSecret: paymentIntent.client_secret,
                paymentIntentId: paymentIntent.id,
            }
        });
    } catch (e) {
        return res.send({ data: { clientSecret: '', error: e.message } });
    }
});

exports.CreateAccount = functions.https.onRequest(async (req, res) => {

    const account = await stripe.accounts.create({
        type: 'express',
        country: 'BR',
        business_type: 'individual',
        business_profile: {
            mcc: '7623',
            product_description: 'GroupUp',
        },
        individual: {
            political_exposure: 'none',
        },
        capabilities: {
            card_payments: { requested: true },
            transfers: { requested: true },
        },
    });

    const accountLink = await stripe.accountLinks.create({
        account: account.id,
        refresh_url: 'https://groupupapp.page.link/stripe',
        return_url: 'https://groupupapp.page.link/stripe',
        type: 'account_onboarding',
        collect: 'eventually_due',
    });

    console.log(accountLink.url);
    console.log(account.details_submitted);

    return res.send({
        data: {
            accountId: account.id,
            accountLink: accountLink,
            accountLinkUrl: accountLink.url,
            detailsSubmitted: account.details_submitted,
        }
    });
});

exports.CreateAccountLink = functions.https.onRequest(async (req, res) => {
    const { accountId } = req.body.data;

    const accountLink = await stripe.accountLinks.create({
        account: accountId,
        refresh_url: 'https://groupupapp.page.link/stripe',
        return_url: 'https://groupupapp.page.link/stripe',
        type: 'account_onboarding',
        collect: 'eventually_due',
    });

    return res.send({
        data: {
            accountLink: accountLink,
            accountLinkUrl: accountLink.url,
        }
    });
});


exports.GetAccount = functions.https.onRequest(async (req, res) => {
    const { accountId } = req.body.data;
    const account = await stripe.accounts.retrieve(accountId);
    return res.send({
        data: {
            account: account,
            detailsSubmitted: account.details_submitted,
        }
    });
});

exports.LoginLink = functions.https.onRequest(async (req, res) => {
    const { accountId } = req.body.data;

    const loginLink = await stripe.accounts.createLoginLink(
        accountId
    );

    console.log(loginLink.url);

    return res.send({
        data: {
            loginLink: loginLink.url,
        }
    });
});

exports.CreateTransferStripe = functions.https.onRequest(async (req, res) => {
    const { accountId, amount, paymentIntentId } = req.body.data;

    const paymentIntent = await stripe.paymentIntents.retrieve(
        paymentIntentId,
    );

    try {
        const transfer = await stripe.transfers.create({
            amount: amount * 100,
            currency: 'brl',
            destination: accountId,
            source_transaction: paymentIntent.latest_charge,
        });

        return res.send({
            data: {
                transfer: transfer,
                paymentIntent: paymentIntent.latest_charge,
            }
        });

    } catch (error) {
        return res.send({ data: { error: e.message } });
    }

});

exports.DeleteAccount = functions.https.onRequest(async (req, res) => {
    const { accountId } = req.body.data;
    const account = await stripe.accounts.del(accountId);
    return res.send(account);
});

exports.onGroupEnded = functions.firestore.document('groups/{groupId}').onUpdate(async (change, context) => {
    const groupId = context.params.groupId;
    const groupData = change.after.data();
    const userId = groupData.creator;

    const dateTimeNow = new Date();

    console.log(groupData.endDate);
    console.log(groupId);
    console.log(userId);

    if (groupData.endDate < dateTimeNow.setDate(dateTimeNow.getDate() - 1)) {
        const groupDoc = await admin.firestore().collection('groups').doc(groupId).get();
        const groupData = groupDoc.data();

        const userRef = admin.firestore().collection('users').doc(userId);
        const userData = (await userRef.get()).data();
        console.log(userRef);
        console.log(userData);
        const paymentIntentIds = removeDuplicates(groupData.paymentIntentIds.concat(userData.paymentIntentIds || []));
        userRef.update({
            paymentIntentIds,
        });
    }
});
