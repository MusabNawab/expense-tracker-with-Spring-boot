package com.expense_tracker.expenseTracker.Controllers;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import com.expense_tracker.expenseTracker.ErrorResponse.ErrorResponse;
import com.expense_tracker.expenseTracker.Exceptions.UserAlreadyExists;

@RestControllerAdvice
public class ControllersAdvice {

    @ExceptionHandler(UserAlreadyExists.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ErrorResponse handleUserAlreadyExistsException(UserAlreadyExists exception) {
        return new ErrorResponse("User Already Exits", exception.getMessage());
    }
}
