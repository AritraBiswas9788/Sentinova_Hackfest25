import 'package:flutter/material.dart';

class ExpandableTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final double minHeight;
  final double maxHeight;
  final String? Function(String?)? validator;

  const ExpandableTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.minHeight = 120,
    this.maxHeight = 600.0,
    this.validator,
  });

  @override
  ExpandableTextFieldState createState() => ExpandableTextFieldState();
}

class ExpandableTextFieldState extends State<ExpandableTextField> {
  double _currentHeight = 100;
  int _wordCount = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _currentHeight = widget.minHeight;
    widget.controller.addListener(_updateHeightAndCount);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateHeightAndCount);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateHeightAndCount() {
    final text = widget.controller.text;
    const lineHeight = 22.0;
    final lineCount = '\n'.allMatches(text).length + 1;
    final newHeight =
        (lineCount * lineHeight).clamp(widget.minHeight, widget.maxHeight);

    setState(() {
      _currentHeight = newHeight;
      _wordCount =
          text.trim().isEmpty ? 0 : text.trim().split(RegExp(r'\s+')).length;
      print(_currentHeight);
      print(_wordCount);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      constraints: BoxConstraints(
        minHeight: widget.minHeight,
        maxHeight: widget.maxHeight,
      ),
      height: _currentHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 1.2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Stack(
        children: [
          Scrollbar(
            thumbVisibility: true,
            controller: _scrollController,
            radius: const Radius.circular(8),
            interactive: true,
            child: TextFormField(
              controller: widget.controller,
              validator: widget.validator,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              expands: true,
              scrollController: _scrollController,
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              onChanged: (text){
                _updateHeightAndCount();
              },
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(bottom: 40, top: 4),
              ),
            ),
          ),
          Positioned(
            bottom: 4,
            left: 0,
            right: 0,
            child: Row(
              children: [
                Text(
                  '$_wordCount words',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
    // Add your send logic here
                    widget.controller.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("✅ Feedback submitted successfully!"),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.green.shade600,
                        duration: Duration(seconds: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    );
                  },
                  icon: const Icon(Icons.send, color: Colors.white),
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
