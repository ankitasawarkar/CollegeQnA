---##### Schema creation #####

use College;

CREATE TABLE marks (
    student_name VARCHAR(100) NOT NULL,
    semester INT NOT NULL,
    gpa DECIMAL(3,2) NOT NULL,
    PRIMARY KEY (student_name, semester)
);

CREATE TABLE fees (
    student_name VARCHAR(100) NOT NULL,
    semester INT NOT NULL,
    total_fees DECIMAL(10,2) NOT NULL,
    paid DECIMAL(10,2) NOT NULL,
    pending DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (student_name, semester)
);

-- Insert data into the "marks" table
INSERT INTO marks (student_name, semester, gpa)
VALUES
    ('Aarav Sharma', 1, 3.75),
    ('Aarav Sharma', 2, 3.88),
    ('Aarav Sharma', 3, 3.95),
    ('Aarav Sharma', 4, 4.00),
    ('Aarav Sharma', 5, 3.92),
    ('Ishaan Patel', 1, 3.60),
    ('Ishaan Patel', 2, 3.75),
    ('Ishaan Patel', 3, 3.82),
    ('Ishaan Patel', 4, 3.90),
    ('Ishaan Patel', 5, 3.95),
    ('Aanya Gupta', 1, 3.70),
    ('Aanya Gupta', 2, 3.80),
    ('Aanya Gupta', 3, 3.88),
    ('Aanya Gupta', 4, 3.92),
    ('Aanya Gupta', 5, 4.00),
    ('Riya Singh', 1, 3.65),
    ('Riya Singh', 2, 3.70),
    ('Riya Singh', 3, 3.75),
    ('Riya Singh', 4, 3.85),
    ('Riya Singh', 5, 3.92);

-- Insert data into the "fees" table
INSERT INTO fees (student_name, semester, total_fees, paid, pending)
VALUES
    ('Aarav Sharma', 1, 2000.00, 1800.00, 200.00),
    ('Aarav Sharma', 2, 2000.00, 1900.00, 100.00),
    ('Aarav Sharma', 3, 2000.00, 2000.00, 0.00),
    ('Aarav Sharma', 4, 2000.00, 2000.00, 0.00),
    ('Aarav Sharma', 5, 2000.00, 1920.00, 80.00),
    ('Ishaan Patel', 1, 2000.00, 1900.00, 100.00),
    ('Ishaan Patel', 2, 2000.00, 2000.00, 0.00),
    ('Ishaan Patel', 3, 2000.00, 1980.00, 20.00),
    ('Ishaan Patel', 4, 2000.00, 2000.00, 0.00),
    ('Ishaan Patel', 5, 2000.00, 2000.00, 0.00),
    ('Aanya Gupta', 1, 2000.00, 1950.00, 50.00),
    ('Aanya Gupta', 2, 2000.00, 2000.00, 0.00),
    ('Aanya Gupta', 3, 2000.00, 2000.00, 0.00),
    ('Aanya Gupta', 4, 2000.00, 1980.00, 20.00),
    ('Aanya Gupta', 5, 2000.00, 2000.00, 0.00),
    ('Riya Singh', 1, 2000.00, 1950.00, 50.00),
    ('Riya Singh', 2, 2000.00, 1960.00, 40.00),
    ('Riya Singh', 3, 2000.00, 2000.00, 0.00),
    ('Riya Singh', 4, 2000.00, 2000.00, 0.00),
    ('Riya Singh', 5, 2000.00, 1980.00, 20.00);


-- Procedure for getting marks in SQL Server
CREATE PROCEDURE get_marks 
    @student_name VARCHAR(100),   -- Input parameter for student name
    @semester INT,               -- Input parameter for semester
    @operation VARCHAR(10)       -- Input parameter for operation (e.g., 'max', 'min', 'avg')
AS
BEGIN
    DECLARE @result DECIMAL(3,2); -- Declare a variable to store the result GPA

    IF @student_name <> ''       -- Check if student name is provided
    BEGIN
        SELECT @result = gpa     -- Retrieve GPA for the specific student and semester
        FROM marks
        WHERE LOWER(student_name) = LOWER(@student_name) AND semester = @semester;
    END
    ELSE IF @operation = 'max'   -- Check if the operation is to find the maximum GPA
    BEGIN
        SELECT @result = MAX(gpa) -- Retrieve the maximum GPA for the semester
        FROM marks
        WHERE semester = @semester;
    END
    ELSE IF @operation = 'min'   -- Check if the operation is to find the minimum GPA
    BEGIN
        SELECT @result = MIN(gpa) -- Retrieve the minimum GPA for the semester
        FROM marks
        WHERE semester = @semester;
    END
    ELSE IF @operation = 'avg'   -- Check if the operation is to find the average GPA
    BEGIN
        SELECT @result = AVG(gpa) -- Retrieve the average GPA for the semester
        FROM marks
        WHERE semester = @semester;
    END;

    -- Handling when no records are found
    IF @result IS NULL
    BEGIN
        SET @result = -1;        -- Set a default value of -1 when no records are found
    END;

    SELECT @result AS GPA;        -- Return the result as GPA
END;

-- Procedure for getting fees in SQL Server
CREATE PROCEDURE get_fees 
    @student_name VARCHAR(100),   -- Input parameter for student name
    @semester INT,               -- Input parameter for semester
    @fees_type VARCHAR(10)       -- Input parameter for fees type (e.g., 'paid', 'pending', 'total')
AS
BEGIN
    DECLARE @result DECIMAL(10,2); -- Declare a variable to store the result (fees)

    IF @student_name <> ''       -- Check if student name is provided
    BEGIN
        IF @fees_type = 'paid'    -- Check if the desired fees type is 'paid'
        BEGIN
            SELECT @result = paid -- Retrieve the paid fees for the specific student and semester
            FROM fees
            WHERE LOWER(student_name) = LOWER(@student_name) AND semester = @semester;
        END
        ELSE IF @fees_type = 'pending' -- Check if the desired fees type is 'pending'
        BEGIN
            SELECT @result = pending -- Retrieve the pending fees for the specific student and semester
            FROM fees
            WHERE LOWER(student_name) = LOWER(@student_name) AND semester = @semester;
        END
        ELSE IF @fees_type = 'total' -- Check if the desired fees type is 'total'
        BEGIN
            SELECT @result = total_fees -- Retrieve the total fees for the specific student and semester
            FROM fees
            WHERE LOWER(student_name) = LOWER(@student_name) AND semester = @semester;
        END;
    END
    ELSE -- Case where no specific student name is provided
    BEGIN
        IF @fees_type = 'paid'    -- Check if the desired fees type is 'paid'
        BEGIN
            SELECT @result = SUM(paid) -- Retrieve the sum of paid fees for the semester
            FROM fees
            WHERE semester = @semester;
        END
        ELSE IF @fees_type = 'pending' -- Check if the desired fees type is 'pending'
        BEGIN
            SELECT @result = SUM(pending) -- Retrieve the sum of pending fees for the semester
            FROM fees
            WHERE semester = @semester;
        END
        ELSE IF @fees_type = 'total' -- Check if the desired fees type is 'total'
        BEGIN
            SELECT @result = SUM(total_fees) -- Retrieve the sum of total fees for the semester
            FROM fees
            WHERE semester = @semester;
        END;
    END;

    -- Handling when no records are found
    IF @result IS NULL
    BEGIN
        SET @result = -1;        -- Set a default value of -1 when no records are found
    END;

    SELECT @result AS Fees;      -- Return the result as Fees
END;

