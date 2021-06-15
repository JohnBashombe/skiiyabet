import 'package:skiiyabet/components/price.dart';

class JackPots {
  static var data = {
    'jackpot_id': '1',
    'time': {
      'time': '12:00:00',
      'date': '15-04-2021',
      'date_time': '15-04-2021 12:00:00',
      'timestamp': 100000000,
      'createdAt': '15-04-2021 12:00:00',
    },
    'description': {
      'name': 'Pick 17',
      'bet_type': '1x2',
      'description': 'Pick 17 winners',
      'status': 'pending',
    },
    'matches': {
      'data': [
        {
          'id': '1',
          'localTeam': 'Liverpool',
          'visitorTeam': 'Chelsea',
        },
        {
          'id': '2',
          'localTeam': 'Man City',
          'visitorTeam': 'Leicester',
        },
      ],
      'time': [
        {
          'time': '12:00:00',
          'date': '15-04-2021',
          'date_time': '15-04-2021 12:00:00',
          'timestamp': 100000000,
        },
        {
          'time': '12:00:00',
          'date': '15-04-2021',
          'date_time': '15-04-2021 12:00:00',
          'timestamp': 100000000,
        },
      ],
      'location': [
        {
          'country': 'England',
          'championship': 'Premier League',
        },
        {
          'country': 'England',
          'championship': 'Premier League',
        }
      ],
      'scores': [
        {'team1': null, 'team2': null},
        {'team1': null, 'team2': null}
      ],
      'choices': [
        {
          '1': false,
          'x': false,
          '2': false,
        },
        {
          '1': false,
          'x': false,
          '2': false,
        },
      ]
    },
    'outcome': [
      {
        '0 correct': {
          'winners': 10.0,
          'total_amount': 0.0,
          'winner_reward': 0.0,
          'currency': Price.currency_symbol,
          'userIds': []
        },
        '1 correct': {
          'winners': 10.0,
          'total_amount': 0.0,
          'winner_reward': 0.0,
          'currency': Price.currency_symbol,
          'userIds': []
        },
        '2 correct': {
          'winners': 10.0,
          'total_amount': 0.0,
          'winner_reward': 0.0,
          'currency': Price.currency_symbol,
          'userIds': []
        },
      }
    ],
  };
}
