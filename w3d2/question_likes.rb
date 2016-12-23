class QuestionLike
  attr_accessor :question_id, :user_id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
    data.map { |datum| QuestionLikes.new(datum) }
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes WHERE id = #{id}")
    QuestionLike.new(data[0])
  end

  def self.likers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute("SELECT user_id AS id FROM question_likes WHERE question_id = #{question_id}")
    data.map { |datum| User.new(datum) }
  end

  def self.num_likes_for_question_id(question_id)
    QuestionsDatabase.instance.execute("SELECT COUNT(user_id) FROM question_likes WHERE question_id = #{question_id}")
  end

  def self.liked_questions_for_user_id(user_id)
    QuestionsDatabase.instance.execute("SELECT question_id FROM question_likes WHERE user_id = #{user_id}")
  end

  def self.most_liked_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        *, COUNT(question_likes.user_id) AS likers
      FROM
        questions
      JOIN
        question_likes ON questions.id = question_likes.question_id
      WHERE
        questions.id = question_likes.question_id
      GROUP BY
        questions.id
      ORDER BY
        likers DESC
      LIMIT ?
    SQL

    data
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

  def create
    raise "#{self} already in database" if @id
    QuestionsDatabase.instance.execute(<<-SQL, @question_id, @user_id)
      INSERT INTO
        question_likes (question_id, user_id)
      VALUES
        (?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    QuestionsDatabase.instance.execute(<<-SQL, @question_id, @user_id, @id)
      UPDATE
        question_likes
      SET
        question_id = ?, user_id = ?
      WHERE
        id = ?
    SQL
  end
end
