import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings/view/widgets/master_detail_utils.dart';

class DetailRoute<T> extends TransitionRoute<T> with LocalHistoryRoute<T> {
  DetailRoute({
    required this.builder,
    RouteSettings? settings,
  }) : super(settings: settings);

  final WidgetBuilder builder;

  @override
  Iterable<OverlayEntry> createOverlayEntries() {
    return [
      OverlayEntry(builder: (context) {
        return Positioned(
          left: isTablet(context) ? kTabletMasterContainerWidth : 0,
          top: 0,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: isTablet(context)
                ? MediaQuery.of(context).size.width -
                    kTabletMasterContainerWidth
                : MediaQuery.of(context).size.width,
            child: builder(context),
          ),
        );
      }),
    ];
  }

  @override
  void install() {
    super.install();
  }

  @override
  bool didPop(T? result) {
    final bool returnValue = super.didPop(result);
    assert(returnValue);
    if (finishedWhenPopped) {
      navigator!.finalizeRoute(this);
    }
    return returnValue;
  }

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 4);
}
