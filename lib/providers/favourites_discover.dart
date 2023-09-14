
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:news_app/models/news_model.dart';

class FavoriteDiscoveryOptionsNotifier extends StateNotifier<List<Discovery>> {
  FavoriteDiscoveryOptionsNotifier() : super([]);

  bool toggleDiscoveryOptionFavoriteStatus(Discovery id) {
    final isFavorite = state.contains(id); 

    if (isFavorite) {
      // Remove the option with the matching id from the list of favorites.
      state = state.where((id) => id.id != id.id).toList();
      return false; // It's no longer a favorite.
    } else {
      
      state = [...state, id];
      return true;
    }
    
  }
}

final favoriteDiscoveryOptionsProvider =
    StateNotifierProvider<FavoriteDiscoveryOptionsNotifier, List<Discovery>>(
  (ref) 
  {
    return FavoriteDiscoveryOptionsNotifier();
  }
  
);

