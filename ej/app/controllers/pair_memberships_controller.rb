class PairMembershipsController < ApplicationController
  before_action :set_pair_membership, only: [:show, :edit, :update, :destroy]

  # GET /pair_memberships
  # GET /pair_memberships.json
  def index
    @pair_memberships = PairMembership.all
  end

  # GET /pair_memberships/1
  # GET /pair_memberships/1.json
  def show
  end

  # GET /pair_memberships/new
  def new
    @pair_membership = PairMembership.new
  end

  # GET /pair_memberships/1/edit
  def edit
  end

  # POST /pair_memberships
  # POST /pair_memberships.json
  def create
    @pair_membership = PairMembership.new(pair_membership_params)

    respond_to do |format|
      if @pair_membership.save
        format.html { redirect_to @pair_membership, notice: 'Pair membership was successfully created.' }
        format.json { render :show, status: :created, location: @pair_membership }
      else
        format.html { render :new }
        format.json { render json: @pair_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pair_memberships/1
  # PATCH/PUT /pair_memberships/1.json
  def update
    respond_to do |format|
      if @pair_membership.update(pair_membership_params)
        format.html { redirect_to @pair_membership, notice: 'Pair membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @pair_membership }
      else
        format.html { render :edit }
        format.json { render json: @pair_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pair_memberships/1
  # DELETE /pair_memberships/1.json
  def destroy
    @pair_membership.destroy
    respond_to do |format|
      format.html { redirect_to pair_memberships_url, notice: 'Pair membership was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pair_membership
      @pair_membership = PairMembership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pair_membership_params
      params.require(:pair_membership).permit(:user_id, :pair_id)
    end
end
