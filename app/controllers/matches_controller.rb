class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :edit, :update, :destroy, :up, :down]

  # GET /matches
  # GET /matches.json
  def index
    session.clear
    session['matches_session'] = Hash.new
    @matches = Match.all
  end

  # GET /matches/1
  # GET /matches/1.json
  def show
  end

  # GET /matches/new
  def new
    @match = Match.new
  end

  # GET /matches/1/edit
  def edit
  end

  # POST /matches
  # POST /matches.json
  def create
    @match = Match.new(match_params)
    respond_to do |format|
      if @match.save
        format.html { redirect_to @match, notice: 'Match was successfully created.' }
        format.json { render :show, status: :created, location: @match }
      else
        format.html { render :new }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /matches/1
  # PATCH/PUT /matches/1.json
  def update
    respond_to do |format|
      if @match.update(match_params)
        format.html { redirect_to @match, notice: 'Match was successfully updated.' }
        format.json { render :show, status: :ok, location: @match }
      else
        format.html { render :edit }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @match.destroy
    respond_to do |format|
      format.html { redirect_to matches_url, notice: 'Match was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /matches/up/1.json
  def up
    if @match.increment!(:minutes_booked)
      user_session_amout_minutes(@match.id, @match.price_per_minute, true)
      render json: { 
        notice: "1min added · total #{ ActiveSupport::NumberHelper.number_to_currency(session['matches_session']["total"]) }", 
        entity: @match, 
        matches_session: session["matches_session"],
        current_amount_minutes: session['matches_session']["#{@match.id}_match_amount_minutes"]
      }, status: :ok and return
    else
      render json: { 
        errors: @match.errors, 
        entity: @match,
        matches_session: session["matches_session"]
      }, status: :unprocessable_entity and return
    end
  end

  # POST /matches/down/1.json
  def down
    if session['matches_session']["#{@match.id}_match_amount_minutes"].to_i != 0 && @match.decrement!(:minutes_booked)
      user_session_amout_minutes(@match.id, @match.price_per_minute, false)
      render json: { 
        notice: "1min subtracted · total #{ ActiveSupport::NumberHelper.number_to_currency(session['matches_session']["total"]) }", 
        entity: @match, 
        matches_session: session["matches_session"],
        current_amount_minutes: session['matches_session']["#{@match.id}_match_amount_minutes"]
      }, status: :ok and return
    else
      render json: { 
        errors: @match.errors, 
        entity: @match, 
        matches_session: session["matches_session"],
      }, status: :unprocessable_entity and return
    end
  end

  def user_session_amout_minutes(id, price, added)
    if added
      session['matches_session']["#{id}_match_amount_minutes"] = session['matches_session']["#{id}_match_amount_minutes"].to_i + 1
      session['matches_session']["#{id}_match_total"] = session['matches_session']["#{id}_match_total"].to_i + price
    elsif session['matches_session']["#{id}_match_amount_minutes"] != 0
      session['matches_session']["#{id}_match_amount_minutes"] = session['matches_session']["#{id}_match_amount_minutes"] - 1
      session['matches_session']["#{id}_match_total"] = session['matches_session']["#{id}_match_total"] - price
    end
    session['matches_session']["amount_minutes"] = 0
    session['matches_session']["total"] = 0
    session['matches_session'].keys.each do |key|
      if key.include?("match_amount_minutes")
        session['matches_session']["amount_minutes"] = session['matches_session']["amount_minutes"] + session['matches_session'][key]
      end
      if key.include?("match_total")
        session['matches_session']["total"] = session['matches_session']["total"] + session['matches_session'][key]
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.fetch(:match, {})
    end
end
