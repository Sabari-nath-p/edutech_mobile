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
