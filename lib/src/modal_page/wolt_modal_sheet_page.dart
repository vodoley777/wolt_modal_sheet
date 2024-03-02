import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/src/modal_page/sliver_wolt_modal_sheet_page.dart';

/// [WoltModalSheetPage] is a specialized subclass of [SliverWoltModalSheetPage], designed
/// for scenarios where the main content of a modal sheet is a single non-sliver widget.
/// This class provides a convenient shortcut for creating a modal sheet page with standard
/// box widgets, encapsulating them in a sliver-compatible format.
///
/// This class is particularly useful when:
/// - The content of the modal sheet is simple and does not require the complex scroll
///   behaviors or layout structures that slivers enable.
/// - You need to quickly wrap a single widget, such as a container or a column, within
///   a modal sheet without the need to manually convert it into a sliver.
///
/// Key Features:
/// - **Simplification:** Streamlines the process of embedding standard Flutter widgets
///   within a scrollable modal sheet, by automatically wrapping the provided `child`
///   widget in a `SliverToBoxAdapter`.
/// - **Consistency:** Maintains the layered structure and behavior established by
///   `SliverWoltModalSheetPage`, ensuring a consistent user experience across different
///   types of modal sheet pages.
/// - **Flexibility:** Allows for easy customization and inclusion of common modal sheet
///   elements such as top bars, navigation bars, hero images, and action bars.
///
/// Usage Example:
/// ```dart
/// WoltModalSheetPage(
///   child: MyCustomContentWidget(),
///   pageTitle: Text('My Page Title'),
///   // Other properties...
/// )
/// ```
/// This creates a modal sheet page with `MyCustomContentWidget` as the main content,
/// wrapped in a sliver to seamlessly integrate with the scrolling behavior of the modal sheet.
///
/// See also:
/// - [SliverWoltModalSheetPage], for more complex pages that require multiple slivers.
/// - [SliverToBoxAdapter], the underlying widget used to wrap the `child` in a sliver.
class WoltModalSheetPage extends SliverWoltModalSheetPage {
  /// A [Widget] that represents the main content displayed in the page.
  /// This is a shortcut for providing a list of Sliver widgets with only one Sliver widget.
  final Widget child;

  /// Creates a [WoltModalSheetPage] with a single child main content.
  WoltModalSheetPage({
    required this.child,
    super.pageTitle,
    super.navBarHeight,
    super.topBarTitle,
    super.heroImage,
    super.heroImageHeight,
    super.backgroundColor,
    super.surfaceTintColor,
    super.hasSabGradient,
    super.sabGradientColor,
    super.enableDrag,
    super.forceMaxHeight = false,
    super.isTopBarLayerAlwaysVisible,
    super.hasTopBarLayer,
    super.scrollController,
    super.stickyActionBar,
    super.leadingNavBarWidget,
    super.trailingNavBarWidget,
    super.topBar,
  }) : super(mainContentSlivers: [SliverToBoxAdapter(child: child)]);

  WoltModalSheetPage copyWith({
    Widget? pageTitle,
    double? navBarHeight,
    Widget? child,
    Widget? topBarTitle,
    Widget? heroImage,
    double? heroImageHeight,
    Color? backgroundColor,
    Color? surfaceTintColor,
    bool? hasSabGradient,
    Color? sabGradientColor,
    bool? enableDrag,
    bool? forceMaxHeight,
    bool? isTopBarLayerAlwaysVisible,
    bool? hasTopBarLayer,
    ScrollController? scrollController,
    Widget? stickyActionBar,
    Widget? leadingNavBarWidget,
    Widget? trailingNavBarWidget,
    Widget? topBar,
  }) {
    return WoltModalSheetPage(
      pageTitle: pageTitle ?? this.pageTitle,
      navBarHeight: navBarHeight ?? this.navBarHeight,
      child: child ?? this.child,
      topBarTitle: topBarTitle ?? this.topBarTitle,
      heroImage: heroImage ?? this.heroImage,
      heroImageHeight: heroImageHeight ?? this.heroImageHeight,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      surfaceTintColor: surfaceTintColor ?? this.surfaceTintColor,
      hasSabGradient: hasSabGradient ?? this.hasSabGradient,
      sabGradientColor: sabGradientColor ?? this.sabGradientColor,
      enableDrag: enableDrag ?? this.enableDrag,
      forceMaxHeight: forceMaxHeight ?? this.forceMaxHeight,
      isTopBarLayerAlwaysVisible:
          isTopBarLayerAlwaysVisible ?? this.isTopBarLayerAlwaysVisible,
      hasTopBarLayer: hasTopBarLayer ?? this.hasTopBarLayer,
      scrollController: scrollController ?? this.scrollController,
      stickyActionBar: stickyActionBar ?? this.stickyActionBar,
      leadingNavBarWidget: leadingNavBarWidget ?? this.leadingNavBarWidget,
      trailingNavBarWidget: trailingNavBarWidget ?? this.trailingNavBarWidget,
      topBar: topBar ?? this.topBar,
    );
  }
}
