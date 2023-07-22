String s1 =
    "Amet minim mollit non deserunt ullamco est sit aliqua amet sint. Velit officia consequat duis enim velit mollit.";

String instruction =
    "Read the instructions carefully: \nMake sure you read the instructions for each question carefully before answering. This will help you avoid mistakes and ensure that you understand what is being asked. \nManage your time: Make sure you manage your time effectively during the exam. Keep an eye on the clock and ensure that you have enough time to answer all the questions. \nAnswer all questions: Make sure you answer all the questions in the exam, even if you are not sure of the answer. \nIt is better to make an educated guess than to leave a question unanswered. Avoid cheating: Cheating is not allowed during the exam. \nMake sure you do not use any unauthorized materials or resources during the exam. Submit your exam on time: Make sure you submit your exam before the deadline. \nLate submissions may not be accepted. Use scratch paper: If you need to do any calculations or work out a problem, use the scratch paper provided. \nThis will help you keep your work organized and ensure that you don't make any mistakes.";

String questionData = """
{
    "title": "title of exam",
    "id": 10,
    "instruction": "instruction that show in exam",
    "duration": "duration in second",
    "questions": [
        {
            "question": "what is the value of pi ?",
            "image": "https://hi-static.z-dn.net/files/d42/f4840750339e72e143489c70fd42cd26.jpg",
            "type": "mix",
            "id": 1,
            "model": "multi_select",
            "answers": [
                {
                    "id": "a",
                    "answer": "https://hi-static.z-dn.net/files/d42/f4840750339e72e143489c70fd42cd26.jpg",
                    "type": "image"
                },
                {
                    "id": "b",
                    "answer": "3.12",
                    "type": "text"
                },
                {
                    "id": "c",
                    "answer": "31.4",
                    "type": "text"
                },
                {
                    "id": "d",
                    "answer": "1.4",
                    "type": "text"
                }
            ],
            "correct_answer": "a",
            "mark": 10,
            "negative_mark": 4,
            "solution": {
                "type": "text",
                "solution": "value of pi associated with circle perimeter",
                "solution_image": "<image_url>"
            }
        },
           {
            "question": "https://hi-static.z-dn.net/files/d42/f4840750339e72e143489c70fd42cd26.jpg",
            "image": "<image_url>",
            "type": "image",
            "id": 1,
            "model": "numeric",
            "answers": [
                {
                    "id": "a",
                    "answer": "3.14",
                    "type": "text"
                },
                {
                    "id": "b",
                    "answer": "3.12",
                    "type": "text"
                },
                {
                    "id": "c",
                    "answer": "31.4",
                    "type": "text"
                },
                {
                    "id": "d",
                    "answer": "1.4",
                    "type": "text"
                }
            ],
            "correct_answer": "a",
            "mark": 10,
            "negative_mark": 4,
            "solution": {
                "type": "text",
                "solution": "value of pi associated with circle perimeter",
                "solution_image": "<image_url>"
            }
        },
           {
            "question": "what is the value of pi ?",
            "image": "<image_url>",
            "type": "text",
            "id": 1,
            "model": "multiple_choice",
            "answers": [
                {
                    "id": "a",
                    "answer": "3.14",
                    "type": "text"
                },
                {
                    "id": "b",
                    "answer": "3.12",
                    "type": "text"
                },
                {
                    "id": "c",
                    "answer": "31.4",
                    "type": "text"
                },
                {
                    "id": "d",
                    "answer": "1.4",
                    "type": "text"
                }
            ],
            "correct_answer": "a",
            "mark": 10,
            "negative_mark": 4,
            "solution": {
                "type": "text",
                "solution": "value of pi associated with circle perimeter",
                "solution_image": "<image_url>"
            }
        },
           {
            "question": "what is the value of pi ?",
            "image": "<image_url>",
            "type": "text",
            "id": 1,
            "model": "multiple_choice",
            "answers": [
                {
                    "id": "a",
                    "answer": "3.14",
                    "type": "text"
                },
                {
                    "id": "b",
                    "answer": "3.12",
                    "type": "text"
                },
                {
                    "id": "c",
                    "answer": "31.4",
                    "type": "text"
                },
                {
                    "id": "d",
                    "answer": "1.4",
                    "type": "text"
                }
            ],
            "correct_answer": "a",
            "mark": 10,
            "negative_mark": 4,
            "solution": {
                "type": "text",
                "solution": "value of pi associated with circle perimeter",
                "solution_image": "<image_url>"
            }
        },
           {
            "question": "what is the value of pi ?",
            "image": "<image_url>",
            "type": "text",
            "id": 1,
            "model": "multiple_choice",
            "answers": [
                {
                    "id": "a",
                    "answer": "3.14",
                    "type": "text"
                },
                {
                    "id": "b",
                    "answer": "3.12",
                    "type": "text"
                },
                {
                    "id": "c",
                    "answer": "31.4",
                    "type": "text"
                },
                {
                    "id": "d",
                    "answer": "1.4",
                    "type": "text"
                }
            ],
            "correct_answer": "a",
            "mark": 10,
            "negative_mark": 4,
            "solution": {
                "type": "text",
                "solution": "value of pi associated with circle perimeter",
                "solution_image": "<image_url>"
            }
        }
    ],
    "pass_mark": 20,
    "access_type": "free"
}
""";

String description = r"""
\documentclass{article}

\title{Class Description: plustwo}
\author{Your Name}
\date{\today}

\begin{document}

\maketitle

\section{Class Overview}
The \texttt{plustwo} class is a simple Python class that provides a method to add two to a given number. It serves as a basic example to demonstrate class creation and method implementation in Python.

\section{Class Structure}

\subsection{Attributes}
The \texttt{plustwo} class does not have any class-level attributes.

\subsection{Methods}
The \texttt{plustwo} class has the following method:

\subsubsection{\texttt{add\_two}}
\textbf{Description:} This method takes a single integer argument and returns the result of adding two to the input number.

\textbf{Input:}
\begin{itemize}
    \item \texttt{num} (int): The input number to which two will be added.
\end{itemize}

\textbf{Output:}
\begin{itemize}
    \item (int): The result of adding two to the input number.
\end{itemize}

\section{Usage}
To use the \texttt{plustwo} class, follow these steps:

\begin{verbatim}
# Import the plustwo class
from plustwo import plustwo

# Create an instance of the plustwo class
obj = plustwo()

# Call the add_two method and pass a number as an argument
result = obj.add_two(5)

# Print the result
print(result) # Output: 7
\end{verbatim}

\end{document}

""";
