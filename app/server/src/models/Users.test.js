const dbClientInstance_ = require( './../db/mongo.js' );

const { model: Users } = require( './Users.js' );


describe( 'Model: Users', ()=>{
    beforeAll( async ()=>{
        try{
            await dbClientInstance_;
        }catch( err ){
            console.error( new Error( `Cannot connect to database: ${ process.env.MONGODB_URL }` ) );
            process.exit( 1 );
        }
    });


    test( 'creating a user', async ()=>{
        const userData = {
            name: 'myname',
            email: 'myname@example.com',
            password: 'mypassword'
        };

        const userDoc = await Users( userData );
        await userDoc.save();

        const userRecord = await Users.findOne({ email: userData.email });

        const { password, ...userInfo } = userData;

        expect( userRecord ).toEqual( expect.objectContaining( userInfo ) );
    });

    test( 'deleting a user', async ()=>{
        const userData = {
            name: 'anothername',
            email: 'anothername@example.com',
            password: 'anotherpassword'
        };

        const userDoc = await Users( userData );
        await userDoc.save();

        await Users.remove({ email: userData.email })

        const userRecord = await Users.findOne({ email: userData.email });

        expect( userRecord ).toBeNull();
    });


    afterAll( async ()=>{
        const dbClient = await dbClientInstance_;
        const { connection } = dbClient;
        await connection.dropDatabase();
        await dbClient.disconnect();
    });
});
