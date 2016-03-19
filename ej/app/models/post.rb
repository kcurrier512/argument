class Post < ActiveRecord::Base
		belongs_to :user
    belongs_to :assignment
    belongs_to :position
    has_many :comments
    has_many :notes
    has_many :likes
    has_many :evaluations


    def peer_grade
		((self.pg_1 + self.pg_2 + self.pg_3) / 3).round(2)
	end


	def pg_1
		@evals = Evaluation.where(post_id: self.id)
		i = 0
		grade = 0.0
			@evals.each do |eval|
				unless eval.rating_1.nil?
					grade = grade + eval.rating_1
					i += 1
				end
			end
		grade = (grade/i).round(2)
	end

	def pg_2
		@evals = Evaluation.where(post_id: self.id)
		@evals = Evaluation.where(post_id: self.id)
		i = 0
		grade = 0.0
			@evals.each do |eval|
				unless eval.rating_2.nil?
					grade = grade + eval.rating_2
					i += 1
				end
			end
		grade = (grade/i).round(2)
	end

	def pg_3
		@evals = Evaluation.where(post_id: self.id)
		@evals = Evaluation.where(post_id: self.id)
		i = 0
		grade = 0.0
			@evals.each do |eval|
				unless eval.rating_3.nil?
					grade = grade + eval.rating_3
					i += 1
				end
			end
		grade = (grade/i).round(2)
	end

	def avg_rank
		@eval = Evaluation.where(post_id: self.id)
		rank = 1
		i = 1
		@eval.each do |e|
			unless e.user_rank.nil?
			rank += e.user_rank
			i += 1
			end
		end
		return (rank/i).round(2)
	end

end
