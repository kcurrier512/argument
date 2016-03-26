class User < ActiveRecord::Base
  has_many :posts
  has_many :notes
  has_many :comments
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :assigned_positions
  has_many :positions, through: :assigned_positions
  has_many :evaluations
  has_many :annotations
  has_many :team_annotations
  has_many :footnotes
  has_many :tags
  has_many :drafts
  has_many :pair_memberships
  has_many :pairs, through: :pair_memberships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable

    def delta (problem)
    @posts = Post.where(problemID: problem)
    @evaluations = Evaluation.where(user_id: self.id, :post_id => @posts).order('user_rank ASC')
    delta = 0
    i = 0
    @evaluations.each do |e1|
      @evaluations.each do |e2|
        unless e1.user_rank.nil? or e2.user_rank.nil?
        if e1.user_rank < e2.user_rank
          unless e1.post.ta_rank.nil? or e2.post.ta_rank.nil?
            i += 1
          if e1.post.ta_rank > e2.post.ta_rank
            delta += 1
          end
        end
        end
      end
      end
    end
    if i == 0
      delta = 100
    end
    return delta
  end

end
