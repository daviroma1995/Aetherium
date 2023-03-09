import 'package:aetherium_salon/fragments/banner.dart';
import 'package:aetherium_salon/model/welcome_banner_list.dart';
import 'package:aetherium_salon/themes/themes.dart';
import 'package:aetherium_salon/utils/colors.dart';
import 'package:aetherium_salon/utils/spacing.dart';
import 'package:aetherium_salon/widgets/button/button.dart';
import 'package:aetherium_salon/widgets/container/container.dart';
import 'package:aetherium_salon/widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  double aspectRatio = 0.0;
  List<WelcomeBannerModel> welcomeBannerList = [
    WelcomeBannerModel("Regolamento", primaryColor, "/guidelines"),
    WelcomeBannerModel("Servizi", primaryShade001, "treatments"),
    WelcomeBannerModel("Chi siamo", primaryShade002, "about_us"),
  ];

  final offerPagesController = PageController(viewportFraction: 0.93, keepPage: true, initialPage: 1);
  final reviewPagesController = PageController(viewportFraction: 0.93, keepPage: true, initialPage: 1);
  late ThemeData theme;

  @override
  void dispose() {
    offerPagesController.dispose();
    reviewPagesController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: Spacing.nBottom(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const AppText.titleMedium("Welcome", letterSpacing: 0, fontWeight: 600),
                    Spacing.height(20),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                              return NotificationDialog();
                            },
                            fullscreenDialog: true));
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Icon(
                            MdiIcons.bellOutline,
                            color: theme.colorScheme.onBackground.withAlpha(200),
                          ),
                          Positioned(
                            right: -2,
                            top: -2,
                            child: AppContainer.rounded(
                              padding: Spacing.zero,
                              height: 14,
                              width: 14,
                              color: theme.colorScheme.primary,
                              child: Center(
                                child: AppText.labelSmall(
                                  "2",
                                  color: theme.colorScheme.onPrimary,
                                  fontSize: 9,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Spacing.height(20),
              SizedBox(
                height: 170,
                child: PageView.builder(
                  controller: offerPagesController,
                  itemCount: welcomeBannerList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, welcomeBannerList[index].pageName);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: BannerWidget(
                          title: welcomeBannerList[index].title,
                          color: welcomeBannerList[index].color,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SmoothPageIndicator(
                controller: offerPagesController,
                count: 3,
                effect: const ExpandingDotsEffect(
                  dotHeight: 7,
                  dotWidth: 8,
                  activeDotColor: Colors.black,
                  expansionFactor: 2.2,
                ),
              ),
              Spacing.height(20),
              Padding(
                padding: Spacing.x(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    AppText.bodyLarge("Prossimi appuntamenti", fontWeight: 600, letterSpacing: 0),
                    AppText.bodySmall('Tutti', fontWeight: 700, letterSpacing: 0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationDialog extends StatefulWidget {
  @override
  _NotificationDialogState createState() => _NotificationDialogState();
}

@override
State<NotificationDialog> createState() => _NotificationDialogState();

class _NotificationDialogState extends State<NotificationDialog> {
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const AppText.titleMedium("Notification", fontWeight: 600),
        actions: <Widget>[
          Container(
            margin: Spacing.right(16),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                MdiIcons.notificationClearAll,
                size: 24,
                color: theme.colorScheme.onBackground,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        padding: Spacing.all(16),
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const AppText.bodyLarge(
                "Offers",
                fontWeight: 600,
              ),
              AppContainer.rounded(
                margin: Spacing.left(8),
                width: 18,
                paddingAll: 0,
                height: 18,
                color: theme.colorScheme.primary.withAlpha(40),
                child: Center(
                    child: AppText.labelSmall(
                  "2",
                  fontWeight: 600,
                  color: theme.colorScheme.primary,
                )),
              )
            ],
          ),
          Spacing.height(24),
          singleNotification(
              image: './assets/images/apps/grocery/product-5.png',
              text: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: "50% OFF ",
                      style: AppTextStyle.labelMedium(
                          color: theme.colorScheme.primary, fontWeight: 600, letterSpacing: 0.2)),
                  TextSpan(
                    text: "in ultraboost all puma ltd shoes",
                    style: AppTextStyle.labelMedium(
                        color: theme.colorScheme.onBackground, fontWeight: 500, letterSpacing: 0.2),
                  )
                ]),
              ),
              time: "9:35 AM"),
          Spacing.height(24),
          singleNotification(
              image: './assets/images/apps/grocery/product-2.png',
              text: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: "30% OFF ",
                      style: AppTextStyle.labelMedium(
                          color: theme.colorScheme.primary, fontWeight: 600, letterSpacing: 0.2)),
                  TextSpan(
                      text: "in all cake till 31 july",
                      style: AppTextStyle.labelMedium(
                          color: theme.colorScheme.onBackground, fontWeight: 500, letterSpacing: 0.2))
                ]),
              ),
              time: "9:35 AM"),
          Spacing.height(24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const AppText.bodyLarge(
                "Orders",
                fontWeight: 600,
              ),
              AppContainer.rounded(
                margin: Spacing.left(8),
                width: 18,
                paddingAll: 0,
                height: 18,
                color: theme.colorScheme.primary.withAlpha(40),
                child: Center(
                    child: AppText.labelSmall(
                  "8",
                  fontWeight: 600,
                  color: theme.colorScheme.primary,
                )),
              )
            ],
          ),
          Spacing.height(24),
          singleNotification(
              image: './assets/images/apps/grocery/product-3.png',
              text: AppText.labelMedium("Your cake order has been delivered at Himalaya",
                  color: theme.colorScheme.onBackground, fontWeight: 500, letterSpacing: 0),
              time: "Just Now"),
          Spacing.height(24),
          singleNotification(
              image: './assets/images/apps/grocery/product-2.png',
              text: AppText.labelMedium("last order has been cancelled by seller",
                  color: theme.colorScheme.onBackground, fontWeight: 500, letterSpacing: 0),
              time: "14 July"),
          Spacing.height(24),
          Center(
            child: AppButton.text(
              splashColor: theme.colorScheme.primary.withAlpha(40),
              child: AppText.labelMedium("View all",
                  color: theme.colorScheme.primary, fontWeight: 600, letterSpacing: 0.2),
              onPressed: () {},
            ),
          ),
          Spacing.height(24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const AppText.bodyLarge(
                "Security",
                fontWeight: 600,
              ),
              AppContainer.rounded(
                margin: Spacing.left(8),
                width: 18,
                paddingAll: 0,
                height: 18,
                color: theme.colorScheme.primary.withAlpha(40),
                child: Center(
                    child: AppText.labelSmall(
                  "1",
                  fontWeight: 600,
                  color: theme.colorScheme.primary,
                )),
              )
            ],
          ),
          Spacing.height(24),
          singleNotification(
              image: './assets/images/apps/grocery/profile.png',
              text: AppText.labelMedium("Your account password has been changed",
                  color: theme.colorScheme.onBackground, fontWeight: 500, letterSpacing: 0),
              time: "2 days ago"),
        ],
      ),
    );
  }

  Widget singleNotification({required String image, Widget? text, required String time}) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AppContainer.rounded(
            width: 52,
            height: 52,
            padding: Spacing.all(10),
            color: theme.colorScheme.primary.withAlpha(40),
            child: Image.asset(image),
          ),
          Expanded(
            child: Container(margin: Spacing.horizontal(16), child: text),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              AppText.bodySmall(time, muted: true, fontWeight: 500, letterSpacing: -0.2),
            ],
          )
        ],
      ),
    );
  }
}
