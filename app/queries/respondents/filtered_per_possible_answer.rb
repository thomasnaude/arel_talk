module Respondents
  class FilteredPerPossibleAnswer
    attr_reader :relation

    def initialize(relation = Respondent.all, filters = [])
      @relation = relation
      @filters = filters
    end

    def call
      @relation.where(id: sub_query)
    end

    private

    def sub_query
      @relation.find_by_sql(filter_query.to_sql)
    end

    def filter_query
      i = 0
      @filters.inject(respondents) do |query, filter|
        i += 1
        query
          .join(answers(i), join_type(i)).on(respondents[:id].eq(answers(i)[:respondent_id]))
          .join(possible_answers(i)).on(answers(i)[:possible_answer_id].eq(possible_answers(i)[:id]))
          .join(questions(i)).on(possible_answers(i)[:question_id].eq(questions(i)[:id]))
          .where(possible_answers(i)[:label].in(filter[:possible_answers]))
          .where(questions(i)[:label].eq(filter[:question]))
      end.project(respondents[Arel.star])
    end

    def respondents
      Respondent.arel_table
    end

    def answers(i)
      Answer.arel_table.alias("answers#{i}")
    end

    def possible_answers(i)
      PossibleAnswer.arel_table.alias("possible_answers#{i}")
    end

    def questions(i)
      Question.arel_table.alias("questions#{i}")
    end

    def join_type(i)
      i <= 1 ? Arel::Nodes::InnerJoin : Arel::Nodes::FullOuterJoin
    end
  end
end
