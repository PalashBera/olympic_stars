user = User.create(
  first_name: "Olympic",
  last_name: "Stars",
  email: "olympicstars@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  confirmation_sent_at: Time.current,
  confirmed_at: Time.current + 5.minutes
)
