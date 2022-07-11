import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final ValueChanged<String>? onChnaged;
  final List<String> listFilter;
  const CustomDropDown({
    Key? key,
    this.onChnaged,
    this.listFilter = const [],
  }) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  bool showdrop = false;
  final getBoxKey = GlobalKey();

  ///
  String data = '';

  ///overlay
  OverlayState? overlayState;
  OverlayEntry? overlayEntry;
  void showOverlay(BuildContext context1, GlobalKey getkey, int getIndex,
      Function onCancel) async {
    ///
    var newKey = getkey;
    overlayState = Overlay.of(context1);
    var positionval = newKey.currentContext!.findRenderObject() as RenderBox;
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              overlayEntry!.remove();
              onCancel();
            },
            child: Container(
              color: Colors.transparent,
              child: Stack(
                children: [
                  ///Tooltips
                  Positioned(
                    top: positionval.localToGlobal(Offset.zero).dy + 60,
                    left: positionval.localToGlobal(Offset.zero).dx,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 150,
                        height: 250,
                        // padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          color: Colors.yellow,
                        ),
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const Divider(height: 0),
                          itemCount: widget.listFilter.length,
                          itemBuilder: (context, index) => ListTile(
                              onTap: () {
                                if (widget.onChnaged != null) {
                                  widget.onChnaged!(widget.listFilter[index]);
                                }
                                data = widget.listFilter[index];
                                overlayEntry!.remove();
                                onCancel();
                                setState(() {});
                              },
                              title: Text(widget.listFilter[index])),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
    overlayState!.insert(overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showdrop = !showdrop;
        if (showdrop) {
          showOverlay(context, getBoxKey, 0, () {
            debugPrint('Cancel');
            showdrop = !showdrop;
            setState(() {});
          });
        }
        setState(() {});
      },
      child: Container(
        key: getBoxKey,
        // height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Text(data),
            const Spacer(),
            !showdrop
                ? const Icon(Icons.keyboard_arrow_down_rounded)
                : const Icon(Icons.keyboard_arrow_up_rounded)
          ],
        ),
      ),
    );
  }
}
