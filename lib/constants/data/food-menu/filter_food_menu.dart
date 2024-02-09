class FoodMenuFilterer {
  static Map<int, String> foodVal = {
    1: 'All',
    2: 'Meal',
    3: 'Drinks',
    4: 'Misc'
  };

  static int findKeyByValue(String targetValue) {
    for (var entry in foodVal.entries) {
      if (entry.value.toLowerCase() == targetValue.toLowerCase()) {
        return entry.key;
      }
    }
    return 1; // Return null if the value is not found
  }

  // static List<String> foodMenus = ["All", "Meal", "Drinks", "Misc"];
}
