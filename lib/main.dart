import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui';

void main() {
  runApp(const BiodataApp());
}

class BiodataApp extends StatelessWidget {
  const BiodataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interactive Biodata',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
      ),
      home: const BiodataScreen(),
    );
  }
}

class BiodataScreen extends StatefulWidget {
  const BiodataScreen({super.key});

  @override
  State<BiodataScreen> createState() => _BiodataScreenState();
}

class _BiodataScreenState extends State<BiodataScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Animated Gradients
          const AnimatedBackground(),
          
          // Main Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: FadeTransition(
                opacity: _fadeController,
                child: MouseRegion(
                  onEnter: (_) => setState(() => _isHovering = true),
                  onExit: (_) => setState(() => _isHovering = false),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    width: 800,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: _isHovering ? Colors.pinkAccent.withOpacity(0.5) : Colors.white.withOpacity(0.1),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 40,
                          offset: const Offset(0, 20),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            bool isMobile = constraints.maxWidth < 600;
                            return Padding(
                              padding: const EdgeInsets.all(40),
                              child: isMobile
                                  ? Column(children: _buildContent(isMobile))
                                  : Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: _buildContent(isMobile),
                                    ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildContent(bool isMobile) {
    final avatar = Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.pinkAccent, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.pinkAccent.withOpacity(0.5),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
        image: const DecorationImage(
          image: AssetImage('assets/images/profile.png'),
          fit: BoxFit.cover,
        ),
      ),
    );

    final info = Expanded(
      flex: isMobile ? 0 : 2,
      child: Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          if (isMobile) const SizedBox(height: 20),
          Text(
            'M. Rizky',
            style: GoogleFonts.outfit(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          Text(
            'Fullstack Developer & UI Enthusiast',
            style: GoogleFonts.outfit(
              fontSize: 18,
              color: Colors.pinkAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Passionate about creating beautiful, functional, and interactive user experiences. Student at SMT 6 exploring the world of Flutter and Cloud Computing.',
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: const TextStyle(height: 1.6, color: Colors.white70),
          ),
          const SizedBox(height: 30),
          const Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              SkillChip(label: 'Flutter'),
              SkillChip(label: 'Dart'),
              SkillChip(label: 'Javascript'),
              SkillChip(label: 'Vercel'),
              SkillChip(label: 'Firebase'),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              SocialButton(icon: FontAwesomeIcons.github, onPressed: () {}),
              SocialButton(icon: FontAwesomeIcons.linkedin, onPressed: () {}),
              SocialButton(icon: FontAwesomeIcons.instagram, onPressed: () {}),
              SocialButton(icon: FontAwesomeIcons.envelope, onPressed: () {}),
            ],
          ),
        ],
      ),
    );

    return [
      if (!isMobile) ...[
        Column(children: [avatar, const SizedBox(height: 20)]),
        const SizedBox(width: 40),
      ] else ...[
        avatar,
      ],
      info,
    ];
  }
}

class SkillChip extends StatelessWidget {
  final String label;
  const SkillChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.pinkAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.pinkAccent.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class SocialButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const SocialButton({super.key, required this.icon, required this.onPressed});

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: _isHovered ? Colors.pinkAccent : Colors.white.withOpacity(0.05),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(widget.icon),
          color: _isHovered ? Colors.white : Colors.white70,
          onPressed: widget.onPressed,
        ),
      ),
    );
  }
}

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: const [
                Color(0xFF0F0C29),
                Color(0xFF302B63),
                Color(0xFF24243E),
              ],
              stops: [0.0, 0.5, 1.0],
              transform: GradientRotation(_controller.value * 2 * 3.14159),
            ),
          ),
        );
      },
    );
  }
}
