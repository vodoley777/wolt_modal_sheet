import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/src/wolt_modal_sheet.dart';

/// The page classes are responsible for creating a modal sheet page within the context of the
/// [WoltModalSheet]. It's designed to represent a visually layered structure with clear
/// navigation and content display.
///
/// The structure is organized across layers on the z-axis:
/// 1. **Main Content Layer**: The fundamental content of the page, including the optional page
///    title, optional hero image, and the main content, which may be scrollable.
/// 2. **Top Bar Layer**: Further above the main content layer, this layer with the filled
///    color includes the top bar title and may become hidden or sticky based on scroll position
///    and specific properties.
/// 3. **Navigation Bar Layer**: Sitting at the top of the top bar layer on z-axis, this
///    transparent-background layer contains navigational widgets for the interface, such as back
///    or close buttons.
/// 4. **Sticky Action Bar Layer**: Positioned at the top of the z axis, this layer guides the
///    user towards the next step, uses an optional gentle gradient on top to hint that there is
///    more content below ready for scrolling.
///
/// By organizing these components across distinct layers, the class facilitates a clear and
/// intuitive user experience, with flexible customization options for various use cases.
///
/// [SliverWoltModalSheetPage] utilizes Flutter's sliver widgets for its main content,
/// encapsulated in [mainContentSlivers]. Slivers are specialized Flutter widgets that
/// create elements with custom scroll effects and are a fundamental part of creating
/// advanced scrollable layouts.
///
/// The use of slivers in this context offers several key advantages:
///
/// 1. **Efficient On-Demand Rendering:**
///    Slivers render their items lazily, meaning they only build and render items that
///    are currently visible within the viewport. This approach is highly efficient for
///    scrollable lists or content areas with many items, as it optimizes both memory
///    usage and performance, especially for long or infinitely scrolling lists.
///
/// 2. **Custom Scroll Effects:**
///    Slivers enable the creation of custom scroll effects and behaviors. This is
///    particularly useful in the context of a modal sheet, where customized scrolling
///    behavior can enhance the user experience. For instance, parallax effects, sticky
///    headers, or collapsing toolbars can be seamlessly implemented using slivers.
///
/// 3. **Flexible Layout Structures:**
///    Slivers provide flexibility in layout design, allowing for dynamic arrangements of
///    components in a scrollable area. This flexibility is crucial for
///    [SliverWoltModalSheetPage] as it needs to adapt to various content structures and
///    user interactions within the modal sheet.
///
/// 4. **Integration with CustomScrollView:**
///    Using slivers allows `SliverWoltModalSheetPage` to integrate seamlessly with
///    `CustomScrollView`, a widget designed to create custom scroll effects with slivers.
class SliverWoltModalSheetPage {
  /// Represents the widget that stands for the page title. A page title above the main content
  /// provides users with a quick understanding of what to expect from the page. As the user
  /// scrolls, this title becomes hidden, at which point the top bar title continues to serve
  /// this context-providing purpose.
  ///
  /// In many cases the text content for the [pageTitle] is the same as the text content in
  /// [topBarTitle]. Hence, when [topBarTitle] is not provided, the data of the first "Text" direct
  /// child of the of this widget will be used as the source for the [topBarTitle].
  ///
  /// A deeply nested text in the [pageTitle] widget can cause performance issues during the title
  /// retrieval process. Hence, it's recommended to keep the title text structure as simple as
  /// possible or explicitly provide the [topBarTitle] widget.
  final Widget? pageTitle;

  /// A [Widget] representing the title displayed in the top bar.
  ///
  /// When not provided, the data of the first "Text" direct child of the [pageTitle] widget will
  /// be used as the data for topBarTitle Text widget. If you want to avoid using the [pageTitle]
  /// text data, you should explicitly provide topBarTitle widget or set it as SizedBox.shrink().
  final Widget? topBarTitle;

  /// An optional [Widget] representing the top bar.
  ///
  /// When provided this widget will be used as the top bar instead of the default top bar. If
  /// this widget is provided, the [topBarTitle] will not be displayed. The height of this
  /// [topBar] should be set using the [navBarHeight] field.
  final Widget? topBar;

  /// On z axis, the Top Bar layer resides above the main content layer and below the transparent
  /// navigation bar layer.
  ///
  /// Top bar aids users in grasping the context by displaying an optional title. The height of
  /// the top bar is equal to the height of [navBarHeight]. In other saying, when visible,
  /// the top bar fills the transparent background of the navigation bar.
  ///
  /// In scenarios where sheets are filled with content requiring scrolling, by default the top
  /// bar becomes visible as the user scrolls, causing the page title replaced by the top bar. At
  /// this point, the top bar adopts a 'sticky' position at the top, guaranteeing consistent
  /// visibility. When [isTopBarLayerAlwaysVisible] is set to true, the top bar will be permanently
  /// sticky at the top of the sheet regardless of the scroll position.
  ///
  /// The Top Bar design is flexible, when [hasTopBarLayer] is set to false, the top bar and the
  /// [topBarTitle] will be hidden.
  final bool? hasTopBarLayer;

  /// Indicates whether the top bar should always remain visible, regardless of the page scroll
  /// position. When set to true, the top bar will be permanently displayed; when false, it may
  /// be hidden or revealed  based on the page's scrolling behavior.
  final bool? isTopBarLayerAlwaysVisible;

  /// This list of sliver widgets within the scrollable modal sheet is responsible for displaying
  /// the main content inside the [CustomScrollView] of the modal sheet.
  final List<Widget> mainContentSlivers;

  /// A [Widget] representing the hero image displayed on top of the main content. A Hero Image
  /// is positioned at the top of the main content. This widget immediately grabs the user's
  /// attention, effectively conveying the primary theme or message of the content.
  final Widget? heroImage;

  /// The height of the [heroImage].
  final double? heroImageHeight;

  /// The background color of the page.
  final Color? backgroundColor;

  /// Overrides the default value for surfaceTintColor.
  ///
  /// If null, [WoltModalSheet] will not display an overlay color.
  ///
  /// See [Material.surfaceTintColor] for more details.
  final Color? surfaceTintColor;

  /// Height of the navigation bar. This value will also be the height of the top bar.
  ///
  /// The navigation bar layer has a transparent background, and sits directly above the top bar
  /// on the z-axis.
  ///
  /// It includes two specific widgets:
  /// the [leadingNavBarWidget] and the [trailingNavBarWidget]. The leading widget usually
  /// functions as the back button, enabling users to navigate to the previous page. The trailing
  /// widget often serves as the close button, utilized to close the modal sheet. Together, these
  /// widgets provide clear and intuitive navigational control, differentiating themselves from
  /// the top bar by focusing specifically on directional navigation within the interface.
  final double? navBarHeight;

  /// Indicates whether the page height should be at maximum even if the content size is smaller.
  final bool forceMaxHeight;

  /// A [ScrollController] that controls the scrolling behavior of the page.
  final ScrollController? scrollController;

  /// A widget representing the action widgets located at the bottom of the page.
  ///
  /// The Sticky Action Bar (SAB) guides the user towards the next step. Anchored to the bottom
  /// of the view, the SAB elevates above the content with a gentle gradient. This position
  /// guarantees that the action remains visible, subtly hinting to the user that there is more
  /// content to be explored below the fold.
  final Widget? stickyActionBar;

  /// Indicates whether a gentle gradient overlay should be rendered above the
  /// [stickyActionBar]. The purpose of this gradient is to visually suggest
  /// to the user that additional content might be present below the action bar.
  ///
  /// If set to `true`, a gradient from the [sabGradientColor] to transparent is rendered right
  /// above the [stickyActionBar]. If `false`, no gradient is rendered. By default, it's set to
  /// `true`.
  final bool? hasSabGradient;

  /// Controls the draggability of the bottom sheet. This setting overrides the value provided
  /// via [WoltModalSheet.show] specifically for this page when the modal is displayed as a bottom sheet.
  final bool? enableDrag;

  /// The color of the gentle gradient overlay that is rendered above the [stickyActionBar]. The
  /// purpose of this gradient is to visually suggest to the user that additional content might
  /// be present below the action bar.
  ///
  /// If [hasSabGradient] set to `true`, a gradient from this color to transparent is rendered
  /// right above the [stickyActionBar]. If `false`, no gradient is rendered. By default, it's
  /// value is to page background color.
  final Color? sabGradientColor;

  /// A widget representing leading widget in the navigation toolbar. This widget is usually
  /// a the back button.
  final Widget? leadingNavBarWidget;

  /// A widget representing trailing widget in the navigation toolbar. This widget is usually
  /// a the close button.
  final Widget? trailingNavBarWidget;

  /// Creates a page to be built within [WoltScrollableModalSheet].
  const SliverWoltModalSheetPage({
    required this.mainContentSlivers,
    this.pageTitle,
    this.navBarHeight,
    this.topBarTitle,
    this.topBar,
    this.heroImage,
    this.heroImageHeight,
    this.backgroundColor,
    this.surfaceTintColor,
    this.hasSabGradient,
    this.enableDrag,
    this.sabGradientColor,
    this.forceMaxHeight = false,
    this.scrollController,
    this.stickyActionBar,
    this.leadingNavBarWidget,
    this.trailingNavBarWidget,
    this.hasTopBarLayer,
    this.isTopBarLayerAlwaysVisible,
  }) : assert(!(topBar != null && hasTopBarLayer == false),
            "When topBar is provided, hasTopBarLayer must not be false");
}
