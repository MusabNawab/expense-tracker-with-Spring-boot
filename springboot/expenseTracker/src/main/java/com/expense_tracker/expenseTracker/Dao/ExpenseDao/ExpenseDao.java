package com.expense_tracker.expenseTracker.Dao.ExpenseDao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.expense_tracker.expenseTracker.Dao.UserDao.UserDao;
import com.expense_tracker.expenseTracker.entities.Expenses;
import com.expense_tracker.expenseTracker.entities.Users;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import jakarta.transaction.Transactional;

@Repository
public class ExpenseDao implements ExpenseDaoInterface {

    private EntityManager entityManager;
    private UserDao userDao;

    @Autowired
    public ExpenseDao(EntityManager entityManager, UserDao userDao) {
        this.entityManager = entityManager;
        this.userDao = userDao;
    }

    public ExpenseDao() {
    }

    @Override
    @Transactional
    public String saveExpense(Expenses expense, int uid) {
        Users temp = userDao.getUser(uid);
        expense.setUser(temp);
        entityManager.persist(expense);
        return "Saved expense:" + expense.getTitle();
    }

    // @Override
    // public List<Expenses> getAll() {
    // TypedQuery<Expenses> query = entityManager.createQuery("FROM Expenses",
    // Expenses.class);

    // return query.getResultList();
    // }

    @Override
    public Expenses expense(int id) {
        return entityManager.find(Expenses.class, id);
    }

    @Override
    @Transactional
    public void deleteExpense(int id) {

        Expenses expense = expense(id);
        // fetching user to remove the link between user and expense
        Users temp = userDao.getUser(expense.getUser().getUserId());
        // removing the expense from user's expense list
        temp.removeExpense(expense);
        entityManager.remove(expense);
    }

    @Override
    @Transactional
    public Expenses updateExpense(Expenses expense) {
        Expenses temp = expense(expense.getId());
        temp.setTitle(expense.getTitle());
        temp.setAmt(expense.getAmt());
        temp.setCategory(expense.getCategory());
        temp.setDate(expense.getDate());
        return entityManager.merge(temp);
    }

    @Override
    public List<Expenses> getUsersExpense(int uid) {
        TypedQuery<Expenses> theQuery = entityManager.createQuery("SELECT e FROM Expenses e WHERE e.user = :user",
                Expenses.class);

        Users user = userDao.getUser(uid);

        theQuery.setParameter("user", user);
        return theQuery.getResultList();
    }

}
