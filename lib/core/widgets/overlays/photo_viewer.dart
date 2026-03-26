// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:elmazraa/core/theme/app_theme.dart';
// import 'package:elmazraa/core/widgets/scaffold/custom_scaffold.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:photo_view/photo_view.dart' as pv;
// import 'package:photo_view/photo_view_gallery.dart' as pvg;
//
// abstract class PhotoViewerArgs {
//   final String? title;
//   PhotoViewerArgs({this.title});
// }
//
// class PhotoViewerSingle extends PhotoViewerArgs {
//   final String image;
//   PhotoViewerSingle({required this.image, super.title});
// }
//
// class PhotoViewerMultiple extends PhotoViewerArgs {
//   final List<String> images;
//   final int? activeIndex;
//   PhotoViewerMultiple({required this.images, this.activeIndex, super.title});
// }
//
// class PhotoViewer extends StatefulWidget {
//   final PhotoViewerArgs args;
//   const PhotoViewer({super.key, required this.args});
//
//   @override
//   State<PhotoViewer> createState() => _PhotoViewerState();
// }
//
// class _PhotoViewerState extends State<PhotoViewer> {
//   late int _currentIndex;
//   late PageController _pageController;
//
//   static const _bgDecoration = BoxDecoration(color: Colors.transparent);
//
//   Widget _loading() =>
//       const Center(child: CircularProgressIndicator(color: Colors.white));
//
//   Widget _error() =>
//       const Center(child: Icon(Icons.broken_image, color: Colors.white, size: 48));
//
//   pvg.PhotoViewGalleryPageOptions _pageOption(String image) {
//     return pvg.PhotoViewGalleryPageOptions(
//       imageProvider: CachedNetworkImageProvider(image),
//       minScale: pv.PhotoViewComputedScale.contained,
//       maxScale: pv.PhotoViewComputedScale.covered * 3,
//       errorBuilder: (_, __, ___) => _error(),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.args is PhotoViewerMultiple
//         ? (widget.args as PhotoViewerMultiple).activeIndex ?? 0
//         : 0;
//     _pageController = PageController(initialPage: _currentIndex);
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isMultiple = widget.args is PhotoViewerMultiple;
//     final images = isMultiple
//         ? (widget.args as PhotoViewerMultiple).images
//         : [(widget.args as PhotoViewerSingle).image];
//
//     return Theme(
//       data: AppTheme.dark,
//       child: BaseScaffold(
//         title: widget.args.title ?? "",
//         padding: 0,
//         body: isMultiple ? _buildGallery(images) : _buildSingle(images.first),
//       ),
//     );
//   }
//
//   Widget _buildSingle(String image) {
//     return pv.PhotoView(
//       imageProvider: CachedNetworkImageProvider(image),
//       minScale: pv.PhotoViewComputedScale.contained,
//       maxScale: pv.PhotoViewComputedScale.covered * 3,
//       backgroundDecoration: _bgDecoration,
//       loadingBuilder: (_, __) => _loading(),
//       errorBuilder: (_, __, ___) => _error(),
//     );
//   }
//
//   Widget _buildGallery(List<String> images) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         pvg.PhotoViewGallery.builder(
//           pageController: _pageController,
//           scrollPhysics: const BouncingScrollPhysics(),
//           itemCount: images.length,
//           onPageChanged: (index) => setState(() => _currentIndex = index),
//           backgroundDecoration: _bgDecoration,
//           builder: (_, index) => _pageOption(images[index]),
//           loadingBuilder: (_, __) => _loading(),
//         ),
//         Positioned(
//           left: 8,
//           child: _ArrowButton(
//             icon: Icons.arrow_forward_ios,
//             visible: _currentIndex > 0,
//             onTap: () => _pageController.previousPage(
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//             ),
//           ),
//         ),
//         Positioned(
//           right: 8,
//           child: _ArrowButton(
//             icon: Icons.arrow_back_ios_new,
//             visible: _currentIndex < images.length - 1,
//             onTap: () => _pageController.nextPage(
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 24.h,
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: List.generate(
//               images.length,
//                   (i) => AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 margin: const EdgeInsets.symmetric(horizontal: 3),
//                 width: _currentIndex == i ? 16 : 6,
//                 height: 6,
//                 decoration: BoxDecoration(
//                   color: _currentIndex == i ? Colors.white : Colors.white38,
//                   borderRadius: BorderRadius.circular(3),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _ArrowButton extends StatelessWidget {
//   final IconData icon;
//   final bool visible;
//   final VoidCallback onTap;
//
//   const _ArrowButton({
//     required this.icon,
//     required this.visible,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedOpacity(
//       opacity: visible ? 1 : 0,
//       duration: const Duration(milliseconds: 200),
//       child: GestureDetector(
//         onTap: visible ? onTap : null,
//         child: Container(
//           padding: const EdgeInsets.all(8),
//           decoration: const BoxDecoration(
//             color: Colors.black45,
//             shape: BoxShape.circle,
//           ),
//           child: Icon(icon, color: Colors.white, size: 28),
//         ),
//       ),
//     );
//   }
// }
