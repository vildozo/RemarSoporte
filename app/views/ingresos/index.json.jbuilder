json.array!(@ingresos) do |ingreso|
  json.extract! ingreso, :id, :montoBs, :concepto, :fecha, :estado, :venta_id, :recepcionDonativo_id
  json.url ingreso_url(ingreso, format: :json)
end
