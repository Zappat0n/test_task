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
