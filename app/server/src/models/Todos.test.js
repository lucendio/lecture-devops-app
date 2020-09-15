const dbClientInstance_ = require( '../db/mongo.js' );
const { model: Todos } = require( './Todos.js' );
const mongoose = require('mongoose');


describe( 'Model: Todos', ()=>{
    beforeAll( async ()=>{
        try{
            await dbClientInstance_;
        }catch( err ){
            console.error( new Error( `Cannot connect to database: ${ process.env.MONGODB_URL }` ) );
            process.exit( 1 );
        }
    });


    test( 'creating a todo', async ()=>{
        console.log("Test: Creating Todo")

        const todoData = {
            title: 'Title of the Todo',
            description: 'Description of the Todo',
            important: true,
            done: true,
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