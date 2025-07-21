import '../models/commissioner.dart';

class CommissionerService {
  static final CommissionerService _instance = CommissionerService._internal();
  factory CommissionerService() => _instance;
  CommissionerService._internal();

  // Sample commissioners data for Ramsey, Isle of Man
  static final List<Commissioner> _commissioners = [
    Commissioner(
      id: '1',
      name: 'Mrs. Annie Oates',
      title: 'Chairman of Ramsey Town Commissioners',
      party: 'Independent',
      constituency: 'Ramsey',
      email: 'annie.oates@ramsey.gov.im',
      phone: '+44 1624 812345',
      bio:
          'Annie has been serving the Ramsey community for over 15 years, focusing on heritage preservation and community development. She previously worked in local education and has been instrumental in several town improvement projects.',
      imageUrl:
          'https://images.unsplash.com/photo-1494790108755-2616b612b890?w=300&h=300&fit=crop&crop=face',
      responsibilities: [
        'Town Planning',
        'Heritage & Tourism',
        'Community Events',
        'Local Development',
      ],
      electedDate: DateTime(2019, 5, 1),
    ),
    Commissioner(
      id: '2',
      name: 'Mr. David Cretney',
      title: 'Deputy Chairman',
      party: 'Independent',
      constituency: 'Ramsey',
      email: 'david.cretney@ramsey.gov.im',
      phone: '+44 1624 812346',
      bio:
          'David brings extensive business experience to the commission, having run several local enterprises. He specializes in economic development and infrastructure projects for the town.',
      imageUrl:
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=300&h=300&fit=crop&crop=face',
      responsibilities: [
        'Economic Development',
        'Infrastructure',
        'Business Relations',
        'Finance Committee',
      ],
      electedDate: DateTime(2020, 5, 1),
    ),
    Commissioner(
      id: '3',
      name: 'Mrs. Clare Sharpe',
      title: 'Commissioner',
      party: 'Independent',
      constituency: 'Ramsey',
      email: 'clare.sharpe@ramsey.gov.im',
      phone: '+44 1624 812347',
      bio:
          'Clare is passionate about environmental issues and sustainability. She leads initiatives on waste management, green spaces, and environmental protection within Ramsey.',
      imageUrl:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=300&h=300&fit=crop&crop=face',
      responsibilities: [
        'Environmental Protection',
        'Waste Management',
        'Parks & Recreation',
        'Sustainability',
      ],
      electedDate: DateTime(2021, 5, 1),
    ),
    Commissioner(
      id: '4',
      name: 'Mr. John McGuinness',
      title: 'Commissioner',
      party: 'Independent',
      constituency: 'Ramsey',
      email: 'john.mcguinness@ramsey.gov.im',
      phone: '+44 1624 812348',
      bio:
          'John has a background in public safety and emergency services. He oversees safety initiatives, traffic management, and emergency preparedness for the community.',
      imageUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop&crop=face',
      responsibilities: [
        'Public Safety',
        'Traffic & Transport',
        'Emergency Services',
        'Community Safety',
      ],
      electedDate: DateTime(2018, 5, 1),
    ),
    Commissioner(
      id: '5',
      name: 'Mrs. Linda Cain',
      title: 'Commissioner',
      party: 'Independent',
      constituency: 'Ramsey',
      email: 'linda.cain@ramsey.gov.im',
      phone: '+44 1624 812349',
      bio:
          'Linda focuses on housing, social services, and community welfare. She works closely with local charities and social organizations to support vulnerable residents.',
      imageUrl:
          'https://images.unsplash.com/photo-1554151228-14d9def656e4?w=300&h=300&fit=crop&crop=face',
      responsibilities: [
        'Housing & Social Services',
        'Community Welfare',
        'Health & Wellbeing',
        'Charitable Relations',
      ],
      electedDate: DateTime(2022, 5, 1),
    ),
  ];

  // Get all commissioners
  List<Commissioner> getAllCommissioners() {
    return List.from(_commissioners);
  }

  // Get commissioner by ID
  Commissioner? getCommissionerById(String id) {
    try {
      return _commissioners.firstWhere((commissioner) => commissioner.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get commissioners by type (for future expansion)
  List<Commissioner> getCommissionersByType(CommissionerType type) {
    // For now, all commissioners are local
    if (type == CommissionerType.local) {
      return getAllCommissioners();
    }
    return [];
  }

  // Get chairman
  Commissioner? getChairman() {
    try {
      return _commissioners.firstWhere(
        (commissioner) => commissioner.title.contains('Chairman'),
      );
    } catch (e) {
      return null;
    }
  }

  // Get contact information
  Map<String, String> getOfficeContact() {
    return {
      'address': 'Town Hall, Parliament Street, Ramsey, Isle of Man, IM8 1RT',
      'phone': '+44 1624 812345',
      'email': 'info@ramsey.gov.im',
      'website': 'www.ramsey.gov.im',
      'office_hours': 'Monday - Friday: 9:00 AM - 5:00 PM',
    };
  }

  // Get meeting information
  Map<String, String> getMeetingInfo() {
    return {
      'schedule': 'First Tuesday of every month',
      'time': '7:00 PM',
      'location': 'Town Hall Council Chamber',
      'public_access': 'Open to the public',
      'agenda_available': '48 hours before meeting',
    };
  }
}
