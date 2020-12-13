const mongoose = require( 'mongoose' );
const dbClientInstance_ = require( '../db/mongo.js' );

const { model: Todos } = require( './Todos.js' );


describe( 'Model: Todos', ()=>{
    beforeAll( async ()=>{
        try{
            await dbClientInstance_;
        }catch( err ){
            console.error( new Error( `Cannot connect to database: ${ process.env.MONGODB_URL }` ) );
            process.exit( 1 );
        }
    });


    test( 'creating a todo for a non-existing user', async ()=>{

        const todoData = {
            title: 'Homework',
            description: 'Devops project 2020',
            user: mongoose.Types.ObjectId()
        };

        const todoDoc = await Todos( todoData );
        await todoDoc.save();

        const todoRecord = await Todos.findOne({ user: todoData.user });

        const { description, ...todoInfo } = todoData;

        expect( todoRecord ).toEqual( expect.objectContaining( todoInfo ) );
    });


    afterAll( async ()=>{
        const dbClient = await dbClientInstance_;
        const { connection } = dbClient;
        await connection.dropDatabase();
        await dbClient.disconnect();
    });
});
