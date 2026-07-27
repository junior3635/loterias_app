import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/lottery_result.dart';

class LotteryResultCard extends StatelessWidget {
  const LotteryResultCard({required this.result, super.key});

  final LotteryResult result;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d MMM y', 'es');
    final theme = Theme.of(context);
    final screenSize = MediaQuery.sizeOf(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  result.lotteryName,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  dateFormat.format(result.drawDate),
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
            if (result.state != null) ...[
              const SizedBox(height: 2),
              Text(result.state!, style: theme.textTheme.bodySmall),
            ],
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...result.numbers.map((n) => _NumberBall(number: n)),
                    if (result.bonusNumber != null)
                      _NumberBall(number: result.bonusNumber!, highlight: true),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(

                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Bordes medio redondeados
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                  ),
                  child: Text('VER RESULTADOS')
                )
              ]
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(

                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Bordes medio redondeados
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                  ),
                  child: Text('VER RESULTADOS')
                )
              ]
            ),
            if (result.jackpotAmount != null) ...[
              const SizedBox(height: 12),
              Text(
                'Jackpot: ${NumberFormat.simpleCurrency(name: result.currency ?? 'USD').format(result.jackpotAmount)}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NumberBall extends StatelessWidget {
  const _NumberBall({required this.number, this.highlight = false});

  final int number;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radio = 20;
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.black,
      child: Container(
        width: radio * 2, // Radio de 18 * 2
        height: radio * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            center: const Alignment(0.0, -0.5), // circle at 50% 25%
            radius: 0.8,
            colors: highlight ? const [
              Color.fromARGB(255, 248, 9, 9), // #fff
              Color.fromARGB(255, 248, 9, 9), // #fff
            ] : 
            const [
              Color(0xFFFFFFFF), // #fff
              Color(0xFFBBBBBB), // #bbb
            ],
          ),
        ),
        child: Center(
          child: Text(
            '$number',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: highlight
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
