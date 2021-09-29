# Generate Users

USERS = [
  { username: 'John', password: '12345678' },
  { username: 'Peter', password: '12345678' },
  { username: 'Kayla', password: '12345678' },
  { username: 'Ulric', password: '12345678' },
  { username: 'Frederick', password: '12345678' },
  { username: 'Morton', password: '12345678' },
  { username: 'Bud', password: '12345678' },
  { username: 'Jewel', password: '12345678' },
  { username: 'Bruno', password: '12345678' },
  { username: 'Nigek', password: '12345678' },
].freeze

User.create(USERS) if User.count.zero?

# Generate Ratings

if Rating.count.zero?
  User.all.each do |user|
    1.upto(rand(2..4)) do
      Rating.create(rating_value: rand(1..5), user: user)
    end
  end

end

# Generate Jobs

JOBS = [
  { title: 'Paint house'},
  { title: 'Remove floor'},
  { title: 'Plant tree'},
  { title: 'Change windows'},
  { title: 'Fix problem in roof'},
  { title: 'Fix toilet'},
  { title: 'Install solar panels'},
  { title: 'Install kitchen'},
  { title: 'Demolish house'},
  { title: 'Garden maintenance'}
].freeze

Job.create(JOBS) if Job.count.zero?