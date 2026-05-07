import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/service/url_launcher.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_assets.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/shared/view/widgets/section_header.dart';

typedef _ContactUsTile  = ({String title ,Color? color, IconData? icon , GestureTapCallback? onTap});
typedef _SocialMediaTile  = ({String title ,Color? color,Gradient? gradient ,String path, SocialMediaPlatform platform, String? userName});

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  late List<_ContactUsTile> _contactUsData;
  late List<_SocialMediaTile> _socialMediaData;
  @override
  void initState() {
    super.initState();
    _contactUsData = [
      (title: "call us", color: AppColors.primary, icon: MvIcons.call, onTap: ()async{
        await UrlLauncherService.instance.launchPhoneCall(AppConstants.supportPhoneNumber) ;
      }),
      (title: "mail", color: AppColors.primary, icon: MvIcons.email, onTap: ()async{
        await UrlLauncherService.instance.launchEmail(AppConstants.supportEmail) ;
      }),
    ];
    _socialMediaData =[
      (title: "facebook", color: const Color(0xff0866FF), path: AppAssets.facebookIcon, platform: SocialMediaPlatform.facebook, userName: AppConstants.supportFacebook,gradient: null),
      (title: "instagram", color: AppColors.primary, path: AppAssets.instagramIcon, platform: SocialMediaPlatform.instagram, userName: AppConstants.supportInstagram, gradient: const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0xFFFCAF45), // Yellow
          Color(0xFFF77737), // Orange
          Color(0xFFE1306C), // Pink
          Color(0xFFC13584), // Purple
          Color(0xFF833AB4), // Dark Purple
        ],
        stops: [0.0, 0.25, 0.5, 0.75, 1.0],
      ),),
      (title: "whatsapp", color: const Color(0xff3EE85D), path: AppAssets.whatsappIcon, platform: SocialMediaPlatform.whatsapp, userName: AppConstants.supportWhatsApp,gradient: null),
      (title: "tiktok", color: AppColors.black, path: AppAssets.tikTokIcon, platform: SocialMediaPlatform.tiktok, userName: AppConstants.supportTikTok, gradient: null),

    ] ;
  }
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: "Contact Us",),
      body: SingleChildScrollView(
        child: Column(
          spacing: 4.h,
          children: [
            SvgPicture.asset(AppAssets.contactUsIllustration, height: 180.h,),
            Text("We’re always happy to help! If you have any questions or issues, feel free to contact us anytime. Our support team is available 24/7 to assist you and make sure you have the best experience possible.",

            style: TextStyles.bodySmall.copyWith(color: context.colors.surfaceContainer),),
            const SectionHeader(title: "reach us "),
           Row(
             spacing: 4.w,
             children: _contactUsData.map((e) => Expanded(child: _contactUsTile(e))).toList(),
           ),
            Gap.small(),
            const SectionHeader(title: "Social Media"),
           ..._socialMediaData.where((e)=>e.userName!=null).toList().map((e)=>_socialMediaTile(e)),



          ],
        ),
      ),
    );
  }

  Widget _contactUsTile(_ContactUsTile tile)=>AppClick(
    onTap: tile.onTap,
    child: Container(
      decoration: BoxDecoration(
        color: tile.color,
        borderRadius: BorderRadius.circular(Decorations.borderRadius8.r),
      ),
      padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8.w,
        children: [
          if(tile.icon != null)
          Icon(tile.icon,size: 24.sp ,color: Colors.white),
          Text(tile.title, style: TextStyles.labelMedium.copyWith(color: AppColors.white),),
          const Spacer(),
        ],
      ),

    ),
  );
  Widget _socialMediaTile(_SocialMediaTile tile)=>AppClick(
    onTap: ()async{
      await UrlLauncherService.instance.launchSocialMedia(tile.platform, tile.userName!);
    },
    child: Container(
      decoration: BoxDecoration(
        color: tile.color,
        gradient: tile.gradient,
        borderRadius: BorderRadius.circular(Decorations.borderRadius8.r),
      ),
      padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        spacing: 8.w,
        children: [
          SvgPicture.asset(tile.path, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),),
          Text(tile.title, style: TextStyles.labelMedium.copyWith(color: AppColors.white),),
          const Spacer(),
          Icon(MvIcons.arrowForward,size: 20.sp ,color: Colors.white),
        ],
      ),

    ),
  );
}
