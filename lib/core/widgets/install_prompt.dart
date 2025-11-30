import 'package:flutter/material.dart';
import 'dart:html' as html;

class InstallPrompt extends StatefulWidget {
  const InstallPrompt({super.key});

  @override
  State<InstallPrompt> createState() => _InstallPromptState();
}

class _InstallPromptState extends State<InstallPrompt> {
  bool _showPrompt = true;
  bool _isStandalone = false;

  @override
  void initState() {
    super.initState();
    _checkIfStandalone();
  }

  void _checkIfStandalone() {
    // Check if app is already installed (running in standalone mode)
    final mediaQuery = html.window.matchMedia('(display-mode: standalone)');
    setState(() {
      _isStandalone = mediaQuery.matches;
      // Don't show prompt if already installed
      if (_isStandalone) {
        _showPrompt = false;
      }
    });
  }

  bool _isIOS() {
    final userAgent = html.window.navigator.userAgent.toLowerCase();
    return userAgent.contains('iphone') || 
           userAgent.contains('ipad') || 
           userAgent.contains('ipod');
  }

  bool _isAndroid() {
    final userAgent = html.window.navigator.userAgent.toLowerCase();
    return userAgent.contains('android');
  }

  @override
  Widget build(BuildContext context) {
    if (!_showPrompt || _isStandalone) {
      return const SizedBox.shrink();
    }

    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        child: Row(
          children: [
            Icon(
              Icons.download_rounded,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Install Wellness Tracker',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _isIOS()
                        ? 'Tap Share → Add to Home Screen'
                        : 'Tap menu → Add to Home Screen',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              onPressed: () {
                setState(() {
                  _showPrompt = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
