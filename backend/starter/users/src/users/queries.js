const getChefs = "SELECT * FROM users WHERE user_type='chef'";
const getCustomers = "SELECT * FROM users WHERE user_type='user'";
const getAllUsers = "SELECT * FROM users";
const getActiveChefs = "SELECT * FROM users WHERE user_type='chef' AND status='active'";
const getUser = "SELECT * FROM users WHERE id = $1";
const addUser = "SSELECT * FROM users WHERE id = $1";
const updateUser = "SSELECT * FROM users WHERE id = $1";
const deleteUser = "SSELECT * FROM users WHERE id = $1";
const checkUsernameOrEmsil = "SSELECT * FROM users WHERE id = $1";


module.exports = {
    getAllUsers,
    getChefs,
    getActiveChefs,
    getCustomers,
    getUser,
    addUser,
    updateUser,
    deleteUser,
    checkUsernameOrEmsil
}