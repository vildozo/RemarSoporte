class Conyugue < ActiveRecord::Base
	belongs_to :interno
	before_save :default_values

  def default_values
    self.estado ||= 'true'
  end


def full_name
  "#{self.nombre} #{self.apellido1} #{self.apellido2}"
end

  	validates :ci, presence: {:message => "- El carnet es un campo obligatorio"}
	validates :ci, uniqueness: { :message => "- El carnet ya existe"}
	validates :ci, format: { allow_blank: true,with: /\A[+-]?\d+\Z/, message: " Solo se aceptan numeros"}
	validates :ci, length: { maximum: 7, too_long: "- %{count} caracteres es la longitud maxima permitida" }
	validates :ci, length: { allow_blank: true, minimum: 6, muy_corto: "- %{count} caracteres es la longitud minima permitida" }
	
	validates :apellido1, presence: {:message => "- El apellido Paterno es un campo obligatorio"}
	validates :apellido1, format: { with: /\A[a-zA-Z\W]+\z/, allow_blank: true, message: "- Solo se aceptan letras"}
	validates :apellido1, length: { maximum: 25, too_long: "- %{count} caracteres es la longitud maxima permitida para apellido Paterno" }

	validates :apellido2, format: { with: /\A[a-zA-Z\W ]+\z/, allow_blank: true, message: "- Solo se aceptan letras"}
	validates :apellido2, length: { maximum: 25, too_long: "- %{count} caracteres es la longitud maxima permitida para apellido Materno" }

	validates :nombre, presence: {:message => "- El nombre es un campo obligatorio"}
	validates :nombre, format: { with: /\A[a-zA-Z\W ]+\z/, allow_blank: true, message: "- Solo se aceptan letras"}
	validates :nombre, length: { maximum: 35, too_long: "- %{count} caracteres es la longitud maxima permitida para un nombre" }


	validates :direccion, presence: {:message => "- La Direccion es un campo obligatorio"}
	validates :direccion, length: { maximum: 35, too_long: "- %{count} caracteres es la longitud maxima permitida para un direccion" }
	validates :direccion, format: { with: /\A[a-zA-Z0-9 #\W]+\z/, allow_blank: true, message: "- Solo se aceptan letras"}



	validates :telefono, length: { maximum: 10, too_long: "- %{count} caracteres es la longitud maxima permitida" }
	validates :telefono, length: { minimum: 6, too_long: "- %{count} caracteres es la longitud minima permitida" }, :allow_blank => true
	validates :telefono,    :numericality => true, :allow_blank => true

	

	
	validates :lugarNacimiento, presence: {:message => "- Lugar de Nacimiento es un campo obligatorio"}
  
end
