import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SocialCardsRow extends StatefulWidget {
  final bool scrollLeftToRight; // allows reversing scroll direction
  final List<Widget> cards;

  const SocialCardsRow({
    Key? key,
    required this.cards,
    this.scrollLeftToRight = true,
  }) : super(key: key);

  @override
  State<SocialCardsRow> createState() => _SocialCardsRowState();
}

class _SocialCardsRowState extends State<SocialCardsRow> {
  late ScrollController _scrollController;
  Timer? _scrollTimer;
  bool _userInteracting = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _scrollTimer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (_scrollController.hasClients && !_userInteracting) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.offset;

        if (widget.scrollLeftToRight) {
          if (currentScroll >= maxScroll) {
            _scrollController.jumpTo(0);
          } else {
            _scrollController.jumpTo(currentScroll + 1);
          }
        } else {
          if (currentScroll <= 0) {
            _scrollController.jumpTo(maxScroll);
          } else {
            _scrollController.jumpTo(currentScroll - 1);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        if (notification.direction != ScrollDirection.idle) {
          _userInteracting = true;
        } else {
          _userInteracting = false;
        }
        return true;
      },
      child: SizedBox(
        height: 160,
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: widget.cards.length * 100, // infinite loop effect
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: widget.cards[index % widget.cards.length],
            );
          },
        ),
      ),
    );
  }
}
