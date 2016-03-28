class TeamAnnotationsController < ApplicationController
  before_action :set_team_annotation, only: [:show, :edit, :update, :destroy]

  # GET /team_annotations
  # GET /team_annotations.json
  def index
    @team_annotations = TeamAnnotation.all
  end

  # GET /team_annotations/1
  # GET /team_annotations/1.json
  def show
  end

  # GET /team_annotations/new
  def new
    @team_annotation = TeamAnnotation.new
  end

  # GET /team_annotations/1/edit
  def edit
  end

  # POST /team_annotations
  # POST /team_annotations.json
  def create
    @team_annotation = TeamAnnotation.new(team_annotation_params)

    respond_to do |format|
      if @team_annotation.save
        format.html { redirect_to compare_path(@team_annotation.assignment_id, @team_annotation.group_id, params[:member1], params[:member2]), notice: 'Team annotation was successfully created.' }
        format.json { render :show, status: :created, location: @team_annotation }
      else
        format.html { render :new }
        format.json { render json: @team_annotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_annotations/1
  # PATCH/PUT /team_annotations/1.json
  def update
    respond_to do |format|
      if @team_annotation.update(team_annotation_params)
        format.html { redirect_to compare_path(@team_annotation.assignment_id, @team_annotation.group_id, params[:member1], params[:member2]), notice: 'Team annotation was successfully updated.' }
        format.json { render :show, status: :ok, location: @team_annotation }
      else
        format.html { render :edit }
        format.json { render json: @team_annotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_annotations/1
  # DELETE /team_annotations/1.json
  def destroy
    @team_annotation.destroy
    respond_to do |format|
      format.html { redirect_to team_annotations_url, notice: 'Team annotation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_annotation
      @team_annotation = TeamAnnotation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_annotation_params
      params.require(:team_annotation).permit(:content, :assignment_id, :group_id, :user_id)
    end
end
