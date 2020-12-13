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
            console.log( `Connection state changed to: ${ eventName }` );
        });
    });
}


const mongooseInstance_ = mongoose.connect(
    process.env.MONGODB_URL,
    {
        useNewUrlParser: true,
        useCreateIndex: true,
        useFindAndModify: false,

        useUnifiedTopology: true,
        heartbeatFrequencyMS: 1000 * 5,         // 1 sec * 5
        serverSelectionTimeoutMS: 1000 * 10     // 1 sec * 10
    }
);

mongooseInstance_
    .then(()=>{
        process.env.NODE_ENV !== 'test' && console.log( `Connect established to database: ${ process.env.MONGODB_URL }` );
    })
    .catch(( err )=>{
        console.error( `Cannot connect to database: ${ process.env.MONGODB_URL }` );
    });


process.on( 'exit', async ()=>{
    const dbClient = await mongooseInstance_;
    dbClient.disconnect();
});


module.exports = mongooseInstance_;
