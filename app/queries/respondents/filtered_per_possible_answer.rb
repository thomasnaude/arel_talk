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
      @filters.each_with_index.inject(respondents) do |query, (filter, index)|
        query
          .join(answers(index), join_type(index)).on(respondents[:id].eq(answers(index)[:respondent_id]))
          .join(possible_answers(index)).on(answers(index)[:possible_answer_id].eq(possible_answers(index)[:id]))
          .join(questions(index)).on(possible_answers(index)[:question_id].eq(questions(index)[:id]))
          .where(possible_answers(index)[:label].in(filter[:possible_answers]))
          .where(questions(index)[:label].eq(filter[:question]))
      end.project(respondents[Arel.star])
    end

    def respondents
      Respondent.arel_table
    end

    def answers(index)
      Answer.arel_table.alias("answers#{index}")
    end

    def possible_answers(index)
      PossibleAnswer.arel_table.alias("possible_answers#{index}")
    end

    def questions(index)
      Question.arel_table.alias("questions#{index}")
    end

    def join_type(index)
      index <= 1 ? Arel::Nodes::InnerJoin : Arel::Nodes::FullOuterJoin
    end
  end
end
