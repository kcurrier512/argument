class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]
  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.all
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
    1.times { @assignment.positions.build}
  end

  # GET /assignments/1/edit
  def edit
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = Assignment.new(params[:assignment].permit(:title, :description, :draft_deadline, :final_deadline, 
                         positions_attributes:[:id, :title, :_destroy]))

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to assignments_path, notice: 'Assignment was successfully created.' }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    respond_to do |format|
      if @assignment.update(params[:assignment].permit(:title, :description, :draft_deadline, :final_deadline, 
                         positions_attributes:[:id, :title, :_destroy]))
        format.html { redirect_to assignments_path, notice: 'Assignment was successfully updated.' }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to assignments_url, notice: 'Assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def compare
    @group = Group.find(params[:group_id])
    @assignment = Assignment.find(params[:assignment_id])
    @members=[User.find(params[:member1]),User.find(params[:member2])]

    @posts=[]
    @first_drafts=[]
    @final_drafts=[]
    for i in 0..1
      @posts<<Post.where(assignment_id:@assignment.id,user_id:@members[i]).first
      if Draft.where(post_id:@posts[i].id).empty?
        @first_drafts<<Draft.new(post_id:@posts[i].id,content:@posts[i].draft1,title:"first draft")
        @first_drafts[i].save()
        @final_drafts[i]=Draft.new(post_id:@posts[i].id,content:@posts[i].draft2,title:"final draft")
        @final_drafts[i].save()
      else
        @first_drafts[i]=Draft.where(post_id:@posts[i].id,title:"first draft").first
        @final_drafts[i]=Draft.where(post_id:@posts[i].id,title:"final draft").first
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:title, :description, :draft_deadline, :final_deadline, positions_attributes: [:id, :title])
    end
end
