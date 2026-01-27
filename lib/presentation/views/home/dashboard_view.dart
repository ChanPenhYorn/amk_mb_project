import 'package:amk_bank_project/presentation/views/home/widgets/dashboard_widgets.dart';
import 'package:amk_bank_project/core/shared/app_font.dart';
import 'package:amk_bank_project/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.amkPrimary, width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(
                      'assets/images/united-kingdom.png',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "Good morning, Mary Doe!",
                  style: AppFont.bold(
                    fontSizeValue: 16,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Quick Actions Grid (3x2)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 24,
              crossAxisSpacing: 20,
              childAspectRatio: 0.85,
              children: [
                QuickActionIcon(
                  icon: Icons.account_balance_wallet_outlined,
                  label: "Accounts",
                  onTap: () {},
                ),
                QuickActionIcon(
                  icon: Icons.list_alt_rounded,
                  label: "Payments",
                  onTap: () {},
                ),
                QuickActionIcon(
                  icon: Icons.sync_alt_rounded,
                  label: "Local Transfer",
                  onTap: () {},
                ),
                QuickActionIcon(
                  icon: Icons.access_time_rounded,
                  label: "History",
                  onTap: () {},
                ),
                QuickActionIcon(
                  icon: Icons.phone_android_rounded,
                  label: "Phone Top Up",
                  onTap: () {},
                ),
                QuickActionIcon(
                  icon: Icons.public_rounded,
                  label: "Overseas\nTransfer",
                  onTap: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Fast Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                FastActionButton(
                  label: "Fast Transfer",
                  icon: Icons.swap_horiz_rounded,
                  backgroundColor: AppColors.amkPrimary,
                  onTap: () {},
                ),
                const SizedBox(width: 12),
                FastActionButton(
                  label: "Fast Payment",
                  icon: Icons.qr_code_2_rounded,
                  backgroundColor: Colors.blue.shade600,
                  onTap: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Explore Features Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Explore Features",
                  style: AppFont.bold(
                    fontSizeValue: 16,
                    color: isDark ? Colors.white : Colors.black54,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        "See all",
                        style: AppFont.bold(
                          fontSizeValue: 14,
                          color: AppColors.amkPrimary,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: AppColors.amkPrimary,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Explore Features Horizontal List
          SizedBox(
            height: 130,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const BouncingScrollPhysics(),
              children: [
                FeatureTile(
                  label: "My Points",
                  icon: Icon(
                    Icons.stars_rounded,
                    color: Colors.amber.shade600,
                    size: 36,
                  ),
                  onTap: () {},
                ),
                FeatureTile(
                  label: "Loan Request",
                  icon: Icon(
                    Icons.handshake_rounded,
                    color: Colors.teal.shade500,
                    size: 36,
                  ),
                  onTap: () {},
                ),
                FeatureTile(
                  label: "Credit Bureau Cambodia",
                  icon: Icon(
                    Icons.account_balance_rounded,
                    color: Colors.green.shade600,
                    size: 36,
                  ),
                  onTap: () {},
                ),
                FeatureTile(
                  label: "Goal Savings",
                  icon: Icon(
                    Icons.savings_outlined,
                    color: Colors.blue.shade500,
                    size: 36,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Promotions Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Promotions",
              style: AppFont.bold(
                fontSizeValue: 16,
                color: isDark ? Colors.white : Colors.black54,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/amk_no_bg.png',
                  fit: BoxFit.cover,
                  color: AppColors.amkPrimary.withOpacity(0.1),
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
