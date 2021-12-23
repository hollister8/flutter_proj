import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AutoSearchBar extends StatefulWidget {
  const AutoSearchBar({Key? key}) : super(key: key);

  @override
  _AutoSearchBarState createState() => _AutoSearchBarState();
}

class _AutoSearchBarState extends State<AutoSearchBar> {
  late final OverlayEntry overlayEntry =
      OverlayEntry(builder: _overlayEntryBuilder);
  final GlobalKey _searchBarKey = GlobalKey();
  final LayerLink _serchBarLink = LayerLink();
  // final AutoCompleteController controller = Get.find<AutoCompleteController>();

  // @override
  // void initState() {
  //   super.initState();
  //   controller.initOverlayHandlers(
  //     inserOverlay: insertOverlay, removeOverlay: removeOverlay
  //   );
  // }

  @override
  void dispose() {
    overlayEntry.dispose();
    super.dispose();
  }

  void insert(OverlayEntry entry, {OverlayEntry? below, OverlayEntry? above}) {
    setState(() {

    });
  }

  void insertOverlay() {
    if (!overlayEntry.mounted) {
      OverlayState overlayState = Overlay.of(context)!;
      overlayEntry.insert(overlayEntry);
    }
  }

  void removeOverlay() {
    if (overlayEntry.mounted) {
      overlayEntry.remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _serchBarLink,
      // child:
      );
  }

  Widget _overlayEntryBuilder(BuildContext context) {
    Offset position = _getOverlayEntryPosition();
    Size size = _getOverlayEntrySize();

    return Positioned(
        child: CompositedTransformFollower(
          link: _serchBarLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height),
        )
    );
  }

  Offset _getOverlayEntryPosition() {
    RenderBox renderBox =
        _searchBarKey.currentContext!.findRenderObject()! as RenderBox;
    return Offset(renderBox.localToGlobal(Offset.zero).dx,
        renderBox.localToGlobal(Offset.zero).dy + renderBox.size.height
    );
  }

  Size _getOverlayEntrySize() {
    RenderBox renderBox =
    _searchBarKey.currentContext!.findRenderObject()! as RenderBox;
    return renderBox.size;
  }


}
