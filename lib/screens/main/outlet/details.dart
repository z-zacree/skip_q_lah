import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skip_q_lah/widgets/outlet/map.dart';
import 'package:skip_q_lah/widgets/outlet/panel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:provider/provider.dart';
import 'package:skip_q_lah/models/firestore/collections/outlet.dart';
import 'package:skip_q_lah/models/providers/order.dart';
import 'package:skip_q_lah/screens/main/outlet/order/is_takeaway.dart';

class OutletDetail extends StatefulWidget {
  const OutletDetail({Key? key, required this.outlet}) : super(key: key);

  final Outlet outlet;

  @override
  State<OutletDetail> createState() => _OutletDetailState();
}

class _OutletDetailState extends State<OutletDetail> {
  late Outlet outlet;

  @override
  Widget build(BuildContext context) {
    outlet = widget.outlet;

    return Consumer<CreateOrderProvider>(
      builder: (
        BuildContext context,
        CreateOrderProvider orderProvider,
        Widget? child,
      ) {
        return Scaffold(
          body: Stack(
            children: [
              SlidingUpPanel(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
                minHeight: 100,
                parallaxEnabled: true,
                parallaxOffset: 0.55,
                color: Theme.of(context).backgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                panelBuilder: (ScrollController scrollController) =>
                    PanelWidget(
                  scrollController: scrollController,
                  outlet: outlet,
                ),
                body: MapWidget(outlet: outlet),
              ),
              Positioned(
                bottom: 0,
                left: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 12),
                  color: Theme.of(context).backgroundColor,
                  child: ElevatedButton(
                    onPressed: outlet.isOpen
                        ? () {
                            orderProvider.beginOrder(outlet);
                            Navigator.push(
                              context,
                              SwipeablePageRoute(
                                canOnlySwipeFromEdge: true,
                                builder: (context) {
                                  return IsTakeaway(outlet: outlet);
                                },
                              ),
                            );
                          }
                        : null,
                    child: Text(outlet.isOpen ? 'Order Here' : 'Closed'),
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 24,
                top: 48,
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: Theme.of(context).backgroundColor,
                  child: IconButton(
                    splashRadius: 28,
                    onPressed: () => Navigator.pop(context),
                    icon: FaIcon(
                      FontAwesomeIcons.arrowLeft,
                      size: 18,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
