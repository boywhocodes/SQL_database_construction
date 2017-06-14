
class QuestionDatabase  <  SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    #a
    self.type_translation = true
    self.results_as_hash = true

  end
end


class Reply
  attr_reader :reply, :parent_id, :user_id, :body, :question_id
  attr_accessor :id

  def initialize(options)
    @id = options['id']
    @reply = options['reply']
    @parent_id = options['parent_id']
    @user_id = options['user_id']
    @body = options['body']
    @question_id = options['question_id']
  end

  def self.find_by_user_id(user_id)
    reply = QuestionDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
      replies
    WHERE
      user_id = ?
    SQL
    Reply.new(reply.first)
  end

  def self.find_by_question_id(question_id)
    reply = QuestionDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      replies
    WHERE
      question_id = ?
    SQL
    Reply.new(reply.first)
  end

  def user
    user = QuestionDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
      users
    WHERE
      id = ?
    SQL
  end

  def question
    QuestionDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      questions
    WHERE
      id = ?
    SQL

  end

  def parent_reply
    QuestionDatabase.instance.execute(<<-SQL, parent_id)
    SELECT
      *
    FROM
      replies
    WHERE
      id = ?
    SQL
  end


  def child_replies
    QuestionDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      replies
    WHERE
      parent_id = ?
    SQL
  end



end
# id INTEGER PRIMARY KEY,
# reply TEXT NULL,
# parent_id INTEGER NOT NULL, --parent_id
# user_id INTEGER NOT NULL,
# body TEXT NOT NULL,
# question_id INTEGER NOT NULL,
