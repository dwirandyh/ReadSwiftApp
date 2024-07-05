import 'package:flutter/material.dart';

class ThemeSelectionView extends StatefulWidget {
  final String selectedTheme;
  final Function(String) onThemeSelected;

  const ThemeSelectionView({
    Key? key,
    required this.selectedTheme,
    required this.onThemeSelected,
  }) : super(key: key);

  @override
  State<ThemeSelectionView> createState() => _ThemeSelectionViewState();
}

class _ThemeSelectionViewState extends State<ThemeSelectionView> {
  late String _selectedTheme;

  @override
  void initState() {
    super.initState();

    _selectedTheme = widget.selectedTheme;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Select Theme",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              RadioListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                title: const Text("Light"),
                value: "Light",
                groupValue: _selectedTheme,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedTheme = value;
                    });
                    widget.onThemeSelected(value);
                  }
                },
              ),
              RadioListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                title: const Text("Dark"),
                value: "Dark",
                groupValue: _selectedTheme,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedTheme = value;
                    });
                    widget.onThemeSelected(value);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
