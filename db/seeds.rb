# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Match.create([
	{ 
		title: 'Napoli - Bologna',  
		game_time: DateTime.parse('Feb 11, 2018 14:30'),
		home_team_logo: '/images/napoli.png',
		away_team_logo: '/images/bolonga.png',
		reach: 4,
		league: 'Serie A',
		channel: 'Rai1',
		price_per_minute: 3200,
		minutes_booked: 0
	}, 
	{
		title: 'Udinese - Spal',  
		game_time: DateTime.parse('Feb 11, 2018 14:30'),
		home_team_logo: '/images/udinese.png',
		away_team_logo: '/images/spal.png',
		reach: 3,
		league: 'Serie A',
		channel: 'Rai1',
		price_per_minute: 3600,
		minutes_booked: 0
	},
	{
		title: 'Juventus - Genoa',  
		game_time: DateTime.parse('Feb 11, 2018 14:30'),
		home_team_logo: '/images/juventus.jpg',
		away_team_logo: '/images/genoa.png',
		reach: 6,
		league: 'Serie A',
		channel: 'Rai1',
		price_per_minute: 4500,
		minutes_booked: 0
	}
])
