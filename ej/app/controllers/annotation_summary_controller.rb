class AnnotationSummaryController < ApplicationController

  def index
  end

  def summary
    if !PairMembership.where(user_id: current_user.id).first.nil?
      @pair = Pair.find(PairMembership.where(user_id: current_user.id).first.pair_id)
      @all_activity = {}
      @overall_activity = []

      @pair.users.each_with_index do |user, index|
        annotations = []
        team_annotations = []
        footnotes = []

        # view activity for a specific assignment
        if params[:assignment_id].present?
          @assignment = Assignment.find(params[:assignment_id])
          # only append events that occurred for the specified assignment
          Annotation.where(user_id: user.id).order('created_at ASC').each do |a|
            post = Post.find(a.post_id)
            if (post.assignment_id == @assignment.id)
              annotations << a
            end
          end
          # only append comments that occurred for the specified assignment
          TeamAnnotation.where(user_id: user.id).order('created_at ASC').each do |t|
            post = Post.find(t.post_id)
            if post.assignment_id == @assignment.id
              team_annotations << t
            end
          end
          # only append likes that occurred for the specified assignment
          Footnote.where(user_id: user.id).order('created_at ASC').each do |f|
            post = Post.find(Draft.find(f.draft_id).post_id)
            if post.assignment_id == @assignment.id
              footnotes << f
            end
          end
        else # view activity for all assignments
          annotations = Annotation.where(user_id: user.id).order('created_at ASC')
          team_annotations = TeamAnnotation.where(user_id: user.id).order('created_at ASC')
          footnotes = Footnote.where(user_id: user.id).order('created_at ASC')
        end

        @all_activity[index] = []

        g = 0
        h = 0
        i = 0
        total = annotations.count + team_annotations.count + footnotes.count

        # iterate through each array of objects and merge into mega-list of actions in chronological order
        while @all_activity[index].count < total.to_i do
          lowest = annotations[h]
          if (team_annotations[g] != NIL) && ((lowest == NIL) || lowest.created_at > team_annotations[g].created_at)
            lowest = team_annotations[g]
          end
          if (footnotes[i] != NIL) && ((lowest == NIL) || lowest.created_at > footnotes[i].created_at)
            lowest = footnotes[i]
          end
          if lowest == annotations[h]
            h += 1
          elsif lowest == team_annotations[g]
            g += 1
          elsif lowest == footnotes[i]
            i += 1
          end
          @all_activity[index] << lowest
        end
      end

      @count = 0
      @pair.users.each_with_index do |user, index|
        @count += @all_activity[index].count
      end

      while @overall_activity.length < @count do
        @lowest = @all_activity.values[0][0]
        @all_activity.values.each do |act|
          if (act[0] != NIL) && ((@lowest == NIL) || @lowest.created_at > act[0].created_at)
            @lowest = act[0]
          end
        end

        # lowest item is found. HOORAY! now find where it's from and shift it out from the original array
        @all_activity.values.each do |act|
          if @lowest == act[0]
            act.shift
          end
        end

        @overall_activity << @lowest
      end
    end
  end

end
