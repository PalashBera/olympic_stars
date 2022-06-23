account = Account.create(name: "Olympic Stars")

user = User.create(
  first_name: "Olympic",
  last_name: "Stars",
  email: "olympicstars@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  confirmation_sent_at: Time.current,
  confirmed_at: Time.current + 5.minutes
)

account.payment_methods.create(name: "Credit Card")
account.payment_methods.create(name: "Debit Card")
account.payment_methods.create(name: "Cash")
account.payment_methods.create(name: "Demand Draft")
account.payment_methods.create(name: "Cheque")

account.client_types.create(name: "Adults")
account.client_types.create(name: "Early Stimulation")
account.client_types.create(name: "Kids")
account.client_types.create(name: "Kids Advance")
account.client_types.create(name: "Teens")

account.courses.create(name: "2 days a week", amount: 1500)
account.courses.create(name: "3 days a week", amount: 1950)
account.courses.create(name: "4 days a week", amount: 2350)
account.courses.create(name: "5 days a week", amount: 2700)
account.courses.create(name: "6 days a week", amount: 2900)
account.courses.create(name: "Summer Coaching 1 week", amount: 1000)
account.courses.create(name: "Summer Coaching 2 week", amount: 1600)
account.courses.create(name: "Summer Coaching 3 week", amount: 2600)

account.payment_types.create(name: "Monthly Student Due")
account.payment_types.create(name: "Registration Fee")
account.payment_types.create(name: "Yearly Bonus")
account.payment_types.create(name: "Monthly Staff Salary")
account.payment_types.create(name: "Monthly Teacher Salary")

100.times do |t|
  account.students.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    student_code: Faker::Alphanumeric.alphanumeric(number: 5).upcase,
    date_of_birth: Faker::Date.birthday(min_age: 10, max_age: 30),
    school_name: Faker::Educator.secondary_school,
    allergies: Faker::Cannabis.medical_use,
    registration_date: Faker::Date.backward(days: Faker::Number.number(digits: 2)),
    mother_name: "#{Faker::Name.female_first_name} #{Faker::Name.last_name}",
    mother_email: Faker::Internet.email,
    mother_phone_number: Faker::PhoneNumber.cell_phone_with_country_code,
    father_name: "#{Faker::Name.male_first_name} #{Faker::Name.last_name}",
    father_email: Faker::Internet.email,
    father_phone_number: Faker::PhoneNumber.cell_phone_with_country_code,
    address: Faker::Address.full_address,
    remarks: Faker::ChuckNorris.fact,
    pro_client: Faker::Boolean.boolean,
    facebook: Faker::Boolean.boolean,
    archived: Faker::Boolean.boolean,
    client_type_id: account.client_types.sample.id,
    course_id: account.courses.sample.id
  )
end

50.times do |t|
  account.teachers.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    date_of_birth: Faker::Date.birthday(min_age: 30, max_age: 45),
    phone_number: Faker::PhoneNumber.cell_phone,
    mobile_number: Faker::PhoneNumber.cell_phone_with_country_code,
    wages_per_hour: Faker::Number.number(digits: 2) * 10,
    wages_per_day: Faker::Number.number(digits: 2) * 100,
    wages_per_month: Faker::Number.decimal(l_digits: 2) * 1000,
    archived: Faker::Boolean.boolean
  )
end

account.teachers.each do |teacher|
  [10, 15, 20, 25, 30].sample.times do |t|
    teacher.work_logs.create(date: Faker::Date.backward(days: Faker::Number.number(digits: 2)), hours: Faker::Number.decimal(l_digits: 1))
  end
end

40.times do |t|
  number = Faker::Number.between(from: 7, to: 20)
  duration = Faker::Number.between(from: 1, to: 3)

  account.groups.create(
    name: Faker::Team.name,
    quota: Faker::Number.between(from: 10, to: 30),
    start_time: "#{number}:00",
    end_time: "#{number + duration}:00",
    monday: Faker::Boolean.boolean,
    tuesday: Faker::Boolean.boolean,
    wednesday: Faker::Boolean.boolean,
    thursday: Faker::Boolean.boolean,
    friday: Faker::Boolean.boolean,
    saturday: Faker::Boolean.boolean,
    archived: Faker::Boolean.boolean,
    teacher_id: account.teachers.sample.id,
    client_type_id: account.client_types.sample.id
  )
end
