import 'package:flutter/material.dart';

void main() => runApp(const LiveWaveApp());

const purple = Color(0xFF9147FF);
const bg = Color(0xFF0E0B13);
const panel = Color(0xFF17121D);

class LiveWaveApp extends StatelessWidget {
  const LiveWaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LiveWave',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: purple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1D1824),
          hintStyle: const TextStyle(color: Color(0xFF8D8797)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: Color(0xFF342A40)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: Color(0xFF342A40)),
          ),
        ),
      ),
      home: const DiscoveryPage(),
    );
  }
}

class StreamInfo {
  const StreamInfo({
    required this.creator,
    required this.title,
    required this.category,
    required this.viewers,
    required this.color,
    required this.initials,
    this.live = true,
  });

  final String creator;
  final String title;
  final String category;
  final String viewers;
  final Color color;
  final String initials;
  final bool live;
}

const demoStreams = <StreamInfo>[
  StreamInfo(
    creator: 'NinaPlays',
    title: 'Zerando o boss hoje 🔥',
    category: 'RPG',
    viewers: '2,4 mil',
    color: Color(0xFF4D2A72),
    initials: 'NP',
  ),
  StreamInfo(
    creator: 'GuiFPS',
    title: 'Ranked até pegar Mestre',
    category: 'FPS',
    viewers: '986',
    color: Color(0xFF174E58),
    initials: 'GF',
  ),
  StreamInfo(
    creator: 'PixelCafe',
    title: 'Jogos indie e conversa',
    category: 'Just Chatting',
    viewers: '421',
    color: Color(0xFF7A3B38),
    initials: 'PC',
  ),
  StreamInfo(
    creator: 'LuaCosplay',
    title: 'Montando um cenário novo',
    category: 'Criatividade',
    viewers: '178',
    color: Color(0xFF55452A),
    initials: 'LC',
    live: false,
  ),
];

class DiscoveryPage extends StatefulWidget {
  const DiscoveryPage({super.key});

  @override
  State<DiscoveryPage> createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  final searchController = TextEditingController();
  String category = 'Para você';
  final Set<String> followed = {'NinaPlays'};

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = searchController.text.toLowerCase();
    final filtered = demoStreams.where((stream) {
      final matchesQuery =
          '${stream.creator} ${stream.title} ${stream.category}'
              .toLowerCase()
              .contains(query);
      final matchesFollowed =
          category != 'Seguindo' || followed.contains(stream.creator);
      final matchesLive = category != 'Ao vivo' || stream.live;
      return matchesQuery && matchesFollowed && matchesLive;
    }).toList();

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF15101B),
        indicatorColor: const Color(0xFF39234F),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.live_tv_outlined),
            label: 'Ao vivo',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            label: 'Seguindo',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
        onDestinationSelected: (index) {
          setState(() {
            if (index == 0) category = 'Para você';
            if (index == 1) category = 'Ao vivo';
            if (index == 2) category = 'Seguindo';
            if (index == 3) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Login e perfil serão adicionados na próxima etapa.',
                  ),
                ),
              );
            }
          });
        },
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _header(context)),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const Text(
                    'SEU PRÓXIMO MOMENTO FAVORITO',
                    style: TextStyle(
                      color: Color(0xFFB68AFF),
                      fontSize: 10,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Ao vivo. Do seu jeito.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 31,
                      height: 1.15,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Descubra criadores, acompanhe comunidades e entre na conversa.',
                    style: TextStyle(color: Color(0xFFAAA2B5), height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Color(0xFFB68AFF)),
                      hintText: 'Buscar canais, jogos e criadores',
                    ),
                  ),
                  const SizedBox(height: 17),
                  SizedBox(
                    height: 42,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children:
                          [
                                'Para você',
                                'Seguindo',
                                'Jogos',
                                'Música',
                                'Ao vivo',
                              ]
                              .map(
                                (item) => Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: ChoiceChip(
                                    label: Text(item),
                                    selected: category == item,
                                    onSelected: (_) =>
                                        setState(() => category = item),
                                    selectedColor: purple,
                                    backgroundColor: const Color(0xFF1D1824),
                                    side: BorderSide.none,
                                    labelStyle: TextStyle(
                                      color: category == item
                                          ? Colors.white
                                          : const Color(0xFFB7AFC1),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Lives para descobrir',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        '${filtered.where((s) => s.live).length} AO VIVO',
                        style: const TextStyle(
                          color: Color(0xFFFF6A8A),
                          fontSize: 10,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 13),
                  if (filtered.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'Nenhum canal encontrado. Tente outra busca.',
                      ),
                    )
                  else
                    ...filtered.map((stream) => _streamCard(context, stream)),
                  const SizedBox(height: 18),
                  const Center(
                    child: Text(
                      'LIVEWAVE · PROTÓTIPO INICIAL',
                      style: TextStyle(
                        color: Color(0xFF8D7B9E),
                        fontSize: 9,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Center(
                    child: Text(
                      'Canais de demonstração · sem transmissão real',
                      style: TextStyle(color: Color(0xFF62596C), fontSize: 10),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF292331))),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: purple,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'L',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
          ),
          const SizedBox(width: 9),
          const Text(
            'livewave',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const Spacer(),
          IconButton(
            tooltip: 'Entrar',
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Autenticação será conectada na próxima etapa.'),
              ),
            ),
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
    );
  }

  Widget _streamCard(BuildContext context, StreamInfo stream) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2A2232)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => StreamPage(
                  stream: stream,
                  isFollowed: followed.contains(stream.creator),
                  onToggleFollow: () => setState(() {
                    if (!followed.add(stream.creator))
                      followed.remove(stream.creator);
                  }),
                ),
              ),
            ),
            child: Container(
              height: 174,
              width: double.infinity,
              color: stream.color,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: -45,
                    right: -15,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: const BoxDecoration(
                        color: Color(0x1AFFFFFF),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Text(
                    stream.initials,
                    style: const TextStyle(
                      color: Color(0xE6FFFFFF),
                      fontSize: 52,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -3,
                    ),
                  ),
                  if (stream.live)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF04468),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          '● AO VIVO',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    right: 12,
                    bottom: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xB8000000),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        stream.viewers,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFF342345),
                  child: Text(
                    stream.initials.substring(0, 1),
                    style: const TextStyle(color: Color(0xFFD8BFFF)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stream.title,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        stream.creator,
                        style: const TextStyle(
                          color: Color(0xFF92899D),
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2036),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          stream.category,
                          style: const TextStyle(
                            color: Color(0xFFC7B0E7),
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: followed.contains(stream.creator)
                      ? 'Deixar de seguir'
                      : 'Seguir',
                  onPressed: () => setState(() {
                    if (!followed.add(stream.creator))
                      followed.remove(stream.creator);
                  }),
                  icon: Icon(
                    followed.contains(stream.creator) ? Icons.check : Icons.add,
                    color: const Color(0xFFCBAAFF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StreamPage extends StatefulWidget {
  const StreamPage({
    super.key,
    required this.stream,
    required this.isFollowed,
    required this.onToggleFollow,
  });

  final StreamInfo stream;
  final bool isFollowed;
  final VoidCallback onToggleFollow;

  @override
  State<StreamPage> createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  final messageController = TextEditingController();
  final messages = <({String user, String text})>[
    (user: 'mod_ana', text: 'Bem-vindos à live! 💜'),
    (user: 'pedro123', text: 'Salve, chat!'),
    (user: 'gamerBR', text: 'Esse jogo é muito bom'),
  ];

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      messages.add((user: 'voce', text: text));
      messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.stream.creator)),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: widget.stream.color,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.play_circle_outline, size: 58),
                SizedBox(height: 12),
                Text(
                  'PRÉVIA DO PLAYER',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'A reprodução HLS será conectada na próxima etapa.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text(
            widget.stream.title,
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 5),
          Text(
            '${widget.stream.creator} · ${widget.stream.category} · ${widget.stream.viewers} espectadores',
            style: const TextStyle(color: Color(0xFF92899D), fontSize: 12),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: widget.onToggleFollow,
            icon: const Icon(Icons.favorite_border),
            label: Text(widget.isFollowed ? 'Seguindo' : 'Seguir canal'),
          ),
          const SizedBox(height: 16),
          const Text(
            'Chat da live',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          ...messages.map(
            (message) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Color(0xFFD9D2E2),
                    fontSize: 13,
                  ),
                  children: [
                    TextSpan(
                      text: '${message.user}: ',
                      style: const TextStyle(
                        color: Color(0xFFC59BFF),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextSpan(text: message.text),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  onSubmitted: (_) => sendMessage(),
                  decoration: const InputDecoration(
                    hintText: 'Envie uma mensagem',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(onPressed: sendMessage, child: const Text('Enviar')),
            ],
          ),
        ],
      ),
    );
  }
}
