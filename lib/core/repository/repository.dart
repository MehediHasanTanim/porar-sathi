/// Data-access boundary.
///
/// Presentation widgets and the planner talk to repositories. They do not
/// import Drift tables, generated row classes, or open the database.
abstract interface class Repository {}
