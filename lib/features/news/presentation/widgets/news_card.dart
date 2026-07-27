import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/news_article.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({required this.article, super.key});

  final NewsArticle article;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('d MMM y · HH:mm', 'es');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(article.summary, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 10),
            Row(
              children: [
                if (article.sourceName != null) ...[
                  Text(
                    article.sourceName!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(' · '),
                ],
                Text(
                  dateFormat.format(article.publishedAt),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
