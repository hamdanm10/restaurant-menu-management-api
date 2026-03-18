# db/seeds.rb

puts "Seeding Restaurants and MenuItems..."

restaurants_data = [
  {
    name: "Restaurant A",
    address: "Address A",
    phone: "+6212345678",
    opening_hours: "Mon-Sun 08:00-22:00"
  },
  {
    name: "Restaurant B",
    address: "Address B",
    phone: "+6212345679",
    opening_hours: "Mon-Sun 09:00-23:00"
  }
]

restaurants_data.each do |r_data|
  restaurant = Restaurant.find_or_create_by!(name: r_data[:name]) do |r|
    r.address = r_data[:address]
    r.phone = r_data[:phone]
    r.opening_hours = r_data[:opening_hours]
  end
  puts "Restaurant '#{restaurant.name}' created."

  menu_items_data = [
    { name: "Menu 1", description: "Description 1", price: 10.0, category: :appetizer, is_available: true },
    { name: "Menu 2", description: "Description 2", price: 20.0, category: :main, is_available: true },
    { name: "Menu 3", description: "Description 3", price: 5.0, category: :dessert, is_available: true },
    { name: "Menu 4", description: "Description 4", price: 3.0, category: :drink, is_available: true },
    { name: "Menu 5", description: "Description 5", price: 15.0, category: :main, is_available: false }
  ]

  menu_items_data.each do |m_data|
    menu_item = restaurant.menu_items.find_or_create_by!(name: m_data[:name]) do |m|
      m.description = m_data[:description]
      m.price = m_data[:price]
      m.category = m_data[:category]
      m.is_available = m_data[:is_available]
    end
    puts "MenuItem '#{menu_item.name}' for '#{restaurant.name}' created."
  end
end

puts "Seeding finished."
