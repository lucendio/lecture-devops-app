const mongoose = require('mongoose');


// utilize event emitter to indicate connection retries in logs
// DOCS: https://mongoosejs.com/docs/connections.html#connection-events
const CONNECTION_EVENTS = [
    'connecting', 'connected', 'disconnecting', 'disconnected',
    'close', 'reconnectFailed', 'reconnected', 'error'
]

if( process.env.NODE_ENV === 'production' ){
    CONNECTION_EVENTS.forEach(( eventName )=>{
        return mongoose.connection.on( eventName, ()=>{
            console.log( `DB connection state changed to: ${ eventName }` );
        });
    });
}


const mongooseInstance_ = mongoose.connect(
    process.env.MONGODB_URL,
    {
        keepAlive: true,
        keepAliveInitialDelay: 300000,  // 1 sec * 300 = 5 min
        connectTimeoutMS: 1000 * 10     // 1 sec * 10
    }
);

mongooseInstance_
    .then(()=>{
        process.env.NODE_ENV !== 'test' && console.log( `Connect established to database: ${ process.env.MONGODB_URL }` );
    })
    .catch(( err )=>{
        console.error( `Cannot connect to database: ${ process.env.MONGODB_URL }` );
        console.error( err );
    });


module.exports = mongooseInstance_;
