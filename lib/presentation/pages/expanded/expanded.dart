import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/list_extension.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../core/services/screen_size_service.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import 'cubit/expanded_cubit.dart';

class ExpandedWrapperProvider extends StatelessWidget {
  const ExpandedWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ExpandedCubit>(),
      child: const ExpandedPage(title: "Expanded Panel"),
    );
  }
}

class ExpandedPage extends StatefulWidget {
  const ExpandedPage({super.key, required this.title});
  final String title;

  @override
  State<ExpandedPage> createState() => _ExpandedPageState();
}

class _ExpandedPageState extends State<ExpandedPage> {

  static const String termsString = "Terms Panel";

  static const String agreementString = "Agreement Panel";

  List<Map<String, dynamic>> termsPanel = [
    {
      "title": "Terms of Service",
      "isExpanded": false,
      "content": "<h2>Terms of Service</h2><img src=\"https://lelogama.go-jek.com/post_featured_image/General-IBSCPP-PayDayMar-2022.jpg\" alt=\"Image\"><p>By using this website, you agree to comply with and be bound by the following <strong>terms of service</strong>. These terms govern your access to and use of the services provided by our website. They include important provisions related to your rights and responsibilities when using our platform, as well as limitations on our liability. Please read these terms carefully before using our services. By accessing or using the website, you indicate your acknowledgment and acceptance of these terms.</p><p>We reserve the right to modify, suspend, or discontinue the website or any part thereof at any time without notice. We will not be liable to you or to any third party for any modification, suspension, or discontinuance of the website.</p>"
    },
    {
      "title": "Website Terms",
      "isExpanded": false,
      "content": "<h2>Website Terms</h2><img src=\"https://lelogama.go-jek.com/post_featured_image/header_blog_promo_game_and_entertainment.jpg\" alt=\"Image\"><p>Access to and use of this website is conditioned on your acceptance of and compliance with these <a href=\"https://lelogama.go-jek.com/post_featured_image/header_blog_promo_game_and_entertainment.jpg\">website terms</a>. These terms govern your use of our website, including browsing, interaction, and content consumption. They outline our policies regarding user conduct, privacy, and intellectual property rights. By accessing or using our website, you agree to abide by these terms and conditions.</p><p>We reserve the right to modify, suspend, or discontinue the website or any part thereof at any time without notice. We will not be liable to you or to any third party for any modification, suspension, or discontinuance of the website.</p>"
    },
    {
      "title": "Terms of Use",
      "isExpanded": false,
      "content": "<h2>Terms of Use</h2><img src=\"https://lelogama.go-jek.com/post_featured_image/Blog_Discover.png\" alt=\"Image\"><p>By accessing or using this website, you agree to be bound by the <em>terms of use</em>, including any additional terms and conditions referenced herein or available by hyperlink. These terms govern your use of our website and constitute a legally binding agreement between you and us. They cover various aspects such as user rights, responsibilities, and limitations on liability. Please read these terms carefully before using our website. By accessing or using the website, you indicate your acknowledgment and acceptance of these terms.</p><p>We reserve the right to modify, update, or discontinue the website or any part thereof at any time without notice. We will not be liable to you or to any third party for any modification, update, or discontinuance of the website.</p>"
    },
  ];

  List<Map<String, dynamic>> agreementPanel = [
    {
      "title": "User Agreement",
      "isExpanded": false,
      "content": "<h2>User Agreement</h2><img src=\"https://lelogama.go-jek.com/post_featured_image/Blog_Sambungin.jpg\" alt=\"Image\"><p>Your use of this service is subject to acceptance of the <em>user agreement</em>. This agreement outlines the terms and conditions under which you may access and use our platform. It covers various aspects such as user conduct, content usage rights, and dispute resolution mechanisms. By accessing or using our service, you acknowledge that you have read, understood, and agree to be bound by the terms of this agreement.</p><p>The user agreement may be modified or updated by us from time to time without notice. It is your responsibility to review this agreement periodically for changes. Your continued use of the service after the posting of changes constitutes your binding acceptance of such changes.</p>"
    },
    {
      "title": "Usage Policy",
      "isExpanded": false,
      "content": "<h2>Usage Policy</h2><img src=\"https://lelogama.go-jek.com/post_featured_image/header_blog_transaksi-goride-gocar-100_goclub_xp.jpg\" alt=\"Image\"><p>Please review the following <strong>usage policy</strong> carefully. Your use of this service indicates your agreement to be bound by this policy. This policy governs the acceptable use of our platform and sets forth guidelines for user conduct, content submission, and community interaction. It also outlines the consequences of violating these guidelines. By using our service, you agree to comply with this usage policy.</p><p>We may, at our discretion, terminate or suspend access to our service immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the terms.</p>"
    },
    {
      "title": "Privacy Policy",
      "isExpanded": false,
      "content": "<h2>Privacy Policy</h2><img src=\"https://lelogama.go-jek.com/post_featured_image/gopromo-ads-solutions-en-banner.jpg\" alt=\"Image\"><p>Our privacy policy outlines how we collect, use, disclose, and manage your personal information when you use our services. It also explains your rights and choices regarding your information. By using our services, you agree to the terms of our privacy policy.</p><p>We may update our privacy policy from time to time. It is your responsibility to review the privacy policy periodically for changes. Your continued use of our services after the changes are made constitutes your acceptance of the updated privacy policy.</p>"
    },
    {
      "title": "Cookie Policy",
      "isExpanded": false,
      "content": "<h2>Cookie Policy</h2><img src=\"https://lelogama.go-jek.com/post_featured_image/Tartibjek_Blog_Banner_2.jpg\" alt=\"Image\"><p>Our cookie policy explains how we use cookies and similar tracking technologies on our website. It describes the types of cookies we use, the purposes for which we use them, and your choices regarding cookies. By using our website, you consent to the use of cookies in accordance with our cookie policy.</p><p>We may update our cookie policy from time to time. Any changes to the cookie policy will be posted on our website. By continuing to use our website after the changes are posted, you agree to the updated cookie policy.</p>"
    },
    {
      "title": "Service Agreement",
      "isExpanded": false,
      "content": "<h2>Service Agreement</h2><img src=\"https://lelogama.go-jek.com/post_featured_image/header_promo_jago_gopay.jpg\" alt=\"Image\"><p>Your use of this website constitutes acceptance of the <a href=\"https://lelogama.go-jek.com/post_featured_image/header_blog_promo_game_and_entertainment.jpg\">service agreement</a>, as well as our privacy policy. The service agreement outlines the terms and conditions under which we provide our services to you. It includes provisions related to account registration, payment terms, and service limitations. By using our website, you agree to be bound by the terms of this agreement and our privacy policy.</p><p>We reserve the right to modify, suspend, or terminate the service or any part thereof at any time without notice. We will not be liable to you or to any third party for any modification, suspension, or termination of the service.</p>"
    },
  ];

  String currentPanelName = "";

  List<Map<String, dynamic>> currentPanel = [];

  @override
  void initState() {
    currentPanelName = termsString;
    onChangePanel(currentPanelName);
    super.initState();
  }

  void onChangePanel (String item) {
    switch(item) {
      case termsString: {
        setState(() {
          currentPanelName = item;
          currentPanel = termsPanel;
        });
      }
      case agreementString: {
        setState(() {
          currentPanelName = item;
          currentPanel = agreementPanel;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var ss = sl<ScreenSizeService>()..init(context);
    return Consumer2<ThemeService, LanguageService> (
        builder: (context, ThemeService themeService, LanguageService languageService, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
            ),
            body: Container(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                clipBehavior: Clip.none,
                children: [
                  const Text(
                    "Select Panel",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 8),
                  PopupMenuButton<String>(
                    popUpAnimationStyle: AnimationStyle.noAnimation,
                    offset: const Offset(0, 65),
                    constraints: BoxConstraints(
                      minWidth: ss.screenSize.width - 32,
                    ),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(16.0)
                        ),
                        side: BorderSide(color: Colors.grey)
                    ),
                    surfaceTintColor: Theme.of(context).colorScheme.background,
                    onSelected: onChangePanel,
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem<String>(
                        value: termsString,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListTile(
                              title: const Text(
                                termsString,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal
                                ),
                              ),
                              trailing: currentPanelName == termsString ? Icon(
                                Icons.check_circle,
                                color: Theme.of(context).colorScheme.inversePrimary,
                              ) : null
                          ),
                        )
                      ),
                      const PopupMenuDivider(),
                      PopupMenuItem<String>(
                        value: agreementString,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListTile(
                              title: const Text(
                                agreementString,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal
                                ),
                              ),
                              trailing: currentPanelName == agreementString ? Icon(
                                Icons.check_circle,
                                color: Theme.of(context).colorScheme.inversePrimary,
                              ) : null
                          ),
                        )
                      )
                    ],
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: ListTile(
                            title: Text(currentPanelName),
                            trailing: const Icon(Icons.arrow_forward_outlined)
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    currentPanelName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: ExpansionPanelList(
                            dividerColor: Colors.grey,
                            elevation: 0,
                            expandedHeaderPadding: EdgeInsets.zero,
                            expansionCallback: (int index, bool isExpanded) {
                              setState(() {
                                currentPanel[index]['isExpanded'] = isExpanded;
                              });
                            },
                            materialGapSize: 0,
                            children: currentPanel.mapIndexed((index, item) {
                              return ExpansionPanel(
                                canTapOnHeader: true,
                                headerBuilder: (BuildContext context, bool isExpanded) {
                                  return ListTile(
                                    title: Text(item['title']),
                                  );
                                },
                                body: ListTile(
                                  subtitle: Html(
                                    data: item['content'],
                                  ),
                                  tileColor: Theme.of(context).hoverColor,
                                ),
                                isExpanded: item['isExpanded'],
                              );
                            }).toList()
                        )
                    ),
                  ),
                ],
              )
            )
          );
        }
    );
  }

}