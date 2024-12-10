# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb
# Eliminar todo antes de ejecutar
User.destroy_all
Category.destroy_all
Product.destroy_all
Role.destroy_all
Size.destroy_all
Color.destroy_all
Brand.destroy_all
SizeStock.destroy_all

# Crear Roles
roles = [ 'Administrador', 'Gerente', 'Empleado' ]
roles.each do |role_name|
  Role.create(name: role_name)
end

# Crear Usuarios
admin_role = Role.find_by(name: 'Administrador')
gerente_role = Role.find_by(name: 'Gerente')
empleado_role = Role.find_by(name: 'Empleado')

User.create!(
  email_address: 'lucianoganzero94@gmail.com',
  password_digest: BCrypt::Password.create('123456'),
  username: 'Lucianito',
  entry_date: Date.today,
  phone: '22322222',
  active: true,
  role: admin_role
)

User.create!(
  email_address: 'gerente@example.com',
  password_digest: BCrypt::Password.create('123456'),
  username: 'Gerente123',
  entry_date: Date.today,
  active: true,
  phone: '223212345',
  role: gerente_role
)

User.create!(
  email_address: 'empleado@example.com',
  password_digest: BCrypt::Password.create('123456'),
  username: 'Empleado456',
  entry_date: Date.today,
  active: true,
  phone: '223212345',
  role: empleado_role
)

# Crear Sizes
clothes_size = [  'XXS', 'XS', 'S', 'M', 'L', 'XL', 'XXL' ]
shoes_size = [ '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45', '46', '47' ]
children_shoe_size = [ '20', '21', '22', '23', '24', '25', '26', '27', '28', '30', '31', '32', '33' ]
trousers_size = [ '28', '30', '32', '34', '36', '38', '40', '42', '44', '46', '48', '50', '52', '54', '56', '58', '60' ]

# Crear talles para ropa
clothes_size.each { |size| Size.find_or_create_by(size: size) }
# Crear talles para zapatos
shoes_size.each { |size| Size.find_or_create_by(size: size) }
# Crear talles para zapatos infantiles
children_shoe_size.each { |size| Size.find_or_create_by(size: size) }
# Crear talles para pantalones
trousers_size.each { |size| Size.find_or_create_by(size: size) }

# Crear Categorías
categories = [ 'Hombre', 'Mujer', 'Niño', 'Pantalones', 'Buzos', 'Remeras', 'Calzado', 'Indumentaria', 'Calzado Infantil', 'Futbol', 'Basket', 'Running' ]
categories.each do |category_name|
  Category.create(name: category_name)
end

# Asociar Categorías con Talles
pantalones = Category.find_by(name: 'Pantalones')
indumentaria = Category.find_by(name: 'Indumentaria')
calzado = Category.find_by(name: 'Calzado')
calzado_infantil = Category.find_by(name: 'Calzado Infantil')

# Asociar pantalones con todos los talles de pantalones
trousers_size.each do |size|
  size_record = Size.find_by(size: size)
  if size_record
    pantalones.sizes << size_record unless pantalones.sizes.include?(size_record)
  end
end

# Asociar indumentaria con todos los talles de ropa (clothes_size)
clothes_size.each do |size|
  size_record = Size.find_by(size: size)
  if size_record
    indumentaria.sizes << size_record unless indumentaria.sizes.include?(size_record)
  end
end

# Asociar calzado con todos los talles de zapatos (shoes_size)
shoes_size.each do |size|
  size_record = Size.find_by(size: size)
  if size_record
    calzado.sizes << size_record unless calzado.sizes.include?(size_record)
  end
end

# Asociar calzado infantil con todos los talles de zapatos infantiles (children_shoe_size)
children_shoe_size.each do |size|
  size_record = Size.find_by(size: size)
  if size_record
    calzado_infantil.sizes << size_record unless calzado_infantil.sizes.include?(size_record)
  end
end

# Crear Colores
colors = [
  { name: 'Rojo', code: '#FF0000' },
  { name: 'Verde', code: '#00FF00' },
  { name: 'Azul', code: '#0000FF' },
  { name: 'Amarillo', code: '#FFFF00' },
  { name: 'Negro', code: '#000000' },
  { name: 'Blanco', code: '#FFFFFF' },
  { name: 'Gris', code: '#808080' },
  { name: 'Naranja', code: '#FFA500' },
  { name: 'Rosa', code: '#FFC0CB' },
  { name: 'Marrón', code: '#8B4513' }
]

colors.each do |color|
  Color.create(name: color[:name], code: color[:code])
end

# Crear Marcas
brands = [
  'Nike', 'Adidas', 'Puma', 'Reebok', 'Under Armour', 'New Balance', 'Levi\'s', 'Wrangler', 'H&M', 'Zara'
]

brands.each do |brand_name|
  Brand.create(name: brand_name)
end


# Crear productos con nombres específicos
productos = [
  'Remera deportiva Nike', 'Buzo con capucha Adidas', 'Pantalón de entrenamiento Puma', 'Zapatilla running Asics',
  'Zapatilla de niño Nike', 'Botines futbol Adidas', 'Botines de niño Puma', 'Camiseta de fútbol Barcelona',
  'Pantalón deportivo Under Armour', 'Buzo de hombre Reebok', 'Zapatilla de running New Balance',
  'Zapatilla de fútbol Nike', 'Remera de gimnasio Reebok', 'Botines de fútbol infantil Adidas', 'Zapatilla de fútbol Puma'
]

# Obtener marcas y categorías
brands = Brand.all
categories = Category.where(name: [ 'Pantalones', 'Indumentaria', 'Calzado', 'Calzado Infantil' ])

productos.each do |product_name|
  description = Faker::Lorem.paragraph
  unit_price = Faker::Commerce.price
  entry_date = Faker::Date.backward(days: 30)

  # Buscar la marca que coincide con el nombre del producto (si existe)
  brand = brands.find { |b| product_name.downcase.include?(b.name.downcase) }
  if !brand
    brand = brands.sample
  end

  # Crear producto
  product = Product.create!(
    name: product_name,
    description: description,
    unit_price: unit_price,
    entry_date: entry_date,
    deactivation_date: nil,
    brand: brand
  )

  # Asociar colores al azar
  product_colors = colors.sample(2).map { |color| color[:name] }  # Elegir 2 colores al azar
  product_colors.each do |color_name|
    color = Color.find_or_create_by(name: color_name)
    product.colors << color
  end

  # Asociar con la categoría según el nombre del producto
  if product.name.downcase.include?('pantalón') || product.name.downcase.include?('jeans')
    product_category = categories.find { |cat| cat.name == 'Pantalones' }
    selected_sizes = trousers_size
  elsif product.name.downcase.include?('niño') || product.name.downcase.include?('niña') || product.name.downcase.include?('infantil')
    product_category = categories.find { |cat| cat.name == 'Calzado Infantil' }
    selected_sizes = children_shoe_size
  elsif product.name.downcase.include?('zapatilla') || product.name.downcase.include?('calzado')
    product_category = categories.find { |cat| cat.name == 'Calzado' }
    selected_sizes = shoes_size
  elsif product.name.downcase.include?('buzo') || product.name.downcase.include?('sudadera')
    product_category = categories.find { |cat| cat.name == 'Indumentaria' }
    selected_sizes = clothes_size
  elsif product.name.downcase.include?('camiseta') || product.name.downcase.include?('remera')
    product_category = categories.find { |cat| cat.name == 'Indumentaria' }
    selected_sizes = clothes_size
  elsif product.name.downcase.include?('botines')
    product_category = categories.find { |cat| cat.name == 'Calzado' }
    selected_sizes = shoes_size
  else
    # Default category
    product_category = categories.find { |cat| cat.name == 'Calzado' }
    selected_sizes = shoes_size
  end

  # Asociar con la categoría
  product.categories << product_category

  # Inicializar stock por talla, asegurando que solo se asocien talles válidos para cada categoría
  selected_sizes.each do |size|
    product_category.sizes.each do |category_size|
      if category_size.size == size
        SizeStock.create!(
          product: product,
          size: category_size,
          stock_available: rand(0..10)  # Stock aleatorio entre 0 y 10
        )
      end
    end
  end
end



puts "Seeding completed!"
