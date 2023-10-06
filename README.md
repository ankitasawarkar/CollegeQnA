# CollegeQnA
ChatGPT for own college which give internal information from College Databse. Main focus OpenAI functiona call, SQL Server database, Streamlit

Below functions and their representing procedure we are calling to get specific information from internal databased in the form of ChatGPT.
1. Fees related questions:

How much x_student has paid so far?
How much is pending for x_student?
What is the total fees for semester 1?

def get_fees(input):
{
    'student_name': 'x',
    'semester':2,
    'fees_type': 'paid'
}

How much was Riya Singh's due fees in the first semester?
                         |
                        LLM
                         |
        function_name        function_args
        get_fees                'student_name': 'Riya Singh',
                                'semester': 1
                                'fees_type': due
                         |
                    Python Code
                    db_helper  -->  $50
                         |
                        LLM
                         |
Riya Singh's due fees for the first semester amount to $50.


2. GPA / marks of student and semesters:

What was x_student's GPA in semester 2?
What was the average GPA for all the students semester 4?
Minimum GPA in semester 4?

def get_marks(dic: input):
    input = {
        'student_name': 'x',
        'semester': 1, 2, 3, 4, or 0
        'opration': max, min, average
    }


Average gpa in third semester?
                |
               LLM
                |
  function_name        function_args
  get_marks              'student_name': '',
                        'semester': 3
                        'opration': avg
                |
        Python Code
        db_helper  -->  3.85
                |
               LLM
                |
The average GPA in the third semester is 3.85.
