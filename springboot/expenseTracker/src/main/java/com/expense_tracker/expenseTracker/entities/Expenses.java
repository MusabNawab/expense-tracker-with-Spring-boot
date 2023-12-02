package com.expense_tracker.expenseTracker.entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "expenses")
public class Expenses {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "expense_id")
    private int id;

    @Column(name = "title")
    private String title;

    @Column(name = "amount")
    private int amt;

    @Column(name = "expense_date")
    private String date;

    @Column(name = "category")
    private String category;

    @ManyToOne()
    @JoinColumn(name = "user_id")
    private Users user;

    public Expenses(String title, int amt, String date, String category) {
        this.title = title;
        this.amt = amt;
        this.date = date;
        this.category = category;
    }

    public Expenses() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getAmt() {
        return amt;
    }

    public void setAmt(int amt) {
        this.amt = amt;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
    
    @JsonBackReference
    public Users getUser() {
        return user;
    }

    public void setUser(Users user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "Expenses [id=" + id + ", title=" + title + ", amt=" + amt + ", date=" + date + ", category=" + category
                + ", user=" + user + "]";
    }

}
