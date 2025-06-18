import 'package:easy_localization/easy_localization.dart';

class ItemsData {
  List<Map<String, dynamic>> getFoodItems(String category) {
    switch (category) {
      case 'Gamburger':
        return [
          {
            'name': 'Classic Burger',
            'description': 'classicBurgerDescription'.tr(),
            'imagePath': "assets/images/hamburger_image.jpg",
            'sizes': [
              {'name': 'large'.tr(), 'price': 35000},
              {'name': 'medium'.tr(), 'price': 25000},
              {'name': 'small'.tr(), 'price': 18000},
            ],
          },
          {
            'name': 'Cheese Burger',
            'description': 'cheeseBurgerDescription'.tr(),
            'imagePath': "assets/images/cheese_burger_image.jpg",
            'sizes': [
              {'name': 'large'.tr(), 'price': 40000},
              {'name': 'medium'.tr(), 'price': 30000},
              {'name': 'small'.tr(), 'price': 22000},
            ],
          },
          {
            'name': 'Double Burger',
            'description': 'doubleBurgerDescription'.tr(),
            'imagePath': "assets/images/double_burger_image.jpg",
            'sizes': [
              {'name': 'large'.tr(), 'price': 45000},
              {'name': 'medium'.tr(), 'price': 35000},
              {'name': 'small'.tr(), 'price': 28000},
            ],
          },
        ];
      case 'Hot Dog':
        return [
          {
            'name': 'Classic Hot Dog',
            'description': 'classicHotDogDescription'.tr(),
            'imagePath': "assets/images/classic_hot_dog.jpg",
            'sizes': [
              {'name': 'large'.tr(), 'price': 25000},
              {'name': 'medium'.tr(), 'price': 20000},
              {'name': 'small'.tr(), 'price': 15000},
            ],
          },
          {
            'name': 'Double Hot Dog',
            'description': 'doubleHotDogDescription'.tr(),
            'imagePath': "assets/images/double_hot_dog.jpg",
            'sizes': [
              {'name': 'large'.tr(), 'price': 30000},
              {'name': 'medium'.tr(), 'price': 25000},
              {'name': 'small'.tr(), 'price': 20000},
            ],
          },
          {
            'name': 'Cheese Hot Dog',
            'description': 'cheeseHotDogDescription'.tr(),
            'imagePath': "assets/images/cheese_hot_dog.webp",
            'sizes': [
              {'name': 'large'.tr(), 'price': 28000},
              {'name': 'medium'.tr(), 'price': 22000},
              {'name': 'small'.tr(), 'price': 18000},
            ],
          },
        ];
      case 'Pizza':
        return [
          {
            'name': 'Margarita',
            'description': 'margaritaDescription'.tr(),
            'imagePath': "assets/images/margarita.jpg",
            'sizes': [
              {'name': 'large'.tr(), 'price': 65000},
              {'name': 'medium'.tr(), 'price': 45000},
              {'name': 'small'.tr(), 'price': 35000},
            ],
          },
          {
            'name': 'Pepperoni',
            'description': 'pepperoniDescription'.tr(),
            'imagePath': "assets/images/pepperoni.jpg",
            'sizes': [
              {'name': 'large'.tr(), 'price': 75000},
              {'name': 'medium'.tr(), 'price': 55000},
              {'name': 'small'.tr(), 'price': 45000},
            ],
          },
          {
            'name': 'Four Cheese',
            'description': 'fourCheeseDescription'.tr(),
            'imagePath': "assets/images/chees_4_pizza.jpg",
            'sizes': [
              {'name': 'large'.tr(), 'price': 70000},
              {'name': 'medium'.tr(), 'price': 50000},
              {'name': 'small'.tr(), 'price': 40000},
            ],
          },
        ];
      case 'Ichimliklar':
        return [
          {
            'name': 'Coca Cola',
            'description': 'cocaColaDescription'.tr(),
            'imagePath': "assets/images/coca_cola_image.jpg",
            'sizes': [
              {'name': 'large'.tr(), 'price': 12000},
              {'name': 'medium'.tr(), 'price': 8000},
              {'name': 'small'.tr(), 'price': 5000},
            ],
          },
          {
            'name': 'Fanta',
            'description': 'fantaDescription'.tr(),
            'imagePath': "assets/images/fanta_image.jpg",
            'sizes': [
              {'name': 'large'.tr(), 'price': 12000},
              {'name': 'medium'.tr(), 'price': 8000},
              {'name': 'small'.tr(), 'price': 5000},
            ],
          },
          {
            'name': 'Sprite',
            'description': 'spriteDescription'.tr(),
            'imagePath': "assets/images/sprite_image.jpg",
            'sizes': [
              {'name': 'large'.tr(), 'price': 12000},
              {'name': 'medium'.tr(), 'price': 8000},
              {'name': 'small'.tr(), 'price': 5000},
            ],
          },
        ];
      case 'Sneklar':
        return [
          {
            'name': 'Kartoshka Fri',
            'description': 'kartoshkaFriDescription'.tr(),
            'imagePath': "assets/images/patato_fri_image.jpg",
            'sizes': [
              {'name': 'large'.tr(), 'price': 20000},
              {'name': 'medium'.tr(), 'price': 15000},
              {'name': 'small'.tr(), 'price': 10000},
            ],
          },
          {
            'name': 'Nuggets',
            'description': 'nuggetsDescription'.tr(),
            'imagePath': "assets/images/chicken_nuggets.jpg",
            'sizes': [
              {'name': 'large'.tr(), 'price': 25000},
              {'name': 'medium'.tr(), 'price': 20000},
              {'name': 'small'.tr(), 'price': 15000},
            ],
          },
          {
            'name': 'Chicken Wings',
            'description': 'chickenWingsDescription'.tr(),
            'imagePath': "assets/images/chicken_wings.jpg",
            'sizes': [
              {'name': 'large'.tr(), 'price': 30000},
              {'name': 'medium'.tr(), 'price': 25000},
              {'name': 'small'.tr(), 'price': 20000},
            ],
          },
        ];
      default:
        return [];
    }
  }
}