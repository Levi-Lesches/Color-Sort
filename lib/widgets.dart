import "package:flutter/material.dart";

export "package:go_router/go_router.dart";

export "src/widgets/generic/reactive_widget.dart";
export "src/widgets/atomic/bottle.dart";

/// Helpful methods on [BuildContext].
extension ContextUtils on BuildContext {
	/// Gets the app's color scheme.
	ColorScheme get colorScheme => Theme.of(this).colorScheme;
	/// Gets the app's text theme.
	TextTheme get textTheme => Theme.of(this).textTheme;

	/// Formats a date according to the user's locale.
	String formatDate(DateTime date) => MaterialLocalizations.of(this).formatCompactDate(date);
	/// Formats a time according to the user's locale.
	String formatTime(DateTime time) => MaterialLocalizations.of(this).formatTimeOfDay(TimeOfDay.fromDateTime(time));
}
