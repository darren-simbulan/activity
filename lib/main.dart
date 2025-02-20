
import 'package:flutter/cupertino.dart';

void main() {
runApp(
CupertinoApp(
debugShowCheckedModeBanner: false,
home: MyApp(),
),
);
}

class MyApp extends StatefulWidget {
const MyApp({super.key});

@override
State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
int _profileIndex = 0;
final List<Map<String, String>> _profiles = [
{'image': 'images/2.jpg', 'name': 'Angilyn Borja', 'lastMessage': 'Hey, how are you?'},
{'image': 'images/1.jpg', 'name': 'Darren Simbulan', 'lastMessage': 'Let\'s catch up soon!'},
{'image': 'images/jay.jpg', 'name': 'jay ingal', 'lastMessage': 'Hey, how are you?'},
{'image': 'images/rafpost.jpg', 'name': 'rafael lorenzo', 'lastMessage': 'Let\'s catch up soon!'},
// Add more profiles and messages if needed
];

@override
Widget build(BuildContext context) {
return CupertinoPageScaffold(
navigationBar: CupertinoNavigationBar(
middle: Text('Messenger'),
trailing: CupertinoButton(
child: Icon(CupertinoIcons.profile_circled),
onPressed: () {
showCupertinoDialog(
context: context,
builder: (context) {
int tempIndex = _profileIndex;
return StatefulBuilder(
builder: (context, setDialogState) {
return CupertinoAlertDialog(
title: Text('List of Members'),
content: Column(
children: [
ClipOval(
child: Image.asset(
_profiles[tempIndex]['image']!,
height: 50,
),
),
SizedBox(height: 10),
Text(_profiles[tempIndex]['name']!),
],
),
actions: [
CupertinoButton(
child: Text(
'Next',
style: TextStyle(color: CupertinoColors.activeBlue),
),
onPressed: () {
setDialogState(() {
tempIndex = (tempIndex + 1) % _profiles.length;
});
},
),
CupertinoButton(
child: Text(
'Close',
style: TextStyle(color: CupertinoColors.destructiveRed),
),
onPressed: () {
setState(() {
_profileIndex = tempIndex;
});
Navigator.pop(context);
},
),
],
);
},
);
},
);
},
),
leading: Icon(CupertinoIcons.chevron_back),
),
child: SafeArea(
child: Padding(
padding: const EdgeInsets.all(20.0),
child: Column(
children: [
// Displaying List of Profiles and Conversation Previews
Expanded(
child: ListView.builder(
itemCount: _profiles.length,
itemBuilder: (context, index) {
return CupertinoListTile(
leading: ClipOval(
child: Image.asset(
_profiles[index]['image']!,
height: 50,
width: 50,
),
),
title: Text(_profiles[index]['name']!),
subtitle: Text(_profiles[index]['lastMessage']!),
trailing: Icon(CupertinoIcons.bubble_left),
onTap: () {
// Navigate to the conversation screen when a profile is tapped
Navigator.push(
context,
CupertinoPageRoute(
builder: (context) => ConversationScreen(
profile: _profiles[index],
),
),
);
},
);
},
),
),
],
),
),
),
);
}
}

class ConversationScreen extends StatefulWidget {
final Map<String, String> profile;

const ConversationScreen({super.key, required this.profile});

@override
_ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
List<String> messages = [
'Hey, how are you?',
'Let\'s catch up soon!',
]; // Initial messages in the conversation

TextEditingController _messageController = TextEditingController();

void _sendMessage() {
if (_messageController.text.isNotEmpty) {
setState(() {
messages.add(_messageController.text); // Add new message to the list
});
_messageController.clear();
}
}

@override
Widget build(BuildContext context) {
return CupertinoPageScaffold(
navigationBar: CupertinoNavigationBar(
leading: CupertinoButton(
padding: EdgeInsets.zero,
child: Icon(CupertinoIcons.chevron_back),
onPressed: () {
Navigator.pop(context);
},
),
middle: Text('Chat with ${widget.profile['name']}'),
),
child: SafeArea(
child: Padding(
padding: const EdgeInsets.all(20.0),
child: Column(
children: [

ClipOval(
child: Image.asset(
widget.profile['image']!,
height: 150,
width: 150,
),
),
SizedBox(height: 10),
Text(
widget.profile['name']!,
style: TextStyle(
fontSize: 24,
fontWeight: FontWeight.bold,
),
),
SizedBox(height: 20),
// Simulated conversation area
Expanded(
child: ListView.builder(
itemCount: messages.length,
itemBuilder: (context, index) {
return CupertinoListTile(
title: Text(messages[index]),
subtitle: Text('12:30 PM'),
);
},
),
),
// Input field for new message
CupertinoTextField(
controller: _messageController,
placeholder: 'Type a message...',
padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
suffix: CupertinoButton(
child: Icon(CupertinoIcons.arrow_up_circle_fill),
onPressed: _sendMessage,
),
),
],
),
),
),
);
}
}
