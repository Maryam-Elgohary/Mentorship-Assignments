
// The main class that we will inherit any number of classes from it for each specific content type we need
abstract class ContentItem {
  Widget build(BuildContext context);
}

// for content type: text
class TextItem extends ContentItem {
  final String text;
  TextItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}

//for content type: image
class ImageItem extends ContentItem {
  final String url;
  ImageItem(this.url);

  @override
  Widget build(BuildContext context) {
    return Image.network(url);
  }
}

//for content type: video
class VideoItem extends ContentItem {
  final String url;
  VideoItem(this.url);

  @override
  Widget build(BuildContext context) {
    return Text("Video player for $url"); // here we can use any package that display videos or any video player
  }
}


class ContentDisplay extends StatelessWidget {
  // we use ContentItem as the type of this list, because any content type will be a subclass from this abstract class.
  final List<ContentItem> items;
  ContentDisplay(this.items);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) => item.build(context)).toList(),
    );
  }
}
