class Reply
  attr_accessor :question_id, :parent_reply_id, :user_id, :body

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies WHERE id = #{id}")
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_user_id(user_id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies WHERE id = #{user_id}")
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_question_id(question_id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes WHERE id = #{question_id}")
    data.map { |datum| Reply.new(datum) }
  end

  # def self.find_by_attrs(question_id, parent_reply_id, user_id, body)
  #   data = QuestionsDatabase.instance.execute(<<-SQL, question_id, parent_reply_id, user_id, body)
  #     SELECT
  #       *
  #     FROM
  #       users
  #     WHERE
  #       question_id = ? AND parent_reply_id = ? AND user_id = ? AND body = ?
  #   SQL
  #   Reply.new(data[0])
  # end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @parent_reply_id = options['parent_reply_id']
    @user_id = options['user_id']
    @body = options['body']
  end

  def create
    raise "#{self} already in database" if @id
    QuestionsDatabase.instance.execute(<<-SQL, @question_id, @parent_reply_id, @user_id, @body)
      INSERT INTO
        replies (question_id, parent_reply_id, user_id, body)
      VALUES
        (?, ?, ?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    QuestionsDatabase.instance.execute(<<-SQL, @question_id, @parent_reply_id, @user_id, @body, @id)
      UPDATE
        replies
      SET
        question_id = ?, parent_reply_id = ?, user_id = ?, body = ?
      WHERE
        id = ?
    SQL
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_reply_id)
  end

  def child_replies
    data = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply_id = ?
    SQL
    data.map { |datum| Reply.new(datum) }
  end
end
