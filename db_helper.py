import pyodbc

#load dabase config
import os
from dotenv import load_dotenv

load_dotenv()  # Load environment variables from a .env file (if present)
server = os.getenv("server")
database = os.getenv("database")
username = os.getenv("username")
password = os.getenv("password")

# Define your SQL Server connection parameters


def get_db_cursor():
    try:
        # Establish a connection to the SQL Server database
        connection_string = f'DRIVER=SQL Server;SERVER={server};DATABASE={database};UID={username};PWD={password}'
        db = pyodbc.connect(connection_string)

        # Create a cursor to interact with the database
        cursor = db.cursor()
        return db, cursor
    except Exception as e:
        print(f"Error connecting to the database: {str(e)}")
        return None, None

def close_db_connection(db, cursor):
    try:
        # Close the cursor and database connection
        cursor.close()
        db.close()
        print('Connection Closed')
    except Exception as e:
        print(f"Error closing the database connection: {str(e)}")

def get_marks(params):
    db, cursor = get_db_cursor()
    if db and cursor:
        print("Connection get")
        try:
            # Execute the 'get_marks' stored procedure
            cursor.execute("EXEC get_marks ?, ?, ?", (params.get('student_name', ''), params.get('semester', ''), params.get('operation', '')))
            result = None

            # Fetch the result
            for row in cursor.fetchall():
                result = float(row[0]) if row[0] is not None else None

            close_db_connection(db, cursor)
            return result
        except Exception as e:
            print(f"Error executing 'get_marks' stored procedure: {str(e)}")
            close_db_connection(db, cursor)
            return None
    else:
        return "Connection Failed"

def get_fees(params):
    db, cursor = get_db_cursor()
    if db and cursor:
        try:
            # Execute the 'get_fees' stored procedure
            cursor.execute("EXEC get_fees ?, ?, ?", (params.get('student_name', ''), params.get('semester', ''), params.get('fees_type', '')))
            result = None

            # Fetch the result
            for row in cursor.fetchall():
                result = float(row[0]) if row[0] is not None else None

            close_db_connection(db, cursor)
            return result
        except Exception as e:
            print(f"Error executing 'get_fees' stored procedure: {str(e)}")
            close_db_connection(db, cursor)
            return None
    else:
        return "Connection Failed"#None

if __name__ == "__main__":
    # Example usage
    print(get_marks({
        'semester': 4,
        'operation': 'avg'
    }))
    print(get_fees({
        'student_name': "Aanya Gupta",
        'semester': 1,
        'fees_type': 'paid'
    }))
    
