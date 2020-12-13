const mongoose = require('mongoose');


const schema = new mongoose.Schema({
    title: {
        type: String,
        required: true,
        maxlength: 100,
    },
    description: {
        type: String
    },
    important: {
        type: Boolean,
        default: false
    },
    done: {
        type: Boolean,
        default: false
    },
    user: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
    }
}, {
    timestamps: true
});

const model = mongoose.model( 'ToDos', schema );


module.exports = { schema, model };
