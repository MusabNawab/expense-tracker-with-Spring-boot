package com.expense_tracker.expenseTracker.Dao.ExpenseDao;

import java.util.List;

import com.expense_tracker.expenseTracker.entities.Expenses;

public interface ExpenseDaoInterface {
    String saveExpense(Expenses expense,int uid);

    Expenses expense(int id);

    Expenses updateExpense(Expenses expense);

    void deleteExpense(int id);

    List<Expenses> getUsersExpense(int uid);

}
