const router = require("express").Router();
const controller = require('./controllers')

router.get('/', controller.getChefs)
router.get('/admin/all', controller.getAllUsers)
router.get('/admin/customers', controller.getCustomers)
router.get('/:id', controller.getUser)
router.post('/', controller.addUser)
router.put('/:id', controller.updateUser)
router.delete('/:id', controller.deleteUser)

module.exports = router;