import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../widgets/about_us_card.dart';

class AboutUsPage extends StatefulWidget {
  static const id = '/AboutUs';
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage>
    with SingleTickerProviderStateMixin {
  final panelController = PanelController();
  // final tabController = TabController(length: 3, vsync: this);
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SlidingUpPanel(
          controller: panelController,
          minHeight: MediaQuery.of(context).size.height - 250,
          maxHeight: MediaQuery.of(context).size.height,
          defaultPanelState: PanelState.CLOSED,
          body: Stack(
            children: [
              Container(
                height: 225,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/GDSC_cover.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 10,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          panelBuilder: (controller) => PanelWidget(
            controller: controller,
            panelController: panelController,
            tabController: tabController,
          ),
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(20),
            right: Radius.circular(20),
          ),
        ),
      ),
    );
  }
}

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;
  final TabController tabController;

  const PanelWidget(
      {Key? key,
      required this.controller,
      required this.panelController,
      required this.tabController})
      : super(key: key);

  void togglePanel() {
    panelController.isPanelOpen
        ? panelController.close()
        : panelController.open();
  }

  Widget buildDragHandler() => GestureDetector(
        onTap: togglePanel,
        child: Center(
          child: Container(
            width: 75,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      controller: controller,
      children: <Widget>[
        const SizedBox(height: 8),
        buildDragHandler(),
        const SizedBox(height: 20),
        const Text(
          'About Us',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF213F8D),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.''',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: null,
          child: TabBar(
            controller: tabController,
            labelColor: const Color(0xFF05354C),
            unselectedLabelColor: const Color(0xFFA4A2A7),
            tabs: const [
              Tab(text: 'Mentors'),
              Tab(text: 'Developers'),
              Tab(text: 'Designers'),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: TabBarView(
            controller: tabController,
            children: [
              ListView(
                // controller: controller,
                children: const <Widget>[
                  AboutUsCard(
                    name: 'John Doe',
                    imgUrl: 'assets/default_user.png',
                    subTitle: 'Flutter Developer     ⦿ ECE',
                    fbUrl: 'https://www.facebook.com/',
                    instaUrl: 'https://www.instagram.com/',
                  ),
                  AboutUsCard(
                    name: 'John Doe',
                    imgUrl: 'assets/default_user.png',
                    subTitle: 'Flutter Developer     ⦿ ECE',
                    fbUrl: 'https://www.facebook.com/',
                    instaUrl: 'https://www.instagram.com/',
                  ),
                  AboutUsCard(
                    name: 'John Doe',
                    imgUrl: 'assets/default_user.png',
                    subTitle: 'Flutter Developer     ⦿ ECE',
                    fbUrl: 'https://www.facebook.com/',
                    instaUrl: 'https://www.instagram.com/',
                  ),
                  AboutUsCard(
                    name: 'John Doe',
                    imgUrl: 'assets/default_user.png',
                    subTitle: 'Flutter Developer     ⦿ ECE',
                    fbUrl: 'https://www.facebook.com/',
                    instaUrl: 'https://www.instagram.com/',
                  ),
                  AboutUsCard(
                    name: 'John Doe',
                    imgUrl: 'assets/default_user.png',
                    subTitle: 'Flutter Developer     ⦿ ECE',
                    fbUrl: 'https://www.facebook.com/',
                    instaUrl: 'https://www.instagram.com/',
                  ),
                ],
              ),
              ListView(
                children: const <Widget>[
                  AboutUsCard(
                    name: 'John Doe',
                    imgUrl: 'assets/default_user.png',
                    subTitle: 'Flutter Developer     ⦿ ECE',
                    fbUrl: 'https://www.facebook.com/',
                    instaUrl: 'https://www.instagram.com/',
                  ),
                  AboutUsCard(
                    name: 'John Doe',
                    imgUrl: 'assets/default_user.png',
                    subTitle: 'Flutter Developer     ⦿ ECE',
                    fbUrl: 'https://www.facebook.com/',
                    instaUrl: 'https://www.instagram.com/',
                  ),
                  AboutUsCard(
                    name: 'John Doe',
                    imgUrl: 'assets/default_user.png',
                    subTitle: 'Flutter Developer     ⦿ ECE',
                    fbUrl: 'https://www.facebook.com/',
                    instaUrl: 'https://www.instagram.com/',
                  ),
                ],
              ),
              ListView(
                children: const <Widget>[
                  AboutUsCard(
                    name: 'John Doe',
                    imgUrl: 'assets/default_user.png',
                    subTitle: 'Flutter Developer     ⦿ ECE',
                    fbUrl: 'https://www.facebook.com/',
                    instaUrl: 'https://www.instagram.com/',
                  ),
                  AboutUsCard(
                    name: 'John Doe',
                    imgUrl: 'assets/default_user.png',
                    subTitle: 'Flutter Developer     ⦿ ECE',
                    fbUrl: 'https://www.facebook.com/',
                    instaUrl: 'https://www.instagram.com/',
                  ),
                  AboutUsCard(
                    name: 'John Doe',
                    imgUrl: 'assets/default_user.png',
                    subTitle: 'Flutter Developer     ⦿ ECE',
                    fbUrl: 'https://www.facebook.com/',
                    instaUrl: 'https://www.instagram.com/',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
