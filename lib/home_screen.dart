import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  OverlayEntry? entry;
  final layerLink = LayerLink();
  String? selectCategory = 'Demo Dropdown';

  List<String> requestItems = ['One', 'Two', 'Three', 'Four', 'Five'];

  showOverlay() {
    final overlay = Overlay.of(context)!;
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size / 2;

    print('size render box is width ${size.width}');
    print('size render box is height ${size.height}');
    print('size offset is height ${size.height / 10.6}');

    print('show overlay method');
    entry = OverlayEntry(
        builder: (context) => Positioned(
            // left: offset.dx,
            //   top: offset.dy + size.height + 8,
            width: 165.0,
            child: CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              //offset: Offset(-10, 33),
              offset: Offset(-10, (size.height / 10.6)),
              child: Material(
                child: Container(
                    width: 280.0,
                    height: 205,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1.0,
                        color: const Color(0xFFCBCBCB),
                      ),
                    ),
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: requestItems.length,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.5),
                          child: InkWell(
                              onTap: () {
                                Future.delayed(Duration.zero, () {
                                  setState(() {
                                    selectCategory = requestItems[index];
                                    hideOverlay();
                                  });
                                });
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${requestItems[index]}',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: const Color(0xFF464646),
                                  ),
                                ),
                              )),
                        );
                      },
                      separatorBuilder: (_, __) {
                        return Divider(
                          color: Colors.grey,
                        );
                      },
                    )),
              ),
            )));

    overlay.insert(entry!);
  }

  hideOverlay() {
    print('Hide method');
    entry?.remove();
    entry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Overlay Widget'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: 158.0,
            height: 34.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.white,
              border: Border.all(
                width: 1.0,
                color: const Color(0xFFCBCBCB),
              ),
            ),
            child: CompositedTransformTarget(
                link: layerLink,
                //child: Center(child: buildDropdownButton()))
                child: Center(
                    child: InkWell(
                  onTap: () => showOverlay(),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          '$selectCategory',
                          style: TextStyle(
                              color: Color(0XFF262626),
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.arrow_drop_down)))
                    ],
                  ),
                )))),
      ),
    );
  }
}
