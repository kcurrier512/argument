class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    if current_user.admin?
      @assignment = Assignment.find(params[:assignment_id])
      @posts = Post.where(assignment_id: @assignment.id)
    else
      @assignment = Assignment.find(params[:assignment_id])
      @teammates = Array.new
      current_user.memberships.last.group.users.each do |u|
        @teammates << u.id
      end
      @posts = Post.where(assignment_id: @assignment.id, :user_id => @teammates)
      @post =  Post.where(assignment_id: @assignment.id, user_id: current_user.id).first
      ahoy.track "Visited Assignments Page"
    end
  end

  def analyze
    @post = Post.find(params[:id])
    if Draft.where(post_id:@post.id).empty?
      @first_draft=Draft.new(post_id:@post.id,content:@post.draft1,title:"first draft")
      @first_draft.save()
      @final_draft=Draft.new(post_id:@post.id,content:@post.draft2,title:"final draft")
      @final_draft.save()
    else
      @first_draft=Draft.where(post_id:@post.id,title:"first draft").first
      @final_draft=Draft.where(post_id:@post.id,title:"final draft").first
    end
  end

  def annotate
    @post = Post.find(params[:id])
  end

  def diff
    @post = Post.find(params[:id])
  end

  def inclass
    @posts = Post.where(bookmarked: true)
  end

  def myposts
    if current_user.admin
      @user = User.find(params[:user_id])
      @posts = Post.where(user_id: @user.id)
    else
    @posts = Post.where(user_id: current_user.id)
    ahoy.track "Visited My Post Page"
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    unless @post.user.id == current_user.id
      ahoy.track "Read Post", post_id: @post.id
    end
  end

  # GET /posts/new
  def new
    @assignment = Assignment.find(params[:assignment_id])
    @post = Post.new(assignment_id: @assignment.id)

    if current_user.assigned_positions.last
      @position_title = current_user.positions.last.title
    else
      @position_title = "No Position"
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @assignment = Assignment.find(@post.assignment_id)
    ahoy.track "Edited Post", post_id: @post.id
    if current_user.assigned_positions.last
      @position_title = current_user.positions.last.title
    else
      @position_title = "No Position"
    end
  end

  # POST /posts
  # POST /posts.json
  def create

    @post = Post.new(post_params)

    if params[:commit] == 'Submit Post To Class'
      @post.submitted = true
      @post.draft2 = @post.draft1
    else
      @post.submitted = false
    end

    if current_user.assigned_positions.last
      @post.position_id = current_user.assigned_positions.last.position.id
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to edit_post_path(@post), notice: 'Post was successfully created.' }
        format.json { render :edit, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update

    if params[:commit] == 'Submit Post To Class'
      @post.submitted = true
      @post.draft2 = @post.draft1
    end


    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to edit_post_path(@post), notice: 'Post was successfully updated.' }
        format.json { render :edit, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def flop
    post = Post.find(params[:id])
    if !post.bookmarked
      UserMailer.notification_email(post.user).deliver_now
    end
    post.bookmarked = !post.bookmarked # flop the status
    post.save

    redirect_to post_path(post)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
        params.require(:post).permit(:headline, :draft1, :draft2, :bookmarked, :user_id, :assignment_id, :position_id)
    end
end
