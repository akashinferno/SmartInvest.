// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'dart:io'; // Import dart:io for File

// class StockModule {
//   final String title;
//   final String description;
//   final String videoUrl;
//   bool completed;

//   StockModule({
//     required this.title,
//     required this.description,
//     required this.videoUrl,
//     this.completed = false,
//   });
// }

// class StockBasicsPage extends StatefulWidget {
//   const StockBasicsPage({super.key});

//   @override
//   State<StockBasicsPage> createState() => _StockBasicsPageState();
// }

// class _StockBasicsPageState extends State<StockBasicsPage> {
//   late List<StockModule> _modules;
//   VideoPlayerController? _videoController;
//   String? _currentlyPlayingVideoUrl;
//   int? _expandedModuleIndex;

//   @override
//   void initState() {
//     super.initState();
//     _modules = [
//       StockModule(
//         title: 'Module 1: Introduction to Stocks',
//         description:
//             'Understand what stocks represent and why companies issue them.',
//         videoUrl: 'assets/stock_intro.mp4', // Local video path
//       ),
//       StockModule(
//         title: 'Module 2: How the Stock Market Works',
//         description:
//             'Learn about stock exchanges, brokers, and mechanics of trading.',
//         videoUrl: 'assets/video2.mp4', // Local video path
//       ),
//       StockModule(
//         title: 'Module 3: Types of Stocks',
//         description:
//             'Explore common vs. preferred, growth vs. value, market caps.',
//         videoUrl: 'assets/video3.mp4', // Local video path
//       ),
//       StockModule(
//         title: 'Module 4: Basic Stock Analysis',
//         description: 'Introduction to fundamental and technical analysis.',
//         videoUrl: 'assets/video4.mp4', // Local video path
//       ),
//       StockModule(
//         title: 'Module 5: Risks and Rewards',
//         description:
//             'Understand potential risks and rewards in stock investing.',
//         videoUrl: 'assets/video5.mp4', // Local video path
//       ),
//     ];
//   }

//   @override
//   void dispose() {
//     _videoController?.dispose();
//     super.dispose();
//   }

//   void _toggleCompletion(int index) {
//     setState(() {
//       _modules[index].completed = !_modules[index].completed;
//     });
//   }

//   double _calculateProgress() {
//     if (_modules.isEmpty) return 0.0;
//     final completedCount = _modules.where((m) => m.completed).length;
//     return completedCount / _modules.length;
//   }

//   void _initializeVideoPlayer(String videoUrl) {
//     if (_videoController != null) {
//       _videoController!.dispose();
//       _videoController = null;
//     }

//     try {
//       if (videoUrl.startsWith('assets/')) {
//         // Local video
//         _videoController = VideoPlayerController.asset(videoUrl);
//       } else {
//         // Network video
//         _videoController =
//             VideoPlayerController.networkUrl(Uri.parse(videoUrl));
//       }

//       _videoController!.initialize().then((_) {
//         setState(() {});
//         if (_videoController != null && _videoController!.value.isInitialized) {
//           _videoController!.play();
//         }
//       }).catchError((error) {
//         print("Error initializing video player: $error");
//       });
//     } catch (e) {
//       print("Error creating VideoPlayerController: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final progress = _calculateProgress();
//     final completedCount = _modules.where((m) => m.completed).length;
//     final totalCount = _modules.length;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Stock Market Basics'),
//         backgroundColor: theme.appBarTheme.backgroundColor,
//         foregroundColor: theme.appBarTheme.foregroundColor,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Your Progress ($completedCount/$totalCount Modules Completed)',
//                   style: theme.textTheme.titleMedium,
//                 ),
//                 const SizedBox(height: 8),
//                 LinearProgressIndicator(
//                   value: progress,
//                   backgroundColor: theme.colorScheme.surfaceVariant,
//                   valueColor:
//                       AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
//                   minHeight: 8,
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _modules.length,
//               itemBuilder: (context, index) {
//                 final module = _modules[index];
//                 final isExpanded = _expandedModuleIndex == index;

//                 return Card(
//                   elevation: 2.0,
//                   margin: const EdgeInsets.symmetric(
//                       horizontal: 12.0, vertical: 6.0),
//                   child: Column(
//                     children: [
//                       ListTile(
//                         leading: Checkbox(
//                           value: module.completed,
//                           onChanged: (bool? value) {
//                             _toggleCompletion(index);
//                           },
//                           activeColor: theme.colorScheme.primary,
//                         ),
//                         title: Text(
//                           module.title,
//                           style: TextStyle(
//                             decoration: module.completed
//                                 ? TextDecoration.lineThrough
//                                 : TextDecoration.none,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         subtitle: Text(module.description),
//                         trailing: IconButton(
//                           icon: Icon(Icons.play_circle_fill,
//                               color: isExpanded
//                                   ? theme.colorScheme.primary
//                                   : Colors.grey[600],
//                               size: 30),
//                           onPressed: () {
//                             setState(() {
//                               if (isExpanded) {
//                                 _expandedModuleIndex = null;
//                                 _videoController?.pause();
//                               } else {
//                                 _expandedModuleIndex = index;
//                                 _initializeVideoPlayer(module.videoUrl);
//                               }
//                             });
//                           },
//                         ),
//                       ),
//                       if (isExpanded &&
//                           _videoController != null &&
//                           _videoController!.value.isInitialized)
//                         AspectRatio(
//                           aspectRatio: _videoController!.value.aspectRatio,
//                           child: Stack(
//                             alignment: Alignment.bottomCenter,
//                             children: <Widget>[
//                               VideoPlayer(_videoController!),
//                               VideoControls(controller: _videoController!),
//                             ],
//                           ),
//                         ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class VideoControls extends StatelessWidget {
//   final VideoPlayerController controller;

//   const VideoControls({Key? key, required this.controller}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black54,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           IconButton(
//             icon: Icon(
//                 controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
//             onPressed: () {
//               if (controller.value.isPlaying) {
//                 controller.pause();
//               } else {
//                 controller.play();
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
