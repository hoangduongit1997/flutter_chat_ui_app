import 'package:meta/meta.dart';

@immutable
class Showcase {
  final String image;
  final String title;

  const Showcase({
    @required this.image,
    @required this.title,
  });
}
