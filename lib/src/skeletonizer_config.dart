import 'package:flutter/cupertino.dart';
import 'package:skeletonizer/skeletonizer.dart';

const _defaultTextBoneBorderRadius = TextBoneBorderRadius.fromHeightFactor(.5);

/// Holds [Skeletonizer] theme data
class SkeletonizerConfigData {
  /// The painting effect to apply
  /// on the skeletonized elements
  final PaintingEffect effect;

  /// The [TextElement] border radius config
  final TextBoneBorderRadius textBorderRadius;

  /// Whether to justify multi line text bones
  final bool justifyMultiLineText;

  /// Whether to ignore container elements and only paint
  /// the dependents
  final bool ignoreContainers;

  /// The color of the container elements
  /// this includes [Container], [Card], [DecoratedBox] ..etc
  ///
  /// if null the actual color will be used
  final Color? containersColor;

  /// Whether to enable switch animation
  ///
  /// This will animate the switch between the skeleton and the actual widget
  final bool enableSwitchAnimation;

  /// The switch animation config
  ///
  /// This will be used if [enableSwitchAnimation] is true
  final SwitchAnimationConfig switchAnimationConfig;

  /// Default constructor
  const SkeletonizerConfigData({
    this.effect = const ShimmerEffect(),
    this.justifyMultiLineText = true,
    this.textBorderRadius = _defaultTextBoneBorderRadius,
    this.ignoreContainers = false,
    this.containersColor,
    this.enableSwitchAnimation = false,
    this.switchAnimationConfig = const SwitchAnimationConfig(),
  });

  /// Builds a light themed instance
  const SkeletonizerConfigData.light({
    this.effect = const ShimmerEffect(),
    this.justifyMultiLineText = true,
    this.textBorderRadius = _defaultTextBoneBorderRadius,
    this.ignoreContainers = false,
    this.containersColor,
    this.enableSwitchAnimation = false,
    this.switchAnimationConfig = const SwitchAnimationConfig(),
  });

  /// Builds a dark themed instance
  const SkeletonizerConfigData.dark({
    this.effect = const ShimmerEffect(
      baseColor: Color(0xFF3A3A3A),
      highlightColor: Color(0xFF424242),
    ),
    this.containersColor,
    this.justifyMultiLineText = true,
    this.textBorderRadius = _defaultTextBoneBorderRadius,
    this.ignoreContainers = false,
    this.enableSwitchAnimation = false,
    this.switchAnimationConfig = const SwitchAnimationConfig(),
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SkeletonizerConfigData &&
          runtimeType == other.runtimeType &&
          effect == other.effect &&
          textBorderRadius == other.textBorderRadius &&
          justifyMultiLineText == other.justifyMultiLineText &&
          ignoreContainers == other.ignoreContainers &&
          enableSwitchAnimation == other.enableSwitchAnimation &&
          switchAnimationConfig == other.switchAnimationConfig &&
          containersColor == other.containersColor;

  @override
  int get hashCode =>
      effect.hashCode ^
      textBorderRadius.hashCode ^
      justifyMultiLineText.hashCode ^
      enableSwitchAnimation.hashCode ^
      switchAnimationConfig.hashCode ^
      ignoreContainers.hashCode ^
      containersColor.hashCode;

  /// Clones the instance with overrides
  SkeletonizerConfigData copyWith({
    PaintingEffect? effect,
    TextBoneBorderRadius? textBorderRadius,
    bool? justifyMultiLineText,
    bool? ignoreContainers,
    Color? containersColor,
    bool? enableSwitchAnimation,
    SwitchAnimationConfig? switchAnimationConfig,
  }) {
    return SkeletonizerConfigData(
      effect: effect ?? this.effect,
      textBorderRadius: textBorderRadius ?? this.textBorderRadius,
      justifyMultiLineText: justifyMultiLineText ?? this.justifyMultiLineText,
      ignoreContainers: ignoreContainers ?? this.ignoreContainers,
      containersColor: containersColor ?? this.containersColor,
      enableSwitchAnimation:
          enableSwitchAnimation ?? this.enableSwitchAnimation,
      switchAnimationConfig:
          switchAnimationConfig ?? this.switchAnimationConfig,
    );
  }
}

/// Holds border radius information
/// for [TextElement]
class TextBoneBorderRadius {
  final BorderRadiusGeometry? _borderRadius;
  final double? _heightPercentage;

  /// Whether this is constructed using [fromHeightFactor]
  final bool usesHeightFactor;

  /// Builds TextBoneBorderRadius instance that
  /// uses default/fixed border radius
  const TextBoneBorderRadius(
    BorderRadiusGeometry borderRadius,
  )   : _borderRadius = borderRadius,
        _heightPercentage = null,
        usesHeightFactor = false;

  /// Builds TextBoneBorderRadius instance that
  /// uses a high factor to resolve used border radius
  const TextBoneBorderRadius.fromHeightFactor(
    double factor,
  )   : assert(factor >= 0 && factor <= 1),
        _borderRadius = null,
        _heightPercentage = factor,
        usesHeightFactor = true;

  /// This defines the value of border radius
  /// based on the font size e.g
  /// fontSize: 14
  /// heightPercentage: .5
  /// border radius =>  14 * .5 = 7
  double? get heightPercentage => _heightPercentage;

  /// The fixed border radius
  BorderRadiusGeometry? get borderRadius => _borderRadius;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextBoneBorderRadius &&
          runtimeType == other.runtimeType &&
          _borderRadius == other._borderRadius &&
          _heightPercentage == other._heightPercentage &&
          usesHeightFactor == other.usesHeightFactor;

  @override
  int get hashCode =>
      _borderRadius.hashCode ^
      _heightPercentage.hashCode ^
      usesHeightFactor.hashCode;
}

/// Provided the scoped [SkeletonizerConfigData] to descended widgets
class SkeletonizerConfig extends InheritedWidget {
  /// The Scoped config data
  final SkeletonizerConfigData data;

  /// Depends on the the nearest SkeletonizerConfigData if any
  static SkeletonizerConfigData? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SkeletonizerConfig>()
        ?.data;
  }

  /// Depends on the the nearest SkeletonizerConfigData if any otherwise it throws
  static SkeletonizerConfigData of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<SkeletonizerConfig>();
    assert(() {
      if (scope == null) {
        throw FlutterError(
          'SkeletonizerTheme operation requested with a context that does not include a SkeletonizerTheme.\n'
          'The context used to push or pop routes from the Navigator must be that of a '
          'widget that is a descendant of a SkeletonizerTheme widget.',
        );
      }
      return true;
    }());
    return scope!.data;
  }

  /// Default constructor
  const SkeletonizerConfig({
    super.key,
    required super.child,
    required this.data,
  });

  @override
  bool updateShouldNotify(covariant SkeletonizerConfig oldWidget) {
    return data != oldWidget.data;
  }
}

/// Holds the configuration for the switch animation
class SwitchAnimationConfig {
  /// The duration of the switch animation
  final Duration duration;

  /// The curve of the switch in animation
  final Curve switchInCurve;

  /// The curve of the switch out animation
  final Curve switchOutCurve;

  /// The duration of the reverse switch animation
  final Duration? reverseDuration;

  /// The transition builder
  final AnimatedSwitcherTransitionBuilder transitionBuilder;

  /// Default constructor
  const SwitchAnimationConfig({
    this.duration = const Duration(milliseconds: 300),
    this.switchInCurve = Curves.linear,
    this.switchOutCurve = Curves.linear,
    this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder,
    this.reverseDuration,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SwitchAnimationConfig &&
          runtimeType == other.runtimeType &&
          duration == other.duration &&
          switchInCurve == other.switchInCurve &&
          switchOutCurve == other.switchOutCurve &&
          reverseDuration == other.reverseDuration &&
          transitionBuilder == other.transitionBuilder;

  @override
  int get hashCode =>
      duration.hashCode ^
      switchInCurve.hashCode ^
      switchOutCurve.hashCode ^
      reverseDuration.hashCode ^
      transitionBuilder.hashCode;
}
