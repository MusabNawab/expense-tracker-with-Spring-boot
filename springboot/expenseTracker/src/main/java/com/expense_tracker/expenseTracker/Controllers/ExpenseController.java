package com.expense_tracker.expenseTracker.Controllers;

import java.util.List;

import javax.management.RuntimeErrorException;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.expense_tracker.expenseTracker.Dao.ExpenseDao.ExpenseDao;
import com.expense_tracker.expenseTracker.entities.Expenses;

@RestController
@RequestMapping("/expense-tracker")
public class ExpenseController {

    private ExpenseDao expenseDao;

    public ExpenseController(ExpenseDao expenseDao) {
        this.expenseDao = expenseDao;
    }

    @PostMapping("/expense/{uid}")
    private String post(@RequestBody Expenses expense, @PathVariable int uid) {
        expense.setId(0);
        return expenseDao.saveExpense(expense, uid);
    }

    @GetMapping("/expense/{expenseId}")
    private Expenses getSingleExpense(@PathVariable int expenseId) {
        return expenseDao.expense(expenseId);
    }

    @GetMapping("/expense/userExpense/{uid}")
    private List<Expenses> getExpenses(@PathVariable int uid) {
        return expenseDao.getUsersExpense(uid);
    }

    @PutMapping("/expense")
    private Expenses update(@RequestBody Expenses expense) {
        return expenseDao.updateExpense(expense);
    }

    @DeleteMapping("/expense/{expenseId}")
    private String delete(@PathVariable int expenseId) {
        Expenses temp = expenseDao.expense(expenseId);

        if (temp == null) {
            throw new RuntimeErrorException(null, "Expense with id" + expenseId + "not found");
        }
        expenseDao.deleteExpense(expenseId);
        return "Succesfully deleted";
    }
}
