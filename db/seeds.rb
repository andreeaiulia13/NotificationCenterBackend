Notification.destroy_all
User.destroy_all

User.create(email: 'admin@gmail.com', password: 'admin@1', admin: true)
User.create(email: 'andreea@gmail.com', password: '123456')
User.create(email: 'john@gmail.com', password: '123456')
User.create(email: 'ana@gmail.com', password: '123456')

User.where(admin: false).each do |client|
  Notification.create(
    title: 'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.',
    description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
    user_id: client.id
  )

  Notification.create(
    title: 'Etiam iaculis ipsum id felis iaculis pharetra. Pellentesque gravida leo nec mollis feugiat.',
    description: "Fusce tempus, leo vitae tempor porta, nisl tellus sodales ligula, et elementum nisl risus eget odio. Maecenas molestie tellus ultrices orci ultricies accumsan. Curabitur sollicitudin tempor erat ut porta. Phasellus a lobortis est. Integer malesuada congue elit blandit dignissim.",
    user_id: client.id
  )
end
