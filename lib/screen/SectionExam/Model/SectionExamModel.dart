import 'dart:ffi';

class SExamModel {
  int? examUniqueId;
  int? module;
  int? accessType;
  String? examId;
  String? examName;
  String? instruction;
  String? durationOfExam;
  int? totalMarks;
  int? noOfQuestions;
  String? slugExams;
  String? solutionPdf;

  bool? isActive;
  List<Sections>? sections;

  SExamModel(
      {this.examUniqueId,
      this.module,
      this.accessType,
      this.examId,
      this.examName,
      this.instruction,
      this.durationOfExam,
      this.totalMarks,
      this.noOfQuestions,
      this.solutionPdf,
      this.slugExams,
      this.isActive,
      this.sections});

  SExamModel.fromJson(Map<String, dynamic> json) {
    examUniqueId = json['exam_unique_id'];
    module = json['module'];
    accessType = json['access_type'];
    examId = json['exam_id'];
    examName = json['exam_name'];
    instruction = json['instruction'];
    solutionPdf = json["solution_pdf"];
    durationOfExam = json['duration_of_exam'];
    totalMarks = json['total_marks'];
    noOfQuestions = json['no_of_questions'];
    slugExams = json['slug_exams'];
    isActive = json['is_active'];
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(new Sections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exam_unique_id'] = this.examUniqueId;
    data['module'] = this.module;
    data['access_type'] = this.accessType;
    data['exam_id'] = this.examId;
    data['exam_name'] = this.examName;
    data['instruction'] = this.instruction;
    data['duration_of_exam'] = this.durationOfExam;
    data['total_marks'] = this.totalMarks;
    data["solution_pdf"] = this.solutionPdf;
    data['no_of_questions'] = this.noOfQuestions;
    data['slug_exams'] = this.slugExams;
    data['is_active'] = this.isActive;
    if (this.sections != null) {
      data['sections'] = this.sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sections {
  int? id;
  int? examName;
  String? sectionNo;
  String? sectionName;
  int? noOfQuesToBeValidated;
  double? positiveMarks;
  double? negetiveMark;
  int? totalScore;
  int? noOfQuestions;
  List<Multiplechoice>? multiplechoice;
  List<Multiselect>? multiselect;
  List<Numericals>? numericals;

  Sections(
      {this.id,
      this.examName,
      this.sectionNo,
      this.sectionName,
      this.noOfQuesToBeValidated,
      this.positiveMarks,
      this.negetiveMark,
      this.totalScore,
      this.noOfQuestions,
      this.multiplechoice,
      this.multiselect,
      this.numericals});

  Sections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    examName = json['exam_name'];
    sectionNo = json['section_no'];
    sectionName = json['section_name'];
    noOfQuesToBeValidated = json['no_of_ques_to_be_validated'];
    positiveMarks = json['positive_marks'];
    negetiveMark = json['negetive_mark'];
    totalScore = json['total_score'];
    noOfQuestions = json['no_of_questions'];
    if (json['multiplechoice'] != null) {
      multiplechoice = <Multiplechoice>[];
      json['multiplechoice'].forEach((v) {
        multiplechoice!.add(new Multiplechoice.fromJson(v));
      });
    }
    if (json['multiselect'] != null) {
      multiselect = <Multiselect>[];
      json['multiselect'].forEach((v) {
        multiselect!.add(new Multiselect.fromJson(v));
      });
    }
    if (json['numericals'] != null) {
      numericals = <Numericals>[];
      json['numericals'].forEach((v) {
        numericals!.add(new Numericals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['exam_name'] = this.examName;
    data['section_no'] = this.sectionNo;
    data['section_name'] = this.sectionName;
    data['no_of_ques_to_be_validated'] = this.noOfQuesToBeValidated;
    data['positive_marks'] = this.positiveMarks;
    data['negetive_mark'] = this.negetiveMark;
    data['total_score'] = this.totalScore;
    data['no_of_questions'] = this.noOfQuestions;
    if (this.multiplechoice != null) {
      data['multiplechoice'] =
          this.multiplechoice!.map((v) => v.toJson()).toList();
    }
    if (this.multiselect != null) {
      data['multiselect'] = this.multiselect!.map((v) => v.toJson()).toList();
    }
    if (this.numericals != null) {
      data['numericals'] = this.numericals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Multiplechoice {
  int? mcqId;
  int? examName;
  int? section;
  int? questionNo;
  String? question;
  String? questionImage;
  String? option1Text;
  String? option2Text;
  String? option3Text;
  String? option4Text;
  String? option1Image;
  String? option2Image;
  String? option3Image;
  String? option4Image;
  String? answer;
  String? solutionText;
  String? solutionImage;

  Multiplechoice(
      {this.mcqId,
      this.examName,
      this.section,
      this.questionNo,
      this.question,
      this.questionImage,
      this.option1Text,
      this.option2Text,
      this.option3Text,
      this.option4Text,
      this.option1Image,
      this.option2Image,
      this.option3Image,
      this.option4Image,
      this.answer,
      this.solutionText,
      this.solutionImage});

  Multiplechoice.fromJson(Map<String, dynamic> json) {
    mcqId = json['mcq_id'];
    examName = json['exam_name'];
    section = json['section'];
    questionNo = json['question_no'];
    question = json['question'];
    questionImage = json['question_image'];
    option1Text = json['option1_text'];
    option2Text = json['option2_text'];
    option3Text = json['option3_text'];
    option4Text = json['option4_text'];
    option1Image = json['option1_image'];
    option2Image = json['option2_image'];
    option3Image = json['option3_image'];
    option4Image = json['option4_image'];
    answer = json['answer'];
    solutionText = json['solution_text'];
    solutionImage = json['solution_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mcq_id'] = this.mcqId;
    data['exam_name'] = this.examName;
    data['section'] = this.section;
    data['question_no'] = this.questionNo;
    data['question'] = this.question;
    data['question_image'] = this.questionImage;
    data['option1_text'] = this.option1Text;
    data['option2_text'] = this.option2Text;
    data['option3_text'] = this.option3Text;
    data['option4_text'] = this.option4Text;
    data['option1_image'] = this.option1Image;
    data['option2_image'] = this.option2Image;
    data['option3_image'] = this.option3Image;
    data['option4_image'] = this.option4Image;
    data['answer'] = this.answer;
    data['solution_text'] = this.solutionText;
    data['solution_image'] = this.solutionImage;
    return data;
  }
}

class Multiselect {
  int? msqId;
  int? questionNo;
  int? section;
  int? examName;
  String? question;
  String? questionImage;
  List<Options>? options;
  String? solutionImage;
  String? solutionText;
  String? slugMultiselect;

  Multiselect(
      {this.msqId,
      this.questionNo,
      this.section,
      this.examName,
      this.question,
      this.questionImage,
      this.options,
      this.solutionImage,
      this.solutionText,
      this.slugMultiselect});

  Multiselect.fromJson(Map<String, dynamic> json) {
    msqId = json['msq_id'];
    questionNo = json['question_no'];
    section = json['section'];
    examName = json['exam_name'];
    question = json['question'];
    questionImage = json['question_image'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
    solutionImage = json['solution_image'];
    solutionText = json['solution_text'];
    slugMultiselect = json['slug_multiselect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msq_id'] = this.msqId;
    data['question_no'] = this.questionNo;
    data['section'] = this.section;
    data['exam_name'] = this.examName;
    data['question'] = this.question;
    data['question_image'] = this.questionImage;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    data['solution_image'] = this.solutionImage;
    data['solution_text'] = this.solutionText;
    data['slug_multiselect'] = this.slugMultiselect;
    return data;
  }
}

class Options {
  int? optionId;
  int? question;
  int? optionNo;
  String? optionsText;
  String? optionsImage;
  bool? isAnswer;
  String? slugOptions;

  Options(
      {this.optionId,
      this.question,
      this.optionNo,
      this.optionsText,
      this.optionsImage,
      this.isAnswer,
      this.slugOptions});

  Options.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'];
    question = json['question'];
    optionNo = json['option_no'];
    optionsText = json['options_text'];
    optionsImage = json['options_image'];
    isAnswer = json['is_answer'];
    slugOptions = json['slug_options'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option_id'] = this.optionId;
    data['question'] = this.question;
    data['option_no'] = this.optionNo;
    data['options_text'] = this.optionsText;
    data['options_image'] = this.optionsImage;
    data['is_answer'] = this.isAnswer;
    data['slug_options'] = this.slugOptions;
    return data;
  }
}

class Numericals {
  int? nqId;
  int? examName;
  int? section;
  int? questionNo;
  String? question;
  String? questionImage;
  String? ansMinRange;
  String? ansMaxRange;
  String? answer;
  String? solutionText;
  String? solutionImage;
  String? slugNumericals;

  Numericals(
      {this.nqId,
      this.examName,
      this.section,
      this.questionNo,
      this.question,
      this.questionImage,
      this.ansMinRange,
      this.ansMaxRange,
      this.answer,
      this.solutionText,
      this.solutionImage,
      this.slugNumericals});

  Numericals.fromJson(Map<String, dynamic> json) {
    nqId = json['nq_id'];
    examName = json['exam_name'];
    section = json['section'];
    questionNo = json['question_no'];
    question = json['question'];
    questionImage = json['question_image'];
    ansMinRange = json['ans_min_range'];
    ansMaxRange = json['ans_max_range'];
    answer = json['answer'];
    solutionText = json['solution_text'];
    solutionImage = json['solution_image'];
    slugNumericals = json['slug_numericals'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nq_id'] = this.nqId;
    data['exam_name'] = this.examName;
    data['section'] = this.section;
    data['question_no'] = this.questionNo;
    data['question'] = this.question;
    data['question_image'] = this.questionImage;
    data['ans_min_range'] = this.ansMinRange;
    data['ans_max_range'] = this.ansMaxRange;
    data['answer'] = this.answer;
    data['solution_text'] = this.solutionText;
    data['solution_image'] = this.solutionImage;
    data['slug_numericals'] = this.slugNumericals;
    return data;
  }
}
