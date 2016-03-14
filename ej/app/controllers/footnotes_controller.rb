class FootnotesController < ApplicationController
  before_action :set_footnote, only: [:show, :edit, :update, :destroy]

  # GET /footnotes
  # GET /footnotes.json
  def index
    @footnotes = Footnote.all
  end

  # GET /footnotes/1
  # GET /footnotes/1.json
  def show
  end

  # GET /footnotes/new
  def new
    @footnote = Footnote.new
  end

  # GET /footnotes/1/edit
  def edit
  end

  # POST /footnotes
  # POST /footnotes.json
  def create
    @footnote = Footnote.new(footnote_params)

    respond_to do |format|
      if @footnote.save
        format.html { redirect_to analyze_path(Post.find(Draft.find(@footnote.draft_id).post_id)), notice: 'Footnote was successfully created.' }
        format.json { render :show, status: :created, location: @footnote }
      else
        format.html { render :new }
        format.json { render json: @footnote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /footnotes/1
  # PATCH/PUT /footnotes/1.json
  def update
    respond_to do |format|
      if @footnote.update(footnote_params)
        format.html { redirect_to @footnote, notice: 'Footnote was successfully updated.' }
        format.json { render :show, status: :ok, location: @footnote }
      else
        format.html { render :edit }
        format.json { render json: @footnote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /footnotes/1
  # DELETE /footnotes/1.json
  def destroy
    @footnote.destroy
    respond_to do |format|
      format.html { redirect_to analyze_path(Post.find(Draft.find(@footnote.draft_id).post_id)), notice: 'Footnote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_footnote
      @footnote = Footnote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def footnote_params
      params.require(:footnote).permit(:content, :location, :draft_id, :user_id)
    end
end
