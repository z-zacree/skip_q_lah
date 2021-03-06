import 'package:flutter/material.dart';
import 'package:skip_q_lah/models/firestore/collections/outlet.dart';
import 'package:skip_q_lah/widgets/reusable_widgets.dart';

class PanelWidget extends StatelessWidget {
  const PanelWidget({
    Key? key,
    required this.scrollController,
    required this.outlet,
  }) : super(key: key);

  final ScrollController scrollController;
  final Outlet outlet;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.only(
            left: 32,
            right: 32,
            bottom: 62,
          ),
          physics: const BouncingScrollPhysics(),
          controller: scrollController,
          children: <Widget>[
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 18),
                width: 48,
                height: 4.5,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            TextHeader(text: outlet.name),
            panelText(header: 'Description', body: outlet.description),
            const SizedBox(height: 24),
            panelText(
              header: 'Address',
              body: '''
${outlet.address.main}, ${outlet.address.sub}
${outlet.address.postalCode}''',
            ),
            const SizedBox(height: 24),
            panelText(header: 'Contact', body: outlet.contactNumber),
            const SizedBox(height: 24),
            const TextSubHeader('Opening Hours'),
            const SizedBox(height: 8),
            ...outlet.openingHours.asMap().entries.map((
              MapEntry<int, Period> periodEntry,
            ) {
              Period period = periodEntry.value;
              String day = days[periodEntry.key];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      SizedBox(
                        width: 64,
                        child: Text(day),
                      ),
                      Text('${period.open.time} - ${period.close.time}')
                    ],
                  ),
                ],
              );
            }),
            const SizedBox(height: 24),
          ],
        ),
        indicator(outlet),
      ],
    );
  }
}

List<String> days = ['Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat', 'Sun'];

Widget panelText({required String header, required String body}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextSubHeader(header),
      const SizedBox(height: 8),
      Text(body),
    ],
  );
}

Widget indicator(Outlet outlet) {
  return Positioned(
    top: 18,
    right: 12,
    child: Container(
      margin: const EdgeInsets.only(left: 8, right: 10, bottom: 2),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: outlet.isOpen ? Colors.green : Colors.red,
        shape: BoxShape.circle,
      ),
    ),
  );
}
