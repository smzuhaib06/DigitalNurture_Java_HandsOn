SET SERVEROUTPUT ON;

-- =========================================
-- Scenario 1: Apply 1% Discount for Customers Above 60
-- =========================================

CREATE OR REPLACE PROCEDURE UpdateSeniorCitizenLoanInterest AS
BEGIN
    FOR v_cus IN (
        SELECT CustomerID, DOB
        FROM Customers
    ) LOOP
        IF TRUNC(MONTHS_BETWEEN(SYSDATE, v_cus.DOB) / 12) > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate * 0.99
            WHERE CustomerID = v_cus.CustomerID;

            DBMS_OUTPUT.PUT_LINE('Discount Applied For: ' || v_cus.CustomerID);
        END IF;
    END LOOP;

    COMMIT;
END;
/

BEGIN
    UpdateSeniorCitizenLoanInterest;
END;
/

SELECT CustomerID, InterestRate
FROM Loans
ORDER BY CustomerID;

-- =========================================
-- Scenario 2: Mark Customers as VIP
-- =========================================

ALTER TABLE Customers ADD IsVIP CHAR(1);

CREATE OR REPLACE PROCEDURE UpdateVIPStatus AS
BEGIN
    FOR v_cus IN (
        SELECT CustomerID, Balance
        FROM Customers
    ) LOOP
        IF v_cus.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'Y'
            WHERE CustomerID = v_cus.CustomerID;
        ELSE
            UPDATE Customers
            SET IsVIP = 'N'
            WHERE CustomerID = v_cus.CustomerID;
        END IF;
    END LOOP;

    COMMIT;
END;
/

BEGIN
    UpdateVIPStatus;
END;
/

SELECT CustomerID, Name, Balance, IsVIP
FROM Customers
ORDER BY CustomerID;

-- =========================================
-- Scenario 3: Loan Due Reminders
-- =========================================

CREATE OR REPLACE PROCEDURE SendLoanReminders AS
BEGIN
    FOR v_loan IN (
        SELECT l.LoanID,
               c.Name,
               l.EndDate
        FROM Loans l
        JOIN Customers c
        ON l.CustomerID = c.CustomerID
        WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Reminder: Dear ' ||
            v_loan.Name ||
            ', your loan #' ||
            v_loan.LoanID ||
            ' is due on ' ||
            TO_CHAR(v_loan.EndDate, 'DD-MON-YYYY')
        );
    END LOOP;
END;
/

BEGIN
    SendLoanReminders;
END;
/

-- OUTPUT:

-- Discount Applied For: 3
-- Discount Applied For: 4
-- Discount Applied For: 6
-- Discount Applied For: 7

-- CUSTOMERID INTERESTRATE
-- ---------- ------------
-- 	 1	      5
-- 	 3	   7.92
-- 	 4	   6.93
-- 	 5	      9
-- 	 6	   5.94
-- 	 7	    9.9

-- CUSTOMERID
-- ----------
-- NAME
-- --------------------------------------------------------------------------------
--    BALANCE I
-- ---------- -
-- 	 1
-- John Doe
--       1000 N

-- 	 2
-- Jane Smith
--       1500 N

-- CUSTOMERID
-- ----------
-- NAME
-- --------------------------------------------------------------------------------
--    BALANCE I
-- ---------- -

-- 	 3
-- Robert Wilson
--      25000 Y

-- 	 4
-- Mary Thomas

-- CUSTOMERID
-- ----------
-- NAME
-- --------------------------------------------------------------------------------
--    BALANCE I
-- ---------- -
--      18000 Y

-- 	 5
-- David Miller
--       5000 N

-- 	 6

-- CUSTOMERID
-- ----------
-- NAME
-- --------------------------------------------------------------------------------
--    BALANCE I
-- ---------- -
-- Sarah Davis
--      30000 Y

-- 	 7
-- James Anderson
--      12000 Y
