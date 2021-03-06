class EgresosController < ApplicationController
  before_action :set_egreso, only: [:show, :edit, :update, :destroy]

  # GET /egresos
  # GET /egresos.json
  def index
    @egresos = Egreso.all.paginate(:per_page => 4, :page => params[:page])
    if params[:fecha_fin] == nil || params[:fecha_fin] == ""
      params[:fecha_fin]=Date.today
      @egresos = Egreso.order("fecha DESC").paginate(:per_page => 4, :page => params[:page]).where("fecha <= ?", params[:fecha_fin].to_date)
    else
      if params[:fecha_inicio] != nil && params[:fecha_fin] != nil
        @egresos = Egreso.order("fecha DESC").paginate(:per_page => 4, :page => params[:page]).where("fecha >= ? and fecha <= ?", params[:fecha_inicio].to_date, params[:fecha_fin].to_date)
    end
  end
  end

  # GET /egresos/1
  # GET /egresos/1.json
  def activo
    @egreso.activo
      respond_to do |format|
      format.html { redirect_to egresos_url }
      format.json { head :no_content }
    end
  end

  def buscar_entre_fechas     
    @egresos = Egreso.where("fecha >= ? AND fecha <= ?", "#{@fecha_inicio}", "#{@fecha_fin}")
  end

  def show
  end

  def dinero_actual()
    @total=0
    @total_egreso=0
    @total_egreso_interno=0

    @ingresos= Ingreso.all
    @egresos=Egreso.all
    @egreso_internos=EgresoInterno.all

    @ingresos.each do |ingreso| 
      if (ingreso.montoBs != nil)
        @total += ingreso.montoBs
      end
    end

    @egresos.each do |egreso| 
      if (egreso.monto != nil)
        @total_egreso += egreso.monto
      end
    end
    
    @egreso_internos.each do |egreso_interno| 
      if (egreso_interno.monto != nil)
        @total_egreso_interno += egreso_interno.monto
      end
    end

    @total=@total-@total_egreso-@total_egreso_interno
    return @total
  end

  # GET /egresos/new
  def new
    @egreso = Egreso.new
    @total = dinero_actual
  end

  # GET /egresos/1/edit
  def edit
  end

  # POST /egresos
  # POST /egresos.json
  def create
    @egreso = Egreso.new(egreso_params)
    
    @total=dinero_actual
    if @egreso.monto>@total
      flash[:warning] = 'El monto de egreso no puede ser mayor al monto actual'
      render action: "new"
    else
      if @egreso.save
        flash[:success] = 'Egreso creado exitosamente'
        redirect_to '/egresos'
      else
        render action: "new"
      end
    end
  end

  # PATCH/PUT /egresos/1
  # PATCH/PUT /egresos/1.json
  def update
    @egreso = Egreso.find(params[:id])
    @total=dinero_actual
  
      if @egreso.update(egreso_params)
        if @egreso.monto>@total
          flash[:warning] = 'El monto de egreso no puede ser mayor al monto actual'
          render action: "edit"
        else
          flash[:success] = "Egreso actualizado exitosamente"
          redirect_to '/egresos'
        end
      end
  end

  # DELETE /egresos/1
  # DELETE /egresos/1.json
  def destroy
    @egreso.destroy
    respond_to do |format|
      format.html { redirect_to egresos_url, notice: 'Egreso was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_egreso
      @egreso = Egreso.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def egreso_params
      params.require(:egreso).permit(:estado, :monto, :fecha, :concepto)
    end
end
