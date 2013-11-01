class LineItemsController < ApplicationController
#  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
  #  @line_item = LineItem.ne₹w(params[])

  #  render :text => params[:player_id]
    #@line_item = nil


  if params[:result]

    rnd = Round.find(session[:round_id])  

    pls = Player.where(:winner => true, :is_playing => true)

    summ = rnd.pot / pls.count
    #summ = summ.round_down(2)
    rnd.pot = 0

    pls.each do |pl|

      pl.balance = pl.balance + summ

      pl.save

      @line_item = LineItem.new(:player_id => pl.id, :round_id => rnd.id , :amount => 0 - summ,  :level => rnd.level, :pass => false )
      @line_item.save

    end
    rnd.save
    redirect_to root_url
    return

  end

  if params[:winner]

      pl = Player.find(params[:player_id])
      if pl.winner == false
        pl.winner = true
      else
        pl.winner = false
      end
      pl.save

      redirect_to root_url
      return

    end

   if params[:check]

      if Player.where(:is_playing => true, :pass => true).count == 0

        rnd = Round.find(session[:round_id])  
        rnd.level = rnd.level + 1

        players = Player.where(:is_playing => true)

        players.each do |player|
          player.pass = false
          player.save
        end

        rnd.call_value = rnd.big_blind
         rnd.save
     end
     redirect_to root_url
     return
   end


   
    if params[:fold]
      pl = Player.find(params[:player_id])
      pl.is_playing = false
      pl.save

      if Player.where(:is_playing => true, :pass => false).count == 0

      rnd = Round.find(session[:round_id])  
      rnd.level = rnd.level + 1

      players = Player.where(:is_playing => true)

      players.each do |player|
        player.pass = false
        player.save
      end

      rnd.call_value = rnd.big_blind
       rnd.save
    end

      redirect_to root_url
      return

    end

    if params[:raise]

      params[:amount] = params[:raise].to_d - LineItem.where(:player_id => params[:player_id], :round_id => params[:round_id], :level => params[:level]).sum(&:amount)
    end


    if params[:allin]
       pl = Player.find(params[:player_id])
      params[:amount] =  pl.balance #- LineItem.where(:player_id => params[:player_id], :round_id => params[:round_id], :level => params[:level]).sum(&:amount)
       rnd = Round.find(session[:round_id])  
       if rnd.call_value < pl.balance
        params[:raise] = pl.balance
       end

       pl.is_playing = false
       pl.allin = rnd.level
       pl.save

    end

    @line_item = LineItem.new(:player_id => params[:player_id], :round_id => params[:round_id], :amount => params[:amount],  :level => params[:level], :pass => params[:pass] )
    
    if  @line_item.player.balance < params[:amount].to_d
      redirect_to root_url
      return
    end

    if params[:raise]

      if params[:raise].to_d < @line_item.round.call_value
        redirect_to root_url
        return
      end

       @line_item.round.call_value = params[:raise]

      players = Player.where(:is_playing => true)

      players.each do |player|
        player.pass = false
        if(player.id != params[:player_id])
        player.save
      end
      end

    end

    

    @line_item.round.pot = @line_item.round.pot + params[:amount].to_d
    

    @line_item.player.pass = params[:pass]
    @line_item.player.balance = @line_item.player.balance - params[:amount].to_d

    @line_item.save
    @line_item.player.save

    if Player.where(:is_playing => true, :pass => false).count == 0

      @line_item.round.level = @line_item.round.level + 1
      players = Player.where(:is_playing => true)

      players.each do |player|
        player.pass = false
        player.save
      end

      @line_item.round.call_value = @line_item.round.big_blind

    end

    @line_item.round.save
    redirect_to root_url

    # respond_to do |format|
    #   if @line_item.save
    #     format.html { redirect_to @line_item, notice: 'Line item was successfully created.' }
    #     format.json { render action: 'show', status: :created, location: @line_item }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @line_item.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to line_items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
     # params.require(:line_item).permit(:player_id, :round_id, :level, :amount, :pass)
    end
end
