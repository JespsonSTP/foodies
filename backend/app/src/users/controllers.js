const pool = require("../../db")
const queries = require('./queries')

const getAllUsers = (req, res) =>{
    pool.query(queries.getAllUsers, (error, results) => {
        if(error) throw error;
        res.status(200).json(results.rows);
    });
};

const getChefs = (req, res) =>{
    pool.query(queries.getChefs, (error, results) => {
        if(error) throw error;
        res.status(200).json(results.rows);
    });
};

const getCustomers = (req, res) =>{
    pool.query(queries.getCustomers, (error, results) => {
        if(error) throw error;
        res.status(200).json(results.rows);
    });
};

const getActiveChefs = (req, res) =>{
    pool.query(queries.getActiveChefs, (error, results) => {
        if(error) throw error;
        res.status(200).json(results.rows);
    });
};

const getUser = (req, res) =>{
    
    
    const id = parseInt(req.params.id)
    pool.query(queries.getUser, [id], (error, results) => {
        if(error) throw error;
        res.status(200).json(results.rows);
    });
};

const addUser = (req, res) => {
    const { email, username} = req.body
    //check if username or email exist
    pool.query(queries.getActiveChefs, [username, email], (error, results) =>{
        if (results.rows.length) {
            res.send("Username or Email already in use")
        }

        pool.query(queries.getActiveChefs, [username, email], (error, results) =>{
            if(error) throw error;
            res.status(200).json(results.rows);           
        })
    })
}


const updateUser = (req, res) =>{   
    const id = parseInt(req.params.id)
    const { email, username} = req.body
    pool.query(queries.getUser, [id], (error, results) => {
        const noUserFound = results.rows.length
        if(noUserFound) {
            res.send(" User doesn't exist")
        };
        pool.query(queries.getUser, [username, email], (error, results) => {
            if(error) throw error;
            res.status(200).json(results.rows);
        });
    });
};


const deleteUser = (req, res) =>{   
    const id = parseInt(req.params.id)
    pool.query(queries.getUser, [id], (error, results) => {
        const noUserFound = results.rows.length
        if(noUserFound) {
            res.send(" User doesn't exist")
        };
        pool.query(queries.getUser, [id], (error, results) => {
            if(error) throw error;
            res.status(200).send("User has been removed");
        });
    });
};


module.exports = {
    getAllUsers,
    getChefs,
    getActiveChefs,
    getUser,
    getCustomers,
    addUser,
    updateUser,
    deleteUser
}