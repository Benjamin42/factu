class TypesController < ApplicationController
  # GET /parameters
  # GET /parameters.json
  def index
    @types = Hash.new
    Type.distinctGrp.each do |grp|
      @types[grp.grp] = Type.findAllWithGroupe(grp.grp)
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @types }
    end
  end

  # PUT /parameters/1
  # PUT /parameters/1.json
  def update
    @type = Type.find(params[:id])

    respond_to do |format|
      if @type.update_attributes(params[:type])
        format.html { redirect_to @type, notice: 'Parameter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @type.errors, status: :unprocessable_entity }
      end
    end
  end

end
