users =	User.create([
		{ 
		username: 'kel-c',
		email: 'kelc@email.com'
		password_digest: BCrypt::Password.create('passw0rd')},
		{ 
		username: 'dad',
		email: 'dadiscool@email.com'
		password_digest: BCrypt::Password.create('passw0rd')},
		{
		username: 'wonderwoman',
		email: 'wonderwoman@email.com'
		password_digest: BCrypt::Password.create('passw0rd')}
	])

categories = Category.create([
	{
		name: 'Wonders of the World' },
	{
		name: "Kelsey's Philly Bucketlist" },
	{
		name: 'Best of US' }
	])

items = Item.create([
	{
		name: 'Christ the Redeemer',
		description: 'Statue of Jesus',
		location: 'Brazil',
		user_id: 3,
		category_id: 1
		},
	{
		name: 'Colosseum',
		description: 'Amphitheatre in Rome',
		location: 'Italy',
		user_id: 3,
		category_id: 1
		},
	{
		name: 'Taj Mahal',
		description: 'Mausoleum in Agra',
		location: 'India',
		user_id: 3,
		category_id: 1
		},
	{
		name: 'Great Wall of China',
		description: '4,500mi wall',
		location: 'China',
		user_id: 3,
		category_id: 1
		},
	{
		name: 'Petra',
		description: 'Ancient Temple',
		location: 'Jordan',
		user_id: 3,
		category_id: 1
		},
	{
		name: 'Machu Picchu',
		description: 'Ancient Incan City',
		location: 'Wonders',
		user_id: 3,
		category_id: 1
		},
	{
		name: 'Zahav',
		description: 'Mediterranean food',
		location: 'Philadelphia',
		user_id: 1,
		category_id: 2
		},
	{
		name: 'Vernick Food and Drink',
		description: 'American Fine Dining',
		location: 'Philadelphia',
		user_id: 1,
		category_id: 2
		},
	{
		name: "Talula's Garden",
		description: 'Farm Fresh Restaurant',
		location: 'Philadelphia',
		user_id: 1,
		category_id: 2
		},
	{
		name: "Walk Across the Panhandle",
		description: 'Walk from North to South',
		location: 'Oklahoma',
		user_id: 2,
		category_id: 3
		},
	{
		name: "Route 66",
		description: 'Famous highway',
		location: 'Western US',
		user_id: 2,
		category_id: 3
		}
])
