import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../widgets/about_us_card.dart';
import 'package:efficacy_admin/utils/divider.dart';

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

  PanelWidget(
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

  List<Map<String, String>> data = [
    {
      "name": "Biju",
      "position": "Developer",
      "branch": "EE",
      "imgUrl": "",
      "fbUrl": "",
      "linkedInUrl": ""
    },
    {
      "name": "Biju",
      "position": "Mentor",
      "branch": "CSE",
      "imgUrl": "",
      "fbUrl": "",
      "linkedInUrl": ""
    },
    {
      "name": "Biju",
      "position": "UI/UX",
      "branch": "ECE",
      "imgUrl": "",
      "fbUrl": "",
      "linkedInUrl": ""
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      controller: controller,
      children: <Widget>[
        const SizedBox(height: 8),
        PanelDivider(),
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
          'GDSC NITS develops relevant products to address real-world problems in and around our society.Solving such difficulties provides opportunity for emerging developers to display their talents while also improving and gaining new skillsets.GDSC NITS is not restricted to NITS.Our primary goal is to empower developers in North-East India while simultaneously having a national and worldwide footprint.\n\nOur GDSC is made up of Web, Android Developers, Designers and Cloud enthusiasts .We provide workshops and competitions to help disseminate the developer environment to the aspiring developers in our community.',
          style: TextStyle(
            fontSize: 14,
          ),
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
              ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Visibility(
                    visible: data[index]["position"] == "Mentor",
                    child: AboutUsCard(
                      name: data[index]["name"]!,
                      imgUrl: 'assets/default_user.png',
                      subTitle:
                          "${data[index]["position"]!}     ⦿ ${data[index]["branch"]!}",
                      fbUrl: data[index]["fbUrl"]!,
                      instaUrl: data[index]["linkedInUrl"]!,
                    ),
                  );
                },
              ),
              ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Visibility(
                    visible: data[index]["position"] == "Developer",
                    child: AboutUsCard(
                      name: data[index]["name"]!,
                      imgUrl: 'assets/default_user.png',
                      subTitle:
                          "${data[index]["position"]!}     ⦿ ${data[index]["branch"]!}",
                      fbUrl: data[index]["fbUrl"]!,
                      instaUrl: data[index]["linkedInUrl"]!,
                    ),
                  );
                },
              ),
              ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Visibility(
                    visible: data[index]["position"] == "UI/UX",
                    child: AboutUsCard(
                      name: data[index]["name"]!,
                      imgUrl: 'assets/default_user.png',
                      subTitle:
                          "${data[index]["position"]!}     ⦿ ${data[index]["branch"]!}",
                      fbUrl: data[index]["fbUrl"]!,
                      instaUrl: data[index]["linkedInUrl"]!,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
