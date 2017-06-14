require 'sqlite3'
require 'singleton'


class QuestionDatabase  <  SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    #a
    self.type_translation = true
    self.results_as_hash = true

  end
end


class QuestionFollow
  attr_reader :question_id, :user_id

def initialize(options)
  @question_id = options['question_id']
  @user_id = options['user_id']
end

def self.followers_for_question_id(question_id)

  user = QuestionDatabase.instance.execute(<<-SQL, question_id)
  SELECT
    *
  FROM
    users
  JOIN
    question_follows ON question_follows.question_id = user.id
  JOIN
    question ON question.user_id = user.id
  WHERE
    user_id ?

  SQL
  QuestionFollow.new(user.first)

end


end
