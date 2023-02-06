const functions = require("firebase-functions");
const stripe = require("stripe")('sk_test_51MXufcIXmdKwNYjDzpHrTwv42aY8LErRVMtLgYyFS79jzbXnuFgEvyFBV0XO7vms9VgQo8zLIEPWFPBS6M3xgJTM00N4hMsZ8H');
const admin = require('firebase-admin');
admin.initializeApp();

// const generateResponse = function (intent) {
//     switch (intent.status) {
//         case 'requires_action':
//             return {
//                 clientSecret: intent.client_secret,
//                 requiresAction: true,
//                 status: intent.status,
//             };
//         case 'requires_payment_method':
//             return {
//                 error: 'Your card was declined, please provide a new payment method.',
//             };
//         case 'succeeded':
//             console.log('Payment succeeded!')
//             return {
//                 clientSecret: intent.client_secret,
//                 status: intent.status,
//             };
//     }
//     return {
//         error: 'Failed to process payment.',
//     };
// };

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



exports.StripePayEndPointMethodId = functions.https.onRequest(async (req, res) => {
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

// exports.StripePayEndPointIntentId = functions.https.onRequest(async (req, res) => {
//     const { paymentIntentId } = req.body;
//     try {
//         if (paymentIntentId) {
//             const intent = await stripe.paymentIntents.confirm(paymentIntentId);
//             return res.send(generateResponse(intent));
//         }
//         return res.send(generateResponse(intent));
//     } catch (e) {
//         return res.send({ error: e.message });
//     }
// });

