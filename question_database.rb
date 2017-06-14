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

class Question
  attr_reader :id, :title, :body, :user_id

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options["user_id"]

  end

  def self.find_by_id(id)
    raise "#{self} does not exit" if @id
    question = QuestionDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      questions
    WHERE
      id = ?

    SQL
    Question.new(question.first)
  end

  def self.find_by_user_id(user_id)
    raise "#{self} doesn't exist" if @user_id
    quest = QuestionDatabase.instance.execute(<<-SQL, user_id)

    SELECT
      *
    FROM
     questions
    WHERE
      user_id = ?

    SQL
    Question.new(quest.first)
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

  def replies
    Reply.find_by_question_id(@user_id)
  end

end



class User
  attr_accessor :fname, :lname
  attr_reader :id

  def initialize(options)
    @fname = options['fname']
    @lname = options['lname']

  end

  def self.find_by_name(fname, lname)
    user = QuestionDatabase.instance.execute(<<-SQL, fname, lname)
    SELECT
      *
    FROM
      users
    WHERE
      fname = ? OR lname = ?
    SQL

    User.new(user[0])

  end

  def user_questions
    Question.find_by_user_id(id)

  end

  def user_replies
    Reply.find_by_user_id(id)

  end


end
