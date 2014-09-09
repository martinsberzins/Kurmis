class MolesController < ApplicationController
  require 'nokogiri'
  require 'open-uri'
  
  before_action :set_mole, only: [:show, :edit, :update, :destroy]
  
  # GET /moles
  # GET /moles.json
  def index
    @moles = Mole.all.order(:name)
    @last_event = Event.all.order(:updated_at).last
  end

  # GET /moles/1
  # GET /moles/1.json
  def show
  end

  # GET /moles/new
  def new
    @mole = Mole.new
  end

  # GET /moles/1/edit
  def edit
  end

  # POST /moles
  # POST /moles.json
  def create
    @mole = Mole.new(mole_params)

    respond_to do |format|
      if @mole.save
        format.html { redirect_to @mole, notice: 'Mole was successfully created.' }
        format.json { render action: 'show', status: :created, location: @mole }
      else
        format.html { render action: 'new' }
        format.json { render json: @mole.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /moles/1
  # PATCH/PUT /moles/1.json
  def update
    respond_to do |format|
      if @mole.update(mole_params)
        format.html { redirect_to @mole, notice: 'Mole was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mole.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moles/1
  # DELETE /moles/1.json
  def destroy
    @mole.destroy
    respond_to do |format|
      format.html { redirect_to moles_url }
      format.json { head :no_content }
    end
  end

  def analyze_event
    events = Event.all
    
    events.each do |event|
      if event.var2 != "analyzed"
        update_score_from_event(event)
        update_event_name(event)
      end
    end
    #redirect_to moles_path, notice: mess
    redirect_to events_path notice: "Events analyzed!"
  end
  

 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mole
      @mole = Mole.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mole_params
      params.require(:mole).permit(:name, :score, :avatar)
    end
  
  #update event name
  def update_event_name (event)
    url = event.url
    url_arr = url.split("/")
    leg = url_arr[-2].split("_")
    season = url_arr[-3].split("_")
    name = season[0].capitalize + " " + season[1] + " " + leg[0] + ". " + leg[1]
    event.name = name
    event.save
  end
  
  #update score from yet unalized events
    def update_score_from_event(event)
    moles = Mole.all
    new_event = event
    
    new_url = new_event.url
 
    mess = new_url + " | "
    moles.each do |mole|
      page = Nokogiri::HTML(open(new_url))

      name = mole.avatar
      #go to URL to get necessary nodes
      points = page.css("a[title='#{name}']")

      #check if the runner was participating in the event
      if points.empty?
        mess += mole.name + " didn't run | "
      else
        #convert Nokogiri objet to string objects
        message = ""
        points.each do |p|
          message += p
          message += " | "
        end

        #strip the first result
        result_line = message.partition"|" 

        #split result line from blanks to seperate results
        result_line_arr = result_line[0].split
        
        #check for spacial cases
        if result_line_arr.length == 4
          #special cases 1. DQ 2 win
          if result_line_arr[-1] == "DQ"
            #its DQ i.e. 0 pts
            points = 0
          else
            #its win i.e. 100 pts
            points = 100
          end
        else
          #else its regular case of race 
          #convert race time difference to time object
          race_time_diff_s = result_line_arr[-1]

          last = race_time_diff_s.length
          race_time_diff_s = race_time_diff_s.byteslice(1,last)

          #if lagging by less than 1 hour add 0: to fit the format
          if last<7
           race_time_diff_s = "0:"+race_time_diff_s
          end    

          #parse race times from strings to time objects
          now = Time.now
          null_time = Time.parse("0:00:00", now)
          race_time_sec = Time.parse(result_line_arr[-2], now) - null_time
          race_time_diff_sec = Time.parse(race_time_diff_s, now) - null_time

          #leaders time
          race_time_first_sec = race_time_sec - race_time_diff_sec

          points = (1 - race_time_diff_sec / race_time_first_sec) * 100
        end
        
        #mess += mole.name + " +" + points.to_s + " | " 
        #update mole pts
        mole.score += points
        mole.save
        
      end
        #update event that it is analyzed
      new_event.var2 = "analyzed"
      new_event.save
    end
   
    #show that i have output
    #redirect_to moles_path, notice: mess
  end
  
end
