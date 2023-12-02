package com.expense_tracker.expenseTracker.Dao.UserDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import com.expense_tracker.expenseTracker.Exceptions.UserAlreadyExists;
import com.expense_tracker.expenseTracker.entities.Users;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import jakarta.transaction.Transactional;

@Repository
public class UserDao implements UserDaoInterface {

    private EntityManager entityManager;
    BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

    public UserDao() {
    }

    @Autowired
    public UserDao(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    @Override
    @Transactional
    public Users creatUsers(Users user) {

        if (getUserByEmail(user.getEmail()) != null) {
            throw new UserAlreadyExists("Email Already In Use");
        }
        Users temp = encryptedPass(user);
        // saving the user
        entityManager.persist(temp);
        // success
        return temp;
    }

    @Override
    @Transactional
    public Users updateUsers(Users user) {
        // updating user
        Users temp = encryptedPass(user);
        return entityManager.merge(temp);

    }

    @Override
    public Users getUser(int uid) {
        return entityManager.find(Users.class, uid);
    }

    @Override
    @Transactional
    public String deleteUser(int id) {

        Users temp = getUser(id);

        if (temp == null) {
            return "Unable to find any users with uid:" + id;
        }

        entityManager.remove(temp);
        return "Removed user with uid:" + id;
    }

    Users encryptedPass(Users user) {
        String password = encoder.encode(user.getPassword());
        user.setPassword(password);
        return user;
    }

    @Override
    public Users authenticateUser(Users user) {

        Users temp = getUserByEmail(user.getEmail());

        if (temp == null) {
            return null;
        }

        if (encoder.matches(user.getPassword(), temp.getPassword())) {
            return temp;
        }
        return null;
    }

    @Override
    public Users getUserByEmail(String email) {
        try {
            TypedQuery<Users> query = entityManager
                    .createQuery("SELECT u FROM Users u WHERE u.email=:email", Users.class)
                    .setParameter("email", email);
            Users user = query.getSingleResult();
            return user;

        } catch (Exception e) {
            return null;
        }

    }

}
