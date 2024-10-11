class ApiProvider {
  static String baseUrl = "http://localhost:3000/api";

  // Auth
  static String login = "/login";
  static String register = "/register";
  // End Auth

  // Habit
  static String getAllHabitsByUserId(String userId) => "/habit/all/$userId";
  static String createNewHabit = '/habit/create';
  // End Habit
}
