import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../common/utils/prefs_service.dart';
import '../common/utils/router.dart' show markWelcomeShown;
import '../common/values/prefs_keys.dart';
import '../common/values/route_paths.dart';

/// Welcome screen displayed on first launch.
///
/// Adapts layout across device sizes using [LayoutBuilder]:
/// - Compact (< 600dp): single-column phone layout
/// - Medium (600–900dp): centered content with constrained width
/// - Expanded (≥ 900dp): two-column desktop layout
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            if (width >= 900) {
              return _ExpandedLayout(
                colorScheme: colorScheme,
                textTheme: textTheme,
              );
            }
            if (width >= 600) {
              return _MediumLayout(
                colorScheme: colorScheme,
                textTheme: textTheme,
              );
            }
            return _CompactLayout(
              colorScheme: colorScheme,
              textTheme: textTheme,
            );
          },
        ),
      ),
    );
  }
}

/// Phone layout — single column, compact spacing.
class _CompactLayout extends StatelessWidget {
  const _CompactLayout({required this.colorScheme, required this.textTheme});

  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Spacer(flex: 2),
          _Logo(colorScheme: colorScheme, size: 88),
          const SizedBox(height: 32),
          _Title(textTheme: textTheme),
          const Spacer(),
          _FeatureList(colorScheme: colorScheme, textTheme: textTheme),
          const Spacer(flex: 2),
          _CtaButton(),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

/// Tablet layout — centered content with constrained width.
class _MediumLayout extends StatelessWidget {
  const _MediumLayout({required this.colorScheme, required this.textTheme});

  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 48),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _Logo(colorScheme: colorScheme, size: 104),
                const SizedBox(height: 40),
                _Title(textTheme: textTheme),
                const SizedBox(height: 64),
                _FeatureList(colorScheme: colorScheme, textTheme: textTheme),
                const SizedBox(height: 64),
                _CtaButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Desktop layout — two columns: brand on left, actions on right.
class _ExpandedLayout extends StatelessWidget {
  const _ExpandedLayout({required this.colorScheme, required this.textTheme});

  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 960),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: Row(
            children: [
              // Left column — brand
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _Logo(colorScheme: colorScheme, size: 120),
                    const SizedBox(height: 48),
                    _Title(textTheme: textTheme),
                  ],
                ),
              ),
              const SizedBox(width: 80),
              // Right column — features + CTA
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _FeatureList(
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                      compact: false,
                    ),
                    const SizedBox(height: 48),
                    _CtaButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// App logo icon in a rounded container.
class _Logo extends StatelessWidget {
  const _Logo({required this.colorScheme, required this.size});

  final ColorScheme colorScheme;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(size * 0.27),
      ),
      child: Icon(
        Icons.flutter_dash,
        size: size * 0.55,
        color: colorScheme.onPrimaryContainer,
      ),
    );
  }
}

/// App name and subtitle.
class _Title extends StatelessWidget {
  const _Title({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '记到起',
          textAlign: TextAlign.center,
          style: textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '四川话："别忘了"的意思',
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

/// List of feature highlights.
class _FeatureList extends StatelessWidget {
  const _FeatureList({
    required this.colorScheme,
    required this.textTheme,
    this.compact = true,
  });

  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final bool compact;

  static const _items = [
    (Icons.mic_rounded, '语音交互，LLM理解用户意图'),
    (Icons.checklist_rounded, '把脑子清空，AI来制定计划'),
    (Icons.calendar_month_rounded, '合理规划每一天'),
    (Icons.timer_rounded, '专注做事，我会来"喊"你'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (i, (icon, text)) in _items.indexed) ...[
          if (i > 0) const SizedBox(height: 16),
          _FeatureRow(
            icon: icon,
            text: text,
            colorScheme: colorScheme,
            compact: compact,
          ),
        ],
      ],
    );
  }
}

/// Single feature entry: icon + text.
class _FeatureRow extends StatelessWidget {
  const _FeatureRow({
    required this.icon,
    required this.text,
    required this.colorScheme,
    this.compact = true,
  });

  final IconData icon;
  final String text;
  final ColorScheme colorScheme;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final iconSize = compact ? 40.0 : 48.0;
    return Row(
      children: [
        Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            color: colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: iconSize * 0.55,
            color: colorScheme.onSecondaryContainer,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
        ),
      ],
    );
  }
}

/// "Get started" button that navigates to the main app.
class _CtaButton extends StatelessWidget {
  const _CtaButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton(
        onPressed: () {
          PrefsService.instance.setBool(PrefsKeys.welcomeShown, true);
          markWelcomeShown();
          context.go(RoutePaths.voice);
        },
        child: const Text('开始使用', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
