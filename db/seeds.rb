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
  User.all.each { |user| Rating.create(rating_value: rand(1..5), user: user) }
end

# Generate Jobs

JOBS = [
  { title: 'Baker'},
  { title: 'Butcher'},
  { title: 'Cook'},
  { title: 'Farmer'},
  { title: 'Fireman'},
  { title: 'Gardener'},
  { title: 'Hairdresser'},
  { title: 'Journalist'},
  { title: 'Lawyer'},
  { title: 'Mason'}
].freeze

Job.create(JOBS) if Job.count.zero?