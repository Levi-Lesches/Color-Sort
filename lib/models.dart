/// Defines different types of models used throughout the app.
/// 
/// - [DataModel]s need to be long-lived and preserved in global scope. They may need to initialize.
/// - [BuilderModel]s are used to create a value through the UI.
/// - [ViewModel]s load and manage the data and state for any given page.
library;

import "src/models/model.dart";
export "src/models/model.dart";

export "src/models/view/game.dart";

/// A [DataModel] to manage all other data models.
class Models extends DataModel {
	/// Prevents other instances of this class from being created.
	Models._();

  // List your models here

	/// A list of all models to manage.
	List<DataModel> get models => [];

	@override
	Future<void> init() async {
		for (final model in models) { await model.init(); }
	}

	@override
	void dispose() {
		for (final model in models) { model.dispose(); }
		super.dispose();
	}
}

/// The global data model singleton.
final models = Models._();
