unless User.exists?(role: 'doctor')
  User.create!(
    name: 'Doctor Name',
    email: 'doctor@example.com',
    password: 'password',
    password_confirmation: 'password',
    role: 'doctor'
  )
end
