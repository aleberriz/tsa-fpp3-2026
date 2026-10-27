# Session 14 announcements

- **Homework due Sunday 8 November 2026, 23:59.**
- **The common-errors note on this homework** goes up on Blackboard after the due date.
- **Session 15** is Wednesday 11 November. Monday 9 November is a holiday in Madrid, so there is no
  Monday session that week.
- **Office hours** on request, for concrete questions: email aberrizbeitia@faculty.ie.edu.

## What you asked for in the Menti poll

Thank you for the answers at the end of the transformations session. Here is what changes, and
what does not.

- **The pace.** 19 of 28 said about right and 7 said too fast. If you are in the second group, the
  rendered notebooks go through every slide's idea in more detail, and office hours are open for
  concrete questions.
- **A mock exam.** There will be no mock exam. Instead, before the final, you will get a **practice
  set for the calculation questions**, built from the homework you already have: a list of things
  to compute by hand on the homework's own datasets, each of which you can check against R. For
  the concept questions, the rendered notebooks are the material: everything the final asks about
  is in them.
- **More practice by hand, less R.** From now on, every homework has a **compulsory part by hand**,
  on paper and with your calculator, of the kind the exam asks for. R stays in the course: it is how
  forecasting is done on real data, and the concept questions ask you what its output means.
- **Cheat sheets and study guides.** No notes or formula sheets are allowed in the final, as in the
  midterm. Before it you will get a study guide like the one in the midterm slides of Session 10 (what
  is on the exam, and a check-yourself list for each session). Any formula that is unreasonable to
  memorize will be given in the question itself.
- **The exam questions in advance.** No. The next section explains why.
- **Less homework.** The homework stays, and the last section explains why it is there.
- **Easier exams, and harder exams.** Both came up. The final has the midterm's format: 20
  multiple-choice questions, four options on concept questions and five on calculation questions.

One result worth correcting: only 2 of 26 got the Box–Cox question right. A transformation evens
out the seasonal swings only when their size follows the level of the series. If the level is
steady and the swings grow and shrink for some other reason, no value of lambda can fix them.

## Why the exam questions are new

- **An exam checks whether you can use an idea on a case you have not seen.** That is what
  understanding means. Reproducing an answer you have seen before shows that you remember it, which
  is a different thing.
- **An example from the midterm.** The moving-averages notebook asks you to derive the weights of a
  3×7-MA and a 2×8-MA on paper, and the check-yourself slide of the midterm session listed a
  3×3-MA. The exam
  asked for a 3×3-MA on a table you had not seen. All three are the same idea, a moving average of
  a moving average, with different orders. If you understood why the weights come out as they do,
  any of them was a short calculation. If you had memorized one worked answer, none of the others
  followed from it.
- **The final works the same way.** The homework teaches the methods, and the exam gives you new
  numbers and sometimes a variation of the same method. A list of the exam's questions given out in
  advance would only test whether you remember the list.

## Why there is homework after every session

- **Practice while the lesson is fresh.** A method you apply within a few days of the session
  sticks; one you first try weeks later has to be learned again.
- **The final cannot be crammed.** It covers the whole course, far more than one evening before the
  exam can hold.
- **Reps, like at the gym.** Nobody gets fit the day before a race. A calculation you have done by
  hand several times is one you can do under exam conditions.
- **Low stakes by design.** Homework is 10% of the grade and is graded on completion and genuine
  effort, not on correctness, so a wrong answer costs you nothing. It is the place to make mistakes.
- **It is your practice material.** The calculation questions on the exams are hand calculations of
  the kind the homework asks for, and the practice set before the final is built from the homework.
  If you have done the homework yourself, no method on the exam is new to you.
- **It checks itself.** Most exercises compare your manual computation with R's own result through
  `all.equal()`, so you know whether you got it right without a solutions file.

If a date here disagrees with Blackboard, Blackboard is the authority.
