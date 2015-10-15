class EgresoInternosController < ApplicationController
  before_action :set_egreso_interno, only: [:show, :edit, :update, :destroy]

  # GET /egreso_internos
  # GET /egreso_internos.json
  def index
    #@egreso_internos = EgresoInterno.all
    @palabra = ''
    @palabra = params[:palabra]
    @egreso_internos = EgresoInterno.where("interno_id LIKE ?", "%#{@palabra}%")
  end

  # GET /egreso_internos/1
  # GET /egreso_internos/1.json
  def show
  end

  # GET /egreso_internos/new
  def new
    @egreso_interno = EgresoInterno.new
    @interno = Interno.find_by_id(:interno_id)
    @egreso_interno.interno = @interno
  end

  # GET /egreso_internos/1/edit
  def edit
  end

  # POST /egreso_internos
  # POST /egreso_internos.json
  def create
    @egreso_interno = EgresoInterno.new(egreso_interno_params)
   
      if @egreso_interno.save
        flash[:success] = 'Egreso Interno creado exitosamente'
        redirect_to '/egreso_internos'
      else
        render action: "new"
      end
  end

  # PATCH/PUT /egreso_internos/1
  # PATCH/PUT /egreso_internos/1.json
  def update
    @egreso_interno = EgresoInterno.find(params[:id])
      if @egreso_interno.update(egreso_interno_params)
        flash[:success] = "Egreso Interno actualizado exitosamente"
        redirect_to '/egreso_internos'
      else
        render action: "edit"
      end
  end

  # DELETE /egreso_internos/1
  # DELETE /egreso_internos/1.json
  def destroy
    @egreso_interno.destroy
    respond_to do |format|
      format.html { redirect_to egreso_internos_url, notice: 'Egreso interno was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_egreso_interno
      @egreso_interno = EgresoInterno.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def egreso_interno_params
      params.require(:egreso_interno).permit(:concepto, :monto, :observaciones, :fecha, :interno_id, :egreso_id)
    end
end