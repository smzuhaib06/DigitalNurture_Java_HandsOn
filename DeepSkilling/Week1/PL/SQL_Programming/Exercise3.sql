SET SERVEROUTPUT ON;

/* =========================================================
   EXERCISE 3 - SCENARIO 1
   Process Monthly Interest
   Adds 1% interest to all Savings accounts
   ========================================================= */
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest AS
BEGIN
    UPDATE Accounts
    SET Balance = Balance + (Balance * 0.01)
    WHERE AccountType = 'Savings';

    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' savings account(s) credited with interest.');
    COMMIT;
END;
/

/* =========================================================
   EXERCISE 3 - SCENARIO 2
   Update Employee Bonus
   Applies bonus percentage to employees in a department
   ========================================================= */
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
    p_department IN VARCHAR2,
    p_bonus_percent IN NUMBER
) AS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * p_bonus_percent / 100)
    WHERE Department = p_department;

    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' employee(s) in ' || p_department || ' got a bonus.');
    COMMIT;
END;
/

/* =========================================================
   EXERCISE 3 - SCENARIO 3
   Transfer Funds
   Moves money between accounts after validating balance
   ========================================================= */
CREATE OR REPLACE PROCEDURE TransferFunds(
    p_from_account IN NUMBER,
    p_to_account IN NUMBER,
    p_amount IN NUMBER
) AS
    v_balance NUMBER;
BEGIN
    SELECT Balance INTO v_balance
    FROM Accounts
    WHERE AccountID = p_from_account
    FOR UPDATE;

    IF v_balance >= p_amount THEN

        UPDATE Accounts
        SET Balance = Balance - p_amount
        WHERE AccountID = p_from_account;

        UPDATE Accounts
        SET Balance = Balance + p_amount
        WHERE AccountID = p_to_account;

        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Transferred ' || p_amount || ' successfully.');

    ELSE
        DBMS_OUTPUT.PUT_LINE('Insufficient balance. Transfer aborted.');
    END IF;
END;
/
