import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Account & Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.primaryLight,
                    child: const Text('SK', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.primaryDark)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Surendra Kumar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textDark)),
                        SizedBox(height: 2),
                        Text('surendra@smartchakkii.com', style: TextStyle(fontSize: 12, color: AppColors.textMedium)),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.verified_rounded, size: 14, color: AppColors.primary),
                            SizedBox(width: 4),
                            Text('1Fi Full KYC Complete', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primaryDark)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildSection([
              _buildTile(Icons.account_balance_wallet_outlined, '1Fi Credit Line Settings', 'Manage limit & pledge'),
              _buildTile(Icons.credit_card_outlined, 'Auto-Debit Mandates (eNACH)', 'HDFC Bank - 8921'),
              _buildTile(Icons.location_on_outlined, 'Saved Delivery Addresses', '1 Active Address'),
            ]),
            const SizedBox(height: 16),
            _buildSection([
              _buildTile(Icons.help_outline_rounded, '24x7 1Fi Support', 'Chat with fintech advisor'),
              _buildTile(Icons.security_rounded, 'Privacy & RBI Compliance', 'RBI registered NBFC partners'),
              _buildTile(Icons.info_outline_rounded, 'About 1Fi App', 'Version 1.0.0 (Assignment Build)'),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(List<Widget> children) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget _buildTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: AppColors.textDark),
      ),
      title: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textDark)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textMedium)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textMuted),
      onTap: () {},
    );
  }
}
