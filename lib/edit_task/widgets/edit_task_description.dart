import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class DescriptionTextEditor extends StatefulWidget {
  const DescriptionTextEditor({required QuillController controller, super.key})
      : _controller = controller;

  final QuillController _controller;

  @override
  State<DescriptionTextEditor> createState() => _DescriptionTextEditorState();
}

class _DescriptionTextEditorState extends State<DescriptionTextEditor> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget._controller;

    return Expanded(
      child: SizedBox(
        height: 500,
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: _isFocused ? 96 : 0,
              child: Column(
                children: [
                  Container(
                    height: 38,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    child: ListView(
                      // padding: const EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.horizontal,
                      children: [
                        QuillToolbarHistoryButton(
                          isUndo: true,
                          // options: conf.buttonOptions.undoHistory,
                          controller: controller,
                          options: const QuillToolbarHistoryButtonOptions(
                            iconSize: 10,
                          ),
                        ),
                        QuillToolbarHistoryButton(
                          isUndo: false,
                          // options: conf.buttonOptions.undoHistory,
                          controller: controller,
                          options: const QuillToolbarHistoryButtonOptions(
                            iconSize: 10,
                          ),
                        ),
                        QuillToolbarFontSizeButton(
                          controller: controller,
                          options: const QuillToolbarFontSizeButtonOptions(
                            iconSize: 10,
                          ),
                        ),
                        QuillToolbarToggleStyleButton(
                          attribute: Attribute.bold,
                          controller: controller,
                          options: const QuillToolbarToggleStyleButtonOptions(
                            iconSize: 10,
                          ),
                        ),
                        QuillToolbarToggleStyleButton(
                          attribute: Attribute.italic,
                          controller: controller,
                          options: const QuillToolbarToggleStyleButtonOptions(
                            iconSize: 10,
                          ),
                        ),
                        QuillToolbarClearFormatButton(
                          controller: controller,
                          options: const QuillToolbarBaseButtonOptions(
                            iconSize: 10,
                          ),
                        ),
                        QuillToolbarToggleCheckListButton(
                          controller: controller,
                          options:
                              const QuillToolbarToggleCheckListButtonOptions(
                            iconSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 38,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.horizontal,
                      children: [
                        QuillToolbarColorButton(
                          controller: controller,
                          isBackground: false,
                          options: const QuillToolbarColorButtonOptions(
                            iconSize: 10,
                          ),
                        ),
                        QuillToolbarColorButton(
                          controller: controller,
                          isBackground: true,
                          options: const QuillToolbarColorButtonOptions(
                            iconSize: 10,
                          ),
                        ),
                        QuillToolbarSelectHeaderStyleDropdownButton(
                          controller: controller,
                          options:
                              // ignore: lines_longer_than_80_chars
                              const QuillToolbarSelectHeaderStyleDropdownButtonOptions(
                            iconSize: 10,
                          ),
                        ),
                        QuillToolbarToggleStyleButton(
                          attribute: Attribute.ol,
                          controller: controller,
                          options: const QuillToolbarToggleStyleButtonOptions(
                            iconSize: 10,
                          ),
                        ),
                        QuillToolbarToggleStyleButton(
                          attribute: Attribute.ul,
                          controller: controller,
                          options: const QuillToolbarToggleStyleButtonOptions(
                            iconSize: 10,
                          ),
                        ),
                        QuillToolbarIndentButton(
                          controller: controller,
                          isIncrease: true,
                          options: const QuillToolbarIndentButtonOptions(
                            iconSize: 10,
                          ),
                        ),
                        QuillToolbarIndentButton(
                          controller: controller,
                          isIncrease: false,
                          options: const QuillToolbarIndentButtonOptions(
                            iconSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: QuillEditor.basic(
                  focusNode: _focusNode,
                  controller: controller,
                  configurations: const QuillEditorConfigurations(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
