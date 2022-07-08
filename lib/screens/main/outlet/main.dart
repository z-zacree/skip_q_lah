import 'package:flutter/material.dart';
import 'package:skip_q_lah/screens/main/outlet/listing.dart';
import 'package:skip_q_lah/widgets/theme_material.dart';

class OutletListPage extends StatefulWidget {
  const OutletListPage({Key? key}) : super(key: key);

  @override
  State<OutletListPage> createState() => _OutletListPageState();
}

class _OutletListPageState extends State<OutletListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return const ThemeMaterial(
      initPage: OutletListing(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
