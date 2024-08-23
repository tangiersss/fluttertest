import 'package:flutter/material.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Test app',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isExpanded = false;
  final List<bool> _selected = List.generate(21, (index) => false);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  void _toggleFab() {
    if (_isExpanded) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildFab({required Widget icon, required Color? color, required VoidCallback onPressed}) {
    return FloatingActionButton(
      onPressed: onPressed,
      heroTag: null,
      mini: true,
      backgroundColor: color,
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScaleTransition(
            scale: _animation,
            alignment: Alignment.bottomCenter,
            child: _buildFab(
              icon: const Icon(Icons.task_alt, color: Colors.black),
              color: Colors.greenAccent,
              onPressed: () {},
            ),
          ),
          const SizedBox(height: 2),
          ScaleTransition(
            scale: _animation,
            alignment: Alignment.bottomCenter,
            child: _buildFab(
              icon: const Icon(Icons.arrow_upward, color: Colors.black),
              color: Colors.white70,
              onPressed: () {},
            ),
          ),
          const SizedBox(height: 2),
          ScaleTransition(
            scale: _animation,
            alignment: Alignment.bottomCenter,
            child: _buildFab(
              icon: const Icon(Icons.arrow_downward, color: Colors.black),
              color: Colors.white70,
              onPressed: () {},
            ),
          ),
          const SizedBox(height: 2),
          _buildFab(
            icon: const Icon(Icons.menu, color: Colors.black),
            color: Colors.white,
            onPressed: _toggleFab,
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('MEDBIOTECH'),
        centerTitle: true,
        backgroundColor: Colors.black,
        titleTextStyle: const TextStyle(
          fontFamily: 'WorkSans',
          fontSize: 20,
          color: Colors.white,
        ),
        leading: const Icon(
          Icons.arrow_back_ios,
          size: 30,
          color: Colors.white,
        ),
        actions: const [
          Icon(
            Icons.lightbulb,
            size: 25,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.charging_station_rounded,
            size: 25,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.bluetooth,
            size: 25,
            color: Colors.white,
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/fon.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 75),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 21,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    _selected[index] = !_selected[index];
                  });
                },
                child: Container(
                  color: _selected[index]
                      ? Colors.white.withOpacity(0.3)
                      : Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.manage_accounts_rounded,
                        size: 40,
                        color: Colors.greenAccent,
                      ),
                      Text(
                        'Item $index',
                        style: const TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
