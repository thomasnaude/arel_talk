Arel talk - Apéro Ruby 26 jan 2018

## Our objective : Count respondents that are 18 - 34, males

Lets start by selecting 18 -34 yo using Active Records:

```ruby
Respondent.joins(answers: :possible_answer).where(possible_answers: { label: ['18-24 yo', '25-34 yo'], question: Question.find_by(label: 'Age') }).size`
=>
SELECT COUNT(*)
FROM "respondents"
INNER JOIN "answers" ON "answers"."respondent_id" = "respondents"."id"
INNER JOIN "possible_answers" ON "possible_answers"."id" = "answers"."possible_answer_id"
WHERE "possible_answers"."label" IN ('18-24 yo', '25-34 yo')
AND "possible_answers"."question_id" = 2
```

Lets now add another condition on males :

```ruby
Respondent.joins(answers: :possible_answer).where(possible_answers: { label: ['18-24 yo', '25-34 yo'], question: Question.find_by(label: 'Age') }).where(possible_answers: { label: ['male'], question: Question.find_by(label: 'Gender') }).size
=>
SELECT COUNT(*)
FROM "respondents"
INNER JOIN "answers" ON "answers"."respondent_id" = "respondents"."id"
INNER JOIN "possible_answers" ON "possible_answers"."id" = "answers"."possible_answer_id"
WHERE "possible_answers"."label" IN ('18-24 yo', '25-34 yo')
AND "possible_answers"."question_id" = 2
AND "possible_answers"."label" = 'male'
AND "possible_answers"."question_id" = 1
```

No respondent is selected as an answer cannot belong two different questions / possible_answers at the same time

SOLUTION : join the possible_answers table on itself
ISSUE : Active Records 'joins' or 'includes' don't offer that possiblity


## SOLUTION 1 : pure SQL

```ruby
sql = <<~SQL
  SELECT COUNT(*)
  FROM "respondents"
  INNER JOIN "answers" ON "answers"."respondent_id" = "respondents"."id"
  INNER JOIN "possible_answers" ON "possible_answers"."id" = "answers"."possible_answer_id"
  FULL OUTER JOIN "answers" AS "answers2" ON "answers2"."respondent_id" = "respondents"."id"
  INNER JOIN "possible_answers" AS "possible_answers2" ON "possible_answers2"."id" = "answers2"."possible_answer_id"
  WHERE "possible_answers"."label" IN ('18-24 yo', '25-34 yo')
  AND "possible_answers"."question_id" = 2
  AND "possible_answers2"."label" = 'male'
  AND "possible_answers2"."question_id" = 1
SQL
Respondent.connection.select_all(sql)
```

This works !!!

What happens, however, if I need to remove / add filters on the fly ? Will need to add the right joins in the right spot, with the right names, and add the correct 'where' or 'end' at the end of the query

==> Here comes Arel : a modulable and maintenable way to write SQL

## SOLUTION 2 : Arel

see app/queries/respondents/filtered_per_possible_answer.rb
