// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class StockBasicsPage extends StatefulWidget {
//   @override
//   _StockBasicsPageState createState() => _StockBasicsPageState();
// }

// class _StockBasicsPageState extends State<StockBasicsPage> {
//   late YoutubePlayerController _controller;

//   // Example list of videos with dummy data
//   final List<Map<String, dynamic>> videos = [
//     {
//       'title': 'Introduction to Stocks',
//       'youtubeUrl':
//           'https://www.youtube.com/watch?v=_ETvyDRtdC0&ab_channel=AkashVardhan',
//       'watched': false,
//     },
//     {
//       'title': 'Understanding Market Trends',
//       'youtubeUrl':
//           'https://www.youtube.com/watch?v=_ETvyDRtdC0&ab_channel=AkashVardhan',
//       'watched': true,
//     },
//     {
//       'title': 'Analyzing Financial Statements',
//       'youtubeUrl':
//           'https://www.youtube.com/watch?v=_ETvyDRtdC0&ab_channel=AkashVardhan',
//       'watched': false,
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the YouTube player with the first video's ID
//     final videoId = YoutubePlayer.convertUrlToId(videos[0]['youtubeUrl'])!;
//     _controller = YoutubePlayerController(
//       initialVideoId: videoId,
//       flags: YoutubePlayerFlags(
//         autoPlay: false,
//         mute: false,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   // Builds the list of videos similar to a Coursera course layout.
//   Widget buildVideoList() {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: videos.length,
//       itemBuilder: (context, index) {
//         final video = videos[index];
//         return ListTile(
//           leading: Icon(
//             video['watched']
//                 ? Icons.check_circle
//                 : Icons.radio_button_unchecked,
//             color: video['watched'] ? Colors.green : Colors.grey,
//           ),
//           title: Text(
//             video['title'],
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//           onTap: () {
//             // Load the selected video in the YouTube player
//             final videoId = YoutubePlayer.convertUrlToId(video['youtubeUrl'])!;
//             _controller.load(videoId);
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // The page will inherit the same app theme automatically.
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Stock Basics'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // YouTube video player
//             YoutubePlayer(
//               controller: _controller,
//               showVideoProgressIndicator: true,
//               progressIndicatorColor: Theme.of(context).colorScheme.secondary,
//             ),
//             SizedBox(height: 20),
//             // Section header
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 'Course Videos',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//             ),
//             SizedBox(height: 10),
//             // List of course videos
//             buildVideoList(),
//           ],
//         ),
//       ),
//     );
//   }
// }
