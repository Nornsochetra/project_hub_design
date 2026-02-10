import 'package:flutter/material.dart';
import 'package:project_hub_design/viewmodels/project_view_model.dart';
import 'package:project_hub_design/widgets/card_home_screen.dart';
import 'package:project_hub_design/widgets/overview_home_screen.dart';
import 'package:provider/provider.dart';
import '../models/project.dart';
import 'package:intl/intl.dart';

class TabBarHomeScreen extends StatefulWidget {
  const TabBarHomeScreen({super.key});

  @override
  State<TabBarHomeScreen> createState() => _TabBarHomeScreenState();
}

class _TabBarHomeScreenState extends State<TabBarHomeScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask((){
      context.read<ProjectViewModel>().getAllProjects();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectVm = context.watch<ProjectViewModel>();
    final controller = DefaultTabController.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            return SizedBox(
              height: 56,
              child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                padding: const EdgeInsets.only(left: 12),
                labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                splashFactory: NoSplash.splashFactory,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                labelColor: Colors.blueAccent,
                unselectedLabelColor: Colors.grey,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  _TabWithUnderline(text: 'All Projects', selected: controller.index == 0),
                  _TabWithUnderline(text: 'Active', selected: controller.index == 1),
                  _TabWithUnderline(text: 'Pending', selected: controller.index == 2),
                  _TabWithUnderline(text: 'Completed', selected: controller.index == 3),
                ],
              ),
            );
          },
        ),

        const SizedBox(height: 12),

        //  no fixed height; fill remaining space
        Expanded(
          child: TabBarView(
            children: [
              //  Tab 1: All Projects (Overview + cards loop)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ListView.builder(
                  itemCount: projectVm.project.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          OverviewHomeScreen(
                            title: 'Record Daily Attendance',
                            dateText: DateTime(2026,10,1),
                            progress: 0.35,
                            members: const [
                              AssetImage('assets/images/oggy.jpg'),
                              AssetImage('assets/images/oggy.jpg'),
                              AssetImage('assets/images/oggy.jpg'),
                              AssetImage('assets/images/oggy.jpg'),
                            ],
                          ),
                          const SizedBox(height: 12),
                        ],
                      );
                    }

                    final project = projectVm.project[index - 1];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CardHomeScreen(
                        project: project,
                        onDelete: () => projectVm.deleteProjectById(project.id),
                      ),
                    );
                  },
                ),
              ),

              // Tab 2: Active
              _ProjectList(
                projects: projectVm.project
                    .where((p) => p.status == StatusProject.active)
                    .toList(),
              ),

              // Tab 3: Pending
              _ProjectList(
                projects: projectVm.project
                    .where((p) => p.status == StatusProject.pending)
                    .toList(),
              ),

              // Tab 4: Completed
              _ProjectList(
                projects: projectVm.project
                    .where((p) => p.status == StatusProject.completed)
                    .toList(),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _TabWithUnderline extends StatelessWidget {
  final String text;
  final bool selected;

  const _TabWithUnderline({
    required this.text,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {

    double _textWidth(BuildContext context, String text, TextStyle style) {
      final tp = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: Directionality.of(context),
      )..layout();
      return tp.size.width;
    }

    final style = DefaultTextStyle.of(context).style;
    final w = _textWidth(context, text, style);

    return Tab(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6), // was 10
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text, maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 3), // was 6
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2, // was 3
              width: selected ? (w * 1.2).clamp(18, 90) : 0,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectList extends StatelessWidget {
  final List<Project> projects;

  const _ProjectList({
    required this.projects,
  });

  @override
  Widget build(BuildContext context) {
    final projectVm = context.watch<ProjectViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final p = projects[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: CardHomeScreen(
              project: p,
              onDelete: () => projectVm.deleteProjectById(p.id),
            ),
          );
        },
      ),
    );
  }
}
