const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().functions);

var newData='';

exports.myTrigger = functions.firestore.document('users/{userId}/invitations/{invitationId}').onCreate(async (snapshot, context) => {
    //
    const to_user_id = context.params.userId;
    const invitation_id = context.params.invitationId;
    console.log(to_user_id);

    if (snapshot.empty) {
        console.log('No Devices');
        return;
    }

    newData = snapshot.data();

    const deviceIdTokens = await admin
        .firestore().collection('users').doc(to_user_id).collection('tokens').get();



    var tokens = [];

    for (var token of deviceIdTokens.docs) {
        tokens.push(token.data().token);
        console.log(token);
    }
    var payload = {
        notification: {
            title: 'Invtation',
            body: 'Vous êtes invité à rejoindre ce groupe',
            sound: 'default',
        },
        data: {
            group: invitation_id,
            push_key: 'Push Key Value',
            key1: 'vous invite à rejoindre le groupe',//newData.data
        },
    };

    try {
        const response = await admin.messaging().sendToDevice(tokens, payload);
        console.log('Notification sent successfully');
    } catch (err) {
        console.log(err);
    }
});


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


exports.alertes = functions.firestore.document('groups/{groupId}/alertes/{alerteId}').onCreate(async (snapshot, context) => {
    //
    const to_group_id = context.params.groupId;
    console.log(to_group_id);
    const user_id = context.params.alerteId;
        console.log(user_id);

    if (snapshot.empty) {
        console.log('No Devices');
        return;
    }



    var payload = {

        notification: {
            title: 'Alerte',
            body: 'vous avez une alerte',
            sound: 'default',
        },
        data: {
            push_key: user_id,
            key1: 'hey there',//newData.data
        },
    };

    try {
        const response = await admin.messaging().sendToTopic("/topics/"+to_group_id,payload)
                                                     .then(function(response){
                                                          console.log('Notification sent successfully:',response);
                                                          return response;
                                                     })
                                                     .catch(function(error){
                                                          console.log('Notification sent failed:',error);
                                                     });
                                                     }
     catch (err)  {
     console.log('Notification sent failed');
     }
});




