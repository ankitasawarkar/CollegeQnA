import streamlit as st
from openaiHelper_college import get_answer

# streamlit run <path>/OpenAI_Projects/main_CollegeQnA.py
# http://localhost:8501/

st.title("IIT Madras College: Q&A System")

question = st.text_input("Question:")

if question:
    answer = get_answer(question)
    st.text("Answer:")
    st.write(answer)