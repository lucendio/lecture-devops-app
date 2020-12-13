const express = require('express');
const routes = express.Router();


routes.get('/env', (req, res) => {
    res.send( process.env );
});


module.exports = routes;
