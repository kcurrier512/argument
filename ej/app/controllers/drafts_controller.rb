class DraftsController < ApplicationController
  before_action :set_draft, only: [:show, :edit, :update, :destroy]
  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'

  # GET /drafts
  # GET /drafts.json
  def index
    @drafts = Draft.all
  end

  # GET /drafts/1
  # GET /drafts/1.json
  def show
  end

  # GET /drafts/new
  def new
    @draft = Draft.new
  end

  # GET /drafts/1/edit
  def edit
  end

  # POST /drafts
  # POST /drafts.json
  def create
    @draft = Draft.new(draft_params)

    respond_to do |format|
      if @draft.save
        if !params.has_key?(:compare)
          format.html { redirect_to analyze_path(@draft.post_id), notice: 'Tag added' }
        else
          format.html { redirect_to compare_path(@draft.post.assignment.id,params[:group],params[:member1],params[:member2]), notice: 'Tag added' }
        end
      
      else
        format.html { render :new }
        format.json { render json: @draft.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drafts/1
  # PATCH/PUT /drafts/1.json
  def update
    respond_to do |format|
      if @draft.update(draft_params)
        if !params.has_key?(:compare)
          format.html { redirect_to analyze_path(@draft.post_id), notice: 'Tag added' }
        else
          format.html { redirect_to compare_path(@draft.post.assignment.id,params[:group],params[:member1],params[:member2]), notice: 'Tag added' }
        end
      else
        format.html { render :edit }
        format.json { render json: @draft.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drafts/1
  # DELETE /drafts/1.json
  def destroy
    @draft.destroy
    respond_to do |format|
      format.html { redirect_to drafts_url, notice: 'Draft was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_draft
      @draft = Draft.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def draft_params
      params.require(:draft).permit(:content, :title, :post_id, :user_id, :tag_list)
    end
end
