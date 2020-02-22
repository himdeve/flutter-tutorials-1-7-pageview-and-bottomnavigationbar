import 'package:first_application/features/presentation/components/portfolio_sliver_app_bar.dart';
import 'package:first_application/features/presentation/pages/portfolio/portfolio_gallery_sub_page.dart';
import 'package:first_application/features/presentation/pages/portfolio/portfolio_tutorials_sub_page.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class PortfolioPage extends StatefulWidget {
  PortfolioPage({Key key}) : super(key: key);

  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final List<Tuple2> _pages = [
    Tuple2('Tutorials', PortfolioTutorialsSubPage()),
    Tuple2('Gallery', PortfolioGallerySubPage()),
  ];

  int _selectedPage = 0;

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            PortfolioSliverAppBar(_pages[_selectedPage].item1),
          ];
        },
        body: PageView(
          children: _pages.map<Widget>((Tuple2 page) => page.item2).toList(),
          onPageChanged: (index) {
            setState(() {
              _selectedPage = index;
            });
          },
          controller: _pageController,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            title: Text('Tutorials'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            title: Text('Gallery'),
          ),
        ],
        currentIndex: _selectedPage,
        onTap: (index) {
          setState(() {
            _selectedPage = index;
            _pageController.animateToPage(_selectedPage,
                duration: Duration(milliseconds: 300), curve: Curves.linear);
          });
        },
      ),
    );
  }
}
