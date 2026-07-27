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
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  dateFormat.format(result.drawDate),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
            if (result.state != null) ...[
              const SizedBox(height: 2),
              Text(result.state!, style: theme.textTheme.bodySmall),
            ],
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...result.numbers.map((n) => _NumberBall(number: n)),
                if (result.bonusNumber != null)
                  _NumberBall(number: result.bonusNumber!, highlight: true),
              ],
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
    return CircleAvatar(
      radius: 18,
      backgroundColor: highlight
          ? theme.colorScheme.secondary
          : theme.colorScheme.primaryContainer,
      child: Text(
        '$number',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: highlight
              ? theme.colorScheme.onSecondary
              : theme.colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
