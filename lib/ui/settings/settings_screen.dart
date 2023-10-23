import 'package:best_friend/core/device_utils.dart';
import 'package:best_friend/core/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget itemEndWidget = SvgPicture.asset('assets/svg/ArrowUpRight.svg');
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: ThemeUtils.settingsBack,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Container(
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                    color: ThemeUtils.modalHang,
                    borderRadius: BorderRadius.circular(2)),
              ),
              const SizedBox(
                height: 48,
              ),
              SettingsItem(
                  title: 'Help',
                  svgPath: 'assets/svg/Info.svg',
                  itemEndWidget: itemEndWidget),
              const SettingsItemSeperator(),
              SettingsItem(
                  title: 'Rate Us',
                  svgPath: 'assets/svg/Star.svg',
                  itemEndWidget: itemEndWidget),
              const SettingsItemSeperator(),
              SettingsItem(
                  title: 'Share with Friends',
                  svgPath: 'assets/svg/Export.svg',
                  itemEndWidget: itemEndWidget),
              const SettingsItemSeperator(),
              SettingsItem(
                  title: 'Terms of Use',
                  svgPath: 'assets/svg/Scroll.svg',
                  itemEndWidget: itemEndWidget),
              const SettingsItemSeperator(),
              SettingsItem(
                  title: 'Privacy Policy',
                  svgPath: 'assets/svg/ShieldCheck.svg',
                  itemEndWidget: itemEndWidget),
              const SettingsItemSeperator(),
              SettingsItem(
                  title: 'OS Version',
                  svgPath: 'assets/svg/GitBranch.svg',
                  itemEndWidget: Text(
                    'v${DeviceUtils.version} - ${DeviceUtils.buildNumber}',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: ThemeUtils.labelLight),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.svgPath,
    required this.itemEndWidget,
    required this.title,
  });

  final String svgPath;
  final String title;
  final Widget itemEndWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Row(
        children: [
          SvgPicture.asset(svgPath),
          const SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          itemEndWidget
        ],
      ),
    );
  }
}

class SettingsItemSeperator extends StatelessWidget {
  const SettingsItemSeperator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
      child: Container(
        height: 2,
        width: double.maxFinite,
        color: ThemeUtils.modalHang,
      ),
    );
  }
}
