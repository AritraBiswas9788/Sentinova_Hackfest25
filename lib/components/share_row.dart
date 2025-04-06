import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareRow extends StatelessWidget {
  const ShareRow({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> shareToSocialMedia({
      required String platform,
      required String message,
      List<String> hashtags = const [],
    }) async {
      final tagString =
          hashtags.map((tag) => tag.startsWith('#') ? tag : '#$tag').join(' ');
      final fullMessage = '$message\n\n$tagString';

      Uri? url;

      switch (platform.toLowerCase()) {
        case 'facebook':
          url = Uri.parse(
            'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(fullMessage)}',
          );
          break;
        case 'twitter':
        case 'x':
          url = Uri.parse(
            'https://twitter.com/intent/tweet?text=${Uri.encodeComponent(fullMessage)}',
          );
          break;
        case 'linkedin':
          url = Uri.parse(
            'https://www.linkedin.com/sharing/share-offsite/?url=${Uri.encodeComponent(fullMessage)}',
          );
          break;
        case 'reddit':
          url = Uri.parse(
            'https://www.reddit.com/submit?title=${Uri.encodeComponent(fullMessage)}',
          );
          break;
        case 'instagram':
          // Instagram doesn't support text-based web sharing. Only images/videos can be shared.
          // You can open the Instagram app (if installed)
          final instagramUri = Uri.parse('instagram://app');
          if (await canLaunchUrl(instagramUri)) {
            await launchUrl(instagramUri);
          } else {
            // Fallback
            print('Instagram not installed');
          }
          return;
        default:
          throw Exception('Unsupported platform');
      }

      if (url != null) {
        try {
          await launchUrl(url, mode: LaunchMode.inAppBrowserView);
        } catch (e) {
          print(e);
        }
      } else {
        print('Could not launch $url');
      }
    }

    Future<void> openInstagramApp() async {
      final Uri instagramUri = Uri.parse('instagram://app');

      if (await canLaunchUrl(instagramUri)) {
        await launchUrl(instagramUri, mode: LaunchMode.externalApplication);
      } else {
        // Optionally fall back to the Instagram website
        final Uri fallbackUrl = Uri.parse('https://www.instagram.com/');
        if (await canLaunchUrl(fallbackUrl)) {
          await launchUrl(fallbackUrl, mode: LaunchMode.externalApplication);
        } else {
          print('Could not open Instagram.');
        }
      }
    }

    final shareButtons = [
      {
        'path': 'assets/facebook_share.png',
        'onTap': () async {
          print('Share to Facebook');

          await shareToSocialMedia(
            platform: 'facebook',
            message: 'Check out this cool thing!',
            hashtags: ['Flutter', 'Dart'],
          );

          // try{
          //   final response = await flutterShareMe.shareToFacebook(
          //       url: "https://pub.dev/packages/flutter_share_me", msg: "msg").timeout(Duration(seconds: 5));
          // }catch(e)
          // {
          //   print(e);
          // }
        }
      },
      {
        'path': 'assets/x_share.png',
        'onTap': () async {
          await shareToSocialMedia(
            platform: 'twitter',
            message: 'Check out this cool thing!',
            hashtags: ['Flutter', 'Dart'],
          );
        }
      },
      {
        'path': 'assets/instagram_share.png',
        'onTap': ()async{
          openInstagramApp();
        }
      },
      {
        'path': 'assets/linkedin_share.png',
        'onTap': ()async{
          await shareToSocialMedia(
            platform: 'linkedin',
            message: 'Check out this cool thing!',
            hashtags: ['Flutter', 'Dart'],
          );
        }
      },
      {
        'path': 'assets/reddit_share.png',
        'onTap': () async {
          await shareToSocialMedia(
            platform: 'reddit',
            message: 'Check out this cool thing!',
            hashtags: ['Flutter', 'Dart'],
          );
        }
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: shareButtons.map((btn) {
        return Container(
          child: GlowingShareIcon(
            imagePath: btn['path'] as String,
            onTap: btn['onTap'] as VoidCallback,
          ),
        );
      }).toList(),
    );
  }
}

class GlowingShareIcon extends StatefulWidget {
  final String imagePath;
  final VoidCallback onTap;

  const GlowingShareIcon({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  State<GlowingShareIcon> createState() => _GlowingShareIconState();
}

class _GlowingShareIconState extends State<GlowingShareIcon> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isTapped = true),
      onTapUp: (_) {
        setState(() => _isTapped = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isTapped = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 50),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: _isTapped
              ? [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.7),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ]
              : [],
        ),
        child: AnimatedScale(
            duration: const Duration(milliseconds: 10),
            scale: _isTapped ? 1.1 : 1.0,
            child: Stack(
              children: [
                Image.asset(widget.imagePath, width: 40, height: 40),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white.withOpacity(0.9),
                            // reddit orange glow
                            blurRadius: 10,
                            offset: Offset(0, 0),
                            blurStyle: BlurStyle.outer),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
