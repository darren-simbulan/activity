import 'package:flutter/cupertino.dart';

void main() {
  runApp(
    CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final List<Map<String, dynamic>> profiles = [
    {
      'image': 'images/1.jpg',
      'name': 'Angilyn Borja',
      'email': 'angilyn.borja@email.com',
      'phone': '+63 912 345 6789',
      'education': 'BS Computer Science, University of Manila',
      'skills': ['Flutter', 'Dart', 'UI/UX Design'],
      'experience': '2 years as a Mobile Developer'
    },
    {
      'image': 'images/2.jpg',
      'name': 'Darren Simbulan',
      'email': 'darren.simbulan@email.com',
      'phone': '+63 923 456 7890',
      'education': 'BS Information Technology, Ateneo',
      'skills': ['Backend Development', 'Node.js', 'SQL'],
      'experience': '3 years as a Software Engineer'
    },
    {
      'image': 'images/3.jpg',
      'name': 'Aldrin Migano',
      'email': 'aldrin.migano@email.com',
      'phone': '+63 911 223 3344',
      'education': 'BS Software Engineering, UST',
      'skills': ['Java', 'Kotlin', 'Android Development'],
      'experience': '4 years as an Android Developer'
    },
    {
      'image': 'images/4.jpg',
      'name': 'Rafael Lorenzo',
      'email': 'rafael.lorenzo@email.com',
      'phone': '+63 922 556 7788',
      'education': 'BS Computer Science, De La Salle University',
      'skills': ['Python', 'Machine Learning', 'Data Science'],
      'experience': '5 years as a Data Scientist'
    },
    {
      'image': 'images/5.jpg',
      'name': 'Jay Ingal',
      'email': 'jay.ingal@email.com',
      'phone': '+63 933 667 8899',
      'education': 'BS Information Systems, FEU',
      'skills': ['Cybersecurity', 'Network Administration', 'Cloud Computing'],
      'experience': '3 years as a Cybersecurity Analyst'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Resume List'),
      ),
      child: SafeArea(
        child: ListView.builder(
          itemCount: profiles.length,
          itemBuilder: (context, index) {
            return CupertinoListTile(
              leading: ClipOval(
                child: Image.asset(
                  profiles[index]['image'],
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(profiles[index]['name']),
              subtitle: Text(profiles[index]['email']),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => ResumeScreen(profile: profiles[index]),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ResumeScreen extends StatelessWidget {
  final Map<String, dynamic> profile;

  const ResumeScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(profile['name']),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipOval(
                  child: Image.asset(
                    profile['image'],
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  profile['name'],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Text('📧 Email: ${profile['email']}'),
              Text('📞 Phone: ${profile['phone']}'),
              SizedBox(height: 10),
              Text('🎓 Education: ${profile['education']}'),
              SizedBox(height: 10),
              Text('💼 Work Experience: ${profile['experience']}'),
              SizedBox(height: 10),
              Text('🛠 Skills:'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: profile['skills'].map<Widget>((skill) => Text('- $skill')).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
