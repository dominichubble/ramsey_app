import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/commissioner_card.dart';
import '../widgets/info_card.dart';
import '../services/commissioner_service.dart';

class CommissionersScreen extends StatelessWidget {
  const CommissionersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final commissionerService = CommissionerService();
    final commissioners = commissionerService.getAllCommissioners();
    final contactInfo = commissionerService.getOfficeContact();
    final meetingInfo = commissionerService.getMeetingInfo();
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Commissioners',
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Ramsey Town Commissioners',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Meet your elected representatives who serve the Ramsey community.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),

            const SizedBox(height: 32),

            // Commissioners List
            const Text(
              'Your Commissioners',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            ...commissioners.map((commissioner) {
              return CommissionerCard(
                commissioner: commissioner,
                onTap: () {
                  _showCommissionerDetails(context, commissioner);
                },
              );
            }),

            const SizedBox(height: 32),

            // Contact Information
            InfoCard(
              title: 'Contact Information',
              icon: Icons.contact_phone,
              information: contactInfo,
              color: Colors.blue,
            ),

            const SizedBox(height: 16),

            // Meeting Information
            InfoCard(
              title: 'Public Meetings',
              icon: Icons.event,
              information: meetingInfo,
              color: Colors.green,
            ),

            const SizedBox(height: 32),

            // Additional Information
            Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Theme.of(context).primaryColor,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'About the Commission',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Ramsey Town Commissioners are responsible for local government in Ramsey, including town planning, local infrastructure, environmental protection, and community services. Commissioners are elected every four years and meet regularly to discuss matters affecting the town.',
                      style: TextStyle(fontSize: 14, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showCommissionerDetails(BuildContext context, commissioner) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(commissioner.imageUrl),
                          onBackgroundImageError: (exception, stackTrace) {
                            debugPrint(
                              'Error loading commissioner image: $exception',
                            );
                          },
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                commissioner.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                commissioner.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${commissioner.party} • ${commissioner.yearsInOffice} in office',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Bio
                    const Text(
                      'Biography',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      commissioner.bio,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),

                    const SizedBox(height: 24),

                    // Responsibilities
                    const Text(
                      'Key Responsibilities',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...commissioner.responsibilities.map((responsibility) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 16,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              responsibility,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    }),

                    const SizedBox(height: 24),

                    // Contact
                    const Text(
                      'Contact Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildContactRow(Icons.email, 'Email', commissioner.email),
                    const SizedBox(height: 8),
                    _buildContactRow(Icons.phone, 'Phone', commissioner.phone),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
