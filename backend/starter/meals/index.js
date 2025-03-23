const express = require('express');

const app = express();


app.get('/api/v1/meals', (req, res) => {
    res.send('Hello, API!');
});

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});