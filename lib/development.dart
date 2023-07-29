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

String privacyPolicy = """<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body {
      font-family: Arial, sans-serif;
      line-height: 1.6;
      padding: 20px;
      background-color: #f4f4f4;
      color: #333;
    }

    h1 {
      text-align: center;
      color: #007BFF;
    }

    h2 {
      margin-top: 30px;
      color: #007BFF;
    }

    ul {
      padding-left: 30px;
    }

    p {
      margin-bottom: 15px;
    }

    .section {
      margin-top: 30px;
      border-top: 1px solid #ccc;
      padding-top: 15px;
      background-color: #f9f9f9;
      border-radius: 5px;
      padding: 15px;
    }

    .footer {
      text-align: center;
      margin-top: 40px;
      color: #666;
    }

    .footer p {
      margin: 0;
    }

    .contact-details {
      margin-top: 40px;
      text-align: center;
      color: #666;
    }

    .address {
      margin-top: 10px;
      font-size: 14px;
    }

    .email {
      margin-top: 5px;
    }

    .phone {
      margin-top: 5px;
    }

    .website {
      margin-top: 5px;
      color: #007BFF;
    }
  </style>
</head>

<body>
  <h1>MathLab Cochin - Terms and Policies</h1>

  <p>Effective Date: 01 - AUGEST - 2023</p>

  <div class="section">
    <h2>1. Acceptance of Terms</h2>
    <p>By downloading, installing, accessing, or using the MathLab Cochin mobile app, including video classes, PDF notes, and exams, you acknowledge that you have read, understood, and agree to be bound by these terms and policies. If you do not agree with any part of these terms, you may not use our mobile app.</p>
  </div>

  <div class="section">
    <h2>2. Account Creation and Security</h2>
    <p>To access MathLab Cochin's services through the mobile app, you will be required to create an account using your valid internet login credentials. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account. Please ensure that the information provided during registration is accurate, current, and complete.</p>
  </div>

  <div class="section">
    <h2>3. Data Privacy</h2>
    <p>MathLab Cochin respects your privacy and is committed to protecting your personal information. We only collect and use the minimum necessary data to provide our services effectively. The mobile app does not access any data other than your internet login credentials. Additionally, we do not save any data on your phone or any other device you use to access our mobile app.</p>
  </div>

  <div class="section">
    <h2>4. Intellectual Property</h2>
    <p>All content provided through the MathLab Cochin mobile app, including video classes, PDF notes, and exam materials, is the intellectual property of MathLab Cochin or its licensors. You may not copy, modify, distribute, display, license, or reproduce any content from the mobile app without explicit written permission from us.</p>
  </div>

  <div class="section">
    <h2>5. Prohibited Activities</h2>
    <p>When using the MathLab Cochin mobile app, you agree not to:</p>
    <ul>
      <li>Violate any applicable laws or regulations.</li>
      <li>Infringe upon the rights of others, including copyrights and trademarks.</li>
      <li>Attempt to gain unauthorized access to our mobile app, servers, or other user accounts.</li>
      <li>Transmit any harmful code, viruses, or malware.</li>
      <li>Use MathLab Cochin for any illegal or unethical purposes.</li>
    </ul>
  </div>

  <div class="section">
    <h2>6. User Conduct</h2>
    <p>You are responsible for your conduct within the MathLab Cochin mobile app. Be respectful to other users and instructors. Do not engage in any form of harassment, hate speech, or disruptive behavior. MathLab Cochin reserves the right to suspend or terminate your account if you violate this conduct policy.</p>
  </div>

  <div class="section">
    <h2>7. Disclaimer of Warranties</h2>
    <p>The MathLab Cochin mobile app is provided on an "as is" and "as available" basis. We do not guarantee the accuracy, completeness, or timeliness of the content provided through the app. While we strive to deliver the best possible experience, we do not warrant that our mobile app will be error-free or uninterrupted.</p>
  </div>

  <div class="section">
    <h2>8. Limitation of Liability</h2>
    <p>MathLab Cochin shall not be liable for any direct, indirect, incidental, special, or consequential damages arising from the use of our mobile app or any content provided therein. In no event shall our total liability exceed the amount paid by you, if any, for accessing our services through the mobile app.</p>
  </div>

  <div class="footer">
    <p>If you have any questions or concerns regarding these terms and policies, please contact us at <a href="mailto:support@mathlabcochin.com">support@mathlabcochin.com</a>.</p>
    <p>By using the MathLab Cochin mobile app, you signify your agreement to these terms and policies. Thank you for choosing MathLab Cochin as your e-learning platform!</p>
    <p>[Your Name]</p>
    <p>MathLab Cochin Team</p>
  </div>

  <div class="contact-details">
    <div class="address">
      <p>MathLab Cochin</p>
      <p>First Floor, Anjikkath Tower, Near Metro Pillar No.363,</p>
      <p>Pathadippalam, Koonamthai (P O), Edappally,</p>
      <p>Cochin-682024</p>
    </div>
    <div class="email">
      <p>Email: <a href="mailto:support@mathlabcochin.com">support@mathlabcochin.com</a></p>
    </div>
    <div class="phone">
      <p>Phone: +91 9846613476</p>
    </div>
    <div class="website">
     

""";
