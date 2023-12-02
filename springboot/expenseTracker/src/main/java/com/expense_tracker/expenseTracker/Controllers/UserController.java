package com.expense_tracker.expenseTracker.Controllers;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.expense_tracker.expenseTracker.Dao.UserDao.UserDao;
import com.expense_tracker.expenseTracker.Dao.UserDao.UserDaoInterface;
import com.expense_tracker.expenseTracker.entities.Users;

@RestController
@RequestMapping("/expense-tracker")
public class UserController {

    private UserDaoInterface userDao;
    
    public UserController(UserDao userDao) {
        this.userDao = userDao;
    }

    @GetMapping("/users/{uid}")
    Users getCurrentUser(@PathVariable int uid) {
        return userDao.getUser(uid);
    }

    @PutMapping("/users")
    Users updateCurrentUser(@RequestBody Users users) {
        return userDao.updateUsers(users);
    }

    @PostMapping("/users")
    Users createUser(@RequestBody Users users) {
        return userDao.creatUsers(users);
    }

    @DeleteMapping("/users/{uid}")
    String deleteCurrentUser(@PathVariable int uid) {
        return userDao.deleteUser(uid);
    }

    @GetMapping("/users/auth")
    Users authenticate(@RequestBody Users user){
        return userDao.authenticateUser(user);
    }
}
