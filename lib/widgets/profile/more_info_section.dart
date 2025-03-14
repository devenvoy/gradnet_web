import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradnet_web/model/profile_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreInfoSection extends StatelessWidget {
  final String phoneNumber;
  final String email;
  final List<URLDto>? socialUrls;

  const MoreInfoSection({
    super.key,
    required this.phoneNumber,
    required this.email,
    this.socialUrls,
  });

  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildSectionTitle(context, Icons.contacts, "Contacts"),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          children: [
            _buildContactIconButton(
              icon: Icons.phone,
              onClick: () => _launchUrl("tel:$phoneNumber"),
            ),
            _buildContactIconButton(
              icon: Icons.email,
              onClick: () => _launchUrl("mailto:$email"),
            ),
            if (socialUrls != null)
              ...socialUrls!.map(
                (urlDto) => _buildContactIconButton(
                  icon: _getIconForType(urlDto.type),
                  onClick: urlDto.url != null ? () => _launchUrl(urlDto.url!) : null,
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 6),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildContactIconButton({required IconData icon, VoidCallback? onClick}) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(21),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[200],
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Center(
          child: Icon(icon, size: 24),
        ),
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'linkedinUrl':
        return FontAwesomeIcons.linkedin;
      case 'twitterUrl':
        return FontAwesomeIcons.twitter;
      case 'githubUrl':
        return FontAwesomeIcons.github;
      default:
        return Icons.link; // Default icon for other URLs
    }
  }
}
