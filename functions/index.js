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
        email: 'test@test.com',
        business_type: 'individual',
        individual: {
            political_exposure: 'none',
        },
        business_profile: {
            name: "Andre",
            product_description: "Test",
        },
        individual: {
            first_name: "Andre",
            last_name: "Test",
            id_number: "123456789",
        },
        capabilities: {
            card_payments: { requested: true },
            transfers: { requested: true },
        },
    });
    return res.send(account);
});

exports.DeleteAccount = functions.https.onRequest(async (req, res) => {
    const { accountId } = req.body.data;
    const account = await stripe.accounts.del(accountId);
    return res.send(account);
});
