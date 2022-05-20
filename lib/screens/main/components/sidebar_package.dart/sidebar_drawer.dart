library flutter_sidebar;

import 'dart:math' show min;

import 'package:admin/screens/main/components/sidebar_package.dart/sidebar_drawer_expansion_tile.dart';
import 'package:flutter/material.dart';

import '../../../dashboard/components/header.dart';

class Sidebar extends StatefulWidget {
  final List<Map<String, dynamic>> tabs;
  final void Function(String) onTabChanged;
  final List<int>? activeTabIndices;

  // const Sidebar({
  //   Key key,
  //   @required this.tabs,
  //   this.onTabChanged,
  //   this.activeTabIndices,
  // }) : super(key: key);

  const Sidebar.fromJson({
    Key? key,
    required this.tabs,
    required this.onTabChanged,
    this.activeTabIndices,
  }) : super(key: key);

  @override
  _SidebarState createState() => _SidebarState();
}

class SidebarItem extends StatelessWidget {
  final Map<String, dynamic> data;
  final void Function(String) onTabChanged;
  final List<int> activeTabIndices;
  final void Function(List<int> newIndices) setActiveTabIndices;
  final int? index;
  final List<int> indices;

  SidebarItem(
    this.data,
    this.onTabChanged,
    this.activeTabIndices,
    this.setActiveTabIndices, {
    this.index,
    required this.indices,
  }) : assert(
          (index.toString().isNotEmpty) || (indices.toString().isNotEmpty),
          'Exactly one parameter out of [index, indices] has to be provided',
        );

  @override
  Widget build(BuildContext context) {
    return _buildTiles(data);
  }

  Widget _buildTiles(Map<String, dynamic> root) {
    final _indices = indices;
    if (root['children'] == null)
      return ListTile(
        selected: _indicesMatch(_indices, activeTabIndices),
        contentPadding:
            EdgeInsets.only(left: 16.0 + 20.0 * (_indices.length - 1)),
        leading: Image.network(
          root['icon'],
          width: 32,
        ),
        title: Text(root['title']),
        onTap: () {
          setActiveTabIndices(_indices);
          onTabChanged(root['navigation'] ?? root['']);
        },
      );

    List<Widget> children = [];
    for (int i = 0; i < root['children'].length; i++) {
      Map<String, dynamic> item = root['children'][i];
      List<int> itemIndices = [..._indices, i];
      children.add(
        SidebarItem(
          item,
          onTabChanged,
          activeTabIndices,
          setActiveTabIndices,
          indices: itemIndices,
        ),
      );
    }

    return CustomExpansionTile(
      tilePadding: EdgeInsets.only(
        left: 16.0 + 20.0 * (_indices.length - 1),
        right: 12.0,
      ),
      selected: _indicesMatch(_indices, activeTabIndices),
      title: Text(root['title']),
      leading: Image.network(
        root['icon'],
        width: 32,
      ),
      children: children,
    );
  }

  bool _indicesMatch(List<int> a, List<int> b) {
    for (int i = 0; i < min(a.length, b.length); i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

class _SidebarState extends State<Sidebar> with SingleTickerProviderStateMixin {
  static const double _maxSidebarWidth = 300;
  double _sidebarWidth = _maxSidebarWidth;
  List<int> activeTabIndices = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      width: _sidebarWidth,
      child: Column(
        children: [
          DrawerHeader(
            child: ProfileCard(),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SidebarItem(
                  widget.tabs[index],
                  widget.onTabChanged,
                  activeTabIndices,
                  setActiveTabIndices,
                  index: index,
                  indices: [],
                ),
              ),
              itemCount: widget.tabs.length,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mediaQuery = MediaQuery.of(context);
    _sidebarWidth = min(mediaQuery.size.width * 0.7, _maxSidebarWidth);
  }

  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      if (activeTabIndices.isEmpty) {
        List<int> newActiveTabData = _getFirstTabIndex(widget.tabs, []);
        List<int> newActiveTabIndices = [];
        newActiveTabIndices.add(newActiveTabData.first);
        String tabId = newActiveTabData[1].toString();
        if (newActiveTabIndices.length > 0) {
          setActiveTabIndices(newActiveTabIndices);
          widget.onTabChanged(tabId);
        }
      }
    });
  }

  void setActiveTabIndices(List<int> newIndices) {
    setState(() {
      activeTabIndices = newIndices;
    });
  }

  List<int> _getFirstTabIndex(
      List<Map<String, dynamic>> tabs, List<int> indices) {
    String tabId = "";
    if (tabs.length > 0) {
      Map<String, dynamic> firstTab = tabs[0];
      tabId = firstTab['id'] ?? firstTab['title'];
      indices.clear();
      indices.add(0);

      if (firstTab['children'] != null) {
        final tabData = _getFirstTabIndex(firstTab['children'], indices);
        indices.clear();
        indices.add(tabData.first);
        tabId = tabData[1].toString();
      }
    }
    return [indices.first, int.parse(tabId)];
  }
}
