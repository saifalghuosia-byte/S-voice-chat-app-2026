import 'package:flutter/material.dart';

void main() => runApp(const SVoiceApp());

const navy = Color(0xFF05052D);
const panel = Color(0xFF11113F);
const cyan = Color(0xFF16C9E8);
const purple = Color(0xFFB32BEA);

class SVoiceApp extends StatelessWidget {
  const SVoiceApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'S Voice Chat',
    theme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: navy,
      colorScheme: const ColorScheme.dark(primary: cyan, secondary: purple, surface: panel),
      appBarTheme: const AppBarTheme(backgroundColor: navy, foregroundColor: Colors.white),
    ),
    home: const LoginScreen(),
  );
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final phone = TextEditingController();
  @override
  void dispose() { phone.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: Center(child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(children: [
        ClipRRect(borderRadius: BorderRadius.circular(28),
          child: Image.asset('assets/s_voice_logo.jpg', width: 170, height: 170, fit: BoxFit.cover)),
        const SizedBox(height: 18),
        const Text('S VOICE CHAT', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900, letterSpacing: 2)),
        const SizedBox(height: 6),
        const Text('Your Voice, Your World', style: TextStyle(color: cyan)),
        const SizedBox(height: 34),
        TextField(controller: phone, keyboardType: TextInputType.phone,
          decoration: const InputDecoration(labelText: 'Phone number', prefixIcon: Icon(Icons.phone), border: OutlineInputBorder())),
        const SizedBox(height: 14),
        SizedBox(width: double.infinity, child: FilledButton(
          onPressed: () {
            if (phone.text.trim().length < 6) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid phone number.')));
              return;
            }
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainScreen()));
          },
          child: const Padding(padding: EdgeInsets.all(13), child: Text('Continue')))),
        const SizedBox(height: 12),
        const Text('Demo screen: phone verification / OTP is not connected yet.',
          textAlign: TextAlign.center, style: TextStyle(color: Colors.white60, fontSize: 12)),
      ]),
    ))),
  );
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  int tab = 0;
  final roomData = const [
    ('Saraiki Friends', 'Friendly talk', '6 people', '🎙️'),
    ('Asia Lounge', 'Meet people across Asia', '12 people', '🌏'),
    ('Music & Chat', 'Relax and talk', '4 people', '🎵'),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('S VOICE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2)),
      actions: [IconButton(onPressed: () => info('Notifications will be added later.'), icon: const Icon(Icons.notifications_none))]),
    body: IndexedStack(index: tab, children: [_home(), const WalletScreen(), const AgencyScreen(), const ProfileScreen()]),
    bottomNavigationBar: NavigationBar(
      backgroundColor: panel, indicatorColor: cyan.withOpacity(.16), selectedIndex: tab,
      onDestinationSelected: (v) => setState(() => tab = v),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Wallet'),
        NavigationDestination(icon: Icon(Icons.groups_outlined), label: 'Agency'),
        NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
      ]),
  );

  Widget _home() => ListView(padding: const EdgeInsets.all(16), children: [
    Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(22),
      gradient: const LinearGradient(colors: [Color(0xFF142B70), Color(0xFF4B1680)])),
      child: Row(children: [
        ClipRRect(borderRadius: BorderRadius.circular(14),
          child: Image.asset('assets/s_voice_logo.jpg', width: 76, height: 76, fit: BoxFit.cover)),
        const SizedBox(width: 14),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Your Voice, Your World', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 6), Text('Connect through voice across Asia.')
        ]))
      ])),
    const SizedBox(height: 22),
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      const Text('Voice rooms', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      TextButton(onPressed: () => info('Room creation will be enabled after backend setup.'), child: const Text('+ Create'))
    ]),
    ...roomData.map((r) => Card(color: panel, child: ListTile(
      leading: CircleAvatar(backgroundColor: cyan.withOpacity(.14), child: Text(r.$4)),
      title: Text(r.$1, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('${r.$2} • ${r.$3}'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: cyan),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RoomScreen(name: r.$1))),
    ))),
    const SizedBox(height: 12),
    const Text('Platform features', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    const SizedBox(height: 8),
    const Wrap(spacing: 8, runSpacing: 8, children: [
      Tag('Audio rooms'), Tag('Seat board'), Tag('Host verification'), Tag('Agencies'),
      Tag('Coins & gifts'), Tag('Withdrawals')
    ]),
  ]);
  void info(String s) => showDialog<void>(context: context, builder: (_) => AlertDialog(
    backgroundColor: panel, content: Text(s),
    actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))]));
}

class RoomScreen extends StatefulWidget {
  final String name;
  const RoomScreen({super.key, required this.name});
  @override
  State<RoomScreen> createState() => _RoomScreenState();
}
class _RoomScreenState extends State<RoomScreen> {
  final Set<int> occupied = {0, 2, 4};
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.name)),
    body: Column(children: [
      const SizedBox(height: 20),
      const Text('VOICE ROOM', style: TextStyle(color: cyan, letterSpacing: 3, fontWeight: FontWeight.bold)),
      const Padding(padding: EdgeInsets.all(10), child: Text('Welcome! Be respectful and keep the room safe.', textAlign: TextAlign.center)),
      Expanded(child: GridView.builder(
        padding: const EdgeInsets.all(18), itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 14, mainAxisSpacing: 18),
        itemBuilder: (_, i) => InkWell(
          onTap: () => setState(() { if (occupied.contains(i)) { occupied.remove(i); } else { occupied.add(i); } }),
          child: Column(children: [
            CircleAvatar(radius: 31, backgroundColor: occupied.contains(i) ? purple.withOpacity(.35) : cyan.withOpacity(.15),
              child: Icon(occupied.contains(i) ? Icons.person : Icons.add, color: Colors.white)),
            const SizedBox(height: 7), Text(occupied.contains(i) ? 'Guest ${i+1}' : 'Seat ${i+1}', style: const TextStyle(fontSize: 12))
          ]),
        ),
      )),
      Padding(padding: const EdgeInsets.all(16), child: Row(children: [
        Expanded(child: OutlinedButton.icon(onPressed: () => _msg('Microphone permission and live audio will be connected in the next stage.'),
          icon: const Icon(Icons.mic_none), label: const Text('Mic'))),
        const SizedBox(width: 10),
        Expanded(child: FilledButton.icon(onPressed: () => _msg('Gift sending will be enabled after wallet integration.'),
          icon: const Icon(Icons.card_giftcard), label: const Text('Gift'))),
      ]))
    ]),
  );
  void _msg(String s) => showDialog<void>(context: context, builder: (_) => AlertDialog(
    backgroundColor: panel, content: Text(s),
    actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))]));
}

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Padding(padding: EdgeInsets.all(24),
    child: Text('WALLET\\n\\nCoins • Gifts • Host earnings\\nMinimum withdrawal: $10\\n\\nPayment provider and secure transaction records are not connected yet.',
      textAlign: TextAlign.center, style: TextStyle(fontSize: 17, height: 1.7))));
}
class AgencyScreen extends StatelessWidget {
  const AgencyScreen({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(20), children: const [
    Text('AGENCY CENTER', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
    SizedBox(height: 16),
    FeatureTile(Icons.admin_panel_settings, 'Main agency', 'Manage sub-agencies and agents'),
    FeatureTile(Icons.groups, 'Sub-agency', 'Manage hosts and activity'),
    FeatureTile(Icons.track_changes, 'Targets & commission', 'Monthly targets and earnings reports'),
    FeatureTile(Icons.account_balance_wallet, 'Agency wallet', 'Balances and transaction history'),
    SizedBox(height: 12),
    Text('Agency controls will be connected to the secure backend.', style: TextStyle(color: Colors.white60)),
  ]);
}
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(20), children: const [
    CircleAvatar(radius: 42, child: Icon(Icons.person, size: 42)),
    SizedBox(height: 16),
    Center(child: Text('Your profile', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold))),
    SizedBox(height: 22),
    FeatureTile(Icons.verified_user, 'Host verification', 'Secure age and identity checks'),
    FeatureTile(Icons.shield_outlined, 'Safety & privacy', 'Report, block and moderation tools'),
    FeatureTile(Icons.language, 'Language', 'English / Urdu initially'),
  ]);
}
class FeatureTile extends StatelessWidget {
  final IconData icon; final String title; final String subtitle;
  const FeatureTile(this.icon, this.title, this.subtitle, {super.key});
  @override
  Widget build(BuildContext context) => Card(color: panel, child: ListTile(
    leading: Icon(icon, color: cyan), title: Text(title), subtitle: Text(subtitle)));
}
class Tag extends StatelessWidget {
  final String text;
  const Tag(this.text, {super.key});
  @override
  Widget build(BuildContext context) => Chip(label: Text(text),
    backgroundColor: const Color(0xFF19194E), side: BorderSide(color: cyan.withOpacity(.35)));
}
