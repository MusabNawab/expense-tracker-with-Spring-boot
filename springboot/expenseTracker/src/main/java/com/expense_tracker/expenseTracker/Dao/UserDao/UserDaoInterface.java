package com.expense_tracker.expenseTracker.Dao.UserDao;

import com.expense_tracker.expenseTracker.entities.Users;

public interface UserDaoInterface {

    Users creatUsers(Users user);

    Users updateUsers(Users user);

    Users getUser(int uid);

    String deleteUser(int id);

    Users authenticateUser(Users user);

    Users getUserByEmail(String email);
}
