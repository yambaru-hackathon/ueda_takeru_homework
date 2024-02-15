import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_place/google_place.dart';
import 'package:instagram/toilet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'env/env.dart';

class SearchToiletPage extends StatefulWidget {
  const SearchToiletPage({super.key});

  @override
  State<SearchToiletPage> createState() => _SearchToiletPageState();
}

class _SearchToiletPageState extends State<SearchToiletPage> {
  late GooglePlace googlePlace;
  final apikey = Env.key;

  Toilet? toilet;
  Uri? mapURL;
  bool? isExist;

  @override
  void initState() {
    super.initState();

    _searchLocation();
  }

  Future<void> _searchLocation() async {
    final currentPosition = await _determinePosition();
    final currentLatitude = currentPosition.latitude;
    final currentLongitude = currentPosition.longitude;

    googlePlace = GooglePlace(apikey);

    final response = await googlePlace.search.getNearBySearch(
      Location(lat: currentLatitude, lng: currentLongitude),
      1000,
      keyword: "トイレ",
      rankby: RankBy.Distance,
      language: "ja",
    );

    final results = response?.results;
    final isExist = results?.isNotEmpty ?? false;
    setState(() {
      this.isExist = isExist;
    });

    if (!isExist) {
      return;
    }
    final firstResult = results?.first;
    final toiletLocation = firstResult?.geometry!.location;
    final toiletLatitude = toiletLocation?.lat;
    final toiletongitude = toiletLocation?.lng;

    String urlString = '';

    if (Platform.isAndroid) {
      urlString =
          'https://www.google.com/maps/dir/$currentLatitude,$currentLongitude/$toiletLatitude,$toiletongitude';
    } else if (Platform.isIOS) {
      urlString =
          'comgooglemaps://?saddr=$currentLatitude,$currentLongitude&daddr=$toiletLatitude,$toiletongitude&directionmode=walking';
    }

    if (firstResult != null && mounted) {
      final photoReference = firstResult.photos?.first.photoReference;
      final String photoURI;
      if (photoReference != null) {
        photoURI =
            'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=$photoReference&key=$apikey';
      } else {
        photoURI =
            'https://1.bp.blogspot.com/-AzH65gcVNSk/Uku9c47TJoI/AAAAAAAAYjM/4-BfvdqdJus/s800/toilet_public.png';
      }
      mapURL = Uri.parse(urlString);

      setState(() {
        toilet = Toilet(
          firstResult.name,
          photoURI,
          '$toiletLocation',
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isExist == false) {
      return const Scaffold(
        body: Center(
          child: Text('近くにトイレがありません'),
        ),
      );
    }
    if (toilet == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('今一番近くのトイレ'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                toilet!.photo!,
                fit: BoxFit.contain,
              ),
            ),
            const Padding(padding: EdgeInsets.all(8)),
            Text(
              toilet!.name!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (mapURL != null) {
                  await launchUrl(mapURL!);
                }
              },
              child: const Text('Googleマップへ'),
            ),
          ],
        ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('設定にて位置情報を許可してください');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('設定にて位置情報を許可してください');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('設定にて位置情報を許可してください');
    }

    return await Geolocator.getCurrentPosition();
  }
}
