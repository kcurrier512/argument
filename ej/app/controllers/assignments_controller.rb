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
    if !PairMembership.where(user_id: current_user.id).first.nil?
      @group = Group.find(params[:group_id])
      @assignment = Assignment.find(params[:assignment_id])
      @members=[User.find(params[:member1]),User.find(params[:member2])]

      @pair=Pair.find(PairMembership.where(user_id: current_user.id).first.pair_id)

      @pair_members=@pair.users

      @posts=[]
      @first_drafts=[]
      @final_drafts=[]
      @first_draft_footnotes=[]
      @final_draft_footnotes=[]
      @pair_first_drafts=[]
      @pair_final_drafts=[]
      for i in 0..1
        @posts<<Post.where(assignment_id:@assignment.id,user_id:@members[i]).first
        if Draft.where(post_id:@posts[i].id,user_id:current_user.id).empty?
          @first_drafts<<Draft.new(post_id:@posts[i].id,content:@posts[i].draft1,title:"first draft",user_id:current_user.id)
          @first_drafts[i].save()
          @final_drafts[i]=Draft.new(post_id:@posts[i].id,content:@posts[i].draft2,title:"final draft",user_id:current_user.id)
          @final_drafts[i].save()
        else
          @first_drafts[i]=Draft.where(post_id:@posts[i].id,title:"first draft",user_id:current_user.id).first
          @final_drafts[i]=Draft.where(post_id:@posts[i].id,title:"final draft",user_id:current_user.id).first
        end
        @pair_first_drafts[i]=Draft.where(:user_id => @pair_members.pluck(:id),post_id:@posts[i].id,title:"first draft")
        @pair_final_drafts[i]=Draft.where(:user_id => @pair_members.pluck(:id),post_id:@posts[i].id,title:"final draft")

        @first_draft_footnotes[i]=Footnote.where(:draft_id => @pair_first_drafts[i].pluck(:id)).order(:location)
        @final_draft_footnotes[i]=Footnote.where(:draft_id => @pair_final_drafts[i].pluck(:id)).order(:location)
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
