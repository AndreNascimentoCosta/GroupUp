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

    await admin.firestore().collection('users').doc(userId).update({
        customerId: customer.id
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

const retrievePaymentIntent = async (paymentIntentId) => {
    const paymentIntent = await stripe.paymentIntents.retrieve(paymentIntentId);
    return paymentIntent;
}


exports.StripePayEndPointMethodIdJoinGroup = functions.https.onRequest(async (req, res) => {
    const { groupCode, userId, paymentMethodId } = req.body.data;

    const groupDoc = await admin.firestore().collection('groups').where('groupCode', "==", groupCode).get();
    const groupData = groupDoc.docs[0].data();

    const reward = groupData.reward * 100;
    const currency = groupData.groupCurrencyCode;
    const customerId = await createOrGetCustomerId(userId);

    try {
        if (paymentMethodId != '' && paymentMethodId != null) {
            const paymentIntent = await stripe.paymentIntents.create({
                amount: reward,
                currency: currency,
                customer: customerId,
                payment_method: paymentMethodId,
                off_session: true,
                confirm: true,
            });
            return res.send({
                data: {
                    clientSecret: paymentIntent.client_secret,
                    paymentIntentId: paymentIntent.id,
                    amountReceived: paymentIntent.amount_received,
                    reward: reward,
                    currency: currency,
                }
            });
        } else {
            const paymentIntent = await stripe.paymentIntents.create({
                amount: reward,
                currency: currency,
                customer: customerId,
                automatic_payment_methods: {
                    enabled: true,
                },
                setup_future_usage: 'off_session',
            });
            console.log(customerId);
            return res.send({
                data: {
                    clientSecret: paymentIntent.client_secret,
                    paymentIntentId: paymentIntent.id,
                    amountReceived: paymentIntent.amount_received,
                    reward: reward,
                    currency: currency,
                }
            });
        }
    } catch (e) {
        return res.send({ data: { clientSecret: '', error: e.message } });
    }
});

exports.StripePayEndPointMethodIdCreateGroup = functions.https.onRequest(async (req, res) => {
    const { userId, groupReward, groupCurrency, paymentMethodId } = req.body.data;

    const reward = groupReward * 100;
    const currency = groupCurrency;
    const customerId = await createOrGetCustomerId(userId);

    try {
        if (paymentMethodId != '' && paymentMethodId != null) {
            const paymentIntent = await stripe.paymentIntents.create({
                amount: reward,
                currency: currency,
                customer: customerId,
                payment_method: paymentMethodId,
                off_session: true,
                confirm: true,
            });
            return res.send({
                data: {
                    clientSecret: paymentIntent.client_secret,
                    paymentIntentId: paymentIntent.id,
                    amountReceived: paymentIntent.amount_received,
                    reward: reward,
                    currency: currency,
                }
            });
        } else {
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
                    amountReceived: paymentIntent.amount_received,
                    reward: reward,
                    currency: currency,
                }
            });
        }
    } catch (e) {
        return res.send({ data: { clientSecret: '', error: e.message } });
    }
});

exports.ListPaymentMethods = functions.https.onRequest(async (req, res) => {
    const { userId } = req.body.data;

    const customerId = await createOrGetCustomerId(userId);

    const paymentMethods = await stripe.customers.listPaymentMethods(
        customerId,
        { type: 'card' }
    );

    const paymentMethodsFiltered = paymentMethods.data.filter((item) => {
        if (item.card.wallet == null)
            return item;
    });

    console.log(paymentMethodsFiltered.data);

    return res.send({
        data: {
            paymentMethods: paymentMethodsFiltered,
            paymentMethodsData: paymentMethodsFiltered.data,
        }

    });
});

exports.DetachPaymentMethod = functions.https.onRequest(async (req, res) => {
    const { paymentMethodId } = req.body.data;
    const paymentMethod = await stripe.paymentMethods.detach(
        paymentMethodId,
    );
    return res.send({
        data: {
            paymentMethod: paymentMethod,
        }
    });
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
            amount: amount,
            currency: 'brl',
            destination: accountId,
            source_transaction: paymentIntent.latest_charge,
        });

        return res.send({
            data: {
                transfer: transfer,
                paymentIntent: paymentIntent.latest_charge,
                paymentIntentAmountReceived: paymentIntent.amount_received,
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

exports.RetrivePaymentIntent = functions.https.onRequest(async (req, res) => {
    const { paymentIntentId } = req.body.data;
    const paymentIntent = await stripe.paymentIntents.retrieve(paymentIntentId);
    return res.send({
        data: {
            paymentIntent: paymentIntent,
            paymentIntentAmountReceived: paymentIntent.amount_received,
        }
    });
});

exports.AddGroupRewardToUserBalance = functions.https.onRequest(async (req, res) => {
    const { userId, groupId } = req.body.data;

    const userRef = admin.firestore().collection('users').doc(userId);
    const user = await userRef.get();
    const userData = user.data();

    const group = await admin.firestore().collection('groups').doc(groupId).get();
    const groupData = group.data();

    const paymentIntentIds = removeDuplicates(groupData.paymentIntentIds.concat(userData.paymentIntentIds || []));

    var paymentIntentAmountReceived = 0

    for (let i = 0; i < paymentIntentIds.length; i++) {
        const paymentIntentId = paymentIntentIds[i];
        const paymentIntent = await retrievePaymentIntent(paymentIntentId);
        paymentIntentAmountReceived += paymentIntent.amount_received;
    }

    console.log(paymentIntentAmountReceived);

    userRef.update({
        paymentIntentIds,
        balance: paymentIntentAmountReceived,
    });

    return res.send({
        data: {
            paymentIntentIds,
            paymentIntentAmountReceived,
        }
    });

});

exports.EveryDayAtMidnight = functions.pubsub.schedule('0 0 * * *').timeZone('Etc/UTC').onRun(async () => {

    const dateTimeNow = new Date();

    const groups = await admin.firestore().collection('groups').where('endDate', '<', dateTimeNow).get();

    groups.forEach(async group => {

        const groupData = group.data();

        let participantsDatas = groupData.participantsData.map(participant => ({ uid: participant.uid, sum: participant.inputData.map(input => input.value).reduce((a, b) => a + b, 0) }));

        const greatestValue = participantsDatas.sort((a, b) => b.sum < a.sum ? -1 : 1)[0].sum;

        const winners = participantsDatas.filter(participant => participant.sum === greatestValue);


        if (winners.length > 1) {

            const winnerUid = participantsDatas.sort((a, b) => b.sum < a.sum ? -1 : 1)[0].uid;


            const userRef = admin.firestore().collection('users').doc(winnerUid);
            const userData = (await userRef.get()).data();
            
            const dateTimeNow = new Date();

            dateTimeNow.setDate(dateTimeNow.getDate() - 3);
            console.log(groupData.endDate.toDate().getTime());
            console.log(dateTimeNow.getTime());
            console.log(groupData.endDate.toDate().getTime() < dateTimeNow.getTime() ? 'true' : 'false');

            if (groupData.endDate.toDate().getTime() < dateTimeNow.getTime()) {

                const paymentIntentIds = removeDuplicates(groupData.paymentIntentIds.concat(userData.paymentIntentIds || []));

                var paymentIntentAmountReceived = 0

                for (let i = 0; i < paymentIntentIds.length; i++) {
                    const paymentIntentId = paymentIntentIds[i];
                    const paymentIntent = await retrievePaymentIntent(paymentIntentId);
                    paymentIntentAmountReceived += paymentIntent.amount_received;
                }

                userRef.update({
                    paymentIntentIds,
                    balance: paymentIntentAmountReceived,
                });
            }

        } else {

            const winnerUid = participantsDatas.sort((a, b) => b.sum < a.sum ? -1 : 1)[0].uid;

            console.log(winnerUid);

            const userRef = admin.firestore().collection('users').doc(winnerUid);
            const userData = (await userRef.get()).data();

            const dateTimeNow = new Date();

            dateTimeNow.setDate(dateTimeNow.getDate() - 1);
            console.log(groupData.endDate.toDate().getTime());
            console.log(dateTimeNow.getTime());
            console.log(groupData.endDate.toDate().getTime() < dateTimeNow.getTime() ? 'true' : 'false');

            if (groupData.endDate.toDate().getTime() < dateTimeNow.getTime()) {


                const paymentIntentIds = removeDuplicates(groupData.paymentIntentIds.concat(userData.paymentIntentIds || []));

                var paymentIntentAmountReceived = 0

                for (let i = 0; i < paymentIntentIds.length; i++) {
                    const paymentIntentId = paymentIntentIds[i];
                    const paymentIntent = await retrievePaymentIntent(paymentIntentId);
                    paymentIntentAmountReceived += paymentIntent.amount_received;
                }

                userRef.update({
                    paymentIntentIds,
                    balance: paymentIntentAmountReceived,
                });
            }
        }

    });

});




