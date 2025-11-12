import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../models/user.dart';
import '../utils/theme.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppTheme.spacingLG),
                child: Column(
                  children: [
                    _buildPlanCard(
                      context,
                      plan: SubscriptionPlan.starter,
                      isRecommended: false,
                    ),
                    const SizedBox(height: AppTheme.spacingMD),
                    _buildPlanCard(
                      context,
                      plan: SubscriptionPlan.pro,
                      isRecommended: true,
                    ),
                    const SizedBox(height: AppTheme.spacingMD),
                    _buildPlanCard(
                      context,
                      plan: SubscriptionPlan.premium,
                      isRecommended: false,
                    ),
                    const SizedBox(height: AppTheme.spacingLG),
                    _buildMoneyBackGuarantee(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingLG),
      decoration: const BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              const Expanded(
                child: Text(
                  'Passer à Pro',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: AppTheme.spacingLG),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.trending_up,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppTheme.spacingMD),
          const Text(
            'Boostez votre business',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choisissez le plan qui correspond à vos objectifs',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(
    BuildContext context, {
    required SubscriptionPlan plan,
    required bool isRecommended,
  }) {
    // Define plan details based on image
    String name;
    String price;
    List<String> features;
    Color accentColor;
    IconData icon;

    switch (plan) {
      case SubscriptionPlan.starter:
        name = 'Starter';
        price = '99';
        features = [
          '100 recherches par mois',
          'Analyse de base',
          '5 favoris',
          'Support email',
          'Historique 7 jours',
        ];
        accentColor = const Color(0xFF5B8DEF);
        icon = Icons.rocket_launch_outlined;
        break;
      case SubscriptionPlan.pro:
        name = 'Pro';
        price = '249';
        features = [
          'Recherches illimitées',
          'Analyse avancée',
          'Favoris illimités',
          'Support prioritaire',
          'Historique 30 jours',
          'Export données',
          'Alertes tendances',
        ];
        accentColor = AppTheme.primaryOrange;
        icon = Icons.workspace_premium;
        break;
      case SubscriptionPlan.premium:
        name = 'Premium';
        price = '499';
        features = [
          'Tout du plan Pro',
          'Analyse prédictive',
          'API accès',
          'Support 24/7',
          'Historique illimité',
          'Formation exclusive',
          'Conseiller dédié',
          'Outils marketing',
        ];
        accentColor = const Color(0xFFFFA726);
        icon = Icons.diamond;
        break;
      default:
        name = 'Free';
        price = '0';
        features = [];
        accentColor = AppTheme.mediumGray;
        icon = Icons.star;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppTheme.cardRadius,
        border: isRecommended
            ? Border.all(color: AppTheme.primaryOrange, width: 2)
            : null,
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isRecommended)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                color: AppTheme.warning,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
              ),
              child: const Text(
                'Le plus populaire',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingLG),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              price,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: accentColor,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 6, left: 2),
                              child: Text(
                                'DH/mois',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacingLG),
                ...features.map((feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: accentColor,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              feature,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: AppTheme.spacingMD),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _handleSubscribe(context, plan),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                    ),
                    child: Text('Choisir $name'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoneyBackGuarantee() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLG),
      decoration: BoxDecoration(
        color: AppTheme.info.withOpacity(0.1),
        borderRadius: AppTheme.cardRadius,
        border: Border.all(
          color: AppTheme.info.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.verified_user,
            color: AppTheme.info,
            size: 32,
          ),
          const SizedBox(width: AppTheme.spacingMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Garantie satisfait ou remboursé 14 jours',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Annulez à tout moment, sans frais cachés',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSubscribe(BuildContext context, SubscriptionPlan plan) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmer l\'abonnement'),
        content: Text(
          'Vous allez souscrire au plan ${plan.displayName} pour ${plan.price} DH/mois.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirmer'),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      final success = await userProvider.updateSubscription(plan);
      
      if (success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Abonnement mis à jour avec succès !'),
            backgroundColor: AppTheme.success,
          ),
        );
        Navigator.pop(context);
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(userProvider.error ?? 'Erreur lors de la mise à jour'),
            backgroundColor: AppTheme.error,
          ),
        );
      }
    }
  }
}
