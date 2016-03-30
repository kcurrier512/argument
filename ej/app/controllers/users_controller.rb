class UsersController < ApplicationController


  def index
    @users = User.where(admin: false)
  end

  def activity
    @groups = Group.all
    @users = []
    users = User.where(admin: false)
    time = Time.zone.parse('2016-03-01 21:00')
    # only adds in users created before transcript analysis began: the "old" user accounts
    users.each do |user|
      unless user.created_at > time
        @users << user
      end
    end
  end

  def _postsnap
    @post = Post.find(params[:post_id])
  end

  def playback
    @user = User.find(params[:user_id])
    @nickname = @user.nickname
    @comments = []
    @ahoy_events = []
    @likes = []
    @notes = []
    @posts = []
    if params[:i].present?
      @i = params[:i]
    else
      @i = 0
    end

    # view activity for a specific assignment
    if params[:assignment_id].present?
      @assignment = Assignment.find(params[:assignment_id])
      @posts = Post.where(user_id: @user.id, assignment_id: @assignment.id).order('created_at ASC')
      # only append events that occurred for the specified assignment
      Ahoy::Event.where(user_id: @user.id).order('time ASC').each do |event|
        if event.properties.to_s.length > 2
          unless Post.find_by_id(event.properties.to_s.split('=>')).nil?
            @post = Post.find(event.properties.to_s.split('=>')[1])
            if (@post.assignment_id == @assignment.id)
              @ahoy_events << event
            end
          end
        else
          @ahoy_events << event
        end
      end
      # only append comments that occurred for the specified assignment
      Comment.where(user_id: @user.id).order('created_at ASC').each do |c|
        @post = Post.find(c.post_id)
        if @post.assignment_id == @assignment.id
          @comments << c
        end
      end
      # only append likes that occurred for the specified assignment
      Like.where(user_id: @user.id).order('created_at ASC').each do |l|
        @post = Post.find(l.post_id)
        if @post.assignment_id == @assignment.id
          @likes << l
        end
      end
      Note.where(user_id: @user.id).order('created_at ASC').each do |n|
        @post = Post.find(n.post_id)
        if @post.assignment_id == @assignment.id
          @notes << n
        end
      end
    else # view activity for all assignments
      @ahoy_events = Ahoy::Event.where(user_id: @user.id).order('time ASC')
      @notes = Note.where(user_id: @user.id).order('created_at ASC')
      @comments = Comment.where(user_id: @user.id).order('created_at ASC')
      @likes = Like.where(user_id: @user.id).order('created_at ASC')
      @posts = Post.where(user_id: @user.id).order('created_at ASC')
      @post = @posts.first
    end

    @all_activity = []
    @goposts = []

    g = 0
    h = 0
    i = 0
    j = 0
    k = 0
    total = @comments.count + @notes.count + @ahoy_events.count + @likes.count + @posts.count

    # iterate through each array of objects and merge into mega-list of actions in chronological order
    while @all_activity.count < total.to_i do
      @lowest = @comments[h]
      if (@posts[g] != NIL) && ((@lowest == NIL) || @lowest.created_at > @posts[g].created_at)
        @lowest = @posts[g]
      end
      if (@likes[i] != NIL) && ((@lowest == NIL) || @lowest.created_at > @likes[i].created_at)
        @lowest = @likes[i]
      end
      if (@notes[j] != NIL) && ((@lowest == NIL) || @lowest.created_at > @notes[j].created_at)
        @lowest = @notes[j]
      end
      if (@ahoy_events[k] != NIL) && ((@lowest == NIL) || @lowest.created_at > @ahoy_events[k].time)
        @lowest = @ahoy_events[k]
      end
      if @lowest == @comments[h]
        @goposts << Post.find(@comments[h].post_id)
        h += 1
      elsif @lowest == @posts[g]
        @goposts << @posts[g]
        g += 1
      elsif @lowest == @notes[j]
        @goposts << Post.find(@notes[j].post_id)
        j += 1
      elsif @lowest == @likes[i]
        @goposts << Post.find(@likes[i].post_id)
        i += 1
      elsif @lowest == @ahoy_events[k]
        if @ahoy_events[k].properties.to_s.length > 2
          @goposts << Post.find(@ahoy_events[k].properties.to_s.split('=>')[1])
        else
          @goposts << nil
        end
        k += 1
      end
      @all_activity << @lowest
    end

    # Resets index variable i if it is indexing out of bounds of the array
    if @i.to_i < 0
      @i = @all_activity.length - 1
    elsif @i.to_i >= @all_activity.length
      @i = 0
    end
    @gopost = @goposts[@i.to_i]
  end



  def teamplay
    @group = Group.find(params[:group_id])
    @all_activity = {}
    @overall_activity = []
    @goposts = []

    if params[:i].present?
      @i = params[:i]
    else
      @i = 0
    end

    @group.users.each_with_index do |user, index|
      ahoy_events = []
      comments = []
      likes = []
      notes = []
      posts = []

      # view activity for a specific assignment
      if params[:assignment_id].present?
        @assignment = Assignment.find(params[:assignment_id])
        posts = Post.where(user_id: user.id, assignment_id: @assignment.id).order('created_at ASC')
        # only append events that occurred for the specified assignment
        Ahoy::Event.where(user_id: user.id).order('time ASC').each do |event|
          if (event.properties.to_s.length > 2) # event has a post id if properties attribute length is greater than 2
            unless Post.find_by_id(event.properties.to_s.split('=>')[1]).nil?
              post = Post.find(event.properties.to_s.split('=>')[1])
              if (post.assignment_id == @assignment.id)
                ahoy_events << event
              end
            end
          else
            ahoy_events << event
          end
        end
        # only append comments that occurred for the specified assignment
        Comment.where(user_id: user.id).order('created_at ASC').each do |c|
          post = Post.find(c.post_id)
          if post.assignment_id == @assignment.id
            comments << c
          end
        end
        # only append likes that occurred for the specified assignment
        Like.where(user_id: user.id).order('created_at ASC').each do |l|
          post = Post.find(l.post_id)
          if post.assignment_id == @assignment.id
            likes << l
          end
        end
        Note.where(user_id: user.id).order('created_at ASC').each do |n|
          post = Post.find(n.post_id)
          if post.assignment_id == @assignment.id
            notes << n
          end
        end
      else # view activity for all assignments
        ahoy_events = Ahoy::Event.where(user_id: user.id).order('time ASC')
        notes = Note.where(user_id: user.id).order('created_at ASC')
        comments = Comment.where(user_id: user.id).order('created_at ASC')
        likes = Like.where(user_id: user.id).order('created_at ASC')
        posts = Post.where(user_id: user.id).order('created_at ASC')
        post = posts.first
      end

      @all_activity[index] = []

      g = 0
      h = 0
      i = 0
      j = 0
      k = 0
      total = comments.count + notes.count + ahoy_events.count + likes.count + posts.count

      # iterate through each array of objects and merge into mega-list of actions in chronological order
      while @all_activity[index].count < total.to_i do
        lowest = comments[h]
        if (posts[g] != NIL) && ((lowest == NIL) || lowest.created_at > posts[g].created_at)
          lowest = posts[g]
        end
        if (likes[i] != NIL) && ((lowest == NIL) || lowest.created_at > likes[i].created_at)
          lowest = likes[i]
        end
        if (notes[j] != NIL) && ((lowest == NIL) || lowest.created_at > notes[j].created_at)
          lowest = notes[j]
        end
        if (ahoy_events[k] != NIL) && ((lowest == NIL) || lowest.created_at > ahoy_events[k].time)
          lowest = ahoy_events[k]
        end
        if lowest == comments[h]
          h += 1
        elsif lowest == posts[g]
          g += 1
        elsif lowest == notes[j]
          j += 1
        elsif lowest == likes[i]
          i += 1
        elsif lowest == ahoy_events[k]
          k += 1
        end
        @all_activity[index] << lowest
      end
    end


    @count = 0
    @group.users.each_with_index do |user, index|
      @count += @all_activity[index].count
    end

    a = 0
    b = 0
    c = 0
    #
    while @overall_activity.length < @count do
      @lowest = @all_activity.values[0][0]
      @all_activity.values.each do |act|
        # must implement checks for type of item because some items use .created_at and others *cough* use .time for comparisons
        if (@lowest.is_a?(Ahoy::Event)) # use lowest.time
          if (act[0].is_a?(Ahoy::Event)) # use act[0].time as well
            if (act[0] != NIL) && ((@lowest == NIL) || @lowest.time > act[0].time)
              @lowest = act[0]
            end
          else # use lowest.time and act[0].created_at
            if (act[0] != NIL) && ((@lowest == NIL) || @lowest.time > act[0].created_at)
              @lowest = act[0]
            end
          end
        else # use lowest.created_at
          if (act[0].is_a?(Ahoy::Event)) # use act[0].time
            if (act[0] != NIL) && ((@lowest == NIL) || @lowest.created_at > act[0].time)
              @lowest = act[0]
            end
          else # use .created_at for both items
            if (act[0] != NIL) && ((@lowest == NIL) || @lowest.created_at > act[0].created_at)
              @lowest = act[0]
            end
          end
        end
      end

      # lowest item is found. HOORAY! now find where it's from and shift it out from the original array
      @all_activity.values.each do |act|
        if @lowest == act[0]
          act.shift
        end
      end

      #now...we must check type of item and add its corresponding post id to the gopost array
      if @lowest.is_a?(Comment)
        @goposts << Post.find(@lowest.post_id)
      elsif @lowest.is_a?(Post)
        @goposts << @lowest
      elsif @lowest.is_a?(Note)
        @goposts << Post.find(@lowest.post_id)
      elsif @lowest.is_a?(Like)
        @goposts << Post.find(@lowest.post_id)
      elsif @lowest.is_a?(Ahoy::Event)
        if @lowest.properties.to_s.length > 2
          unless Post.find_by_id(@lowest.properties.to_s.split('=>')[1]).nil?
          @goposts << Post.find(@lowest.properties.to_s.split('=>')[1])
          end
        else
          @goposts << nil
        end
      end
      @overall_activity << @lowest

    end

    # Resets index variable i if it is indexing out of bounds of the array
    if @i.to_i < 0
      @i = @overall_activity.length - 1
    elsif @i.to_i >= @overall_activity.length
      @i = 0
    end

    @gopost = @goposts[@i.to_i]
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :email)
  end

end
