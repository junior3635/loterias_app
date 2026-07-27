import 'package:flutter/material.dart';

class DrawInfoCard extends StatelessWidget {
  final String nextDrawTitle;
  final String nextDrawDate;
  final String jackpotTitle;
  final String jackpotAmount;
  final String cashValueAmount;

  const DrawInfoCard({
    super.key,
    this.nextDrawTitle = 'Next Powerball draw',
    this.nextDrawDate = 'Saturday, Jul 25, 2026',
    this.jackpotTitle = 'Next est. jackpot',
    this.jackpotAmount = '\$600 Million',
    this.cashValueAmount = '\$266.4 Million',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(16.0),
      //   // Sombra suave tipo elevación moderna
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.black.withOpacity(0.05),
      //       blurRadius: 10,
      //       offset: const Offset(0, 4),
      //     ),
      //   ],
      //   // Borde fino opcional
      //   border: Border.all(
      //     color: Colors.grey.shade200,
      //     width: 1,
      //   ),
      // ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Seccion 1: Fecha del sorteo
          _buildInfoRow(
            icon: Icons.calendar_today_outlined,
            title: nextDrawTitle,
            mainContent: Text(
              nextDrawDate,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Sección 2: Jackpot / Premio acumulado
          _buildInfoRow(
            icon: Icons.attach_money_rounded,
            title: jackpotTitle,
            mainContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  jackpotAmount,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    children: [
                      const TextSpan(text: 'Cash value: '),
                      TextSpan(
                        text: cashValueAmount,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper para mantener limpia la estructura de filas con icono
  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required Widget mainContent,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 22,
          color: Colors.blueGrey.shade700,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              mainContent,
            ],
          ),
        ),
      ],
    );
  }
}