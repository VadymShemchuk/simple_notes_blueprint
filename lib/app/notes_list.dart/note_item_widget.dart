import 'package:flutter/material.dart';

class NoteItemWidget extends StatelessWidget {
  const NoteItemWidget({
    super.key,
    required this.title,
    required this.text,
    required this.url,
    required this.date,
  });

  final String title;
  final String text;
  final String date;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Column(
              children: [
                Container(
                  color: Colors.blueGrey.shade400,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: Text(title),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: Text(date),
                      )
                    ],
                  ),
                ),
                if (url != null)
                  Container(
                    color: Colors.white,
                    child: url != null
                        ? FadeInImage(
                            image: NetworkImage(url!),
                            placeholder: const AssetImage(
                                'assets/placeholder_image.jpeg'))
                        : null,
                  ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Text(text),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
